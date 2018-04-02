Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeDBG5X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:57:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41199 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754131AbeDBG5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:57:21 -0400
X-Google-Smtp-Source: AIpwx4+RBIb8/i1MCT5cCu+/GRhEn2EYOjqvSmtN0mTQcfX99k39acdjYCFkG4JS5h8g6D24BScdqA==
Date: Mon, 2 Apr 2018 08:57:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v4.17
Message-ID: <20180402065717.x6dlvqahvsqy5mty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

   # HEAD: 19193bcad8dced863f2f720b1a76110bda07c970 locking/Kconfig: Restructure the lock debugging menu

The main changes in the locking subsystem in this cycle were:

 - Add the Linux Kernel Memory Consistency Model (LKMM) subsystem, which is an
   an array of tools in tools/memory-model/ that formally describe the Linux
   memory coherency model (a.k.a. Documentation/memory-barriers.txt), and also 
   produce 'litmus tests' in form of kernel code which can be directly executed 
   and tested.

   Here's a high level background article about an earlier version of this work on 
   LWN.net:

      https://lwn.net/Articles/718628/

   The design principles:

    "There is some reason to believe that Documentation/memory-barriers.txt
     could use some help, and a major purpose of this patch is to provide
     that help in the form of a design-time tool that can produce all valid
     executions of a small fragment of concurrent Linux-kernel code, which is
     called a "litmus test".  This tool's functionality is roughly similar to
     a full state-space search.  Please note that this is a design-time tool,
     not useful for regression testing.  However, we hope that the underlying
     Linux-kernel memory model will be incorporated into other tools capable
     of analyzing large bodies of code for regression-testing purposes."

     [...]

    "A second tool is klitmus7, which converts litmus tests to loadable
     kernel modules for direct testing.  As with herd7, the klitmus7
     code is freely available from http://diy.inria.fr/sources/index.html
     (and via "git" at https://github.com/herd/herdtools7)."

    [...]

    Credits go to:

    "This patch was the result of a most excellent collaboration founded
     by Jade Alglave and also including Alan Stern, Andrea Parri, and Luc Maranget."

    ... and to the gents listed in the MAINTAINERS entry:

        LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
        M:      Alan Stern <stern@rowland.harvard.edu>
        M:      Andrea Parri <parri.andrea@gmail.com>
        M:      Will Deacon <will.deacon@arm.com>
        M:      Peter Zijlstra <peterz@infradead.org>
        M:      Boqun Feng <boqun.feng@gmail.com>
        M:      Nicholas Piggin <npiggin@gmail.com>
        M:      David Howells <dhowells@redhat.com>
        M:      Jade Alglave <j.alglave@ucl.ac.uk>
        M:      Luc Maranget <luc.maranget@inria.fr>
        M:      "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

   The LKMM project already found several bugs in Linux locking primitives and 
   improved the understanding and the documentation of the Linux memory model all 
   around.

 - Add KASAN instrumentation to atomic APIs (Dmitry Vyukov)

 - Add RWSEM API debugging and reorganize the lock debugging Kconfig (Waiman Long)

 - ... misc cleanups and other smaller changes.

 Thanks,

	Ingo

------------------>
Alan Stern (3):
      tools/memory-model: Add a S lock-based external-view litmus test
      tools/memory-model: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference
      tools/memory-model: Finish the removal of rb-dep, smp_read_barrier_depends(), and lockless_dereference()

Andrea Parri (5):
      tools/memory-model: Clarify the origin/scope of the tool name
      MAINTAINERS: Add the Memory Consistency Model subsystem
      MAINTAINERS: List file memory-barriers.txt within the LKMM entry
      Documentation/memory-barriers.txt: Cross-reference "tools/memory-model/"
      locking/xchg/alpha: Remove superfluous memory barriers from the _local() variants

Borislav Petkov (1):
      locking/lockdep: Show unadorned pointers

Dmitry Vyukov (4):
      locking/atomic, asm-generic: Add asm-generic/atomic-instrumented.h
      locking/atomic/x86: Switch atomic.h to use atomic-instrumented.h
      locking/atomic, asm-generic: Add KASAN instrumentation to atomic operations
      locking/atomic, asm-generic, x86: Add comments for atomic instrumentation

Juri Lelli (2):
      Documentation/locking/lockdep: Update info about states
      Documentation/locking/lockdep: Add section about available annotations

Nikolay Borisov (1):
      memory-barriers: Fix description of data dependency barriers

Paul E. McKenney (9):
      Automate memory-barriers.txt; provide Linux-kernel memory model
      EXP litmus_tests: Add comments explaining tests' purposes
      README: Fix a couple of punctuation errors
      MAINTAINERS: Add Akira Yokosawa as an LKMM reviewer
      tools/memory-model: Add required herd7 version to README file
      tools/memory-model: Convert underscores to hyphens
      locking/memory-barriers: De-emphasize smp_read_barrier_depends() some more
      tools/memory-model: Remove mention of docker/gentoo image
      tools/memory-model: Add documentation of new litmus test

Peter Zijlstra (1):
      locking/rtmutex: Handle non enqueued waiters gracefully in remove_waiter()

Randy Dunlap (1):
      mutex: Drop linkage.h from mutex.h

Tetsuo Handa (1):
      lockdep: Make the lock debug output more useful

Waiman Long (3):
      locking/rwsem: Add DEBUG_RWSEMS to look for lock/unlock mismatches
      locking/Kconfig: Add LOCK_DEBUGGING_SUPPORT to make it more readable
      locking/Kconfig: Restructure the lock debugging menu


 Documentation/locking/lockdep-design.txt           |   51 +-
 Documentation/memory-barriers.txt                  |   34 +-
 MAINTAINERS                                        |   18 +
 arch/alpha/include/asm/cmpxchg.h                   |   20 +-
 arch/alpha/include/asm/xchg.h                      |   27 -
 arch/x86/include/asm/atomic.h                      |  106 +-
 arch/x86/include/asm/atomic64_32.h                 |  106 +-
 arch/x86/include/asm/atomic64_64.h                 |  108 +-
 arch/x86/include/asm/cmpxchg.h                     |   12 +-
 arch/x86/include/asm/cmpxchg_32.h                  |    8 +-
 arch/x86/include/asm/cmpxchg_64.h                  |    4 +-
 include/asm-generic/atomic-instrumented.h          |  476 +++++
 include/linux/mutex.h                              |    1 -
 kernel/locking/lockdep.c                           |   26 +-
 kernel/locking/rtmutex.c                           |    3 +-
 kernel/locking/rtmutex_common.h                    |   11 +-
 kernel/locking/rwsem.c                             |    4 +
 kernel/locking/rwsem.h                             |    8 +-
 lib/Kconfig.debug                                  |  150 +-
 tools/memory-model/Documentation/cheatsheet.txt    |   29 +
 tools/memory-model/Documentation/explanation.txt   | 1845 ++++++++++++++++++++
 tools/memory-model/Documentation/recipes.txt       |  570 ++++++
 tools/memory-model/Documentation/references.txt    |  107 ++
 tools/memory-model/README                          |  206 +++
 tools/memory-model/linux-kernel.bell               |   52 +
 tools/memory-model/linux-kernel.cat                |  121 ++
 tools/memory-model/linux-kernel.cfg                |   21 +
 tools/memory-model/linux-kernel.def                |  106 ++
 .../litmus-tests/CoRR+poonceonce+Once.litmus       |   26 +
 .../litmus-tests/CoRW+poonceonce+Once.litmus       |   25 +
 .../litmus-tests/CoWR+poonceonce+Once.litmus       |   25 +
 .../litmus-tests/CoWW+poonceonce.litmus            |   18 +
 .../litmus-tests/IRIW+mbonceonces+OnceOnce.litmus  |   45 +
 .../litmus-tests/IRIW+poonceonces+OnceOnce.litmus  |   43 +
 .../ISA2+pooncelock+pooncelock+pombonce.litmus     |   41 +
 .../litmus-tests/ISA2+poonceonces.litmus           |   37 +
 ...cerelease+poacquirerelease+poacquireonce.litmus |   39 +
 .../litmus-tests/LB+ctrlonceonce+mbonceonce.litmus |   34 +
 .../LB+poacquireonce+pooncerelease.litmus          |   29 +
 .../litmus-tests/LB+poonceonces.litmus             |   28 +
 .../litmus-tests/MP+onceassign+derefonce.litmus    |   34 +
 tools/memory-model/litmus-tests/MP+polocks.litmus  |   35 +
 .../litmus-tests/MP+poonceonces.litmus             |   27 +
 .../MP+pooncerelease+poacquireonce.litmus          |   28 +
 .../memory-model/litmus-tests/MP+porevlocks.litmus |   35 +
 .../litmus-tests/MP+wmbonceonce+rmbonceonce.litmus |   30 +
 .../memory-model/litmus-tests/R+mbonceonces.litmus |   30 +
 .../memory-model/litmus-tests/R+poonceonces.litmus |   27 +
 tools/memory-model/litmus-tests/README             |  131 ++
 .../memory-model/litmus-tests/S+poonceonces.litmus |   28 +
 .../S+wmbonceonce+poacquireonce.litmus             |   27 +
 .../litmus-tests/SB+mbonceonces.litmus             |   32 +
 .../litmus-tests/SB+poonceonces.litmus             |   29 +
 .../litmus-tests/WRC+poonceonces+Once.litmus       |   35 +
 .../WRC+pooncerelease+rmbonceonce+Once.litmus      |   36 +
 .../Z6.0+pooncelock+poonceLock+pombonce.litmus     |   42 +
 .../Z6.0+pooncelock+pooncelock+pombonce.litmus     |   40 +
 ...ooncerelease+poacquirerelease+mbonceonce.litmus |   42 +
 tools/memory-model/lock.cat                        |   99 ++
 59 files changed, 5106 insertions(+), 301 deletions(-)
 create mode 100644 include/asm-generic/atomic-instrumented.h
 create mode 100644 tools/memory-model/Documentation/cheatsheet.txt
 create mode 100644 tools/memory-model/Documentation/explanation.txt
 create mode 100644 tools/memory-model/Documentation/recipes.txt
 create mode 100644 tools/memory-model/Documentation/references.txt
 create mode 100644 tools/memory-model/README
 create mode 100644 tools/memory-model/linux-kernel.bell
 create mode 100644 tools/memory-model/linux-kernel.cat
 create mode 100644 tools/memory-model/linux-kernel.cfg
 create mode 100644 tools/memory-model/linux-kernel.def
 create mode 100644 tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
 create mode 100644 tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
 create mode 100644 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
 create mode 100644 tools/memory-model/litmus-tests/LB+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+polocks.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+porevlocks.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/R+mbonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/R+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/README
 create mode 100644 tools/memory-model/litmus-tests/S+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/SB+mbonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/SB+poonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
 create mode 100644 tools/memory-model/lock.cat
