Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98868ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFAC20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFAC20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeKIGNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:13:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbeKIGNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:13:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1509F307D85A;
        Thu,  8 Nov 2018 20:35:52 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE648101F97D;
        Thu,  8 Nov 2018 20:35:50 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 07/12] locking/lockdep: Add support for nested terminal locks
Date:   Thu,  8 Nov 2018 15:34:23 -0500
Message-Id: <1541709268-3766-8-git-send-email-longman@redhat.com>
In-Reply-To: <1541709268-3766-1-git-send-email-longman@redhat.com>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 08 Nov 2018 20:35:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are use cases where we want to allow 2-level nesting of one
terminal lock underneath another one. So the terminal lock type is now
extended to support a new nested terminal lock where it can allow the
acquisition of another regular terminal lock underneath it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep.h            |  9 ++++++++-
 kernel/locking/lockdep.c           | 15 +++++++++++++--
 kernel/locking/lockdep_internals.h |  2 +-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c5ff8c5..ed4d177 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -147,12 +147,16 @@ struct lock_class_stats {
  * 1) LOCKDEP_FLAG_NOVALIDATE: No full validation, just simple checks.
  * 2) LOCKDEP_FLAG_TERMINAL: This is a terminal lock where lock/unlock on
  *    another lock within its critical section is not allowed.
+ * 3) LOCKDEP_FLAG_TERMINAL_NESTED: This is a terminal lock that allows
+ *    one more regular terminal lock to be nested underneath it.
  */
 #define LOCKDEP_FLAG_NOVALIDATE 	(1 << 0)
 #define LOCKDEP_FLAG_TERMINAL		(1 << 1)
+#define LOCKDEP_FLAG_TERMINAL_NESTED	(1 << 2)
 
 #define LOCKDEP_NOCHECK_FLAGS		(LOCKDEP_FLAG_NOVALIDATE |\
-					 LOCKDEP_FLAG_TERMINAL)
+					 LOCKDEP_FLAG_TERMINAL   |\
+					 LOCKDEP_FLAG_TERMINAL_NESTED)
 
 /*
  * Map the lock object (the lock instance) to the lock-class object.
@@ -314,6 +318,8 @@ extern void lockdep_init_map(struct lockdep_map *lock, const char *name,
 	do { (lock)->dep_map.flags |= LOCKDEP_FLAG_NOVALIDATE; } while (0)
 #define lockdep_set_terminal_class(lock) \
 	do { (lock)->dep_map.flags |= LOCKDEP_FLAG_TERMINAL; } while (0)
+#define lockdep_set_terminal_nested_class(lock) \
+	do { (lock)->dep_map.flags |= LOCKDEP_FLAG_TERMINAL_NESTED; } while (0)
 
 /*
  * Compare locking classes
@@ -431,6 +437,7 @@ static inline void lockdep_on(void)
 
 #define lockdep_set_novalidate_class(lock)	do { } while (0)
 #define lockdep_set_terminal_class(lock)	do { } while (0)
+#define lockdep_set_terminal_nested_class(lock)	do { } while (0)
 
 /*
  * We don't define lockdep_match_class() and lockdep_match_key() for !LOCKDEP
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 02631a0..2b75613 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3268,13 +3268,24 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	class_idx = class - lock_classes + 1;
 
 	if (depth) {
+		int prev_type;
+
 		hlock = curr->held_locks + depth - 1;
 
 		/*
-		 * Warn if the previous lock is a terminal lock.
+		 * Warn if the previous lock is a terminal lock or the
+		 * previous lock is a nested terminal lock and the current
+		 * one isn't a regular terminal lock.
 		 */
-		if (DEBUG_LOCKS_WARN_ON(hlock_is_terminal(hlock)))
+		prev_type = hlock_is_terminal(hlock);
+		if (DEBUG_LOCKS_WARN_ON((prev_type == LOCKDEP_FLAG_TERMINAL) ||
+			((prev_type == LOCKDEP_FLAG_TERMINAL_NESTED) &&
+			 (flags_is_terminal(class->flags) !=
+				LOCKDEP_FLAG_TERMINAL)))) {
+			pr_warn("Terminal lock error: prev lock = %s, curr lock = %s\n",
+				hlock->instance->name, class->name);
 			return 0;
+		}
 
 		if (hlock->class_idx == class_idx && nest_lock) {
 			if (hlock->references) {
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 271fba8..abe646a 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -215,5 +215,5 @@ static inline unsigned long debug_class_ops_read(struct lock_class *class)
 
 static inline unsigned int flags_is_terminal(unsigned int flags)
 {
-	return flags & LOCKDEP_FLAG_TERMINAL;
+	return flags & (LOCKDEP_FLAG_TERMINAL|LOCKDEP_FLAG_TERMINAL_NESTED);
 }
-- 
1.8.3.1

