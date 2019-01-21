Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4706C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B49020663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfAULbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:31:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50337 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfAULbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:31:40 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBVNFS2496663
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:31:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBVMCg2496658;
        Mon, 21 Jan 2019 03:31:22 -0800
Date:   Mon, 21 Jan 2019 03:31:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-436a49ae7b693161c4fdf98b575ef16243dc2dfa@git.kernel.org>
Cc:     peterz@infradead.org, frederic@kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        will.deacon@arm.com, mingo@kernel.org, paulmck@linux.vnet.ibm.com
Reply-To: tglx@linutronix.de, will.deacon@arm.com, mingo@kernel.org,
          paulmck@linux.vnet.ibm.com, peterz@infradead.org,
          frederic@kernel.org, akpm@linux-foundation.org,
          torvalds@linux-foundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1545973321-24422-2-git-send-email-frederic@kernel.org>
References: <1545973321-24422-2-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Simplify mark_held_locks()
Git-Commit-ID: 436a49ae7b693161c4fdf98b575ef16243dc2dfa
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

Commit-ID:  436a49ae7b693161c4fdf98b575ef16243dc2dfa
Gitweb:     https://git.kernel.org/tip/436a49ae7b693161c4fdf98b575ef16243dc2dfa
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Fri, 28 Dec 2018 06:02:00 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:18:54 +0100

locking/lockdep: Simplify mark_held_locks()

The enum mark_type appears a bit artificial here. We can directly pass
the base enum lock_usage_bit value to mark_held_locks(). All we need
then is to add the read index for each lock if necessary. It makes the
code clearer.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/1545973321-24422-2-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e805fe3bf87f..1dcd8341e35b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2709,35 +2709,28 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	return 1;
 }
 
-enum mark_type {
-#define LOCKDEP_STATE(__STATE)	__STATE,
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-};
-
 /*
  * Mark all held locks with a usage bit:
  */
 static int
-mark_held_locks(struct task_struct *curr, enum mark_type mark)
+mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
 {
-	enum lock_usage_bit usage_bit;
 	struct held_lock *hlock;
 	int i;
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
+		enum lock_usage_bit hlock_bit = base_bit;
 		hlock = curr->held_locks + i;
 
-		usage_bit = 2 + (mark << 2); /* ENABLED */
 		if (hlock->read)
-			usage_bit += 1; /* READ */
+			hlock_bit += 1; /* READ */
 
-		BUG_ON(usage_bit >= LOCK_USAGE_STATES);
+		BUG_ON(hlock_bit >= LOCK_USAGE_STATES);
 
 		if (!hlock->check)
 			continue;
 
-		if (!mark_lock(curr, hlock, usage_bit))
+		if (!mark_lock(curr, hlock, hlock_bit))
 			return 0;
 	}
 
@@ -2758,7 +2751,7 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	 * We are going to turn hardirqs on, so set the
 	 * usage bit for all held locks:
 	 */
-	if (!mark_held_locks(curr, HARDIRQ))
+	if (!mark_held_locks(curr, LOCK_ENABLED_HARDIRQ))
 		return;
 	/*
 	 * If we have softirqs enabled, then set the usage
@@ -2766,7 +2759,7 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	 * this bit from being set before)
 	 */
 	if (curr->softirqs_enabled)
-		if (!mark_held_locks(curr, SOFTIRQ))
+		if (!mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ))
 			return;
 
 	curr->hardirq_enable_ip = ip;
@@ -2880,7 +2873,7 @@ void trace_softirqs_on(unsigned long ip)
 	 * enabled too:
 	 */
 	if (curr->hardirqs_enabled)
-		mark_held_locks(curr, SOFTIRQ);
+		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
 	current->lockdep_recursion = 0;
 }
 
