Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56852C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186C621473
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186C621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeK3JtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:49:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeK3JtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:49:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED74B307D84C;
        Thu, 29 Nov 2018 22:41:57 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5D8E60123;
        Thu, 29 Nov 2018 22:41:56 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/lockdep: Track number of zapped classes & report abuse
Date:   Thu, 29 Nov 2018 17:41:37 -0500
Message-Id: <1543531297-18349-3-git-send-email-longman@redhat.com>
In-Reply-To: <1543531297-18349-1-git-send-email-longman@redhat.com>
References: <1543531297-18349-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 29 Nov 2018 22:41:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a kernel module is unloaded, all the lock classes associated with
that kernel module will be zapped. Unfortunately the corresponding
lockdep entries in stack_trace[], list_entries[], lock_classes[],
lock_chains[] and chain_hlocks[] are not reusable without greatly
complicating the existing code.

As a result, an application that does repeated kernel module load and
unload operations may exhaust all the entries in one of the lockdep
arrays leading to a bug message. Lockdep cannot currently support this
particular use case and we need to let users aware of that.

The number of zapped lock classes will now be tracked. If one of the
lockdep arrays is out of entries and the number of zapped classes is
a significant portion (1/4) of the total, a warning message will be
printed to notify users that we cannot supported repeated kernel module
load and unload operations.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 26 ++++++++++++++++++++++++++
 kernel/locking/lockdep_internals.h |  1 +
 kernel/locking/lockdep_proc.c      |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9e0d36b..7136da4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -138,6 +138,7 @@ static inline int debug_locks_off_graph_unlock(void)
  * get freed - this significantly simplifies the debugging code.
  */
 unsigned long nr_lock_classes;
+unsigned long nr_zapped_classes;
 struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
 
 static inline struct lock_class *hlock_class(struct held_lock *hlock)
@@ -372,6 +373,25 @@ static int verbose(struct lock_class *class)
 }
 
 /*
+ * Check the number of zapped classes and print a warning if it is
+ * more than 1/4 of the total.
+ */
+static void check_zapped_classes(void)
+{
+	if (nr_zapped_classes < nr_lock_classes/4)
+		return;
+	pr_warn("========================================================\n");
+	pr_warn("WARNING: %ld out of %ld locks have been destroyed\n",
+		nr_zapped_classes, nr_lock_classes);
+	pr_warn("through kernel module unload operations.\n");
+	pr_warn("The corresponding lockdep entries are not reusable.\n");
+	pr_warn("The system might have run out of lockdep entries because\n");
+	pr_warn("of repeated kernel module load and unload operations.\n");
+	pr_warn("Lockdep cannot support this particular use case.\n");
+	pr_warn("--------------------------------------------------------\n");
+}
+
+/*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the graph_lock.
  */
@@ -417,6 +437,7 @@ static int save_trace(struct stack_trace *trace)
 			return 0;
 
 		print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
+		check_zapped_classes();
 		dump_stack();
 
 		return 0;
@@ -781,6 +802,7 @@ static bool assign_lock_key(struct lockdep_map *lock)
 		}
 
 		print_lockdep_off("BUG: MAX_LOCKDEP_KEYS too low!");
+		check_zapped_classes();
 		dump_stack();
 		return NULL;
 	}
@@ -847,6 +869,7 @@ static struct lock_list *alloc_list_entry(void)
 			return NULL;
 
 		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low!");
+		check_zapped_classes();
 		dump_stack();
 		return NULL;
 	}
@@ -2183,6 +2206,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 			return 0;
 
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAINS too low!");
+		check_zapped_classes();
 		dump_stack();
 		return 0;
 	}
@@ -2217,6 +2241,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 			return 0;
 
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
+		check_zapped_classes();
 		dump_stack();
 		return 0;
 	}
@@ -4146,6 +4171,7 @@ static void zap_class(struct lock_class *class)
 
 	RCU_INIT_POINTER(class->key, NULL);
 	RCU_INIT_POINTER(class->name, NULL);
+	nr_zapped_classes++;
 }
 
 static inline int within(const void *addr, void *start, unsigned long size)
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 88c847a..e719d3d 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -95,6 +95,7 @@ extern void get_usage_chars(struct lock_class *class,
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
 extern unsigned long nr_lock_classes;
+extern unsigned long nr_zapped_classes;
 extern unsigned long nr_list_entries;
 extern unsigned long nr_lock_chains;
 extern int nr_chain_hlocks;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 3d31f9b..04823e6 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -314,6 +314,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, " irq-read-unsafe locks:         %11lu\n",
 			nr_irq_read_unsafe);
 
+	seq_printf(m, " zapped locks:                  %11lu\n",
+			nr_zapped_classes);
 	seq_printf(m, " uncategorized locks:           %11lu\n",
 			nr_uncategorized);
 	seq_printf(m, " unused locks:                  %11lu\n",
-- 
1.8.3.1

