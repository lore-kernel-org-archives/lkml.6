Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02353C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3272222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991875;
	bh=cIEP7H9Mp1lVsnhgifnr/mbe5BEqFCIVfXDH2oV8UP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P3DdmPUqhHycuae2Ygemk/3Qok8LOwwpeaovs8DAmz4jnJ6zlJ+h44qB+Vd8e9Hct
	 qcx63D/0yC+BjQkA6pkbEc3T9EKfP1QGce0HieS0wYHBJBj3nJak7nVxdme+Y8D4vB
	 mEZAplQ9J/OB0ysl5SsTxVPll1f8i+MyQhrbZcUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfBLRRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbfBLRP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:58 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF5F222B8;
        Tue, 12 Feb 2019 17:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991757;
        bh=cIEP7H9Mp1lVsnhgifnr/mbe5BEqFCIVfXDH2oV8UP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFgEvGqngbI9wc9KMtgNDRp7uQuRJLpqRbesI1GzhTHtRC67lw4c7OBgj72qLP5sW
         CURJko5xUgsGr5BlFAgi66VFYOaSrFY5iWeY+VM4LKMrJHu7wFixP3CDiXitWEhCHX
         haB5LHK/dFiPN5716xK67NhG3y3QptLDDEUvYsbs=
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
Subject: [PATCH 27/32] locking/lockdep: Remove redundant softirqs on check
Date:   Tue, 12 Feb 2019 18:14:18 +0100
Message-Id: <20190212171423.8308-28-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes no more sense to check for redundant softirqs on because
trace_softirqs_on() is no more symmetrical to trace_softirqs_off().

Indeed trace_softirqs_off() is called whenever we know that all softirq
vectors have been disabled. And trace_softirqs_on() is called everytime
we enable at least one vector. So curr->softirqs_enabled may well remain
true throughout subsequent calls.

FIXME: Perhaps we should rename those functions. Another solution would
be to make curr->softirqs_enabled to record the last value of
local_softirqs_enabled() so we could track again redundant calls.

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
 kernel/locking/lockdep.c           | 5 -----
 kernel/locking/lockdep_internals.h | 1 -
 kernel/locking/lockdep_proc.c      | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6a74b433fe4c..9bb39677fd97 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2976,11 +2976,6 @@ void trace_softirqs_on(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
 
-	if (curr->softirqs_enabled) {
-		debug_atomic_inc(redundant_softirqs_on);
-		return;
-	}
-
 	current->lockdep_recursion = 1;
 	/*
 	 * We'll do an OFF -> ON transition:
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 4b0c03f0f7ce..3401e4a91afb 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -186,7 +186,6 @@ struct lockdep_stats {
 	int	redundant_hardirqs_off;
 	int	softirqs_on_events;
 	int	softirqs_off_events;
-	int	redundant_softirqs_on;
 	int	redundant_softirqs_off;
 	int	nr_unused_locks;
 	int	nr_redundant_checks;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 3d31f9b0059e..4157560b36d2 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -169,7 +169,7 @@ static void lockdep_stats_debug_show(struct seq_file *m)
 			   hr2 = debug_atomic_read(redundant_hardirqs_off),
 			   si1 = debug_atomic_read(softirqs_on_events),
 			   si2 = debug_atomic_read(softirqs_off_events),
-			   sr1 = debug_atomic_read(redundant_softirqs_on),
+			   sr1 = 0,
 			   sr2 = debug_atomic_read(redundant_softirqs_off);
 
 	seq_printf(m, " chain lookup misses:           %11llu\n",
-- 
2.17.1

