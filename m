Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBHNEZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:04:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:33784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbeBHNEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:04:24 -0500
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2] printk: Relocate wake_klogd check close to the end of console_unlock()
Date: Thu,  8 Feb 2018 14:04:02 +0100
Message-Id: <20180208130402.15157-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

We mark for waking up klogd whenever we see a new message sequence in
the main loop.  However, the actual wakeup is always at the end of the
function and we can easily test for the wakeup condition when we do
the final should-we-repeat check.

Move the wake_klogd condition check out of the main loop.  This avoids
doing the same thing repeatedly and groups similar checks into a
common place.

This fixes a race introduced by the commit dbdda842fe96f8932 ("printk: Add
console owner and waiter logic to load balance console writes").
The current console owner might process the newly added message before
the related printk() start waiting for the console lock. Then the lock
is passed without waking klogd. The new owner sees the already updated
seen_seq and does not know that the wakeup is needed.

Fixes: dbdda842fe96f8932 ("printk: Add console owner and waiter logic to load balance console writes")
Signed-off-by: Tejun Heo <tj@kernel.org>
[pmladek@suse.com: Describe the new race with console waiter]
Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
The patch [1] was lost in the discussions about the solution
of printk softlockups. I make sense on its own.

Important: It actually fixes a race caused by the new console waiter
logic. This is why I resend it with an updated commit message.

[1] https://lkml.kernel.org/r/20171102135146.GN3252168@devbig577.frc2.facebook.com


 kernel/printk/printk.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index db4b9b8929eb..2682209b1c90 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2335,10 +2335,6 @@ void console_unlock(void)
 
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
-		if (seen_seq != log_next_seq) {
-			wake_klogd = true;
-			seen_seq = log_next_seq;
-		}
 
 		if (console_seq < log_first_seq) {
 			len = sprintf(text, "** %u printk messages dropped **\n",
@@ -2417,12 +2413,17 @@ void console_unlock(void)
 	up_console_sem();
 
 	/*
-	 * Someone could have filled up the buffer again, so re-check if there's
-	 * something to flush. In case we cannot trylock the console_sem again,
-	 * there's a new owner and the console_unlock() from them will do the
-	 * flush, no worries.
+	 * Check whether userland needs notification.  Also, someone could
+	 * have filled up the buffer again, so re-check if there's
+	 * something to flush. In case we cannot trylock the console_sem
+	 * again, there's a new owner and the console_unlock() from them
+	 * will do the flush, no worries.
 	 */
 	raw_spin_lock(&logbuf_lock);
+	if (seen_seq != log_next_seq) {
+		wake_klogd = true;
+		seen_seq = log_next_seq;
+	}
 	retry = console_seq != log_next_seq;
 	raw_spin_unlock(&logbuf_lock);
 	printk_safe_exit_irqrestore(flags);
-- 
2.13.6
