Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37525ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B1C206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B1C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeKIGMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:12:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeKIGMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:12:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9AEE307DAC1;
        Thu,  8 Nov 2018 20:35:26 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D5E01001F4A;
        Thu,  8 Nov 2018 20:35:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 00/12] locking/lockdep: Add a new class of terminal locks
Date:   Thu,  8 Nov 2018 15:34:16 -0500
Message-Id: <1541709268-3766-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 08 Nov 2018 20:35:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 1) The lockdep check will be faster for terminal locks without using
    the lock validation code.
 2) It saves table entries used by the validation code and hence make
    it harder to overflow those tables.

In fact, it is possible to overflow some of the tables by running
a variety of different workloads on a debug kernel. I have seen bug
reports about exhausting MAX_LOCKDEP_KEYS, MAX_LOCKDEP_ENTRIES and
MAX_STACK_TRACE_ENTRIES. This patch will help to reduce the chance
of overflowing some of the tables.

Performance wise, there was no statistically significant difference in
performanace when doing a parallel kernel build on a debug kernel.

Below were selected output lines from the lockdep_stats files of the
patched and unpatched kernels after bootup and running parallel kernel
builds.

  Item                     Unpatched kernel  Patched kernel  % Change
  ----                     ----------------  --------------  --------
  direct dependencies           9732             8994          -7.6%
  dependency chains            18776            17033          -9.3%
  dependency chain hlocks      76044            68419         -10.0%
  stack-trace entries         110403           104341          -5.5%

There were some reductions in the size of the lockdep tables. They were
not significant, but it is still a good start to rein in the number of
entries in those tables to make it harder to overflow them.

Waiman Long (12):
  locking/lockdep: Rework lockdep_set_novalidate_class()
  locking/lockdep: Add a new terminal lock type
  locking/lockdep: Add DEFINE_TERMINAL_SPINLOCK() and related macros
  printk: Make logbuf_lock a terminal lock
  debugobjects: Mark pool_lock as a terminal lock
  debugobjects: Move printk out of db lock critical sections
  locking/lockdep: Add support for nested terminal locks
  debugobjects: Make object hash locks nested terminal locks
  lib/stackdepot: Make depot_lock a terminal spinlock
  locking/rwsem: Mark rwsem.wait_lock as a terminal lock
  cgroup: Mark the rstat percpu lock as terminal
  mm/kasan: Make quarantine_lock a terminal lock

 include/linux/lockdep.h            | 34 +++++++++++++++---
 include/linux/rwsem.h              | 11 +++++-
 include/linux/spinlock_types.h     | 34 ++++++++++++------
 kernel/cgroup/rstat.c              |  9 +++--
 kernel/locking/lockdep.c           | 67 ++++++++++++++++++++++++++++++------
 kernel/locking/lockdep_internals.h |  5 +++
 kernel/locking/lockdep_proc.c      | 11 ++++--
 kernel/locking/rwsem-xadd.c        |  1 +
 kernel/printk/printk.c             |  2 +-
 kernel/printk/printk_safe.c        |  2 +-
 lib/debugobjects.c                 | 70 ++++++++++++++++++++++++++------------
 lib/stackdepot.c                   |  2 +-
 mm/kasan/quarantine.c              |  2 +-
 13 files changed, 195 insertions(+), 55 deletions(-)

-- 
1.8.3.1

