Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612EC2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbfA3SVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:21:32 -0500
Received: from foss.arm.com ([217.140.101.70]:59648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733006AbfA3SVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:21:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7A9E80D;
        Wed, 30 Jan 2019 10:21:31 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B51CE3F557;
        Wed, 30 Jan 2019 10:21:30 -0800 (PST)
Date:   Wed, 30 Jan 2019 18:21:28 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        suzuki.poulose@arm.com, robin.murphy@arm.com
Subject: Re: Could you please help to have a look a bug trace in pmu arm-cci.c
Message-ID: <20190130182128.GM18558@fuggles.cambridge.arm.com>
References: <529F9A9100AE8045A7A5B5A00A39FBB862099B8E@ALA-MBD.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529F9A9100AE8045A7A5B5A00A39FBB862099B8E@ALA-MBD.corp.ad.wrs.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Suzuki and Robin]

On Mon, Jan 28, 2019 at 07:19:20AM +0000, Li, Meng wrote:
> When enable kernel configure CONFIG_DEBUG_ATOMIC_SLEEP, there is below trace
> during pmu arm cci driver probe phase.
> 
> [ 1.983337] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:2004
> [ 1.983340] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
> [ 1.983342] Preemption disabled at:
> [ 1.983353] [<ffffff80089801f4>] cci_pmu_probe+0x1dc/0x488
> [ 1.983360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.20-rt8-yocto-preempt-rt #1
> [ 1.983362] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [ 1.983364] Call trace:
> [ 1.983369] dump_backtrace+0x0/0x158
> [ 1.983372] show_stack+0x24/0x30
> [ 1.983378] dump_stack+0x80/0xa4
> [ 1.983383] ___might_sleep+0x138/0x160
> [ 1.983386] __might_sleep+0x58/0x90
> [ 1.983391] __rt_mutex_lock_state+0x30/0xc0
> [ 1.983395] _mutex_lock+0x24/0x30
> [ 1.983400] perf_pmu_register+0x2c/0x388
> [ 1.983404] cci_pmu_probe+0x2bc/0x488
> [ 1.983409] platform_drv_probe+0x58/0xa8
> 
> Because get_cpu() is invoked, preempt is disable, finally, trace occurs when
> call might_sleep()

Hmm, the {get,put}_cpu() usage here looks very broken to me. There's the
fact that it might sleep, but also the assignment to g_cci_pmu is done after
we've re-enabled preemption, so there's a race with CPU hotplug there too.

I don't think we can simply register the hotplug notifier before registering
the PMU, because we can't call into perf_pmu_migrate_context() until the PMU
has been registered. Perhaps we need to use the _cpuslocked() versions of
the hotplug notifier registration functions.

I tried looking at some other drivers, but they all look broken to me, so
there's a good chance I'm missing something. Anybody know how this is
supposed to work?

Will
