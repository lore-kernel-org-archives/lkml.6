Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2371CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A218A208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A218A208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933118AbeGIUB7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:01:59 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54980 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S932764AbeGIUB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:01:58 -0400
Received: (qmail 10366 invoked by uid 2102); 9 Jul 2018 16:01:57 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jul 2018 16:01:57 -0400
Date:   Mon, 9 Jul 2018 16:01:57 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More than one kernel developer has expressed the opinion that the LKMM
should enforce ordering of writes by locking.  In other words, given
the following code:

	WRITE_ONCE(x, 1);
	spin_unlock(&s):
	spin_lock(&s);
	WRITE_ONCE(y, 1);

the stores to x and y should be propagated in order to all other CPUs,
even though those other CPUs might not access the lock s.  In terms of
the memory model, this means expanding the cumul-fence relation.

Locks should also provide read-read (and read-write) ordering in a
similar way.  Given:

	READ_ONCE(x);
	spin_unlock(&s);
	spin_lock(&s);
	READ_ONCE(y);		// or WRITE_ONCE(y, 1);

the load of x should be executed before the load of (or store to) y.
The LKMM already provides this ordering, but it provides it even in
the case where the two accesses are separated by a release/acquire
pair of fences rather than unlock/lock.  This would prevent
architectures from using weakly ordered implementations of release and
acquire, which seems like an unnecessary restriction.  The patch
therefore removes the ordering requirement from the LKMM for that
case.

All the architectures supported by the Linux kernel (including RISC-V)
do provide this ordering for locks, albeit for varying reasons.
Therefore this patch changes the model in accordance with the
developers' wishes.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

v.2: Restrict the ordering to lock operations, not general release
and acquire fences.

[as1871b]


 tools/memory-model/Documentation/explanation.txt                           |  186 +++++++---
 tools/memory-model/linux-kernel.cat                                        |    8 
 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus |    5 
 3 files changed, 149 insertions(+), 50 deletions(-)

Index: usb-4.x/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-4.x.orig/tools/memory-model/linux-kernel.cat
+++ usb-4.x/tools/memory-model/linux-kernel.cat
@@ -38,7 +38,7 @@ let strong-fence = mb | gp
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let rfi-rel-acq = [Release] ; rfi ; [Acquire]
+let unlock-rf-lock-po = [UL] ; rf ; [LKR] ; po
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -60,13 +60,13 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
-let to-r = addr | (dep ; rfi) | rfi-rel-acq
+let to-r = addr | (dep ; rfi)
 let fence = strong-fence | wmb | po-rel | rmb | acq-po
-let ppo = to-r | to-w | fence
+let ppo = to-r | to-w | fence | (unlock-rf-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = rfe? ; r
-let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
+let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | unlock-rf-lock-po
 let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
 
 (*
Index: usb-4.x/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
===================================================================
--- usb-4.x.orig/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
+++ usb-4.x/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
@@ -1,11 +1,10 @@
 C ISA2+pooncelock+pooncelock+pombonce.litmus
 
 (*
- * Result: Sometimes
+ * Result: Never
  *
- * This test shows that the ordering provided by a lock-protected S
- * litmus test (P0() and P1()) are not visible to external process P2().
- * This is likely to change soon.
+ * This test shows that write-write ordering provided by locks
+ * (in P0() and P1()) is visible to external process P2().
  *)
 
 {}
Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
===================================================================
--- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-4.x/tools/memory-model/Documentation/explanation.txt
@@ -28,7 +28,8 @@ Explanation of the Linux-Kernel Memory C
   20. THE HAPPENS-BEFORE RELATION: hb
   21. THE PROPAGATES-BEFORE RELATION: pb
   22. RCU RELATIONS: rcu-link, gp, rscs, rcu-fence, and rb
-  23. ODDS AND ENDS
+  23. LOCKING
+  24. ODDS AND ENDS
 
 
 
@@ -1067,28 +1068,6 @@ allowing out-of-order writes like this t
 violating the write-write coherence rule by requiring the CPU not to
 send the W write to the memory subsystem at all!)
 
-There is one last example of preserved program order in the LKMM: when
-a load-acquire reads from an earlier store-release.  For example:
-
-	smp_store_release(&x, 123);
-	r1 = smp_load_acquire(&x);
-
-If the smp_load_acquire() ends up obtaining the 123 value that was
-stored by the smp_store_release(), the LKMM says that the load must be
-executed after the store; the store cannot be forwarded to the load.
-This requirement does not arise from the operational model, but it
-yields correct predictions on all architectures supported by the Linux
-kernel, although for differing reasons.
-
-On some architectures, including x86 and ARMv8, it is true that the
-store cannot be forwarded to the load.  On others, including PowerPC
-and ARMv7, smp_store_release() generates object code that starts with
-a fence and smp_load_acquire() generates object code that ends with a
-fence.  The upshot is that even though the store may be forwarded to
-the load, it is still true that any instruction preceding the store
-will be executed before the load or any following instructions, and
-the store will be executed before any instruction following the load.
-
 
 AND THEN THERE WAS ALPHA
 ------------------------
@@ -1766,6 +1745,147 @@ before it does, and the critical section
 grace period does and ends after it does.
 
 
+LOCKING
+-------
+
+The LKMM includes locking.  In fact, there is special code for locking
+in the formal model, added in order to make tools run faster.
+However, this special code is intended to be more or less equivalent
+to concepts we have already covered.  A spinlock_t variable is treated
+the same as an int, and spin_lock(&s) is treated almost the same as:
+
+	while (cmpxchg_acquire(&s, 0, 1) != 0)
+		cpu_relax();
+
+This waits until s is equal to 0 and then atomically sets it to 1,
+and the read part of the cmpxchg operation acts as an acquire fence.
+An alternate way to express the same thing would be:
+
+	r = xchg_acquire(&s, 1);
+
+along with a requirement that at the end, r = 0.  Similarly,
+spin_trylock(&s) is treated almost the same as:
+
+	return !cmpxchg_acquire(&s, 0, 1);
+
+which atomically sets s to 1 if it is currently equal to 0 and returns
+true if it succeeds (the read part of the cmpxchg operation acts as an
+acquire fence only if the operation is successful).  spin_unlock(&s)
+is treated almost the same as:
+
+	smp_store_release(&s, 0);
+
+The "almost" qualifiers above need some explanation.  In the LMKM, the
+store-release in a spin_unlock() and the load-acquire which forms the
+first half of the atomic rmw update in a spin_lock() or a successful
+spin_trylock() -- we can call these things lock-releases and
+lock-acquires -- have two properties beyond those of ordinary releases
+and acquires.
+
+First, when a lock-acquire reads from a lock-release, the LKMM
+requires that every instruction po-before the lock-release must
+execute before any instruction po-after the lock-acquire.  This would
+naturally hold if the release and acquire operations were on different
+CPUs, but the LKMM says it holds even when they are on the same CPU.
+For example:
+
+	int x, y;
+	spinlock_t s;
+
+	P0()
+	{
+		int r1, r2;
+
+		spin_lock(&s);
+		r1 = READ_ONCE(x);
+		spin_unlock(&s);
+		spin_lock(&s);
+		r2 = READ_ONCE(y);
+		spin_unlock(&s);
+	}
+
+	P1()
+	{
+		WRITE_ONCE(y, 1);
+		smp_wmb();
+		WRITE_ONCE(x, 1);
+	}
+
+Here the second spin_lock() reads from the first spin_unlock(), and
+therefore the load of x must execute before the load of y.  Thus we
+cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
+MP pattern).
+
+This requirement does not apply to ordinary release and acquire
+fences, only to lock-related operations.  For instance, suppose P0()
+in the example had been written as:
+
+	P0()
+	{
+		int r1, r2, r3;
+
+		r1 = READ_ONCE(x);
+		smp_store_release(&s, 1);
+		r3 = smp_load_acquire(&s);
+		r2 = READ_ONCE(y);
+	}
+
+Then the CPU would be allowed to forward the s = 1 value from the
+smp_store_release() to the smp_load_acquire(), executing the
+instructions in the following order:
+
+		r3 = smp_load_acquire(&s);	// Obtains r3 = 1
+		r2 = READ_ONCE(y);
+		r1 = READ_ONCE(x);
+		smp_store_release(&s, 1);	// Value is forwarded
+
+and thus it could load y before x, obtaining r2 = 0 and r1 = 1.
+
+Second, when a lock-acquire reads from a lock-release, and some other
+stores W and W' occur po-before the lock-release and po-after the
+lock-acquire respectively, the LKMM requires that W must propagate to
+each CPU before W' does.  For example, consider:
+
+	int x, y;
+	spinlock_t x;
+
+	P0()
+	{
+		spin_lock(&s);
+		WRITE_ONCE(x, 1);
+		spin_unlock(&s);
+	}
+
+	P1()
+	{
+		int r1;
+
+		spin_lock(&s);
+		r1 = READ_ONCE(x);
+		WRITE_ONCE(y, 1);
+		spin_unlock(&s);
+	}
+
+	P2()
+	{
+		int r2, r3;
+
+		r2 = READ_ONCE(y);
+		smp_rmb();
+		r3 = READ_ONCE(x);
+	}
+
+If r1 = 1 at the end then the spin_lock() in P1 must have read from
+the spin_unlock() in P0.  Hence the store to x must propagate to P2
+before the store to y does, so we cannot have r2 = 1 and r3 = 0.
+
+These two special requirements for lock-release and lock-acquire do
+not arise from the operational model.  Nevertheless, kernel developers
+have come to expect and rely on them because they do hold on all
+architectures supported by the Linux kernel, albeit for various
+differing reasons.
+
+
 ODDS AND ENDS
 -------------
 
@@ -1831,26 +1951,6 @@ they behave as follows:
 	events and the events preceding them against all po-later
 	events.
 
-The LKMM includes locking.  In fact, there is special code for locking
-in the formal model, added in order to make tools run faster.
-However, this special code is intended to be exactly equivalent to
-concepts we have already covered.  A spinlock_t variable is treated
-the same as an int, and spin_lock(&s) is treated the same as:
-
-	while (cmpxchg_acquire(&s, 0, 1) != 0)
-		cpu_relax();
-
-which waits until s is equal to 0 and then atomically sets it to 1,
-and where the read part of the atomic update is also an acquire fence.
-An alternate way to express the same thing would be:
-
-	r = xchg_acquire(&s, 1);
-
-along with a requirement that at the end, r = 0.  spin_unlock(&s) is
-treated the same as:
-
-	smp_store_release(&s, 0);
-
 Interestingly, RCU and locking each introduce the possibility of
 deadlock.  When faced with code sequences such as:
 

