Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbeBFViH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:38:07 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33556 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeBFViG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:38:06 -0500
X-Google-Smtp-Source: AH8x2241bf5GfwPhg8k7S9fIxfIFOIvAa4qh1lB4L71/VzmuCfuqN58M761Qbnw/CGlOR/noFAXrEA==
Date: Tue, 6 Feb 2018 22:38:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler updates
Message-ID: <20180206213801.tgisy3rh2j6iphig@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 82845079160817cc6ac64e5321bbd935e0a47b3a Merge branch 'linus' into sched/urgent, to resolve conflicts

This tree includes the following changes:

 - membarrier updates (Mathieu Desnoyers)

 - SMP balancing optimizations (Mel Gorman)

 - stats update optimizations (Peter Zijlstra)

 - RT scheduler race fixes (Steven Rostedt)

 - misc fixes and updates

Note: I merged in a (tested) version of your tree to resolve three separate 
conflicts, two trivial, the third one a bit more complex - but feel free to pull 
the original sha1 before the merge as well.

 Thanks,

	Ingo

------------------>
Mathieu Desnoyers (11):
      membarrier/selftest: Test private expedited command
      powerpc, membarrier: Skip memory barrier in switch_mm()
      membarrier: Document scheduler barrier requirements
      membarrier: Provide GLOBAL_EXPEDITED command
      membarrier/selftest: Test global expedited command
      locking: Introduce sync_core_before_usermode()
      lockin/x86: Implement sync_core_before_usermode()
      membarrier: Provide core serializing command, *_SYNC_CORE
      membarrier/x86: Provide core serializing command
      membarrier/arm64: Provide core serializing command
      membarrier/selftest: Test private expedited sync core command

Mel Gorman (4):
      sched/fair: Remove unnecessary parameters from wake_affine_idle()
      sched/fair: Restructure wake_affine*() to return a CPU id
      sched/fair: Do not migrate if the prev_cpu is idle
      sched/fair: Use a recently used CPU as an idle candidate and the basis for SIS

Peter Zijlstra (2):
      sched/core: Optimize ttwu_stat()
      sched/core: Optimize update_stats_*()

Steven Rostedt (VMware) (2):
      sched/rt: Use container_of() to get root domain in rto_push_irq_work_func()
      sched/rt: Up the root domain ref count when passing it around via IPIs

Wen Yang (1):
      sched/rt: Make update_curr_rt() more accurate


 MAINTAINERS                                        |   1 +
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/kernel/entry.S                          |   4 +
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/membarrier.h              |  27 +++
 arch/powerpc/mm/mmu_context.c                      |   7 +
 arch/x86/Kconfig                                   |   2 +
 arch/x86/entry/entry_32.S                          |   5 +
 arch/x86/entry/entry_64.S                          |   4 +
 arch/x86/include/asm/sync_core.h                   |  28 +++
 arch/x86/mm/tlb.c                                  |   6 +
 include/linux/sched.h                              |   8 +
 include/linux/sched/mm.h                           |  35 ++-
 include/linux/sync_core.h                          |  21 ++
 include/uapi/linux/membarrier.h                    |  74 ++++++-
 init/Kconfig                                       |   9 +
 kernel/fork.c                                      |   5 +
 kernel/sched/core.c                                |  74 ++++---
 kernel/sched/fair.c                                | 101 +++++----
 kernel/sched/membarrier.c                          | 177 +++++++++++++--
 kernel/sched/rt.c                                  |  29 ++-
 kernel/sched/sched.h                               |   2 +
 kernel/sched/stats.h                               |   6 +
 kernel/sched/topology.c                            |  13 ++
 .../testing/selftests/membarrier/membarrier_test.c | 237 +++++++++++++++++++--
 25 files changed, 750 insertions(+), 127 deletions(-)
 create mode 100644 arch/powerpc/include/asm/membarrier.h
 create mode 100644 arch/x86/include/asm/sync_core.h
 create mode 100644 include/linux/sync_core.h
