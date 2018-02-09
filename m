Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBIQHB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:07:01 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:38390 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeBIQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:07:00 -0500
X-Google-Smtp-Source: AH8x226e3/Xbd2KIU1LjHHKbPq3p7UBW/r5Xs6UG82gpN6+nE1mhP5Dn7PeFwK/qyAoErucuiv0cqQ==
Subject: [PATCH] tools/memory-model: Restore compat with herd7 7.47 ("-" ->
 "_")
To: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, Akira Yokosawa <akiyks@gmail.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <20180209141832.GA17505@linux.vnet.ibm.com>
 <df87e89b-7fbe-37a7-42cb-62df74591df4@gmail.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <71d58dec-b76f-8458-1c61-b7d6237634a1@gmail.com>
Date: Sat, 10 Feb 2018 01:06:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <df87e89b-7fbe-37a7-42cb-62df74591df4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 9a0de4d75e18ef8e25a1096f88c7a970d9d693f5 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sat, 10 Feb 2018 00:45:25 +0900
Subject: [PATCH] tools/memory-model: Restore compat with herd7 7.47 ("-" -> "_")

As of herd7 7.47, these '-'s are not permitted and end up in
an error:

    File "./linux-kernel.def", line 44, characters 29-30:
    unexpected '-' (in macros)

Partial revert of commit 2d5fba7782d6 ("linux-kernel*: Make RCU
identifiers match ASPLOS paper") in the repository at
https://github.com/aparri/memory-model can restore the compatibility
with herd7 7.47.

Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
Suggested-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/linux-kernel.bell | 20 ++++++++++----------
 tools/memory-model/linux-kernel.cat  |  8 ++++----
 tools/memory-model/linux-kernel.def  | 14 +++++++-------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 18885ad..436791b 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -25,18 +25,18 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
 		'mb (*smp_mb*) ||
 		'rb_dep (*smp_read_barrier_depends*) ||
-		'rcu-lock (*rcu_read_lock*)  ||
-		'rcu-unlock (*rcu_read_unlock*) ||
-		'sync-rcu (*synchronize_rcu*) ||
-		'before-atomic (*smp_mb__before_atomic*) ||
-		'after-atomic (*smp_mb__after_atomic*) ||
-		'after-spinlock (*smp_mb__after_spinlock*)
+		'rcu_lock (*rcu_read_lock*)  ||
+		'rcu_unlock (*rcu_read_unlock*) ||
+		'sync_rcu (*synchronize_rcu*) ||
+		'before_atomic (*smp_mb__before_atomic*) ||
+		'after_atomic (*smp_mb__after_atomic*) ||
+		'after_spinlock (*smp_mb__after_spinlock*)
 instructions F[Barriers]
 
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
 let matched = let rec
-	    unmatched-locks = Rcu-lock \ domain(matched)
-	and unmatched-unlocks = Rcu-unlock \ range(matched)
+	    unmatched-locks = Rcu_lock \ domain(matched)
+	and unmatched-unlocks = Rcu_unlock \ range(matched)
 	and unmatched = unmatched-locks | unmatched-unlocks
 	and unmatched-po = [unmatched] ; po ; [unmatched]
 	and unmatched-locks-to-unlocks =
@@ -46,8 +46,8 @@ let matched = let rec
 	in matched
 
 (* Validate nesting *)
-flag ~empty Rcu-lock \ domain(matched) as unbalanced-rcu-locking
-flag ~empty Rcu-unlock \ range(matched) as unbalanced-rcu-locking
+flag ~empty Rcu_lock \ domain(matched) as unbalanced-rcu-locking
+flag ~empty Rcu_unlock \ range(matched) as unbalanced-rcu-locking
 
 (* Outermost level of nesting only *)
 let crit = matched \ (po^-1 ; matched ; po^-1)
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index f0d27f8..d0085d5 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -29,10 +29,10 @@ let rb-dep = [R] ; fencerel(Rb_dep) ; [R]
 let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
-	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
-	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
-	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
-let gp = po ; [Sync-rcu] ; po?
+	([M] ; fencerel(Before_atomic) ; [RMW] ; po? ; [M]) |
+	([M] ; po? ; [RMW] ; fencerel(After_atomic) ; [M]) |
+	([M] ; po? ; [LKW] ; fencerel(After_spinlock) ; [M])
+let gp = po ; [Sync_rcu] ; po?
 
 let strong-fence = mb | gp
 
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index f5a1eb0..fc08371 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -21,9 +21,9 @@ smp_mb() { __fence{mb} ; }
 smp_rmb() { __fence{rmb} ; }
 smp_wmb() { __fence{wmb} ; }
 smp_read_barrier_depends() { __fence{rb_dep}; }
-smp_mb__before_atomic() { __fence{before-atomic} ; }
-smp_mb__after_atomic() { __fence{after-atomic} ; }
-smp_mb__after_spinlock() { __fence{after-spinlock} ; }
+smp_mb__before_atomic() { __fence{before_atomic} ; }
+smp_mb__after_atomic() { __fence{after_atomic} ; }
+smp_mb__after_spinlock() { __fence{after_spinlock} ; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
@@ -41,10 +41,10 @@ spin_unlock(X) { __unlock(X) ; }
 spin_trylock(X) __trylock(X)
 
 // RCU
-rcu_read_lock() { __fence{rcu-lock}; }
-rcu_read_unlock() { __fence{rcu-unlock};}
-synchronize_rcu() { __fence{sync-rcu}; }
-synchronize_rcu_expedited() { __fence{sync-rcu}; }
+rcu_read_lock() { __fence{rcu_lock}; }
+rcu_read_unlock() { __fence{rcu_unlock};}
+synchronize_rcu() { __fence{sync_rcu}; }
+synchronize_rcu_expedited() { __fence{sync_rcu}; }
 
 // Atomic
 atomic_read(X) READ_ONCE(*X)
-- 
2.7.4
