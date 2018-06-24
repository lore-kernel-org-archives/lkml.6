Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4F0C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B4524ED0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B4524ED0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeFXMWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:22:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeFXMWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:22:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5OCMV8C824167
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Jun 2018 05:22:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5OCMV2G824164;
        Sun, 24 Jun 2018 05:22:31 -0700
Date:   Sun, 24 Jun 2018 05:22:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lukas Wunner <tipbot@zytor.com>
Message-ID: <tip-519cc8652b3a1d3d0a02257afbe9573ad644da26@git.kernel.org>
Cc:     bhelgaas@google.com, tglx@linutronix.de,
        mika.westerberg@linux.intel.com, lukas@wunner.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          lukas@wunner.de, mika.westerberg@linux.intel.com,
          tglx@linutronix.de, bhelgaas@google.com
In-Reply-To: <d72b41309f077c8d3bee6cc08ad3662d50b5d22a.1529828292.git.lukas@wunner.de>
References: <d72b41309f077c8d3bee6cc08ad3662d50b5d22a.1529828292.git.lukas@wunner.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Synchronize only with single thread on
 free_irq()
Git-Commit-ID: 519cc8652b3a1d3d0a02257afbe9573ad644da26
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  519cc8652b3a1d3d0a02257afbe9573ad644da26
Gitweb:     https://git.kernel.org/tip/519cc8652b3a1d3d0a02257afbe9573ad644da26
Author:     Lukas Wunner <lukas@wunner.de>
AuthorDate: Sun, 24 Jun 2018 10:35:30 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Jun 2018 14:17:27 +0200

genirq: Synchronize only with single thread on free_irq()

When pciehp is converted to threaded IRQ handling, removal of unplugged
devices below a PCIe hotplug port happens synchronously in the IRQ thread.
Removal of devices typically entails a call to free_irq() by their drivers.

If those devices share their IRQ with the hotplug port, __free_irq()
deadlocks because it calls synchronize_irq() to wait for all hard IRQ
handlers as well as all threads sharing the IRQ to finish.

Actually it's sufficient to wait only for the IRQ thread of the removed
device, so call synchronize_hardirq() to wait for all hard IRQ handlers to
finish, but no longer for any threads.  Compensate by rearranging the
control flow in irq_wait_for_interrupt() such that the device's thread is
allowed to run one last time after kthread_stop() has been called.

kthread_stop() blocks until the IRQ thread has completed.  On completion
the IRQ thread clears its oneshot thread_mask bit.  This is safe because
__free_irq() holds the request_mutex, thereby preventing __setup_irq() from
handing out the same oneshot thread_mask bit to a newly requested action.

Stack trace for posterity:
    INFO: task irq/17-pciehp:94 blocked for more than 120 seconds.
    schedule+0x28/0x80
    synchronize_irq+0x6e/0xa0
    __free_irq+0x15a/0x2b0
    free_irq+0x33/0x70
    pciehp_release_ctrl+0x98/0xb0
    pcie_port_remove_service+0x2f/0x40
    device_release_driver_internal+0x157/0x220
    bus_remove_device+0xe2/0x150
    device_del+0x124/0x340
    device_unregister+0x16/0x60
    remove_iter+0x1a/0x20
    device_for_each_child+0x4b/0x90
    pcie_port_device_remove+0x1e/0x30
    pci_device_remove+0x36/0xb0
    device_release_driver_internal+0x157/0x220
    pci_stop_bus_device+0x7d/0xa0
    pci_stop_bus_device+0x3d/0xa0
    pci_stop_and_remove_bus_device+0xe/0x20
    pciehp_unconfigure_device+0xb8/0x160
    pciehp_disable_slot+0x84/0x130
    pciehp_ist+0x158/0x190
    irq_thread_fn+0x1b/0x50
    irq_thread+0x143/0x1a0
    kthread+0x111/0x130

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Link: https://lkml.kernel.org/r/d72b41309f077c8d3bee6cc08ad3662d50b5d22a.1529828292.git.lukas@wunner.de

---
 kernel/irq/manage.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 123a227d3357..1f8be33572a7 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -790,9 +790,19 @@ static irqreturn_t irq_forced_secondary_handler(int irq, void *dev_id)
 
 static int irq_wait_for_interrupt(struct irqaction *action)
 {
-	set_current_state(TASK_INTERRUPTIBLE);
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
 
-	while (!kthread_should_stop()) {
+		if (kthread_should_stop()) {
+			/* may need to run one last time */
+			if (test_and_clear_bit(IRQTF_RUNTHREAD,
+					       &action->thread_flags)) {
+				__set_current_state(TASK_RUNNING);
+				return 0;
+			}
+			__set_current_state(TASK_RUNNING);
+			return -1;
+		}
 
 		if (test_and_clear_bit(IRQTF_RUNTHREAD,
 				       &action->thread_flags)) {
@@ -800,10 +810,7 @@ static int irq_wait_for_interrupt(struct irqaction *action)
 			return 0;
 		}
 		schedule();
-		set_current_state(TASK_INTERRUPTIBLE);
 	}
-	__set_current_state(TASK_RUNNING);
-	return -1;
 }
 
 /*
@@ -1024,7 +1031,7 @@ static int irq_thread(void *data)
 	/*
 	 * This is the regular exit path. __free_irq() is stopping the
 	 * thread via kthread_stop() after calling
-	 * synchronize_irq(). So neither IRQTF_RUNTHREAD nor the
+	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
 	 * oneshot mask bit can be set.
 	 */
 	task_work_cancel(current, irq_thread_dtor);
@@ -1241,7 +1248,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 	/*
 	 * Protects against a concurrent __free_irq() call which might wait
-	 * for synchronize_irq() to complete without holding the optional
+	 * for synchronize_hardirq() to complete without holding the optional
 	 * chip bus lock and desc->lock. Also protects against handing out
 	 * a recycled oneshot thread_mask bit while it's still in use by
 	 * its previous owner.
@@ -1612,11 +1619,11 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	/*
 	 * Drop bus_lock here so the changes which were done in the chip
 	 * callbacks above are synced out to the irq chips which hang
-	 * behind a slow bus (I2C, SPI) before calling synchronize_irq().
+	 * behind a slow bus (I2C, SPI) before calling synchronize_hardirq().
 	 *
 	 * Aside of that the bus_lock can also be taken from the threaded
 	 * handler in irq_finalize_oneshot() which results in a deadlock
-	 * because synchronize_irq() would wait forever for the thread to
+	 * because kthread_stop() would wait forever for the thread to
 	 * complete, which is blocked on the bus lock.
 	 *
 	 * The still held desc->request_mutex() protects against a
@@ -1628,7 +1635,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	unregister_handler_proc(irq, action);
 
 	/* Make sure it's not being used on another CPU: */
-	synchronize_irq(irq);
+	synchronize_hardirq(irq);
 
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*
@@ -1646,6 +1653,12 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	}
 #endif
 
+	/*
+	 * The action has already been removed above, but the thread writes
+	 * its oneshot mask bit when it completes. Though request_mutex is
+	 * held across this which prevents __setup_irq() from handing out
+	 * the same bit to a newly requested action.
+	 */
 	if (action->thread) {
 		kthread_stop(action->thread);
 		put_task_struct(action->thread);
