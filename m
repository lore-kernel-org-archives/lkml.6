Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935656AbeEYHLG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:11:06 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:60938 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934393AbeEYHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:11:05 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hoeun.ryu@lge.com.com
X-Original-SENDERIP: 10.177.226.38
X-Original-MAILFROM: hoeun.ryu@lge.com.com
From: Hoeun Ryu <hoeun.ryu@lge.com.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Liu, Changcheng" <changcheng.liu@intel.com>
Cc: Hoeun Ryu <hoeun.ryu@lge.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nmi_backtrace: use printk_safe_flush_on_panic when triggering backtraces
Date: Fri, 25 May 2018 16:09:19 +0900
Message-Id: <1527232247-31693-1-git-send-email-hoeun.ryu@lge.com.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoeun Ryu <hoeun.ryu@lge.com>

 Use printk_safe_flush_on_panic() in nmi_trigger_cpumask_backtrace().
nmi_trigger_cpumask_backtrace() can be called in NMI context. For example the
function is called in watchdog_overflow_callback() if the flag of hardlockup
backtrace (sysctl_hardlockup_all_cpu_backtrace) is true and
watchdog_overflow_callback() function is called in NMI context on some
architectures.
 printk_safe_flush() eventually tries to lock logbuf_lock in vprintk_emit() but the
logbuf_lock can be already locked in preempted contexts (task or irq in this case)
or by other CPUs and it may cause deadlocks.
 By using printk_safe_flush_on_panic() instead of printk_safe_flush() in
in nmi_trigger_cpumask_backtrace(), the backtrace triggering CPU can access the lock
safely as the lock is reinitialized before calling printk_safe_flush().
 The messages in logbuf can be corrupted if the NMI context preempts other contexts
or ignores the lock held by other CPUs writing the buffer.

Signed-off-by: Hoeun Ryu <hoeun.ryu@lge.com>
---
 lib/nmi_backtrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 61a6b5a..0ace3c9 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -78,8 +78,11 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 	/*
 	 * Force flush any remote buffers that might be stuck in IRQ context
 	 * and therefore could not run their irq_work.
+	 * Call nmi-safe version of printk_safe_flush() because this function can be
+	 * called in NMI context like watchdog_overflow_callback() if
+	 * sysctl_hardlockup_all_cpu_backtrace is true.
 	 */
-	printk_safe_flush();
+	printk_safe_flush_on_panic();
 
 	clear_bit_unlock(0, &backtrace_flag);
 	put_cpu();
-- 
2.1.4
