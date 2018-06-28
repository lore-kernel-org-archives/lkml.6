Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2DFC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AA4278A3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j4JM/Ffa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PhoiSbfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AA4278A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934338AbeF1TbW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:31:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933192AbeF1TbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:31:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A5EC360B23; Thu, 28 Jun 2018 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530214279;
        bh=YeZNEXnABmo7R3nVUfX4jkEWDejJ0hHEkcgBqc0xgc4=;
        h=From:To:Cc:Subject:Date:From;
        b=j4JM/FfaUM78WdqJeYO4CUFUsmU0rw3NujDneneDtRtTlTzFJfN+Q+U2qAXHOU40/
         SF+E/zhh9NvMfMgpshmxT4gB8f10KZL5ZNs2XPqaPrCNltHIDUVMRpk6C2X055RRyT
         6tFM17fWwaMjX+dtOjcSJ/xbuyrYlx2atGdzfASs=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 518CA60274;
        Thu, 28 Jun 2018 19:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530214278;
        bh=YeZNEXnABmo7R3nVUfX4jkEWDejJ0hHEkcgBqc0xgc4=;
        h=From:To:Cc:Subject:Date:From;
        b=PhoiSbfoWwcam506qx8W7NHLreiuk2Qob9CRN0tmEhSzIrHUTEZUKfJ16vyBZ3MPa
         WiCywuDWDY7+B1OKp4unHTIu/YfbUI5szZr5Yl9kOiiS2XlDHi6kqHfuuHjI/tirQ5
         wqkt3YyDYsVd1muGJ09HHWItb6I8KZpd2/sdAj10=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 518CA60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lukas Wunner <lukas@wunner.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V4 1/7] PCI: handle error return from pci_reset_bridge_secondary_bus()
Date:   Thu, 28 Jun 2018 15:30:59 -0400
Message-Id: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 01fd61c0b9bd ("PCI: Add a return type for
pci_reset_bridge_secondary_bus()") added a return value to the function to
return if a device is accessible following a reset. Callers are not
checking the value.

Pass error code up high in the stack if device is not accessible.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_hpc.c |  5 +++--
 drivers/pci/pci.c                | 12 ++++++------
 drivers/pci/pcie/aer.c           |  5 +++--
 drivers/pci/pcie/err.c           |  6 ++++--
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 718b607..bbaa211 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -728,6 +728,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	struct controller *ctrl = slot->ctrl;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 stat_mask = 0, ctrl_mask = 0;
+	int rc;
 
 	if (probe)
 		return 0;
@@ -745,7 +746,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	if (pciehp_poll_mode)
 		del_timer_sync(&ctrl->poll_timer);
 
-	pci_reset_bridge_secondary_bus(ctrl->pcie->port);
+	rc = pci_reset_bridge_secondary_bus(ctrl->pcie->port);
 
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
 	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
@@ -753,7 +754,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
 	if (pciehp_poll_mode)
 		int_poll_timeout(&ctrl->poll_timer);
-	return 0;
+	return rc;
 }
 
 int pcie_init_notification(struct controller *ctrl)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97acba7..98d1490 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4253,9 +4253,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 	if (probe)
 		return 0;
 
-	pci_reset_bridge_secondary_bus(dev->bus->self);
-
-	return 0;
+	return pci_reset_bridge_secondary_bus(dev->bus->self);
 }
 
 static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
@@ -4850,6 +4848,8 @@ EXPORT_SYMBOL_GPL(pci_try_reset_slot);
 
 static int pci_bus_reset(struct pci_bus *bus, int probe)
 {
+	int ret;
+
 	if (!bus->self || !pci_bus_resetable(bus))
 		return -ENOTTY;
 
@@ -4860,11 +4860,11 @@ static int pci_bus_reset(struct pci_bus *bus, int probe)
 
 	might_sleep();
 
-	pci_reset_bridge_secondary_bus(bus->self);
+	ret = pci_reset_bridge_secondary_bus(bus->self);
 
 	pci_bus_unlock(bus);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -4924,7 +4924,7 @@ int pci_try_reset_bus(struct pci_bus *bus)
 
 	if (pci_bus_trylock(bus)) {
 		might_sleep();
-		pci_reset_bridge_secondary_bus(bus->self);
+		rc = pci_reset_bridge_secondary_bus(bus->self);
 		pci_bus_unlock(bus);
 	} else
 		rc = -EAGAIN;
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e8838..f1d0f3e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1305,6 +1305,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
 	u32 reg32;
 	int pos;
+	int rc;
 
 	pos = dev->aer_cap;
 
@@ -1313,7 +1314,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	pci_reset_bridge_secondary_bus(dev);
+	rc = pci_reset_bridge_secondary_bus(dev);
 	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
@@ -1325,7 +1326,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	return PCI_ERS_RESULT_RECOVERED;
+	return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;
 }
 
 /**
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb..3a62a2e 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -175,9 +175,11 @@ static int report_resume(struct pci_dev *dev, void *data)
  */
 static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
-	pci_reset_bridge_secondary_bus(dev);
+	int rc;
+
+	rc = pci_reset_bridge_secondary_bus(dev);
 	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
-	return PCI_ERS_RESULT_RECOVERED;
+	return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;
 }
 
 static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
-- 
2.7.4

