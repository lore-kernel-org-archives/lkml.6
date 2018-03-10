Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbeCJJ3f (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 04:29:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeCJJ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 04:29:34 -0500
Date: Sat, 10 Mar 2018 01:29:11 -0800
From: tip-bot for Alan Stern <tipbot@zytor.com>
Message-ID: <tip-bd5c0ba2cd78a4c116726ead84f8f37dc92d043e@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, paulmck@linux.vnet.ibm.com,
        parri.andrea@gmail.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, stern@rowland.harvard.edu, akiyks@gmail.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: parri.andrea@gmail.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        stern@rowland.harvard.edu, akiyks@gmail.com, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, paulmck@linux.vnet.ibm.com
In-Reply-To: <1520443660-16858-4-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1520443660-16858-4-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Finish the removal of
 rb-dep, smp_read_barrier_depends(), and lockless_dereference()
Git-Commit-ID: bd5c0ba2cd78a4c116726ead84f8f37dc92d043e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bd5c0ba2cd78a4c116726ead84f8f37dc92d043e
Gitweb:     https://git.kernel.org/tip/bd5c0ba2cd78a4c116726ead84f8f37dc92d043e
Author:     Alan Stern <stern@rowland.harvard.edu>
AuthorDate: Wed, 7 Mar 2018 09:27:40 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 10 Mar 2018 10:22:23 +0100

tools/memory-model: Finish the removal of rb-dep, smp_read_barrier_depends(), and lockless_dereference()

Commit:

  bf28ae562744 ("tools/memory-model: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference")

was merged too early, while it was still in RFC form.  This patch adds in
the missing pieces.

Akira pointed out some typos in the original patch, and he noted that
cheatsheet.txt should indicate that READ_ONCE() now implies an address
dependency.  Andrea suggested documenting the relationship betwwen
unsuccessful RMW operations and address dependencies.

Andrea pointed out that the macro for rcu_dereference() in linux.def
should now use the "once" annotation instead of "deref".  He also
suggested that the comments should mention commit:

  5a8897cc7631 ("locking/atomics/alpha: Add smp_read_barrier_depends() to _release()/_relaxed() atomics")

... as an important precursor, and he contributed commit:

  cb13b424e986 ("locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()")

which is another prerequisite.

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Suggested-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
[ Fixed read_read_lock() typo reported by Akira. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: will.deacon@arm.com
Fixes: bf28ae562744 ("tools/memory-model: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference")
Link: http://lkml.kernel.org/r/1520443660-16858-4-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/Documentation/cheatsheet.txt  | 6 +++---
 tools/memory-model/Documentation/explanation.txt | 4 ++--
 tools/memory-model/linux-kernel.def              | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 04e458acd6d4..956b1ae4aafb 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -1,11 +1,11 @@
                                   Prior Operation     Subsequent Operation
                                   ---------------  ---------------------------
                                C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
-                              __  ----  -  -  ---  ----  -  -  --  --  ---  --
+                              --  ----  -  -  ---  ----  -  -  --  --  ---  --
 
 Store, e.g., WRITE_ONCE()            Y                                       Y
-Load, e.g., READ_ONCE()              Y                              Y        Y
-Unsuccessful RMW operation           Y                              Y        Y
+Load, e.g., READ_ONCE()              Y                          Y   Y        Y
+Unsuccessful RMW operation           Y                          Y   Y        Y
 rcu_dereference()                    Y                          Y   Y        Y
 Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
 Successful *_release()         C        Y  Y    Y     W                      Y
diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index dae8b8cb2ad3..a727c82bd434 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -826,7 +826,7 @@ A-cumulative; they only affect the propagation of stores that are
 executed on C before the fence (i.e., those which precede the fence in
 program order).
 
-read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
+rcu_read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
 other properties which we discuss later.
 
 
@@ -1138,7 +1138,7 @@ final effect is that even though the two loads really are executed in
 program order, it appears that they aren't.
 
 This could not have happened if the local cache had processed the
-incoming stores in FIFO order.  In constrast, other architectures
+incoming stores in FIFO order.  By contrast, other architectures
 maintain at least the appearance of FIFO order.
 
 In practice, this difficulty is solved by inserting a special fence
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 5dfb9c7f3462..397e4e67e8c8 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -13,7 +13,7 @@ WRITE_ONCE(X,V) { __store{once}(X,V); }
 smp_store_release(X,V) { __store{release}(*X,V); }
 smp_load_acquire(X) __load{acquire}(*X)
 rcu_assign_pointer(X,V) { __store{release}(X,V); }
-rcu_dereference(X) __load{deref}(X)
+rcu_dereference(X) __load{once}(X)
 
 // Fences
 smp_mb() { __fence{mb} ; }
