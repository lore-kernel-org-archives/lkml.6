Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8993C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 23:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A4020E20
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 23:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQj2gAWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A4020E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeHTCch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 22:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbeHTCch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 22:32:37 -0400
Received: from localhost.localdomain (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D551B20C0E;
        Sun, 19 Aug 2018 23:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534720765;
        bh=MCW6fbfEOEa5jefK6Th7M3Bchw2CVW/sNu7qXNcXuqc=;
        h=From:To:Cc:Subject:Date:From;
        b=HQj2gAWfqXFusbUdKtsjaO85s8KZ6tDCNj8Nlt/osxR4nN1Fp2waL8ccnTaugFKFP
         l6qOFDlglxFA0Bo8n4furbY2cAlM6CZqHFoonWlFU/PyLR0/c88TMO77x+JruTLIgn
         FBxwzBVVtS10Os1NHoLHU9OivOc8IAHTXPVoPQh4=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 1/2] PCI: pciehp: Ignore link events when there is a fatal error pending
Date:   Fri, 17 Aug 2018 23:51:09 -0700
Message-Id: <20180818065126.77912-1-okaya@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AER/DPC reset is known as warm-resets. HP link recovery is known as
cold-reset via power-off and power-on command to the PCI slot.

In the middle of a warm-reset operation (AER/DPC), we are:

1. turning off the slow power. Slot power needs to be kept on in order
for recovery to succeed.

2. performing a cold reset causing Fatal Error recovery to fail.

If link goes down due to a DPC event, it should be recovered by DPC
status trigger. Injecting a cold reset in the middle can cause a HW
lockup as it is an undefined behavior.

Similarly, If link goes down due to an AER secondary bus reset issue,
it should be recovered by HW. Injecting a cold reset in the middle of a
secondary bus reset can cause a HW lockup as it is an undefined behavior.

1. HP ISR observes link down interrupt.
2. HP ISR checks that there is a fatal error pending, it doesn't touch
the link.
3. HP ISR waits until link recovery happens.
4. HP ISR calls the read vendor id function.
5. If all fails, try the cold-reset approach.

If fatal error is pending and a fatal error service such as DPC or AER
is running, it is the responsibility of the fatal error service to
recover the link.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 18 ++++++++++++++++
 drivers/pci/pci.h                 |  2 ++
 drivers/pci/pcie/err.c            | 34 +++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index da7c72372ffc..22354b6850c3 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -222,9 +222,27 @@ void pciehp_handle_disable_request(struct slot *slot)
 void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
 {
 	struct controller *ctrl = slot->ctrl;
+	struct pci_dev *pdev = ctrl->pcie->port;
 	bool link_active;
 	u8 present;
 
+	/* If a fatal error is pending, wait for AER or DPC to handle it. */
+	if (pcie_fatal_error_pending(pdev)) {
+		bool recovered;
+
+		recovered = pcie_wait_fatal_error_clear(pdev);
+
+		/* If the fatal error is gone and the link is up, return */
+		if (recovered && pcie_wait_for_link(pdev, true)) {
+			ctrl_info(ctrl, "Slot(%s): Ignoring Link event due to successful fatal error recovery\n",
+				  slot_name(slot));
+			return;
+		}
+
+		ctrl_info(ctrl, "Slot(%s): Fatal error recovery failed for Link event, trying hotplug reset\n",
+			  slot_name(slot));
+	}
+
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
 	 * Even if it's occupied again, we cannot assume the card is the same.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a07f3f..e2d98654630b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -356,6 +356,8 @@ void pci_enable_acs(struct pci_dev *dev);
 /* PCI error reporting and recovery */
 void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service);
 void pcie_do_nonfatal_recovery(struct pci_dev *dev);
+bool pcie_fatal_error_pending(struct pci_dev *pdev);
+bool pcie_wait_fatal_error_clear(struct pci_dev *pdev);
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb0b0b7..b1b5604cb00b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/aer.h>
+#include <linux/delay.h>
 #include "portdrv.h"
 #include "../pci.h"
 
@@ -386,3 +387,36 @@ void pcie_do_nonfatal_recovery(struct pci_dev *dev)
 	/* TODO: Should kernel panic here? */
 	pci_info(dev, "AER: Device recovery failed\n");
 }
+
+bool pcie_fatal_error_pending(struct pci_dev *pdev)
+{
+	u16 err_status = 0;
+	int rc;
+
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &err_status);
+	if (rc)
+		return false;
+
+	return !!(err_status & PCI_EXP_DEVSTA_FED);
+}
+
+bool pcie_wait_fatal_error_clear(struct pci_dev *pdev)
+{
+	int timeout = 1000;
+	bool ret;
+
+	for (;;) {
+		ret = pcie_fatal_error_pending(pdev);
+		if (ret == false)
+			return true;
+		if (timeout <= 0)
+			break;
+		msleep(20);
+		timeout -= 20;
+	}
+
+	return false;
+}
-- 
2.17.1

