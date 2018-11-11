Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5602080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5602080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbeKLGDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:03:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbeKLGDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:03:08 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt7-0000oP-M0; Sun, 11 Nov 2018 19:59:17 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001SZ-4t; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Bjorn Helgaas" <bhelgaas@google.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.54125903@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 081/366] PCI: pciehp: Clear Presence Detect and Data
 Link Layer Status Changed on resume
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pci/hotplug/pciehp.h      |  2 +-
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c  | 13 ++++++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -143,7 +143,7 @@ struct controller *pcie_init(struct pcie
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
@@ -332,7 +332,7 @@ static int pciehp_resume(struct pcie_dev
 	ctrl = get_service_data(dev);
 
 	/* reinitialize the chipset's event detection logic */
-	pcie_enable_notification(ctrl);
+	pcie_reenable_notification(ctrl);
 
 	slot = ctrl->slot;
 
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -580,7 +580,7 @@ static irqreturn_t pcie_isr(int irq, voi
 	return IRQ_HANDLED;
 }
 
-void pcie_enable_notification(struct controller *ctrl)
+static void pcie_enable_notification(struct controller *ctrl)
 {
 	u16 cmd, mask;
 
@@ -618,6 +618,17 @@ void pcie_enable_notification(struct con
 	pcie_write_cmd(ctrl, cmd, mask);
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

