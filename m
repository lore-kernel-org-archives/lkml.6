Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4848BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C55F21473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C55F21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeHWL3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:29:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeHWL3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:29:15 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D47FDBB6;
        Thu, 23 Aug 2018 08:00:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.4 77/79] PCI: pciehp: Fix use-after-free on unplug
Date:   Thu, 23 Aug 2018 09:53:53 +0200
Message-Id: <20180823074924.260171323@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org # v2.6.4
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/pciehp.h      |    1 +
 drivers/pci/hotplug/pciehp_core.c |    7 +++++++
 drivers/pci/hotplug/pciehp_hpc.c  |    5 ++---
 3 files changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -132,6 +132,7 @@ int pciehp_unconfigure_device(struct slo
 void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
+void pcie_shutdown_notification(struct controller *ctrl);
 int pciehp_enable_slot(struct slot *p_slot);
 int pciehp_disable_slot(struct slot *p_slot);
 void pcie_reenable_notification(struct controller *ctrl);
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -77,6 +77,12 @@ static int reset_slot		(struct hotplug_s
  */
 static void release_slot(struct hotplug_slot *hotplug_slot)
 {
+	struct slot *slot = hotplug_slot->private;
+
+	/* queued work needs hotplug_slot name */
+	cancel_delayed_work(&slot->work);
+	drain_workqueue(slot->wq);
+
 	kfree(hotplug_slot->ops);
 	kfree(hotplug_slot->info);
 	kfree(hotplug_slot);
@@ -276,6 +282,7 @@ static void pciehp_remove(struct pcie_de
 {
 	struct controller *ctrl = get_service_data(dev);
 
+	pcie_shutdown_notification(ctrl);
 	cleanup_slot(ctrl);
 	pciehp_release_ctrl(ctrl);
 }
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -741,7 +741,7 @@ int pcie_init_notification(struct contro
 	return 0;
 }
 
-static void pcie_shutdown_notification(struct controller *ctrl)
+void pcie_shutdown_notification(struct controller *ctrl)
 {
 	if (ctrl->notification_enabled) {
 		pcie_disable_notification(ctrl);
@@ -776,7 +776,7 @@ abort:
 static void pcie_cleanup_slot(struct controller *ctrl)
 {
 	struct slot *slot = ctrl->slot;
-	cancel_delayed_work(&slot->work);
+
 	destroy_workqueue(slot->wq);
 	kfree(slot);
 }
@@ -853,7 +853,6 @@ abort:
 
 void pciehp_release_ctrl(struct controller *ctrl)
 {
-	pcie_shutdown_notification(ctrl);
 	pcie_cleanup_slot(ctrl);
 	kfree(ctrl);
 }


