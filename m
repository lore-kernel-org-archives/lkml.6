Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F180CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B9720851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B9720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeLECPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:15:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:59775 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbeLECPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:15:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 18:15:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="96188844"
Received: from gao-cwp.sh.intel.com ([10.239.159.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2018 18:15:37 -0800
From:   Chao Gao <chao.gao@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chao Gao <chao.gao@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        xen-devel@lists.xenproject.org,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] xen: xen-pciback: Reset MSI-X state when exposing a device
Date:   Wed,  5 Dec 2018 10:19:17 +0800
Message-Id: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find some pass-thru devices don't work any more across guest reboot.
Assigning it to another guest also meets the same issue. And the only
way to make it work again is un-binding and binding it to pciback.
Someone reported this issue one year ago [1]. More detail also can be
found in [2].

The root-cause is Xen's internal MSI-X state isn't reset properly
during reboot or re-assignment. In the above case, Xen set maskall bit
to mask all MSI interrupts after it detected a potential security
issue. Even after device reset, Xen didn't reset its internal maskall
bit. As a result, maskall bit would be set again in next write to
MSI-X message control register.

Given that PHYSDEVOPS_prepare_msix() also triggers Xen resetting MSI-X
internal state of a device, we employ it to fix this issue rather than
introducing another dedicated sub-hypercall.

Note that PHYSDEVOPS_release_msix() will fail if the mapping between
the device's msix and pirq has been created. This limitation prevents
us calling this function when detaching a device from a guest during
guest shutdown. Thus it is called right before calling
PHYSDEVOPS_prepare_msix().

[1]: https://lists.xenproject.org/archives/html/xen-devel/2017-09/
     msg02520.html
[2]: https://lists.xen.org/archives/html/xen-devel/2018-11/msg01616.html

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 drivers/xen/xen-pciback/pci_stub.c | 49 ++++++++++++++++++++++++++++++++++++++
 drivers/xen/xen-pciback/pciback.h  |  1 +
 drivers/xen/xen-pciback/xenbus.c   | 10 ++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 59661db..f8623d0 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -87,6 +87,55 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
 	return psdev;
 }
 
+/*
+ * Reset Xen internal MSI-X state by invoking PHYSDEVOP_{release, prepare}_msix.
+ */
+int pcistub_msix_reset(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI_MSI
+	if (dev->msix_cap) {
+		struct physdev_pci_device ppdev = {
+			.seg = pci_domain_nr(dev->bus),
+			.bus = dev->bus->number,
+			.devfn = dev->devfn
+		};
+		int err;
+		u16 val;
+
+		/*
+		 * Do a write first to flush Xen's internal state to hardware
+		 * such that the following read can infer whether MSI-X maskall
+		 * bit is set by Xen.
+		 */
+		pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &val);
+		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, val);
+
+		pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &val);
+		if (!(val & PCI_MSIX_FLAGS_MASKALL))
+			return 0;
+
+		pr_info("Reset MSI-X state for device %04x:%02x:%02x.%d\n",
+			ppdev.seg, ppdev.bus, PCI_SLOT(ppdev.devfn),
+			PCI_FUNC(ppdev.devfn));
+
+		err = HYPERVISOR_physdev_op(PHYSDEVOP_release_msix, &ppdev);
+		if (err) {
+			dev_warn(&dev->dev, "MSI-X release failed (%d)\n",
+				 err);
+			return err;
+		}
+
+		err = HYPERVISOR_physdev_op(PHYSDEVOP_prepare_msix, &ppdev);
+		if (err) {
+			dev_err(&dev->dev, "MSI-X preparation failed (%d)\n",
+				err);
+			return err;
+		}
+	}
+#endif
+	return 0;
+}
+
 /* Don't call this directly as it's called by pcistub_device_put */
 static void pcistub_device_release(struct kref *kref)
 {
diff --git a/drivers/xen/xen-pciback/pciback.h b/drivers/xen/xen-pciback/pciback.h
index 263c059..9046154 100644
--- a/drivers/xen/xen-pciback/pciback.h
+++ b/drivers/xen/xen-pciback/pciback.h
@@ -66,6 +66,7 @@ struct pci_dev *pcistub_get_pci_dev_by_slot(struct xen_pcibk_device *pdev,
 struct pci_dev *pcistub_get_pci_dev(struct xen_pcibk_device *pdev,
 				    struct pci_dev *dev);
 void pcistub_put_pci_dev(struct pci_dev *dev);
+int pcistub_msix_reset(struct pci_dev *dev);
 
 /* Ensure a device is turned off or reset */
 void xen_pcibk_reset_device(struct pci_dev *pdev);
diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index 581c4e1..2f71f26 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -243,6 +243,16 @@ static int xen_pcibk_export_device(struct xen_pcibk_device *pdev,
 		goto out;
 	}
 
+	/*
+	 * Reset Xen's internal MSI-X state before exposing a device.
+	 *
+	 * In some cases, Xen's internal MSI-X state is not clean, which would
+	 * incur the new guest cannot receive MSIs.
+	 */
+	err = pcistub_msix_reset(dev);
+	if (err)
+		goto out;
+
 	err = xen_pcibk_add_pci_dev(pdev, dev, devid,
 				    xen_pcibk_publish_pci_dev);
 	if (err)
-- 
1.8.3.1

