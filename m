Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DDBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29E521480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FqZxiRmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29E521480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIXQqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:46:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45798 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIXQqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:46:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id j2-v6so2526106edp.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lE7GLv+I95SJzhLDRzuZARrHrYBlTOPVcftV95LpZkg=;
        b=FqZxiRmj4nk6MbPrnsVlF6AHO/DeLTDToUt4gB+tulXJcKPooyPojW3gPjpcdBb06P
         ZJmpBT3j7wek9Dd3s1w/5z/kZr3LsKq0M7QEUevi6ctlOspH3a32/tp1/thJq/7cBw0G
         t5OEWCv4OerQg0YA1zvyNREmTiXbYIBtd9TEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lE7GLv+I95SJzhLDRzuZARrHrYBlTOPVcftV95LpZkg=;
        b=YiKa9QgbEhSGwkOvlnbJpzptw3v1kUVKIjJkpwiUmYYMzs6y5sfv2JYE5x/kSVaHOc
         KdYtQrimT4j36zfr3KS/TLqqdPA5grjniiQCcuRCb/ZQhANCqLGxHspbJvPblQUcg3Sz
         g5ydMvm9Df5x/2s4i5eRFvzbAvQuw6R39Lm64U0Hcb85QpBRTGa2FmBih09du0/Xzlfq
         m8A9OpMo80rkFXfh8k/mJwIpBKR2e8wkjhFdQUyDskWmFPpTWHpil6ey/tbxUJ4gvRNh
         YTo3lIbdosRlVNmnlE8EQ4Mt2GhPPIR/c4+3XLptU66+wkfrIyZASPZVcuDjur0BmsBF
         mUog==
X-Gm-Message-State: ABuFfogvTk4d3bqFu6A/BPCej3YATkzfM4++/PXb6xpsAmsUhjpob/cN
        v6JCj9UPrX6tS7G2Gz2Jxc9NfRZFmR530w==
X-Google-Smtp-Source: ANB0VdYgTkFFO/b+JFVFy5mQu20rxwx3t6n6VRP4i6s2MI6sFe7g+6tW2KQa5Opcy2olIPn36i+WtQ==
X-Received: by 2002:a50:eb96:: with SMTP id y22-v6mr15770856edr.38.1537785900953;
        Mon, 24 Sep 2018 03:45:00 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id x22-v6sm5415402edb.8.2018.09.24.03.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 03:45:00 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: [PATCH] tools/memory-model: Model smp_mb__after_unlock_lock()
Date:   Mon, 24 Sep 2018 12:44:49 +0200
Message-Id: <20180924104449.8211-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the header comment for smp_mb__after_unlock_lock():

  "Place this after a lock-acquisition primitive to guarantee that
   an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
   if the UNLOCK and LOCK are executed by the same CPU or if the
   UNLOCK and LOCK operate on the same lock variable."

This formalizes the above guarantee by defining (new) mb-links according
to the law:

  ([M] ; po ; [UL] ; (co | po) ; [LKW] ;
	fencerel(After-unlock-lock) ; [M])

where the component ([UL] ; co ; [LKW]) identifies "UNLOCK+LOCK pairs on
the same lock variable" and the component ([UL] ; po ; [LKW]) identifies
"UNLOCK+LOCK pairs executed by the same CPU".

In particular, the LKMM forbids the following two behaviors (the second
litmus test below is based on

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
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
---
NOTES.

- A number of equivalent formalizations seems available; for example,
  we could replace "co" in the law above with "coe" (by "coherence")
  and we could limit "coe" to "singlestep(coe)" (by the "prop" term).
  These changes did not show significant performance improvement and
  they looked slightly less readable to me, hence...

- The mb-links order memory accesses po-_before_ the lock-release to
  memory accesses po-_after_ the lock-acquire; in part., this forma-
  lization does _not_ forbid the following behavior (after A. Stern):

C po-in-after-unlock-lock

{}

P0(spinlock_t *s, spinlock_t *t, int *y)
{
	int r0;

	spin_lock(s);
	spin_unlock(s);

	spin_lock(t);
	smp_mb__after_unlock_lock();
	r0 = READ_ONCE(*y);
	spin_unlock(t);
}

P1(spinlock_t *s, int *y)
{
	int r0;

	WRITE_ONCE(*y, 1);
	smp_mb();
	r0 = spin_is_locked(s);
}

exists (0:r0=0 /\ 1:r0=0)

- I'm not aware of currently supported architectures (implementations)
  of smp_mb__after_unlock_lock() and spin_{lock,unlock}() which would
  violate the guarantee formalized in this patch.  It is worth noting
  that the same conclusion does _not_ extend to other locking primiti-
  ves (e.g., write_{lock,unlock}()), AFAICT: c.f., e.g., riscv.  This
  "works" considered the callsites for the barrier, but yeah...
---
 tools/memory-model/linux-kernel.bell | 3 ++-
 tools/memory-model/linux-kernel.cat  | 4 +++-
 tools/memory-model/linux-kernel.def  | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index b84fb2f67109e..796513362c052 100644
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
index 882fc33274ac3..8f23c74a96fdc 100644
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
index 6fa3eb28d40b5..b27911cc087d4 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -23,6 +23,7 @@ smp_wmb() { __fence{wmb}; }
 smp_mb__before_atomic() { __fence{before-atomic}; }
 smp_mb__after_atomic() { __fence{after-atomic}; }
 smp_mb__after_spinlock() { __fence{after-spinlock}; }
+smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
-- 
2.17.1

