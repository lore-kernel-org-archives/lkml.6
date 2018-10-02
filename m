Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01728C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B733F20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B733F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeJCDFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:05:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbeJCDFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:05:49 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0282D8831C;
        Tue,  2 Oct 2018 20:20:44 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C113308BDA0;
        Tue,  2 Oct 2018 20:20:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/5] locking/lockdep: Make class->ops a percpu counter
Date:   Tue,  2 Oct 2018 16:19:19 -0400
Message-Id: <1538511560-10090-5-git-send-email-longman@redhat.com>
In-Reply-To: <1538511560-10090-1-git-send-email-longman@redhat.com>
References: <1538511560-10090-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 02 Oct 2018 20:20:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sizable portion of the CPU cycles spent on the __lock_acquire() is used
up by the atomic increment of class->ops stat counter. By taking it out
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
the unsigned long type, but atomic_inc() was used to increment it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep.h            |  7 +------
 kernel/locking/lockdep.c           | 11 ++++++++---
 kernel/locking/lockdep_internals.h | 23 +++++++++++++++++++++++
 kernel/locking/lockdep_proc.c      |  2 +-
 4 files changed, 33 insertions(+), 10 deletions(-)

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
index b7774ff2516f..57e3f153474f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -138,7 +138,7 @@ static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
  * get freed - this significantly simplifies the debugging code.
  */
 unsigned long nr_lock_classes;
-static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
+struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
 
 static inline struct lock_class *hlock_class(struct held_lock *hlock)
 {
@@ -435,6 +435,7 @@ unsigned int max_lockdep_depth;
  * Various lockdep statistics:
  */
 DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
+DEFINE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);
 #endif
 
 /*
@@ -1391,7 +1392,9 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	printk("%*s->", depth, "");
 	print_lock_name(class);
-	printk(KERN_CONT " ops: %lu", class->ops);
+#ifdef CONFIG_DEBUG_LOCKDEP
+	printk(KERN_CONT " ops: %lu", debug_class_ops_read(class));
+#endif
 	printk(KERN_CONT " {\n");
 
 	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
@@ -3226,7 +3229,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
index d459d624ba2a..536012e81d04 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -155,6 +155,8 @@ struct lockdep_stats {
 };
 
 DECLARE_PER_CPU(struct lockdep_stats, lockdep_stats);
+DECLARE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);
+extern struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
 
 #define __debug_atomic_inc(ptr)					\
 	this_cpu_inc(lockdep_stats.ptr);
@@ -179,9 +181,30 @@ DECLARE_PER_CPU(struct lockdep_stats, lockdep_stats);
 	}								\
 	__total;							\
 })
+
+static inline void debug_class_ops_inc(struct lock_class *class)
+{
+	int idx;
+
+	idx = class - lock_classes;
+	__this_cpu_inc(lock_class_ops[idx]);
+}
+
+static inline unsigned long debug_class_ops_read(struct lock_class *class)
+{
+	int idx, cpu;
+	unsigned long ops = 0;
+
+	idx = class - lock_classes;
+	for_each_possible_cpu(cpu)
+		ops += per_cpu(lock_class_ops[idx], cpu);
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
-- 
2.18.0

