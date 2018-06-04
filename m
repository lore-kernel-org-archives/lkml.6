Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeFDJCk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:02:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39800 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeFDJCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:02:39 -0400
X-Google-Smtp-Source: ADUXVKLTDEfV23ZbtCx8dd8QRfMC9p51L7sfRYEyerS/KfNKTOaukL76Z6wNP+kVKoTs2XnQklOp2w==
Date: Mon, 4 Jun 2018 11:02:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v4.18
Message-ID: <20180604090235.GA15892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

   # HEAD: 1b22fc609cecd1b16c4a015e1a6b3c9717484e3a locking/rwsem: Simplify the is-owner-spinnable checks

The main changes in this cycle were:

 - Lots of tidying up changes all across the map for Linux's formal 
   memory/locking-model tooling, by Alan Stern, Akira Yokosawa, Andrea Parri,
   Paul E. McKenney and SeongJae Park. Notable changes beyond an overall update in 
   the tooling itself is the tidying up of spin_is_locked() semantics, which 
   spills over into the kernel proper as well.

 - qspinlock improvements: the locking algorithm now guarantees forward progress
   whereas the previous implementation in mainline could starve threads 
   indefinitely in cmpxchg() loops. Also other related cleanups to the qspinlock 
   code. (by Will Deacon)

 - misc smaller improvements, cleanups and fixes all across the locking subsystem.

 Thanks,

	Ingo

------------------>
Akira Yokosawa (1):
      tools/memory-model: Update required version of herdtools7

Alan Stern (6):
      tools/memory-model: Rename link and rcu-path to rcu-link and rb
      tools/memory-model: Redefine rb in terms of rcu-fence
      tools/memory-model: Remove duplicated code from lock.cat
      tools/memory-model: Improve comments in lock.cat
      tools/memory-model: Improve mixed-access checking in lock.cat
      tools/memory-model: Remove out-of-date comments and code from lock.cat

Andrea Parri (9):
      locking/spinlocks: Document the semantics of spin_is_locked()
      locking/spinlocks/arm64: Remove smp_mb() from arch_spin_is_locked()
      locking/spinlocks: Clean up comment and #ifndef for {,queued_}spin_is_locked()
      tools/memory-model: Model 'smp_store_mb()'
      tools/memory-model: Fix coding style in 'linux-kernel.def'
      tools/memory-model: Fix coding style in 'lock.cat'
      MAINTAINERS, tools/memory-model: Update e-mail address for Andrea Parri
      tools/memory-model: Update ASPLOS information
      tools/memory-model: Add reference for 'Simplifying ARM concurrency'

Jason Low (1):
      locking/mcs: Use smp_cond_load_acquire() in MCS spin loop

Luc Maranget (1):
      tools/memory-model: Add model support for spin_is_locked()

Oleg Nesterov (1):
      locking/rwsem: Simplify the is-owner-spinnable checks

Paolo Bonzini (1):
      tools/memory-model: Fix cheat sheet typo

Paul E. McKenney (4):
      tools/memory-order: Improve key for SELF and SV
      tools/memory-order: Update the cheat-sheet to show that smp_mb__after_atomic() orders later RMW operations
      tools/memory-model: Add scripts to test memory model
      tools/memory-model: Flag "cumulativity" and "propagation" tests

Peter Zijlstra (1):
      locking/mutex: Optimize __mutex_trylock_fast()

Sebastian Andrzej Siewior (1):
      delayacct: Use raw_spinlocks

SeongJae Park (7):
      locking/memory-barriers.txt/kokr: Update Korean translation to indicate that READ_ONCE() now implies smp_barrier_depends()
      locking/memory-barriers.txt/kokr: Update Korean translation to de-emphasize smp_read_barrier_depends()
      locking/memory-barriers.txt/kokr: Update Korean translation to cross-reference "tools/memory-model/"
      locking/memory-barriers.txt/kokr: Update Korean translation to fix description of data dependency barriers
      locking/memory-barriers.txt/kokr: Update Korean translation to de-emphasize smp_read_barrier_depends() some more
      locking/Documentation: Fix incorrect example code
      locking/Documentation: Use `warning` RST directive

Tetsuo Handa (2):
      locking/lockdep: Use for_each_process_thread() for debug_show_all_locks()
      locking/lockdep: Move sanity check to inside lockdep_print_held_locks()

Thomas Gleixner (1):
      stop_machine: Use raw spinlocks

Waiman Long (1):
      locking/qspinlock: Add stat tracking for pending vs. slowpath

Will Deacon (14):
      locking/barriers: Introduce smp_cond_load_relaxed() and atomic_cond_read_relaxed()
      locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'
      locking/qspinlock: Bound spinning on pending->locked transition in slowpath
      locking/qspinlock/x86: Increase _Q_PENDING_LOOPS upper bound
      locking/qspinlock: Remove unbounded cmpxchg() loop from locking slowpath
      locking/qspinlock: Kill cmpxchg() loop when claiming lock from head of queue
      locking/qspinlock: Use atomic_cond_read_acquire()
      locking/qspinlock: Use smp_cond_load_relaxed() to wait for next node
      locking/qspinlock: Use smp_store_release() in queued_spin_unlock()
      locking/qspinlock: Elide back-to-back RELEASE operations with smp_wmb()
      locking/qspinlock: Use try_cmpxchg() instead of cmpxchg() when locking
      MAINTAINERS: Add myself as a co-maintainer for the locking subsystem
      locking/qspinlock: Remove duplicate clear_pending() function from PV code
      locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example


 Documentation/core-api/atomic_ops.rst              |  13 +-
 Documentation/memory-barriers.txt                  |  17 +-
 .../translations/ko_KR/memory-barriers.txt         |  50 +++--
 MAINTAINERS                                        |   3 +-
 arch/arm64/include/asm/spinlock.h                  |   5 -
 arch/x86/include/asm/qspinlock.h                   |  21 +-
 arch/x86/include/asm/qspinlock_paravirt.h          |   3 +-
 include/asm-generic/atomic-long.h                  |  19 ++
 include/asm-generic/barrier.h                      |  27 ++-
 include/asm-generic/qspinlock.h                    |   4 +-
 include/asm-generic/qspinlock_types.h              |  32 ++-
 include/linux/atomic.h                             |   2 +
 include/linux/delayacct.h                          |   2 +-
 include/linux/mutex.h                              |   3 -
 include/linux/spinlock.h                           |  18 ++
 kernel/delayacct.c                                 |  17 +-
 kernel/locking/lockdep.c                           |  70 ++----
 kernel/locking/mcs_spinlock.h                      |  10 +-
 kernel/locking/mutex.c                             |   3 +-
 kernel/locking/qspinlock.c                         | 247 ++++++++++-----------
 kernel/locking/qspinlock_paravirt.h                |  49 +---
 kernel/locking/qspinlock_stat.h                    |   9 +-
 kernel/locking/rwsem-xadd.c                        |  25 ++-
 kernel/stop_machine.c                              |  24 +-
 tools/memory-model/Documentation/cheatsheet.txt    |   7 +-
 tools/memory-model/Documentation/explanation.txt   | 221 +++++++++++-------
 tools/memory-model/Documentation/references.txt    |  17 +-
 tools/memory-model/README                          |   2 +-
 tools/memory-model/linux-kernel.bell               |   4 +-
 tools/memory-model/linux-kernel.cat                |  41 ++--
 tools/memory-model/linux-kernel.def                |  34 +--
 tools/memory-model/litmus-tests/.gitignore         |   1 +
 .../litmus-tests/IRIW+mbonceonces+OnceOnce.litmus  |   2 +-
 .../MP+polockmbonce+poacquiresilsil.litmus         |  35 +++
 .../MP+polockonce+poacquiresilsil.litmus           |  34 +++
 tools/memory-model/litmus-tests/README             |  19 +-
 .../WRC+pooncerelease+rmbonceonce+Once.litmus      |   4 +-
 tools/memory-model/lock.cat                        | 107 ++++++---
 tools/memory-model/scripts/checkalllitmus.sh       |  73 ++++++
 tools/memory-model/scripts/checklitmus.sh          |  86 +++++++
 40 files changed, 875 insertions(+), 485 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/.gitignore
 create mode 100644 tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
 create mode 100644 tools/memory-model/scripts/checkalllitmus.sh
 create mode 100644 tools/memory-model/scripts/checklitmus.sh
