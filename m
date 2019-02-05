Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0F9C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AD52070B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfBELUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:20:02 -0500
Received: from foss.arm.com ([217.140.101.70]:39896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbfBELUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:20:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B2E480D;
        Tue,  5 Feb 2019 03:20:01 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A05A73F675;
        Tue,  5 Feb 2019 03:19:59 -0800 (PST)
Subject: Re: [PATCH 1/5] perf/arm-cci: Fix CPU hotplug race avoidance
To:     robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, tglx@linutronix.de, bigeasy@linutronix.de,
        Meng.Li@windriver.com
References: <cover.1549299188.git.robin.murphy@arm.com>
 <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3ebabec2-5423-9aca-19aa-7cd96353efd6@arm.com>
Date:   Tue, 5 Feb 2019 11:19:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin,

On 04/02/2019 17:09, Robin Murphy wrote:
> The arm-cci probe logic faces a cyclic dependency wherein it has to pick
> a valid CPU to associate with before registering the PMU device, has to
> have the PMU state initialised before handling hotplug events in case it
> must be migrated, but has to have the hotplug notifier registered before
> the chosen CPU may go offline lest things get out of sync. The present
> code has tried to solve the races by using get_cpu() to pick the current
> CPU and prevent it from disappearing while the other two registrations
> are performed, but that results in taking mutexes with preemption
> disabled, which makes certain configurations very unhappy:
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
> However, we don't actually mind being preempted or migrated at this
> point; all that really matters is that whichever CPU we pick does not
> get offlined before we're done. Thus, do the robust thing and instead
> take the lock to inhibit CPU hotplug for the duration. This also
> revealed an additional race in assigning the global pointer too late
> relative to the hotplug notifier, so that gets fixed in the process.
> 
> Reported-by: "Li, Meng" <Meng.Li@windriver.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks for fixing the issues.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
