Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910C9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB16223D0
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvdgPw/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB16223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbeKNMr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731854AbeKNMr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:27 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC59520818;
        Wed, 14 Nov 2018 02:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163576;
        bh=J0lMDR6Y+j9pMOnuiTmJw1LzGjNv9ecuHy0DqgMiZtM=;
        h=From:To:Cc:Subject:Date:From;
        b=jvdgPw/CWG9cbq8Mmcl/5bf6d9+jgT0Isl4VIeSi5NnbhBAtNPhfjGT3n7ge9OEmM
         irIWt1Hdp/KsC06z3noFP44FVekOUWFf9VxuJDE67FNLP2844l5nXyxowZfAZWww79
         3HLu8u2tpiaJjhFA8Gcl5CAmLa0n2QH2haZTqXxY=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 00/25] sched/nohz: Make kcpustat vtime aware (Fix kcpustat on nohz_full)
Date:   Wed, 14 Nov 2018 03:45:44 +0100
Message-Id: <1542163569-20047-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kcpustat (the stats you see for each CPU on /proc/stat) is partly
maintained by the tick, updated by TICK_NSEC every jiffy, the same way
we account the cputime for tasks.

Now in the case of nohz_full, kcpustat doesn't get accounted anymore while
the tick is stopped. Vtime maintains the task cputime but not kcpustat.

This issue was hidden as long as we had the 1Hz remaining tick, then
Yauheni Kaliuta made me remember that problem.

I scratched my head a lot on this, due to all the possible races.
The solution here is to fetch the task running on a CPU with RCU, read
its vtime delta (like we do for cputime) and add it to the relevant
kcpustat field. There have been several subtleties on the way (concurrent
task nice changes, earliest RCU delayed put_task_struct(), ordering with
vtime) and I couldn't resist a few cleanups so the patchset isn't too
small, sorry about that...

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	nohz/kcpustat

HEAD: c7c45c06334346f62dbbf7bb12e2a8ab954532e5

Thanks,
	Frederic
---

Frederic Weisbecker (25):
      sched/vtime: Fix guest/system mis-accounting on task switch
      sched/vtime: Protect idle accounting under vtime seqcount
      vtime: Rename vtime_account_system() to vtime_account_kernel()
      vtime: Spare a seqcount lock/unlock cycle on context switch
      sched/vtime: Record CPU under seqcount for kcpustat needs
      sched/cputime: Add vtime idle task state
      sched/cputime: Add vtime guest task state
      vtime: Exit vtime before exit_notify()
      kcpustat: Track running task following vtime sequences
      context_tracking: Remove context_tracking_active()
      context_tracking: s/context_tracking_is_enabled/context_tracking_enabled()
      context_tracking: Rename context_tracking_is_cpu_enabled() to context_tracking_enabled_this_cpu()
      context_tracking: Introduce context_tracking_enabled_cpu()
      sched/vtime: Rename vtime_accounting_cpu_enabled() to vtime_accounting_enabled_this_cpu()
      sched/vtime: Introduce vtime_accounting_enabled_cpu()
      sched/cputime: Allow to pass cputime index on user/guest accounting
      sched/cputime: Standardize the kcpustat index based accounting functions
      vtime: Track nice-ness on top of context switch
      sched/vite: Handle nice updates under vtime
      sched/kcpustat: Introduce vtime-aware kcpustat accessor
      procfs: Use vtime aware kcpustat accessor
      cpufreq: Use vtime aware kcpustat accessor
      leds: Use vtime aware kcpustat accessors
      rackmeter: Use vtime aware kcpustat accessors
      sched/vtime: Clarify vtime_task_switch() argument layout


 arch/ia64/include/asm/cputime.h         |   3 +-
 arch/ia64/kernel/time.c                 |  15 +-
 arch/powerpc/include/asm/cputime.h      |   8 +-
 arch/powerpc/kernel/time.c              |  12 +-
 arch/s390/kernel/vtime.c                |  19 +-
 arch/x86/entry/calling.h                |   2 +-
 drivers/cpufreq/cpufreq.c               |  18 +-
 drivers/cpufreq/cpufreq_governor.c      |  27 ++-
 drivers/leds/trigger/ledtrig-activity.c |   9 +-
 drivers/macintosh/rack-meter.c          |  14 +-
 fs/proc/stat.c                          |  21 +-
 include/linux/context_tracking.h        |  30 +--
 include/linux/context_tracking_state.h  |  19 +-
 include/linux/kernel_stat.h             |  28 ++-
 include/linux/sched.h                   |  12 +-
 include/linux/tick.h                    |   2 +-
 include/linux/vtime.h                   |  72 ++++---
 kernel/context_tracking.c               |   6 +-
 kernel/exit.c                           |   1 +
 kernel/sched/core.c                     |   6 +-
 kernel/sched/cputime.c                  | 372 +++++++++++++++++++++++++-------
 kernel/sched/sched.h                    |  39 ++++
 kernel/time/tick-sched.c                |   2 +-
 23 files changed, 548 insertions(+), 189 deletions(-)
