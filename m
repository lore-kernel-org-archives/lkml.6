Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303DBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E46206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E46206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeI2ASi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:18:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbeI2ASh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:18:37 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C23530820C7;
        Fri, 28 Sep 2018 17:53:44 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E95CF2010DAA;
        Fri, 28 Sep 2018 17:53:41 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 4/5] locking/lockdep: Make class->ops a percpu counter
Date:   Fri, 28 Sep 2018 13:53:20 -0400
Message-Id: <1538157201-29173-5-git-send-email-longman@redhat.com>
In-Reply-To: <1538157201-29173-1-git-send-email-longman@redhat.com>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 28 Sep 2018 17:53:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sizable portion of the CPU cycles spent on the __lock_acquire() is used
up by the atomic increment of class->ops stat counter. By changing it
to a per-cpu counter, we can reduce the amount of cacheline contention
on the class structure when multiple CPUs are trying to acquire locks
of the same class simultaneously.

This patch also fixes a bug in the increment code as the counter is of
the unsigned long type, but atomic_inc() was used to increment it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep.h  |  2 +-
 kernel/locking/lockdep.c | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b0d0b51..f8bf705 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -102,7 +102,7 @@ struct lock_class {
 	/*
 	 * Statistics counter:
 	 */
-	unsigned long			ops;
+	unsigned long __percpu		*pops;
 
 	const char			*name;
 	int				name_version;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ca002c0..7a0ed1d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -139,6 +139,7 @@ static inline int debug_locks_off_graph_unlock(void)
  */
 unsigned long nr_lock_classes;
 static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
+static DEFINE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);
 
 static inline struct lock_class *hlock_class(struct held_lock *hlock)
 {
@@ -784,11 +785,14 @@ static bool assign_lock_key(struct lockdep_map *lock)
 		dump_stack();
 		return NULL;
 	}
-	class = lock_classes + nr_lock_classes++;
+	class = lock_classes + nr_lock_classes;
 	debug_atomic_inc(nr_unused_locks);
 	class->key = key;
 	class->name = lock->name;
 	class->subclass = subclass;
+	class->pops = &lock_class_ops[nr_lock_classes];
+	nr_lock_classes++;
+
 	INIT_LIST_HEAD(&class->lock_entry);
 	INIT_LIST_HEAD(&class->locks_before);
 	INIT_LIST_HEAD(&class->locks_after);
@@ -1387,11 +1391,15 @@ static inline int usage_match(struct lock_list *entry, void *bit)
 
 static void print_lock_class_header(struct lock_class *class, int depth)
 {
-	int bit;
+	int bit, cpu;
+	unsigned long ops = 0UL;
+
+	for_each_possible_cpu(cpu)
+		ops += *per_cpu(class->pops, cpu);
 
 	printk("%*s->", depth, "");
 	print_lock_name(class);
-	printk(KERN_CONT " ops: %lu", class->ops);
+	printk(KERN_CONT " ops: %lu", ops);
 	printk(KERN_CONT " {\n");
 
 	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
@@ -3226,7 +3234,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		if (!class)
 			return 0;
 	}
-	atomic_inc((atomic_t *)&class->ops);
+
+	__this_cpu_inc(*class->pops);
+
 	if (very_verbose(class)) {
 		printk("\nacquire class [%px] %s", class->key, class->name);
 		if (class->name_version > 1)
-- 
1.8.3.1

