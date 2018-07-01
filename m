Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2287C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8080623C1E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8080623C1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030978AbeGAQef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:34:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030953AbeGAQea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:34:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5DC649B;
        Sun,  1 Jul 2018 16:34:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 081/157] PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume
Date:   Sun,  1 Jul 2018 18:22:33 +0200
Message-Id: <20180701160856.634321461@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 13c65840feab8109194f9490c9870587173cb29d upstream.

After a suspend/resume cycle the Presence Detect or Data Link Layer Status
Changed bits might be set.  If we don't clear them those events will not
fire anymore and nothing happens for instance when a device is now
hot-unplugged.

Fix this by clearing those bits in a newly introduced function
pcie_reenable_notification().  This should be fine because immediately
after, we check if the adapter is still present by reading directly from
the status register.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/pciehp.h      |    2 +-
 drivers/pci/hotplug/pciehp_core.c |    2 +-
 drivers/pci/hotplug/pciehp_hpc.c  |   13 ++++++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -134,7 +134,7 @@ struct controller *pcie_init(struct pcie
 int pcie_init_notification(struct controller *ctrl);
 int pciehp_enable_slot(struct slot *p_slot);
 int pciehp_disable_slot(struct slot *p_slot);
-void pcie_enable_notification(struct controller *ctrl);
+void pcie_reenable_notification(struct controller *ctrl);
 int pciehp_power_on_slot(struct slot *slot);
 void pciehp_power_off_slot(struct slot *slot);
 void pciehp_get_power_status(struct slot *slot, u8 *status);
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -297,7 +297,7 @@ static int pciehp_resume(struct pcie_dev
 	ctrl = get_service_data(dev);
 
 	/* reinitialize the chipset's event detection logic */
-	pcie_enable_notification(ctrl);
+	pcie_reenable_notification(ctrl);
 
 	slot = ctrl->slot;
 
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -676,7 +676,7 @@ static irqreturn_t pcie_isr(int irq, voi
 	return handled;
 }
 
-void pcie_enable_notification(struct controller *ctrl)
+static void pcie_enable_notification(struct controller *ctrl)
 {
 	u16 cmd, mask;
 
@@ -714,6 +714,17 @@ void pcie_enable_notification(struct con
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
 }
 
+void pcie_reenable_notification(struct controller *ctrl)
+{
+	/*
+	 * Clear both Presence and Data Link Layer Changed to make sure
+	 * those events still fire after we have re-enabled them.
+	 */
+	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_SLTSTA,
+				   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
+	pcie_enable_notification(ctrl);
+}
+
 static void pcie_disable_notification(struct controller *ctrl)
 {
 	u16 mask;


