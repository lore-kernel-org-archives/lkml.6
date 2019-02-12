Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ADCC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D267222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991768;
	bh=OGRETl0u2qv/pNkkAyneT5R5GTDtQ87UvbVX6FutLnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=APPisCmsZ3u9tnNMrbSIkdiac8HllSdyTQgAqU5HhMzd6CxT/U63I5dy3EQNleYS7
	 kdFr5PcVdcdfxm82OmYcgWxW5IMMz9CivzWnCdoS7xdOi6XOUOcZjWCV/w1AdTMWur
	 aB6Yus5/1O+36XnybrnbOQ2uKChJlOTQhjP0+oZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbfBLRQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731650AbfBLRQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:05 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D15222B9;
        Tue, 12 Feb 2019 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991764;
        bh=OGRETl0u2qv/pNkkAyneT5R5GTDtQ87UvbVX6FutLnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCgM6kmDDqaRm+ndWrUpJOLWb4hCAlUlSiB4hmTyKrkNZynSYhIgxyNfcMZmOqxc5
         g5yBx9+auRnd2uQZfAykxprpqqFOkT/ifClyYaeRFAUZ6ZYrDvzLUs62B1HTlmqnSe
         ce0XwMLUzwM2TPQukjaUI4AM/OcS55t65u7V8cVI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 29/32] locking/lockdep: Branch the new vec-finegrained softirq masking to lockdep
Date:   Tue, 12 Feb 2019 18:14:20 +0100
Message-Id: <20190212171423.8308-30-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have full support from softirqs to perform per vector
masking, let's feed lockdep with the proper inputs and push the vector
numbers involved in a base softirq lock usage:

LOCK_ENABLED_SOFTIRQ: push local_softirq_enabled()
LOCK_USED_IN_SOFTIRQ: push curr->softirq_context, modified by
                      lockdep_softirq_enter/exit()

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index acd82145f6a6..570eea5376ec 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2877,6 +2877,7 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	 */
 	if (curr->softirqs_enabled) {
 		usage.bit = LOCK_ENABLED_SOFTIRQ;
+		usage.vector = local_softirq_enabled();
 		if (!mark_held_locks(curr, &usage))
 			return;
 	}
@@ -2964,6 +2965,7 @@ void trace_softirqs_on(unsigned long ip)
 	struct task_struct *curr = current;
 	struct lock_usage usage = {
 		.bit = LOCK_ENABLED_SOFTIRQ,
+		.vector = local_softirq_enabled()
 	};
 
 	if (unlikely(!debug_locks || current->lockdep_recursion))
@@ -3028,7 +3030,7 @@ void trace_softirqs_off(unsigned long ip)
 
 static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 {
-	struct lock_usage usage = { .vector = 0 };
+	struct lock_usage usage;
 	/*
 	 * If non-trylock use in a hardirq or softirq context, then
 	 * mark the lock as used in these contexts:
@@ -3037,22 +3039,26 @@ static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 		if (hlock->read) {
 			if (curr->hardirq_context) {
 				usage.bit = LOCK_USED_IN_HARDIRQ_READ;
+				usage.vector = 0;
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
 			if (curr->softirq_context) {
 				usage.bit = LOCK_USED_IN_SOFTIRQ_READ;
+				usage.vector = curr->softirq_context;
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
 		} else {
 			if (curr->hardirq_context) {
 				usage.bit = LOCK_USED_IN_HARDIRQ;
+				usage.vector = 0;
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
 			if (curr->softirq_context) {
 				usage.bit = LOCK_USED_IN_SOFTIRQ;
+				usage.vector = curr->softirq_context;
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
@@ -3061,19 +3067,23 @@ static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 	if (!hlock->hardirqs_off) {
 		if (hlock->read) {
 			usage.bit = LOCK_ENABLED_HARDIRQ_READ;
+			usage.vector = 0;
 			if (!mark_lock(curr, hlock, &usage))
 				return 0;
 			if (curr->softirqs_enabled) {
 				usage.bit = LOCK_ENABLED_SOFTIRQ_READ;
+				usage.vector = local_softirq_enabled();
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
 		} else {
 			usage.bit = LOCK_ENABLED_HARDIRQ;
+			usage.vector = 0;
 			if (!mark_lock(curr, hlock, &usage))
 				return 0;
 			if (curr->softirqs_enabled) {
 				usage.bit = LOCK_ENABLED_SOFTIRQ;
+				usage.vector = local_softirq_enabled();
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
-- 
2.17.1

