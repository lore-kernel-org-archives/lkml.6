Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCB6C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5718214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5718214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeJISLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:11:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50839 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJISLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:11:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99Asqbk1006594
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 03:54:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99Aspj81006591;
        Tue, 9 Oct 2018 03:54:51 -0700
Date:   Tue, 9 Oct 2018 03:54:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-8ca2b56cd7da98fc8f8d787bb706b9d6c8674a3b@git.kernel.org>
Cc:     longman@redhat.com, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        will.deacon@arm.com, torvalds@linux-foundation.org,
        a.p.zijlstra@chello.nl
Reply-To: will.deacon@arm.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, a.p.zijlstra@chello.nl, peterz@infradead.org,
          longman@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <d66681f3-8781-9793-1dcf-2436a284550b@redhat.com>
References: <d66681f3-8781-9793-1dcf-2436a284550b@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Make class->ops a percpu
 counter and move it under CONFIG_DEBUG_LOCKDEP=y
Git-Commit-ID: 8ca2b56cd7da98fc8f8d787bb706b9d6c8674a3b
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

Commit-ID:  8ca2b56cd7da98fc8f8d787bb706b9d6c8674a3b
Gitweb:     https://git.kernel.org/tip/8ca2b56cd7da98fc8f8d787bb706b9d6c8674a3b
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Wed, 3 Oct 2018 13:07:18 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 9 Oct 2018 09:56:33 +0200

locking/lockdep: Make class->ops a percpu counter and move it under CONFIG_DEBUG_LOCKDEP=y

A sizable portion of the CPU cycles spent on the __lock_acquire() is used
up by the atomic increment of the class->ops stat counter. By taking it out
from the lock_class structure and changing it to a per-cpu per-lock-class
counter, we can reduce the amount of cacheline contention on the class
structure when multiple CPUs are trying to acquire locks of the same
class simultaneously.

To limit the increase in memory consumption because of the percpu nature
of that counter, it is now put back under the CONFIG_DEBUG_LOCKDEP
config option. So the memory consumption increase will only occur if
CONFIG_DEBUG_LOCKDEP is defined. The lock_class structure, however,
is reduced in size by 16 bytes on 64-bit archs after ops removal and
a minor restructuring of the fields.

This patch also fixes a bug in the increment code as the counter is of
the 'unsigned long' type, but atomic_inc() was used to increment it.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/d66681f3-8781-9793-1dcf-2436a284550b@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h            |  7 +------
 kernel/locking/lockdep.c           | 11 ++++++++---
 kernel/locking/lockdep_internals.h | 27 +++++++++++++++++++++++++++
 kernel/locking/lockdep_proc.c      |  2 +-
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b0d0b51c4d85..1fd82ff99c65 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -99,13 +99,8 @@ struct lock_class {
 	 */
 	unsigned int			version;
 
-	/*
-	 * Statistics counter:
-	 */
-	unsigned long			ops;
-
-	const char			*name;
 	int				name_version;
+	const char			*name;
 
 #ifdef CONFIG_LOCK_STAT
 	unsigned long			contention_point[LOCKSTAT_POINTS];
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 511d30f88bce..a0f83058d6aa 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -139,7 +139,7 @@ static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
  * get freed - this significantly simplifies the debugging code.
  */
 unsigned long nr_lock_classes;
-static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
+struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
 
 static inline struct lock_class *hlock_class(struct held_lock *hlock)
 {
@@ -436,6 +436,7 @@ unsigned int max_lockdep_depth;
  * Various lockdep statistics:
  */
 DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
+DEFINE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);
 #endif
 
 /*
@@ -1392,7 +1393,9 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	printk("%*s->", depth, "");
 	print_lock_name(class);
-	printk(KERN_CONT " ops: %lu", class->ops);
+#ifdef CONFIG_DEBUG_LOCKDEP
+	printk(KERN_CONT " ops: %lu", debug_class_ops_read(class));
+#endif
 	printk(KERN_CONT " {\n");
 
 	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
@@ -3227,7 +3230,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		if (!class)
 			return 0;
 	}
-	atomic_inc((atomic_t *)&class->ops);
+
+	debug_class_ops_inc(class);
+
 	if (very_verbose(class)) {
 		printk("\nacquire class [%px] %s", class->key, class->name);
 		if (class->name_version > 1)
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index d459d624ba2a..88c847a41c8a 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -152,9 +152,15 @@ struct lockdep_stats {
 	int	nr_find_usage_forwards_recursions;
 	int	nr_find_usage_backwards_checks;
 	int	nr_find_usage_backwards_recursions;
+
+	/*
+	 * Per lock class locking operation stat counts
+	 */
+	unsigned long lock_class_ops[MAX_LOCKDEP_KEYS];
 };
 
 DECLARE_PER_CPU(struct lockdep_stats, lockdep_stats);
+extern struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
 
 #define __debug_atomic_inc(ptr)					\
 	this_cpu_inc(lockdep_stats.ptr);
@@ -179,9 +185,30 @@ DECLARE_PER_CPU(struct lockdep_stats, lockdep_stats);
 	}								\
 	__total;							\
 })
+
+static inline void debug_class_ops_inc(struct lock_class *class)
+{
+	int idx;
+
+	idx = class - lock_classes;
+	__debug_atomic_inc(lock_class_ops[idx]);
+}
+
+static inline unsigned long debug_class_ops_read(struct lock_class *class)
+{
+	int idx, cpu;
+	unsigned long ops = 0;
+
+	idx = class - lock_classes;
+	for_each_possible_cpu(cpu)
+		ops += per_cpu(lockdep_stats.lock_class_ops[idx], cpu);
+	return ops;
+}
+
 #else
 # define __debug_atomic_inc(ptr)	do { } while (0)
 # define debug_atomic_inc(ptr)		do { } while (0)
 # define debug_atomic_dec(ptr)		do { } while (0)
 # define debug_atomic_read(ptr)		0
+# define debug_class_ops_inc(ptr)	do { } while (0)
 #endif
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 3dd980dfba2d..3d31f9b0059e 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -68,7 +68,7 @@ static int l_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "%p", class->key);
 #ifdef CONFIG_DEBUG_LOCKDEP
-	seq_printf(m, " OPS:%8ld", class->ops);
+	seq_printf(m, " OPS:%8ld", debug_class_ops_read(class));
 #endif
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
