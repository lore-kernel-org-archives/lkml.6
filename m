Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71027C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439EF20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439EF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbeKTFW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:22:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbeKTFW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:22:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3BAC3154866;
        Mon, 19 Nov 2018 18:57:33 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EFA4608E7;
        Mon, 19 Nov 2018 18:57:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 08/17] locking/lockdep: Add support for nestable terminal locks
Date:   Mon, 19 Nov 2018 13:55:17 -0500
Message-Id: <1542653726-5655-9-git-send-email-longman@redhat.com>
In-Reply-To: <1542653726-5655-1-git-send-email-longman@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 19 Nov 2018 18:57:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are use cases where we want to allow nesting of one terminal lock
underneath another terminal-like lock. That new lock type is called
nestable terminal lock which can optionally allow the acquisition of
no more than one regular (non-nestable) terminal lock underneath it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep.h            |  9 ++++++++-
 kernel/locking/lockdep.c           | 15 +++++++++++++--
 kernel/locking/lockdep_internals.h |  2 +-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index a146bca..b9435fb 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -148,16 +148,20 @@ struct lock_class_stats {
  * 1) LOCKDEP_FLAG_NOVALIDATE: No full validation, just simple checks.
  * 2) LOCKDEP_FLAG_TERMINAL: This is a terminal lock where lock/unlock on
  *    another lock within its critical section is not allowed.
+ * 3) LOCKDEP_FLAG_TERMINAL_NESTABLE: This is a terminal lock that can
+ *    allow one more regular terminal lock to be nested underneath it.
  *
  * Only the least significant 4 bits of the flags will be copied to the
  * held_lock structure.
  */
 #define LOCKDEP_FLAG_TERMINAL		(1 << 0)
+#define LOCKDEP_FLAG_TERMINAL_NESTABLE	(1 << 1)
 #define LOCKDEP_FLAG_NOVALIDATE 	(1 << 4)
 
 #define LOCKDEP_HLOCK_FLAGS_MASK	0x0f
 #define LOCKDEP_NOCHECK_FLAGS		(LOCKDEP_FLAG_NOVALIDATE |\
-					 LOCKDEP_FLAG_TERMINAL)
+					 LOCKDEP_FLAG_TERMINAL	 |\
+					 LOCKDEP_FLAG_TERMINAL_NESTABLE)
 
 /*
  * Map the lock object (the lock instance) to the lock-class object.
@@ -327,6 +331,8 @@ extern void lockdep_init_map(struct lockdep_map *lock, const char *name,
 	do { (lock)->dep_map.flags |= LOCKDEP_FLAG_NOVALIDATE; } while (0)
 #define lockdep_set_terminal_class(lock) \
 	do { (lock)->dep_map.flags |= LOCKDEP_FLAG_TERMINAL; } while (0)
+#define lockdep_set_terminal_nestable_class(lock) \
+	do { (lock)->dep_map.flags |= LOCKDEP_FLAG_TERMINAL_NESTABLE; } while (0)
 
 /*
  * Compare locking classes
@@ -444,6 +450,7 @@ static inline void lockdep_on(void)
 
 #define lockdep_set_novalidate_class(lock)	do { } while (0)
 #define lockdep_set_terminal_class(lock)	do { } while (0)
+#define lockdep_set_terminal_nestable_class(lock)	do { } while (0)
 
 /*
  * We don't define lockdep_match_class() and lockdep_match_key() for !LOCKDEP
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 40894c1..5a853a6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3263,13 +3263,24 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	class_idx = class - lock_classes + 1;
 
 	if (depth) {
+		int prev_type;
+
 		hlock = curr->held_locks + depth - 1;
 
 		/*
-		 * Warn if the previous lock is a terminal lock.
+		 * Warn if the previous lock is a terminal lock or the
+		 * previous lock is a nestable terminal lock and the current
+		 * one isn't a regular terminal lock.
 		 */
-		if (DEBUG_LOCKS_WARN_ON(hlock_is_terminal(hlock)))
+		prev_type = hlock_is_terminal(hlock);
+		if (DEBUG_LOCKS_WARN_ON((prev_type == LOCKDEP_FLAG_TERMINAL) ||
+			((prev_type == LOCKDEP_FLAG_TERMINAL_NESTABLE) &&
+			 (flags_is_terminal(class->flags) !=
+				LOCKDEP_FLAG_TERMINAL)))) {
+			pr_warn("Terminal lock error: prev lock = %s, curr lock = %s\n",
+				hlock->instance->name, class->name);
 			return 0;
+		}
 
 		if (hlock->class_idx == class_idx && nest_lock) {
 			if (hlock->references) {
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 271fba8..51fa141 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -215,5 +215,5 @@ static inline unsigned long debug_class_ops_read(struct lock_class *class)
 
 static inline unsigned int flags_is_terminal(unsigned int flags)
 {
-	return flags & LOCKDEP_FLAG_TERMINAL;
+	return flags & (LOCKDEP_FLAG_TERMINAL|LOCKDEP_FLAG_TERMINAL_NESTABLE);
 }
-- 
1.8.3.1

