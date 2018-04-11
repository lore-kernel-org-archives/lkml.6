Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeDKSBL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 14:01:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52032 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752551AbeDKSBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:01:06 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 00/13] kernel/locking: qspinlock improvements
Date: Wed, 11 Apr 2018 19:01:07 +0100
Message-Id: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's v2 of the qspinlock patches I posted last week:

  https://lkml.org/lkml/2018/4/5/496

Changes since v1 include:
  * Use WRITE_ONCE to clear the pending bit if we set it erroneously
  * Report pending and slowpath acquisitions via the qspinlock stat
    mechanism [Waiman Long]
  * Spin for a bounded duration while lock is observed in the
    pending->locked transition
  * Use try_cmpxchg to get better codegen on x86
  * Reword comments

All comments welcome,

Will

--->8

Jason Low (1):
  locking/mcs: Use smp_cond_load_acquire() in mcs spin loop

Waiman Long (1):
  locking/qspinlock: Add stat tracking for pending vs slowpath

Will Deacon (11):
  barriers: Introduce smp_cond_load_relaxed and atomic_cond_read_relaxed
  locking/qspinlock: Bound spinning on pending->locked transition in
    slowpath
  locking/qspinlock/x86: Increase _Q_PENDING_LOOPS upper bound
  locking/qspinlock: Remove unbounded cmpxchg loop from locking slowpath
  locking/qspinlock: Kill cmpxchg loop when claiming lock from head of
    queue
  locking/qspinlock: Use atomic_cond_read_acquire
  locking/qspinlock: Use smp_cond_load_relaxed to wait for next node
  locking/qspinlock: Merge struct __qspinlock into struct qspinlock
  locking/qspinlock: Make queued_spin_unlock use smp_store_release
  locking/qspinlock: Elide back-to-back RELEASE operations with
    smp_wmb()
  locking/qspinlock: Use try_cmpxchg instead of cmpxchg when locking

 arch/x86/include/asm/qspinlock.h          |  21 ++-
 arch/x86/include/asm/qspinlock_paravirt.h |   3 +-
 include/asm-generic/atomic-long.h         |   2 +
 include/asm-generic/barrier.h             |  27 +++-
 include/asm-generic/qspinlock.h           |   2 +-
 include/asm-generic/qspinlock_types.h     |  32 +++-
 include/linux/atomic.h                    |   2 +
 kernel/locking/mcs_spinlock.h             |  10 +-
 kernel/locking/qspinlock.c                | 247 ++++++++++++++----------------
 kernel/locking/qspinlock_paravirt.h       |  41 ++---
 kernel/locking/qspinlock_stat.h           |   9 +-
 11 files changed, 209 insertions(+), 187 deletions(-)

-- 
2.1.4
