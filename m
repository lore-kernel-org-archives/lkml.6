Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935724AbeCSSgg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:36:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965507AbeCSSgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:36:04 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] sched/debug: fix per-task line continuation for console
Date: Mon, 19 Mar 2018 14:35:54 -0400
Message-Id: <1521484555-8620-2-git-send-email-joe.lawrence@redhat.com>
In-Reply-To: <1521484555-8620-1-git-send-email-joe.lawrence@redhat.com>
References: <1521484555-8620-1-git-send-email-joe.lawrence@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1ca0130ed4f9..50026aa2d81e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -32,7 +32,7 @@
 	if (m)					\
 		seq_printf(m, x);		\
 	else					\
-		printk(x);			\
+		pr_cont(x);			\
  } while (0)
 
 /*
-- 
1.8.3.1
