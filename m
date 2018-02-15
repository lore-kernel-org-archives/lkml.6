Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032500AbeBOAum (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:50:42 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39377 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032245AbeBOAuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:50:40 -0500
X-Google-Smtp-Source: AH8x224VAX27GUAelgOCWWSTMsqa1l1y5qs5y/DiLk0R1BqcsVrgflXez951cjLD1r1vcZuBuxlf8w==
Date: Thu, 15 Feb 2018 01:50:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fixes
Message-ID: <20180215005035.lplbmxwvqhw5pdra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: 2dd6fd2e999774041397f2a7da2e1d30b3a27c3a locking/semaphore: Update the file path in documentation

This tree contains two qspinlock fixes and three documentation and comment fixes.

 Thanks,

	Ingo

------------------>
Juri Lelli (1):
      Documentation/locking/mutex-design: Update to reflect latest changes

Tycho Andersen (1):
      locking/semaphore: Update the file path in documentation

Will Deacon (3):
      locking/qspinlock: Ensure node is initialised before updating prev->next
      locking/qspinlock: Ensure node->count is updated before initialising node
      locking/atomic/bitops: Document and clarify ordering semantics for failed test_and_{}_bit()


 Documentation/atomic_bitops.txt        |  7 ++++-
 Documentation/locking/mutex-design.txt | 49 ++++++++++++----------------------
 include/asm-generic/bitops/lock.h      |  3 ++-
 include/linux/semaphore.h              |  2 +-
 kernel/locking/qspinlock.c             | 21 ++++++++++-----
 5 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/atomic_bitops.txt b/Documentation/atomic_bitops.txt
index 5550bfdcce5f..be70b32c95d9 100644
--- a/Documentation/atomic_bitops.txt
+++ b/Documentation/atomic_bitops.txt
@@ -58,7 +58,12 @@ ORDERING
 
  - RMW operations that have a return value are fully ordered.
 
-Except for test_and_set_bit_lock() which has ACQUIRE semantics and
+ - RMW operations that are conditional are unordered on FAILURE,
+   otherwise the above rules apply. In the case of test_and_{}_bit() operations,
+   if the bit in memory is unchanged by the operation then it is deemed to have
+   failed.
+
+Except for a successful test_and_set_bit_lock() which has ACQUIRE semantics and
 clear_bit_unlock() which has RELEASE semantics.
 
 Since a platform only has a single means of achieving atomic operations
diff --git a/Documentation/locking/mutex-design.txt b/Documentation/locking/mutex-design.txt
index 60c482df1a38..818aca19612f 100644
--- a/Documentation/locking/mutex-design.txt
+++ b/Documentation/locking/mutex-design.txt
@@ -21,37 +21,23 @@ Implementation
 --------------
 
 Mutexes are represented by 'struct mutex', defined in include/linux/mutex.h
-and implemented in kernel/locking/mutex.c. These locks use a three
-state atomic counter (->count) to represent the different possible
-transitions that can occur during the lifetime of a lock:
-
-	  1: unlocked
-	  0: locked, no waiters
-   negative: locked, with potential waiters
-
-In its most basic form it also includes a wait-queue and a spinlock
-that serializes access to it. CONFIG_SMP systems can also include
-a pointer to the lock task owner (->owner) as well as a spinner MCS
-lock (->osq), both described below in (ii).
+and implemented in kernel/locking/mutex.c. These locks use an atomic variable
+(->owner) to keep track of the lock state during its lifetime.  Field owner
+actually contains 'struct task_struct *' to the current lock owner and it is
+therefore NULL if not currently owned. Since task_struct pointers are aligned
+at at least L1_CACHE_BYTES, low bits (3) are used to store extra state (e.g.,
+if waiter list is non-empty).  In its most basic form it also includes a
+wait-queue and a spinlock that serializes access to it. Furthermore,
+CONFIG_MUTEX_SPIN_ON_OWNER=y systems use a spinner MCS lock (->osq), described
+below in (ii).
 
 When acquiring a mutex, there are three possible paths that can be
 taken, depending on the state of the lock:
 
-(i) fastpath: tries to atomically acquire the lock by decrementing the
-    counter. If it was already taken by another task it goes to the next
-    possible path. This logic is architecture specific. On x86-64, the
-    locking fastpath is 2 instructions:
-
-    0000000000000e10 <mutex_lock>:
-    e21:   f0 ff 0b                lock decl (%rbx)
-    e24:   79 08                   jns    e2e <mutex_lock+0x1e>
-
-   the unlocking fastpath is equally tight:
-
-    0000000000000bc0 <mutex_unlock>:
-    bc8:   f0 ff 07                lock incl (%rdi)
-    bcb:   7f 0a                   jg     bd7 <mutex_unlock+0x17>
-
+(i) fastpath: tries to atomically acquire the lock by cmpxchg()ing the owner with
+    the current task. This only works in the uncontended case (cmpxchg() checks
+    against 0UL, so all 3 state bits above have to be 0). If the lock is
+    contended it goes to the next possible path.
 
 (ii) midpath: aka optimistic spinning, tries to spin for acquisition
      while the lock owner is running and there are no other tasks ready
@@ -143,11 +129,10 @@ Interfaces
 Disadvantages
 -------------
 
-Unlike its original design and purpose, 'struct mutex' is larger than
-most locks in the kernel. E.g: on x86-64 it is 40 bytes, almost twice
-as large as 'struct semaphore' (24 bytes) and tied, along with rwsems,
-for the largest lock in the kernel. Larger structure sizes mean more
-CPU cache and memory footprint.
+Unlike its original design and purpose, 'struct mutex' is among the largest
+locks in the kernel. E.g: on x86-64 it is 32 bytes, where 'struct semaphore'
+is 24 bytes and rw_semaphore is 40 bytes. Larger structure sizes mean more CPU
+cache and memory footprint.
 
 When to use mutexes
 -------------------
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index bc397573c43a..67ab280ad134 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -7,7 +7,8 @@
  * @nr: Bit to set
  * @addr: Address to count from
  *
- * This operation is atomic and provides acquire barrier semantics.
+ * This operation is atomic and provides acquire barrier semantics if
+ * the returned value is 0.
  * It can be used to implement bit locks.
  */
 #define test_and_set_bit_lock(nr, addr)	test_and_set_bit(nr, addr)
diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index dc368b8ce215..11c86fbfeb98 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -4,7 +4,7 @@
  *
  * Distributed under the terms of the GNU GPL, version 2
  *
- * Please see kernel/semaphore.c for documentation of these functions
+ * Please see kernel/locking/semaphore.c for documentation of these functions
  */
 #ifndef __LINUX_SEMAPHORE_H
 #define __LINUX_SEMAPHORE_H
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 38ece035039e..d880296245c5 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -379,6 +379,14 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	tail = encode_tail(smp_processor_id(), idx);
 
 	node += idx;
+
+	/*
+	 * Ensure that we increment the head node->count before initialising
+	 * the actual node. If the compiler is kind enough to reorder these
+	 * stores, then an IRQ could overwrite our assignments.
+	 */
+	barrier();
+
 	node->locked = 0;
 	node->next = NULL;
 	pv_init_node(node);
@@ -408,14 +416,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 */
 	if (old & _Q_TAIL_MASK) {
 		prev = decode_tail(old);
+
 		/*
-		 * The above xchg_tail() is also a load of @lock which
-		 * generates, through decode_tail(), a pointer.  The address
-		 * dependency matches the RELEASE of xchg_tail() such that
-		 * the subsequent access to @prev happens after.
+		 * We must ensure that the stores to @node are observed before
+		 * the write to prev->next. The address dependency from
+		 * xchg_tail is not sufficient to ensure this because the read
+		 * component of xchg_tail is unordered with respect to the
+		 * initialisation of @node.
 		 */
-
-		WRITE_ONCE(prev->next, node);
+		smp_store_release(&prev->next, node);
 
 		pv_wait_node(node, prev);
 		arch_mcs_spin_lock_contended(&node->locked);
