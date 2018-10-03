Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205DEC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53F92098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53F92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeJCOTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:19:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJCOTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:19:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w937VNIX2264449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 00:31:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w937VNEJ2264443;
        Wed, 3 Oct 2018 00:31:23 -0700
Date:   Wed, 3 Oct 2018 00:31:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-8ee10862476ef8b9e81e5b521205fd5c620b4ffb@git.kernel.org>
Cc:     will.deacon@arm.com, a.p.zijlstra@chello.nl, hpa@zytor.com,
        mingo@kernel.org, longman@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          longman@redhat.com, mingo@kernel.org, hpa@zytor.com,
          will.deacon@arm.com, a.p.zijlstra@chello.nl
In-Reply-To: <1538511560-10090-3-git-send-email-longman@redhat.com>
References: <1538511560-10090-3-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Eliminate redundant IRQs check
 in __lock_acquire()
Git-Commit-ID: 8ee10862476ef8b9e81e5b521205fd5c620b4ffb
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

Commit-ID:  8ee10862476ef8b9e81e5b521205fd5c620b4ffb
Gitweb:     https://git.kernel.org/tip/8ee10862476ef8b9e81e5b521205fd5c620b4ffb
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 2 Oct 2018 16:19:17 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Oct 2018 08:46:02 +0200

locking/lockdep: Eliminate redundant IRQs check in __lock_acquire()

The static __lock_acquire() function has only two callers:

 1) lock_acquire()
 2) reacquire_held_locks()

In lock_acquire(), raw_local_irq_save() is called beforehand. So
IRQs must have been disabled. So the check:

	DEBUG_LOCKS_WARN_ON(!irqs_disabled())

is kind of redundant in this case. So move the above check
to reacquire_held_locks() to eliminate redundant code in the
lock_acquire() path.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1538511560-10090-3-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index fa82d55279fe..a5d7db558928 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3193,6 +3193,10 @@ static int __lock_is_held(const struct lockdep_map *lock, int read);
 /*
  * This gets called for every mutex_lock*()/spin_lock*() operation.
  * We maintain the dependency maps and validate the locking attempt:
+ *
+ * The callers must make sure that IRQs are disabled before calling it,
+ * otherwise we could get an interrupt which would want to take locks,
+ * which would end up in lockdep again.
  */
 static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 			  int trylock, int read, int check, int hardirqs_off,
@@ -3210,14 +3214,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (unlikely(!debug_locks))
 		return 0;
 
-	/*
-	 * Lockdep should run with IRQs disabled, otherwise we could
-	 * get an interrupt which would want to take locks, which would
-	 * end up in lockdep and have you got a head-ache already?
-	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
-		return 0;
-
 	if (!prove_locking || lock->key == &__lockdep_no_validate__)
 		check = 0;
 
@@ -3474,6 +3470,9 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
 {
 	struct held_lock *hlock;
 
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return 0;
+
 	for (hlock = curr->held_locks + idx; idx < depth; idx++, hlock++) {
 		if (!__lock_acquire(hlock->instance,
 				    hlock_class(hlock)->subclass,
