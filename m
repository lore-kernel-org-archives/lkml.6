Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54EFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C91250F3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hzi0AWIu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KT/FICQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C91250F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932357AbeGBWxH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:53:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeGBWxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:53:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B644B60B23; Mon,  2 Jul 2018 22:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530571984;
        bh=RTtqANtiw+9us5A2G10gOXKgoQLMAb4TTs2B1EkUJ24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzi0AWIuoJeQN3lXD5MomIf2mUq1TeeTWVjmv89TA0sNLEqLTX7czpEdKUbncX6t9
         Y5biYJ/WR189DXuYD5gm9jPaacPK8G3fv48pmnDuuTbM+CYwCweZX4t6SD6SqPJ836
         rWN5C/90+61x3oOwdRrFuJQzWY6OdQ2NtQkAImrs=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0221D60B13;
        Mon,  2 Jul 2018 22:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530571983;
        bh=RTtqANtiw+9us5A2G10gOXKgoQLMAb4TTs2B1EkUJ24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KT/FICQdgI1746yD3ZN3nIujf/PDGlD+jc9TDjqjnvkNDhPuG3/41EcHXwAFr76hW
         iVpXxnZ21G+dS3f/kRA/x6M3sG2u61ILnSR2NGM2JhxHj27n2LCyxsIU8wqTT3gBnQ
         8np8auVShN4aiWzaHFrttjzJgmDeLWbIGdpPc7XE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0221D60B13
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V5 1/3] PCI: pciehp: implement mask and unmask interrupt functions
Date:   Mon,  2 Jul 2018 18:52:45 -0400
Message-Id: <1530571967-19099-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding pciehp_mask_irq() and pciehp_unmask_irq() to be called from struct
pcie_device as mask_irq() and unmask_irq() callbacks.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp.h      |  2 ++
 drivers/pci/hotplug/pciehp_core.c | 19 +++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h        |  2 ++
 4 files changed, 62 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 5f89206..c579d03 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -138,6 +138,8 @@ int pciehp_check_link_status(struct controller *ctrl);
 bool pciehp_check_link_active(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
 int pciehp_reset_slot(struct slot *slot, int probe);
+void pciehp_mask_irq(struct slot *slot);
+void pciehp_unmask_irq(struct slot *slot);
 
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 44a6a63..ca2faa1 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -299,6 +299,22 @@ static int pciehp_resume(struct pcie_device *dev)
 }
 #endif /* PM */
 
+static void pciehp_mask_int(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+	struct slot *slot = ctrl->slot;
+
+	pciehp_mask_irq(slot);
+}
+
+static void pciehp_unmask_int(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+	struct slot *slot = ctrl->slot;
+
+	pciehp_unmask_irq(slot);
+}
+
 static struct pcie_port_service_driver hpdriver_portdrv = {
 	.name		= PCIE_MODULE_NAME,
 	.port_type	= PCIE_ANY_PORT,
@@ -311,6 +327,9 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 	.suspend	= pciehp_suspend,
 	.resume		= pciehp_resume,
 #endif	/* PM */
+
+	.mask_irq	= pciehp_mask_int,
+	.unmask_irq	= pciehp_unmask_int,
 };
 
 static int __init pcied_init(void)
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8dae232..d44e2c6 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -757,6 +757,45 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	return rc;
 }
 
+void pciehp_mask_irq(struct slot *slot)
+{
+	struct controller *ctrl = slot->ctrl;
+	u16 ctrl_mask = 0;
+
+	if (!ATTN_BUTTN(ctrl))
+		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
+
+	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
+
+	pcie_write_cmd(ctrl, 0, ctrl_mask);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
+	if (pciehp_poll_mode)
+		del_timer_sync(&ctrl->poll_timer);
+}
+
+void pciehp_unmask_irq(struct slot *slot)
+{
+	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 stat_mask = 0, ctrl_mask = 0;
+
+	if (!ATTN_BUTTN(ctrl)) {
+		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
+		stat_mask |= PCI_EXP_SLTSTA_PDC;
+	}
+	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
+	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
+
+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
+	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
+	if (pciehp_poll_mode)
+		int_poll_timeout(&ctrl->poll_timer);
+}
+
+
 int pcie_init_notification(struct controller *ctrl)
 {
 	if (pciehp_request_irq(ctrl))
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 6ffc797..40bb6f2 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -51,6 +51,8 @@ struct pcie_port_service_driver {
 	void (*remove) (struct pcie_device *dev);
 	int (*suspend) (struct pcie_device *dev);
 	int (*resume) (struct pcie_device *dev);
+	void (*mask_irq)(struct pcie_device *dev);
+	void (*unmask_irq)(struct pcie_device *dev);
 
 	/* Device driver may resume normal operations */
 	void (*error_resume)(struct pci_dev *dev);
-- 
2.7.4

