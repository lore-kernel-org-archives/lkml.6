Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F77C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04D620831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04D620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeLIWFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:05:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36872 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbeLIWFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:05:02 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73O-0002if-Ki; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003GC-SW; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Bjorn Helgaas" <bhelgaas@google.com>,
        "Lukas Wunner" <lukas@wunner.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.467053210@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 051/328] PCI: pciehp: Fix use-after-free on unplug
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 281e878eab191cce4259abbbf1a0322e3adae02c upstream.

When pciehp is unbound (e.g. on unplug of a Thunderbolt device), the
hotplug_slot struct is deregistered and thus freed before freeing the
IRQ.  The IRQ handler and the work items it schedules print the slot
name referenced from the freed structure in various informational and
debug log messages, each time resulting in a quadruple dereference of
freed pointers (hotplug_slot -> pci_slot -> kobject -> name).

At best the slot name is logged as "(null)", at worst kernel memory is
exposed in logs or the driver crashes:

  pciehp 0000:10:00.0:pcie204: Slot((null)): Card not present

An attacker may provoke the bug by unplugging multiple devices on a
Thunderbolt daisy chain at once.  Unplugging can also be simulated by
powering down slots via sysfs.  The bug is particularly easy to trigger
in poll mode.

It has been present since the driver's introduction in 2004:
https://git.kernel.org/tglx/history/c/c16b4b14d980

Fix by rearranging teardown such that the IRQ is freed first.  Run the
work items queued by the IRQ handler to completion before freeing the
hotplug_slot struct by draining the work queue from the ->release_slot
callback which is invoked by pci_hp_deregister().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -141,6 +141,7 @@ int pciehp_unconfigure_device(struct slo
 void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
+void pcie_shutdown_notification(struct controller *ctrl);
 int pciehp_enable_slot(struct slot *p_slot);
 int pciehp_disable_slot(struct slot *p_slot);
 void pcie_reenable_notification(struct controller *ctrl);
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -82,6 +82,10 @@ static void release_slot(struct hotplug_
 	ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
 		 __func__, hotplug_slot_name(hotplug_slot));
 
+	/* queued work needs hotplug_slot name */
+	cancel_delayed_work(&slot->work);
+	drain_workqueue(slot->wq);
+
 	kfree(hotplug_slot->ops);
 	kfree(hotplug_slot->info);
 	kfree(hotplug_slot);
@@ -313,6 +317,7 @@ static void pciehp_remove(struct pcie_de
 {
 	struct controller *ctrl = get_service_data(dev);
 
+	pcie_shutdown_notification(ctrl);
 	cleanup_slot(ctrl);
 	pciehp_release_ctrl(ctrl);
 }
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -687,7 +687,7 @@ int pcie_init_notification(struct contro
 	return 0;
 }
 
-static void pcie_shutdown_notification(struct controller *ctrl)
+void pcie_shutdown_notification(struct controller *ctrl)
 {
 	if (ctrl->notification_enabled) {
 		pcie_disable_notification(ctrl);
@@ -722,7 +722,7 @@ abort:
 static void pcie_cleanup_slot(struct controller *ctrl)
 {
 	struct slot *slot = ctrl->slot;
-	cancel_delayed_work(&slot->work);
+
 	destroy_workqueue(slot->wq);
 	kfree(slot);
 }
@@ -846,7 +846,6 @@ abort:
 
 void pciehp_release_ctrl(struct controller *ctrl)
 {
-	pcie_shutdown_notification(ctrl);
 	pcie_cleanup_slot(ctrl);
 	kfree(ctrl);
 }

