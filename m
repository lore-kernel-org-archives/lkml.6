Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeCTLTC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:19:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753087AbeCTLS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:18:59 -0400
Date: Tue, 20 Mar 2018 04:18:37 -0700
From: tip-bot for Joe Lawrence <tipbot@zytor.com>
Message-ID: <tip-a8c024cd9b9683d25ae1f459525dd2c6bec75e79@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        joe.lawrence@redhat.com, hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, joe.lawrence@redhat.com,
        tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <1521484555-8620-2-git-send-email-joe.lawrence@redhat.com>
References: <1521484555-8620-2-git-send-email-joe.lawrence@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/debug: Fix per-task line continuation for
 console output
Git-Commit-ID: a8c024cd9b9683d25ae1f459525dd2c6bec75e79
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a8c024cd9b9683d25ae1f459525dd2c6bec75e79
Gitweb:     https://git.kernel.org/tip/a8c024cd9b9683d25ae1f459525dd2c6bec75e79
Author:     Joe Lawrence <joe.lawrence@redhat.com>
AuthorDate: Mon, 19 Mar 2018 14:35:54 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 09:30:09 +0100

sched/debug: Fix per-task line continuation for console output

When the SEQ_printf() macro prints to the console, it runs a simple
printk() without KERN_CONT "continued" line printing.  The result of
this is oddly wrapped task info, for example:

  % echo t > /proc/sysrq-trigger
  % dmesg
  ...
  runnable tasks:
  ...
  [   29.608611]  I
  [   29.608613]       rcu_sched     8      3252.013846      4087   120
  [   29.608614]         0.000000        29.090111         0.000000
  [   29.608615]  0 0
  [   29.608616]  /

Modify SEQ_printf to use pr_cont() for expected one-line results:

  % echo t > /proc/sysrq-trigger
  % dmesg
  ...
  runnable tasks:
  ...
  [  106.716329]  S        cpuhp/5    37      2006.315026        14   120         0.000000         0.496893         0.000000 0 0 /

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1521484555-8620-2-git-send-email-joe.lawrence@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1ca0130ed4f9..50026aa2d81e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -32,7 +32,7 @@ static DEFINE_SPINLOCK(sched_debug_lock);
 	if (m)					\
 		seq_printf(m, x);		\
 	else					\
-		printk(x);			\
+		pr_cont(x);			\
  } while (0)
 
 /*
