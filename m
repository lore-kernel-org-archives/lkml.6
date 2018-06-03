Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbeFCWiC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 18:38:02 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:40449 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751201AbeFCWiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 18:38:01 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: hoeun.ryu@lge.com.com
X-Original-SENDERIP: 10.177.226.38
X-Original-MAILFROM: hoeun.ryu@lge.com.com
From: Hoeun Ryu <hoeun.ryu@lge.com.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Hoeun Ryu <hoeun.ryu@lge.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2]  printk: make printk_safe_flush safe in NMI context by skipping flushing
Date: Mon,  4 Jun 2018 07:37:34 +0900
Message-Id: <1528065471-22830-1-git-send-email-hoeun.ryu@lge.com.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoeun Ryu <hoeun.ryu@lge.com>

 Make printk_safe_flush() safe in NMI context.
nmi_trigger_cpumask_backtrace() can be called in NMI context. For example the
function is called in watchdog_overflow_callback() if the flag of hardlockup
backtrace (sysctl_hardlockup_all_cpu_backtrace) is true and
watchdog_overflow_callback() function is called in NMI context on some
architectures.
 Calling printk_safe_flush() in nmi_trigger_cpumask_backtrace() eventually tries
to lock logbuf_lock in vprintk_emit() that might be already be part
of another non-nmi context on the same CPU or a soft- or hard-lockup on another
CPU. The example of deadlock can be

 CPU0
 local_irq_save();
 for (;;)
   req = blk_peek_request(q);
   if (unlikely(!scsi_device_online(sdev)))
     printk()
       vprintk_emit()
         console_unlock()
           logbuf_lock_irqsave()
             slow-serial-console-write()        // close to watchdog threshold
               watchdog_overflow_callback()
                 trigger_allbutself_cpu_backtrace()
                   printk_safe_flush()
                     vprintk_emit()
                       logbuf_lock_irqsave()
                       ^^^^ deadlock

and some other cases.
 This patch prevents a deadlock in printk_safe_flush() in NMI context. It makes
sure that we continue and eventually call printk_safe_flush_on_panic() from panic()
that has better chances to succeed.
 There is a risk that logbuf_lock was not part of a soft- or dead-lockup and we
might just loose the messages. But then there is a high chance that irq_work will
get called and the messages will get flushed the normal way.

Signed-off-by: Hoeun Ryu <hoeun.ryu@lge.com>
Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
---
 v2: fix comments in commit message and code. no change in code itself.

 kernel/printk/printk_safe.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 3e3c200..3b5c660 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -254,6 +254,17 @@ void printk_safe_flush(void)
 {
 	int cpu;
 
+	/*
+	 * Just avoid a deadlock here.
+	 * It makes sure that we continue and eventually call
+	 * printk_safe_flush_on_panic() from panic() that has better chances to succeed.
+	 * There is a risk that logbuf_lock was not part of a soft- or dead-lockup and
+	 * we might just loose the messages. But then there is a high chance that
+	 * irq_work will get called and the messages will get flushed the normal way.
+	 */
+	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
+		return;
+
 	for_each_possible_cpu(cpu) {
 #ifdef CONFIG_PRINTK_NMI
 		__printk_safe_flush(&per_cpu(nmi_print_seq, cpu).work);
-- 
2.1.4
