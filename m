Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030904AbeE2Cw4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:52:56 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:58444 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965500AbeE2Cwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:52:53 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: hoeun.ryu@lge.com.com
X-Original-SENDERIP: 10.177.226.38
X-Original-MAILFROM: hoeun.ryu@lge.com.com
From: Hoeun Ryu <hoeun.ryu@lge.com.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Hoeun Ryu <hoeun.ryu@lge.com>, linux-kernel@vger.kernel.org
Subject: [PATCH]  printk: make printk_safe_flush safe in NMI context by skipping flushing
Date: Tue, 29 May 2018 11:51:48 +0900
Message-Id: <1527562331-25880-1-git-send-email-hoeun.ryu@lge.com.com>
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
to lock logbuf_lock in vprintk_emit() but the logbuf_lock can be already locked in
preempted contexts (task or irq in this case) or by other CPUs and it may cause
deadlocks.
 By making printk_safe_flush() safe in NMI context, the backtrace triggering CPU
just skips flushing if the lock is not avaiable in NMI context. The messages in
per-cpu nmi buffer of the backtrace triggering CPU can be lost if the CPU is in
hard lockup (because irq is disabled here) but if panic() is not called. The
flushing can be delayed by the next irq work in normal cases.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Hoeun Ryu <hoeun.ryu@lge.com>
---
 kernel/printk/printk_safe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 3e3c200..62bcc9b 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -254,6 +254,16 @@ void printk_safe_flush(void)
 {
 	int cpu;
 
+	/*
+	 * Just avoid deadlocks here, we could loose the messages in per-cpu nmi buffer
+	 * in the case that hardlockup happens but panic() is not called (irq_work won't
+	 * work).
+	 * The flushing can be delayed by the next irq_work if flushing is skippped here
+	 * in normal cases.
+	 */
+	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
+		return;
+
 	for_each_possible_cpu(cpu) {
 #ifdef CONFIG_PRINTK_NMI
 		__printk_safe_flush(&per_cpu(nmi_print_seq, cpu).work);
-- 
2.1.4
