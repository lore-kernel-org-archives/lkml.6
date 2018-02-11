Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbeBLBa5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:30:57 -0500
Received: from [198.137.202.136] ([198.137.202.136]:59509 "EHLO
        terminus.zytor.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbeBLBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:30:55 -0500
Date: Sun, 11 Feb 2018 04:15:14 -0800
From: tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-79e902382637a2f421b7f295dcf9934d80d84d7d@git.kernel.org>
Cc: paulmck@linux.vnet.ibm.com, juri.lelli@redhat.com, dave@stgolabs.net,
        hpa@zytor.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, corbet@lwn.net, peterz@infradead.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, corbet@lwn.net, tglx@linutronix.de,
        peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        juri.lelli@redhat.com, paulmck@linux.vnet.ibm.com, dave@stgolabs.net,
        hpa@zytor.com
In-Reply-To: <20180209160114.19980-1-juri.lelli@redhat.com>
References: <20180209160114.19980-1-juri.lelli@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] Documentation/locking/mutex-design: Update to
 reflect latest changes
Git-Commit-ID: 79e902382637a2f421b7f295dcf9934d80d84d7d
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

Commit-ID:  79e902382637a2f421b7f295dcf9934d80d84d7d
Gitweb:     https://git.kernel.org/tip/79e902382637a2f421b7f295dcf9934d80d84d7d
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Fri, 9 Feb 2018 17:01:14 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 12:28:58 +0100

Documentation/locking/mutex-design: Update to reflect latest changes

Commit 3ca0ff571b09 ("locking/mutex: Rework mutex::owner") reworked the
basic mutex implementation to deal with several problems. Documentation
was however left unchanged and became stale.

Update mutex-design.txt to reflect changes introduced by the above commit.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/20180209160114.19980-1-juri.lelli@redhat.com
[ Small readability tweaks to the text. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/locking/mutex-design.txt | 49 ++++++++++++----------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/Documentation/locking/mutex-design.txt b/Documentation/locking/mutex-design.txt
index 60c482d..818aca1 100644
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
@@ -143,11 +129,10 @@ Test if the mutex is taken:
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
