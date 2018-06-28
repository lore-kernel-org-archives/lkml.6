Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F43C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D831277BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FU5XUN1M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bos6iCbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D831277BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030504AbeF1SaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:30:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35992 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967916AbeF1SaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:30:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A37E160B28; Thu, 28 Jun 2018 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530210612;
        bh=2Z4UElKE37gxoSIzK+0WUeRpyeRK1kx3iqXRA1vOugo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FU5XUN1MqncN5seuALff6b/ZsNN4QfP/JvPM79rsmnFcN7VZUh2wg8mEyxa7oJ/mx
         B3SewrpiKKTskbAfsamGPnk9rQOUoco7IHanUMZ+YpnEsRipxhup8oh6HFPTZqaDoX
         QbNmF6PYvb3dGV8ss6MKZYbPjihDGKj4X9AoO81M=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9ECED60B10;
        Thu, 28 Jun 2018 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530210584;
        bh=2Z4UElKE37gxoSIzK+0WUeRpyeRK1kx3iqXRA1vOugo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bos6iCbZNIAzt4yeKynHLCh/zCIw71I2SCr6oiiaNCM8Qm8/QBU9IKQMAcYZP3Gbt
         6a8DLLXMS0SZLoQ1SGTdpT+PGYAwnBXYuScch//cxRFpQSep7P/EwUQJXAbz45I0V1
         bew/uMPg6ne8KwL3W6GetEJwduXuUnRH3De3DXns=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9ECED60B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org (open list),
        kvm@vger.kernel.org (open list:VFIO DRIVER)
Subject: [PATCH V3 3/6] PCI: Unify try slot and bus reset API
Date:   Thu, 28 Jun 2018 14:28:23 -0400
Message-Id: <1530210507-9287-3-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
References: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
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
 drivers/pci/pci.c           | 26 +++++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci.c |  6 ++----
 include/linux/pci.h         |  3 +--
 3 files changed, 24 insertions(+), 11 deletions(-)

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

