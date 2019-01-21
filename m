Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D313C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D13E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfAUL03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:26:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32789 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfAUL02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:26:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBNoP22493769
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:23:50 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBNnNP2493766;
        Mon, 21 Jan 2019 03:23:49 -0800
Date:   Mon, 21 Jan 2019 03:23:49 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-5b735eb1ce481b2f1674a47c0995944b1cb6f5d5@git.kernel.org>
Cc:     will.deacon@arm.com, stern@rowland.harvard.edu,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, peterz@infradead.org,
        tglx@linutronix.de, paulmck@linux.ibm.com, mingo@kernel.org,
        andrea.parri@amarulasolutions.com, dlustig@nvidia.com,
        npiggin@gmail.com, hpa@zytor.com, akiyks@gmail.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, boqun.feng@gmail.com
Reply-To: torvalds@linux-foundation.org, boqun.feng@gmail.com,
          akiyks@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          dhowells@redhat.com, andrea.parri@amarulasolutions.com,
          npiggin@gmail.com, dlustig@nvidia.com, mingo@kernel.org,
          tglx@linutronix.de, paulmck@linux.ibm.com, luc.maranget@inria.fr,
          peterz@infradead.org, j.alglave@ucl.ac.uk,
          stern@rowland.harvard.edu, will.deacon@arm.com
In-Reply-To: <20181203230451.28921-1-paulmck@linux.ibm.com>
References: <20181203230451.28921-1-paulmck@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Model
 smp_mb__after_unlock_lock()
Git-Commit-ID: 5b735eb1ce481b2f1674a47c0995944b1cb6f5d5
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

Commit-ID:  5b735eb1ce481b2f1674a47c0995944b1cb6f5d5
Gitweb:     https://git.kernel.org/tip/5b735eb1ce481b2f1674a47c0995944b1cb6f5d5
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 3 Dec 2018 15:04:49 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:06:55 +0100

tools/memory-model: Model smp_mb__after_unlock_lock()

The kernel documents smp_mb__after_unlock_lock() the following way:

  "Place this after a lock-acquisition primitive to guarantee that
   an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
   if the UNLOCK and LOCK are executed by the same CPU or if the
   UNLOCK and LOCK operate on the same lock variable."

Formalize in LKMM the above guarantee by defining (new) mb-links according
to the law:

  ([M] ; po ; [UL] ; (co | po) ; [LKW] ;
	fencerel(After-unlock-lock) ; [M])

where the component ([UL] ; co ; [LKW]) identifies "UNLOCK+LOCK pairs on
the same lock variable" and the component ([UL] ; po ; [LKW]) identifies
"UNLOCK+LOCK pairs executed by the same CPU".

In particular, the LKMM forbids the following two behaviors (the second
litmus test below is based on:

  Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html

c.f., Section "Tree RCU Grace Period Memory Ordering Building Blocks"):

C after-unlock-lock-same-cpu

(*
 * Result: Never
 *)

{}

P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
{
	int r0;

	spin_lock(s);
	WRITE_ONCE(*x, 1);
	spin_unlock(s);
	spin_lock(t);
	smp_mb__after_unlock_lock();
	r0 = READ_ONCE(*y);
	spin_unlock(t);
}

P1(int *x, int *y)
{
	int r0;

	WRITE_ONCE(*y, 1);
	smp_mb();
	r0 = READ_ONCE(*x);
}

exists (0:r0=0 /\ 1:r0=0)

C after-unlock-lock-same-lock-variable

(*
 * Result: Never
 *)

{}

P0(spinlock_t *s, int *x, int *y)
{
	int r0;

	spin_lock(s);
	WRITE_ONCE(*x, 1);
	r0 = READ_ONCE(*y);
	spin_unlock(s);
}

P1(spinlock_t *s, int *y, int *z)
{
	int r0;

	spin_lock(s);
	smp_mb__after_unlock_lock();
	WRITE_ONCE(*y, 1);
	r0 = READ_ONCE(*z);
	spin_unlock(s);
}

P2(int *z, int *x)
{
	int r0;

	WRITE_ONCE(*z, 1);
	smp_mb();
	r0 = READ_ONCE(*x);
}

exists (0:r0=0 /\ 1:r0=0 /\ 2:r0=0)

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/20181203230451.28921-1-paulmck@linux.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/linux-kernel.bell | 3 ++-
 tools/memory-model/linux-kernel.cat  | 4 +++-
 tools/memory-model/linux-kernel.def  | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index b84fb2f67109..796513362c05 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -29,7 +29,8 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'sync-rcu (*synchronize_rcu*) ||
 		'before-atomic (*smp_mb__before_atomic*) ||
 		'after-atomic (*smp_mb__after_atomic*) ||
-		'after-spinlock (*smp_mb__after_spinlock*)
+		'after-spinlock (*smp_mb__after_spinlock*) ||
+		'after-unlock-lock (*smp_mb__after_unlock_lock*)
 instructions F[Barriers]
 
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 882fc33274ac..8f23c74a96fd 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -30,7 +30,9 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
-	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
+	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
+	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
+		fencerel(After-unlock-lock) ; [M])
 let gp = po ; [Sync-rcu] ; po?
 
 let strong-fence = mb | gp
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 6fa3eb28d40b..b27911cc087d 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -23,6 +23,7 @@ smp_wmb() { __fence{wmb}; }
 smp_mb__before_atomic() { __fence{before-atomic}; }
 smp_mb__after_atomic() { __fence{after-atomic}; }
 smp_mb__after_spinlock() { __fence{after-spinlock}; }
+smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
