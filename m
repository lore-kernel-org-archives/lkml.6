Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA70C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF882184E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991673;
	bh=cEHl1XOIE3qXHIW111NWo8r7LROgMIKv3I5iXcoLPQY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iHEfmP+U2e6uislaTWKHSsV38ieIsvWycsQE4g3x8HGjNUGUcNjwWTFDXUT6OJye+
	 btpnIQgrfRl4TK4U1lHaP9+d7jg+zZVWgSti1t6KJ4aWcKhv2WP3pY8QGrCXbkse5Q
	 UJVZEjw2kxAJQ9m8qMBZrvHVnqXn259LFRVPr0EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfBLROc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbfBLROb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:14:31 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 924112084D;
        Tue, 12 Feb 2019 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991670;
        bh=cEHl1XOIE3qXHIW111NWo8r7LROgMIKv3I5iXcoLPQY=;
        h=From:To:Cc:Subject:Date:From;
        b=yr7ZCDl+Xp2TwWY0r4UTc96BzRj4XLzlifqeRJxrkRygpVnQ2pt+BrkStBbiX0V0z
         JDtPa8OUpFOi+AWngHh80M/oHTkRwMlNqgzJi1Qhfn6tRME6RlIqj9iY2hpOSW5yzs
         IP/hkZto/oCwIFVB6DDRkg/5eUb51eYi03oAAZtQ=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 00/32] softirq: Per vector masking v2 
Date:   Tue, 12 Feb 2019 18:13:51 +0100
Message-Id: <20190212171423.8308-1-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For those who missed the infinitely invasive and carpal tunnel
unfriendly v1: https://lwn.net/Articles/768157/

Softirqs masking is an all or nothing operation. It's currently not
possible to disable a single vector. Yet some workloads are interested
in deterministic latencies for vectors execution. Reducing their
interdependencies is a first step toward that.

Unlike the previous take, the current APIs aren't changed, as advised
by reviewers. But new APIs have been introduced. An individual vector
can be disabled and that behaviour can self-nest and nest with existing
APIs:

    bh = local_bh_disable_mask(BIT(TASKLET_SOFTIRQ));
	    bh2 = spin_lock_bh_mask(lock, BIT(NET_RX_SOFTIRQ));
	        local_bh_disable();
            [...]
            local_bh_enable();
        spin_unlock_bh_mask(lock, bh2);
    local_bh_enable_mask(bh));

Also mandatory, the new version provides lockdep validation in a per
vector finegrained way.

The next step could be to allow soft-interrupting softirq vectors with
other vectors. We'll need to be careful about stack usage and
interdependencies though. But that could solve issues with long lasting
vectors running at the expense of others.

A few details need improvement:

* We need to set all vectors of local_softirq_enabled() on boot for all
  archs. Only x86 does it for now. Shouldn't be too hard to achieve though.

* Handle multiple usage on lockdep verbose debugging (see patch PATCH 10/32)
  Also easy to fix.

* Restore redundant softirqs on tracking on softirq. See
  "locking/lockdep: Remove redundant softirqs on check". Also shouldn't
  be too hard to fix.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	softirq/soft-interruptible

HEAD: 0d35ad1a4b13b62e135672dfe86d362b49f41abf

Thanks,
	Frederic
---

Frederic Weisbecker (32):
      locking/lockdep: Use expanded masks on find_usage_*() functions
      locking/lockdep: Introduce struct lock_usage
      locking/lockdep: Convert usage_mask to u64
      locking/lockdep: Test all incompatible scenario at once in check_irq_usage()
      locking/lockdep: Prepare valid_state() to handle plain masks
      locking/lockdep: Prepare check_usage_*() to handle plain masks
      locking/lockdep: Prepare state_verbose() to handle all softirqs
      locking/lockdep: Make mark_lock() fastpath to work with multiple usage at once
      locking/lockdep: Save stack trace for each softirq vector involved
      locking/lockdep: Make mark_lock() verbosity aware of vector
      softirq: Macrofy softirq vectors
      locking/lockdep: Define per vector softirq lock usage states
      softirq: Pass softirq vector number to lockdep on vector execution
      x86: Revert "x86/irq: Demote irq_cpustat_t::__softirq_pending to u16"
      arch/softirq: Rename softirq_pending fields to softirq_data
      softirq: Normalize softirq_pending naming scheme
      softirq: Convert softirq_pending_*() to set/clear mask scheme
      softirq: Introduce disabled softirq vectors bits
      softirq: Rename _local_bh_enable() to local_bh_enable_no_softirq()
      softirq: Move vectors bits to bottom_half.h
      x86: Init softirq enabled field
      softirq: Check enabled vectors before processing
      softirq: Remove stale comment
      softirq: Uninline !CONFIG_TRACE_IRQFLAGS __local_bh_disable_ip()
      softirq: Prepare for mixing all/per-vector masking
      softirq: Support per vector masking
      locking/lockdep: Remove redundant softirqs on check
      locking/lockdep: Update check_flags() according to new layout
      locking/lockdep: Branch the new vec-finegrained softirq masking to lockdep
      softirq: Allow to soft interrupt vector-specific masked contexts
      locking: Introduce spin_[un]lock_bh_mask()
      net: Make softirq vector masking finegrained on release_sock()


 arch/arm/include/asm/hardirq.h      |   2 +-
 arch/arm64/include/asm/hardirq.h    |   2 +-
 arch/h8300/kernel/asm-offsets.c     |   2 +-
 arch/ia64/include/asm/hardirq.h     |   2 +-
 arch/ia64/include/asm/processor.h   |   2 +-
 arch/m68k/include/asm/hardirq.h     |   2 +-
 arch/m68k/kernel/asm-offsets.c      |   2 +-
 arch/parisc/include/asm/hardirq.h   |   2 +-
 arch/powerpc/include/asm/hardirq.h  |   2 +-
 arch/s390/include/asm/hardirq.h     |  11 +-
 arch/s390/lib/delay.c               |   2 +-
 arch/sh/include/asm/hardirq.h       |   2 +-
 arch/sparc/include/asm/cpudata_64.h |   2 +-
 arch/sparc/include/asm/hardirq_64.h |   4 +-
 arch/um/include/asm/hardirq.h       |   2 +-
 arch/x86/include/asm/hardirq.h      |   2 +-
 arch/x86/kernel/irq.c               |   5 +-
 drivers/s390/char/sclp.c            |   2 +-
 drivers/s390/cio/cio.c              |   2 +-
 include/asm-generic/hardirq.h       |   2 +-
 include/linux/bottom_half.h         |  41 +++-
 include/linux/interrupt.h           |  87 ++++---
 include/linux/irqflags.h            |  12 +-
 include/linux/lockdep.h             |   5 +-
 include/linux/softirq_vector.h      |  10 +
 include/linux/spinlock.h            |  14 ++
 include/linux/spinlock_api_smp.h    |  26 ++
 include/linux/spinlock_api_up.h     |  13 +
 kernel/locking/lockdep.c            | 465 ++++++++++++++++++++++++------------
 kernel/locking/lockdep_internals.h  |  50 +++-
 kernel/locking/lockdep_proc.c       |   2 +-
 kernel/locking/lockdep_states.h     |   4 +-
 kernel/locking/spinlock.c           |  19 ++
 kernel/softirq.c                    | 159 ++++++++----
 lib/locking-selftest.c              |   4 +-
 net/core/sock.c                     |   6 +-
 36 files changed, 690 insertions(+), 281 deletions(-)
