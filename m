Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3CAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA1C27886
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cFNQ13xC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RG5RymkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA1C27886
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935457AbeF1Tbm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:31:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53994 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934767AbeF1Tbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:31:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E174160BDE; Thu, 28 Jun 2018 19:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530214298;
        bh=70YTMwOXjJ7Om4BvuSAGg1BL+Eq8mHIGNY7xUeGWgVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFNQ13xCD2zcqS2gI9m8gCSIZ7BbrcKyAbQOOx0YgA+sXQAL2t9QpDgBhslLAzAgp
         5MzxPAcZFfuEPXiLTn9tjeRDcQ3YWbYcY9Xf5XulKxzECTnGmC2sRKbpgr6yDc+hNm
         XDZ2rjsB6kUaMWyLjd1PVpPwpweatj+dPmhU05qw=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 349D560B26;
        Thu, 28 Jun 2018 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530214295;
        bh=70YTMwOXjJ7Om4BvuSAGg1BL+Eq8mHIGNY7xUeGWgVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RG5RymkYBe/KM1u8TlAJEH7IEFGycaQRMEEsqn8K68KbZeAIGZXMSG4DCWZcaWp3y
         +4Zid2YKnBD/NfT1IVDC4gA86JZi/yZ+XzkBuDLkUOpqnHR3KIrEhBaN1U67BP4ji5
         KrP+TL/igthAx5XWRTv/66rROWCNb/2JMo1vFgNk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 349D560B26
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
        linux-kernel@vger.kernel.org (open list),
        kvm@vger.kernel.org (open list:VFIO DRIVER)
Subject: [PATCH V4 4/7] PCI: Unify try slot and bus reset API
Date:   Thu, 28 Jun 2018 15:31:02 -0400
Message-Id: <1530214274-21139-4-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers are expected to call pci_try_reset_slot() or pci_try_reset_bus() by
querying if a system supports hotplug or not. A survey showed that most
drivers don't do this and we are leaking hotplug capability to the user.

Hide pci_try_slot_reset() from drivers and embed into pci_try_bus_reset().
Change pci_try_reset_bus() parameter from struct pci_bus to struct pci_dev.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/infiniband/hw/hfi1/pcie.c |  2 +-
 drivers/pci/pci.c                 | 26 +++++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci.c       |  6 ++----
 include/linux/pci.h               |  3 +--
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 4570c4d..df4f2d3 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -905,7 +905,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * delay after a reset is required.  Per spec requirements,
 	 * the link is either working or not after that point.
 	 */
-	return pci_try_reset_bus(dev->bus);
+	return pci_try_reset_bus(dev);
 }
 
 /*
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 236220c..79a1566 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4817,12 +4817,12 @@ int pci_reset_slot(struct pci_slot *slot)
 EXPORT_SYMBOL_GPL(pci_reset_slot);
 
 /**
- * pci_try_reset_slot - Try to reset a PCI slot
+ * __pci_try_reset_slot - Try to reset a PCI slot
  * @slot: PCI slot to reset
  *
  * Same as above except return -EAGAIN if the slot cannot be locked
  */
-int pci_try_reset_slot(struct pci_slot *slot)
+static int __pci_try_reset_slot(struct pci_slot *slot)
 {
 	int rc;
 
@@ -4843,7 +4843,6 @@ int pci_try_reset_slot(struct pci_slot *slot)
 
 	return rc;
 }
-EXPORT_SYMBOL_GPL(pci_try_reset_slot);
 
 static int pci_bus_reset(struct pci_bus *bus, int probe)
 {
@@ -4906,12 +4905,12 @@ int pci_reset_bus(struct pci_bus *bus)
 EXPORT_SYMBOL_GPL(pci_reset_bus);
 
 /**
- * pci_try_reset_bus - Try to reset a PCI bus
+ * __pci_try_reset_bus - Try to reset a PCI bus
  * @bus: top level PCI bus to reset
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-int pci_try_reset_bus(struct pci_bus *bus)
+static int __pci_try_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
@@ -4932,6 +4931,23 @@ int pci_try_reset_bus(struct pci_bus *bus)
 
 	return rc;
 }
+
+/**
+ * pci_try_reset_bus - Try to reset a PCI bus
+ * @pdev: top level PCI device to reset via slot/bus
+ *
+ * Same as above except return -EAGAIN if the bus cannot be locked
+ */
+int pci_try_reset_bus(struct pci_dev *pdev)
+{
+	bool slot = false;
+
+	if (!pci_probe_reset_slot(pdev->slot))
+		slot = true;
+
+	return slot ? __pci_try_reset_slot(pdev->slot) :
+			__pci_try_reset_bus(pdev->bus);
+}
 EXPORT_SYMBOL_GPL(pci_try_reset_bus);
 
 /**
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b423a30..71018ec 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1010,8 +1010,7 @@ static long vfio_pci_ioctl(void *device_data,
 						    &info, slot);
 		if (!ret)
 			/* User has access, do the reset */
-			ret = slot ? pci_try_reset_slot(vdev->pdev->slot) :
-				     pci_try_reset_bus(vdev->pdev->bus);
+			ret = pci_try_reset_bus(vdev->pdev);
 
 hot_reset_release:
 		for (i--; i >= 0; i--)
@@ -1373,8 +1372,7 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
 	}
 
 	if (needs_reset)
-		ret = slot ? pci_try_reset_slot(vdev->pdev->slot) :
-			     pci_try_reset_bus(vdev->pdev->bus);
+		ret = pci_try_reset_bus(vdev->pdev);
 
 put_devs:
 	for (i = 0; i < devs.cur_index; i++) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6b12ce2..f5c85b6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1096,10 +1096,9 @@ int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_reset_slot(struct pci_slot *slot);
-int pci_try_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_bus *bus);
-int pci_try_reset_bus(struct pci_bus *bus);
+int pci_try_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
-- 
2.7.4

