Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796C816256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D798204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D798204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeG3Ryh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:54:37 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54574 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731576AbeG3Ryg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:54:36 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fkAsk-0005Yy-7y; Mon, 30 Jul 2018 10:18:53 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fkAsc-0003aO-Aq; Mon, 30 Jul 2018 10:18:42 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 30 Jul 2018 10:18:39 -0600
Message-Id: <20180730161840.13733-4-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180730161840.13733-1-logang@deltatee.com>
References: <20180730161840.13733-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, sbates@raithlin.com, hch@lst.de, bhelgaas@google.com, corbet@lwn.net, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, marc.zyngier@arm.com, kai.heng.feng@canonical.com, mingo@kernel.org, frederic@kernel.org, dan.j.williams@intel.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, christian.koenig@amd.com, willy@infradead.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v8 3/4] PCI: Introduce disable_acs_redir quirk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel SPT PCH hardware has an implementation of the ACS bits that
does not comply with the PCI express standard. To deal with this
the existing code has an enable_acs() quirk for the hardware.

In order to be able to correctly disable the ACS redirect bits for
all hardware we need an analagous quirk to disable those bits.

This adds the function pci_dev_specific_disable_acs_redir() which
behaves similarly to pci_dev_specific_enable_acs() but uses a new
function pointer for quirks which disables the ACS redirect bits.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/quirks.c | 78 ++++++++++++++++++++++++++++++++++++++++++++--------
 include/linux/pci.h  |  5 ++++
 2 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f439de848658..414b22dc06b8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4553,27 +4553,81 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	return 0;
 }
 
-static const struct pci_dev_enable_acs {
+static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
+{
+	int pos;
+	u32 cap, ctrl;
+
+	if (!pci_quirk_intel_spt_pch_acs_match(dev))
+		return -ENOTTY;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return -ENOTTY;
+
+	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
+	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
+
+	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
+
+	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
+
+	pci_info(dev, "Intel SPT PCH root port workaround: disabled ACS redirect\n");
+
+	return 0;
+}
+
+static const struct pci_dev_acs_ops {
 	u16 vendor;
 	u16 device;
 	int (*enable_acs)(struct pci_dev *dev);
-} pci_dev_enable_acs[] = {
-	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_enable_intel_pch_acs },
-	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_enable_intel_spt_pch_acs },
-	{ 0 }
+	int (*disable_acs_redir)(struct pci_dev *dev);
+} pci_dev_acs_ops[] = {
+	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	  .enable_acs = pci_quirk_enable_intel_pch_acs,
+	},
+	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	  .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
+	  .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir
+	},
 };
 
 int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
-	const struct pci_dev_enable_acs *i;
+	const struct pci_dev_acs_ops *p;
+	int i;
 	int ret;
 
-	for (i = pci_dev_enable_acs; i->enable_acs; i++) {
-		if ((i->vendor == dev->vendor ||
-		     i->vendor == (u16)PCI_ANY_ID) &&
-		    (i->device == dev->device ||
-		     i->device == (u16)PCI_ANY_ID)) {
-			ret = i->enable_acs(dev);
+	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
+		p = &pci_dev_acs_ops[i];
+		if ((p->vendor == dev->vendor ||
+		     p->vendor == (u16)PCI_ANY_ID) &&
+		    (p->device == dev->device ||
+		     p->device == (u16)PCI_ANY_ID) &&
+		    p->enable_acs) {
+			ret = p->enable_acs(dev);
+			if (ret >= 0)
+				return ret;
+		}
+	}
+
+	return -ENOTTY;
+}
+
+int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
+{
+	const struct pci_dev_acs_ops *p;
+	int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
+		p = &pci_dev_acs_ops[i];
+		if ((p->vendor == dev->vendor ||
+		     p->vendor == (u16)PCI_ANY_ID) &&
+		    (p->device == dev->device ||
+		     p->device == (u16)PCI_ANY_ID) &&
+		    p->disable_acs_redir) {
+			ret = p->disable_acs_redir(dev);
 			if (ret >= 0)
 				return ret;
 		}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index abd5d5e17aee..0a436ec4fef5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1880,6 +1880,7 @@ enum pci_fixup_pass {
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
+int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 #else
 static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
@@ -1892,6 +1893,10 @@ static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	return -ENOTTY;
 }
+static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
+{
+	return -ENOTTY;
+}
 #endif
 
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
-- 
2.11.0

