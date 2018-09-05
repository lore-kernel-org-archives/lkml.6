Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4600EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C9020645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C9020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeIFAe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:34:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:35758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727254AbeIFAe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:34:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0E65AE46;
        Wed,  5 Sep 2018 20:02:41 +0000 (UTC)
Date:   Wed, 5 Sep 2018 22:02:40 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
In-Reply-To: <20180905184018.GC11625@redhat.com>
Message-ID: <nycvar.YFH.7.76.1809052159330.15880@cbobk.fhfr.pm>
References: <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm> <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com> <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809042046180.15880@cbobk.fhfr.pm> <3f24e8c8-eab8-66c2-9a8d-957e30cac809@linux.intel.com> <nycvar.YFH.7.76.1809050725390.15880@cbobk.fhfr.pm> <20180905155823.GL27886@tassilo.jf.intel.com> <20180905180459.GB11625@redhat.com>
 <nycvar.YFH.7.76.1809052026470.15880@cbobk.fhfr.pm> <20180905184018.GC11625@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Andrea Arcangeli wrote:

> [ 1838.621010] Kernel panic - not syncing: Watchdog detected hard LOCKUP on cpu 6
> [ 1838.629070] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 3.10.0-327.62.4.el7.x86_64 #1
> [ 1838.637610] Hardware name: Dell Inc. PowerEdge R430/0CN7X8, BIOS 2.4.2 01/09/2017
> [ 1838.645954] Call Trace:
> [ 1838.648680]  <NMI>  [<ffffffff8163a05d>] dump_stack+0x19/0x1b
> [ 1838.655113]  [<ffffffff816338d0>] panic+0xd8/0x1e7
> [ 1838.660460]  [<ffffffff8111e960>] ? restart_watchdog_hrtimer+0x50/0x50
> [ 1838.667742]  [<ffffffff8111ea22>] watchdog_overflow_callback+0xc2/0xd0
> [ 1838.675024]  [<ffffffff81162211>] __perf_event_overflow+0xa1/0x250
> [ 1838.681920]  [<ffffffff81162ce4>] perf_event_overflow+0x14/0x20
> [ 1838.688526]  [<ffffffff810337c8>] intel_pmu_handle_irq+0x1e8/0x470
> [ 1838.695423]  [<ffffffff812f83cc>] ? ioremap_page_range+0x24c/0x330
> [ 1838.702320]  [<ffffffff811a9031>] ? unmap_kernel_range_noflush+0x11/0x20
> [ 1838.709797]  [<ffffffff813997f4>] ? ghes_copy_tofrom_phys+0x124/0x210
> [ 1838.716984]  [<ffffffff81399980>] ? ghes_read_estatus+0xa0/0x190
> [ 1838.723687]  [<ffffffff816444bb>] perf_event_nmi_handler+0x2b/0x50
> [ 1838.730582]  [<ffffffff81643c09>] nmi_handle.isra.0+0x69/0xb0
> [ 1838.736992]  [<ffffffff81643db9>] do_nmi+0x169/0x340
> [ 1838.742532]  [<ffffffff81642ff9>] end_repeat_nmi+0x1e/0x7e
> [ 1838.748653]  [<ffffffff81641bbd>] ? _raw_spin_lock_irqsave+0x3d/0x60
> [ 1838.755742]  [<ffffffff81641bbd>] ? _raw_spin_lock_irqsave+0x3d/0x60
> [ 1838.762831]  [<ffffffff81641bbd>] ? _raw_spin_lock_irqsave+0x3d/0x60
> [ 1838.769917]  <<EOE>>  [<ffffffff816391e5>] avc_compute_av+0x126/0x1b5
> [ 1838.777125]  [<ffffffff810b842e>] ? walk_tg_tree_from+0xbe/0x110
> [ 1838.783828]  [<ffffffff8128b9c4>] avc_has_perm_noaudit+0xc4/0x110
> [ 1838.790628]  [<ffffffff8128f1fb>] cred_has_capability+0x6b/0x120
> [ 1838.797331]  [<ffffffff810db71c>] ? ktime_get+0x4c/0xd0
> [ 1838.803160]  [<ffffffff810e167b>] ? clockevents_program_event+0x6b/0xf0
> [ 1838.810532]  [<ffffffff8128f2de>] selinux_capable+0x2e/0x40
> [ 1838.816748]  [<ffffffff81288f65>] security_capable_noaudit+0x15/0x20
> [ 1838.823829]  [<ffffffff8108b975>] has_ns_capability_noaudit+0x15/0x20
> [ 1838.831014]  [<ffffffff8108bc55>] ptrace_has_cap+0x35/0x40
> [ 1838.837126]  [<ffffffff8108c717>] ___ptrace_may_access+0xa7/0x1e0
> [ 1838.843925]  [<ffffffff8163f0ae>] __schedule+0x26e/0xa00
> [ 1838.849855]  [<ffffffff81640949>] schedule_preempt_disabled+0x29/0x70
> [ 1838.857041]  [<ffffffff810d9324>] cpu_startup_entry+0x184/0x290
> [ 1838.863637]  [<ffffffff8104891a>] start_secondary+0x1da/0x250

So yeah, current Linus' tree needs the same treatment -- we have to avoid 
calling out to ptrace_has_cap() in PTRACE_MODE_NOACCESS_CHK cases.

I have updated the patch for v4. Thanks again,

-- 
Jiri Kosina
SUSE Labs

