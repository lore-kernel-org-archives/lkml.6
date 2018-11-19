Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0254AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5C620659
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5C620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeKTFVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:21:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbeKTFVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:21:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C067D3097022;
        Mon, 19 Nov 2018 18:56:49 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C74B648A8;
        Mon, 19 Nov 2018 18:56:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 00/17] locking/lockdep: Add a new class of terminal locks
Date:   Mon, 19 Nov 2018 13:55:09 -0500
Message-Id: <1542653726-5655-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 19 Nov 2018 18:56:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v1->v2:
  - Mark more locks as terminal.
  - Add a patch to remove the unused version field from lock_class.
  - Steal some bits from pin_count of held_lock for flags.
  - Add a patch to warn if a task holding a raw spinlock is acquiring an
    non-raw lock.

The purpose of this patchset is to add a new class of locks called
terminal locks and converts some of the low level raw or regular
spinlocks to terminal locks. A terminal lock does not have forward
dependency and it won't allow a lock or unlock operation on another
lock. Two level nesting of terminal locks is allowed, though.

Only spinlocks that are acquired with the _irq/_irqsave variants or
acquired in an IRQ disabled context should be classified as terminal
locks.

Because of the restrictions on terminal locks, we can do simple checks on
them without using the lockdep lock validation machinery. The advantages
of making these changes are as follows:

 1) It saves table entries used by the validation code and hence make
    it harder to overflow those tables.

 2) The lockdep check in __lock_acquire() will be a little bit faster
    for terminal locks without using the lock validation code.

In fact, it is possible to overflow some of the tables by running
a variety of different workloads on a debug kernel. I have seen bug
reports about exhausting MAX_LOCKDEP_KEYS, MAX_LOCKDEP_ENTRIES and
MAX_STACK_TRACE_ENTRIES. This patch will help to reduce the chance
of overflowing some of the tables.

Below were selected output lines from the lockdep_stats files of the
patched and unpatched kernels after bootup and running parallel kernel
builds and some perf benchmarks.

  Item                     Unpatched kernel  Patched kernel  % Change
  ----                     ----------------  --------------  --------
  direct dependencies           9924             9032          -9.0%
  dependency chains            18258            16326         -10.6%
  dependency chain hlocks      73198            64927         -11.3%
  stack-trace entries         110502           103225          -6.6%

There were some reductions in the size of the lockdep tables. They were
not significant, but it is still a good start to rein in the number of
entries in those tables to make it harder to overflow them.

In term of performance, there isn't that much noticeable differences
in both the kernel build and perf benchmark. Low level locking
microbenchmark with 4 locking threads shows the following locking rates
on a Haswell system:

       Kernel             Lock                 Rate
       ------             ----                 ----
   Unpatched kernel    Regular lock         2,288 kop/s
   Patched kernel      Regular lock         2,352 kop/s
                       Terminal lock        2,512 kop/s

I was not sure why there was a slight performance improvement with
the patched kernel. However, comparing the regular and terminal lock
results, there was a slight 7% improvement in locking throughput for
terminal locks.

Looking at the perf ouput for regular lock:

   5.43%  run-locktest  [kernel.vmlinux]  [k] __lock_acquire
   4.65%  run-locktest  [kernel.vmlinux]  [k] lock_contended
   2.80%  run-locktest  [kernel.vmlinux]  [k] lock_acquired
   2.53%  run-locktest  [kernel.vmlinux]  [k] lock_release
   1.42%  run-locktest  [kernel.vmlinux]  [k] mark_lock

For terminal lock:

   5.00%  run-locktest  [kernel.vmlinux]  [k] __lock_acquire
   4.66%  run-locktest  [kernel.vmlinux]  [k] lock_contended
   2.88%  run-locktest  [kernel.vmlinux]  [k] lock_acquired
   2.55%  run-locktest  [kernel.vmlinux]  [k] lock_release
   1.34%  run-locktest  [kernel.vmlinux]  [k] mark_lock

The __lock_acquire() function ran a bit faster with terminal lock,
but the other lockdep functions remain more or less the same in term
of performance.

In term internal lockdep structure sizes, there should be no size
increase for 64-bit architectures with CONFIG_LOCK_STAT defined.
The lockdep_map structure will increase in size for 32-bit architectures
or when CONFIG_LOCK_STAT isn't defined.

Waiman Long (17):
  locking/lockdep: Remove version from lock_class structure
  locking/lockdep: Rework lockdep_set_novalidate_class()
  locking/lockdep: Add a new terminal lock type
  locking/lockdep: Add DEFINE_TERMINAL_SPINLOCK() and related macros
  printk: Mark logbuf_lock & console_owner_lock as terminal locks
  debugobjects: Mark pool_lock as a terminal lock
  debugobjects: Move printk out of db lock critical sections
  locking/lockdep: Add support for nestable terminal locks
  debugobjects: Make object hash locks nestable terminal locks
  lib/stackdepot: Make depot_lock a terminal spinlock
  locking/rwsem: Mark rwsem.wait_lock as a terminal lock
  cgroup: Mark the rstat percpu lock as terminal
  mm/kasan: Make quarantine_lock a terminal lock
  dma-debug: Mark free_entries_lock as terminal
  kernfs: Mark kernfs_open_node_lock as terminal lock
  delay_acct: Mark task's delays->lock as terminal spinlock
  locking/lockdep: Check raw/non-raw locking conflicts

 fs/kernfs/file.c                   |  2 +-
 include/linux/lockdep.h            | 59 +++++++++++++++++++++++----
 include/linux/rwsem.h              | 11 +++++-
 include/linux/spinlock_types.h     | 34 ++++++++++------
 kernel/cgroup/rstat.c              |  9 ++++-
 kernel/delayacct.c                 |  4 +-
 kernel/dma/debug.c                 |  2 +-
 kernel/locking/lockdep.c           | 81 ++++++++++++++++++++++++++++++++------
 kernel/locking/lockdep_internals.h |  5 +++
 kernel/locking/lockdep_proc.c      | 11 +++++-
 kernel/locking/rwsem-xadd.c        |  1 +
 kernel/locking/spinlock_debug.c    |  1 +
 kernel/printk/printk.c             |  4 +-
 kernel/printk/printk_safe.c        |  2 +-
 lib/debugobjects.c                 | 70 ++++++++++++++++++++++----------
 lib/stackdepot.c                   |  2 +-
 mm/kasan/quarantine.c              |  2 +-
 17 files changed, 235 insertions(+), 65 deletions(-)

-- 
1.8.3.1

