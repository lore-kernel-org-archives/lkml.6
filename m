Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeDFK1q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:27:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41059 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeDFK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:27:45 -0400
Date: Fri, 6 Apr 2018 12:27:39 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
cc: akpm@linux-foundation.org, mingo@kernel.org, keescook@chromium.org,
        lauraa@codeaurora.org, viresh.kumar@linaro.org,
        nicolas.pitre@linaro.org, thomas.lendacky@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A question of sleeping with interrupts are disabled in
 start_kernel()
In-Reply-To: <1eb16c24-ef3b-2962-d216-57f66321035e@gmail.com>
Message-ID: <alpine.DEB.2.21.1804061223240.1982@nanos.tec.linutronix.de>
References: <1eb16c24-ef3b-2962-d216-57f66321035e@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018, Jia-Ju Bai wrote:

> Hello,
> 
> I have a question of the call path init/main.c:
> init/main.c: start_kernel() ->
> kernel/events/core.c: perf_pmu_register() ->
> kernel/events/core.c: perf_event_init() ->
> kernel/events/core.c: pmu_dev_alloc()
> 
> In this call path, start_kernel() calls local_irq_disable() to disable the
> interrupt;
> perf_pmu_register() calls mutex_lock() and idr_alloc(GFP_KERNEL), and they can
> sleep;
> pmu_dev_alloc() calls kzalloc(GFP_KERNEL), and it can sleep.
> 
> In my opinion, this code may sleep with interrupts are disabled.
> I wonder why this code is okay?

Because this is the very early boot up stage where contention of the mutex
cannot happen and the allocations are all implicitely converted to atomic
allocations. If the mutex would be contended then the system would fail to
boot anyway. If the allocations fail at that stage, it's unlikely that the
machine will come up at all.

So yes, it looks odd, but we don't want to have duplicated code pathes just
for the early boot up and the debugging mechanisms are aware of that
situation and don't emit warnings. Once the scheduler is functional and the
early boot stage is done, these 'magic' violations are not longer allowed.

Hope that helps.

Thanks,

	tglx
