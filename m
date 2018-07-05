Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBA1C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C2A20883
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C2A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbeGEKKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:10:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47022 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753155AbeGEKKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:10:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EF2D7A9;
        Thu,  5 Jul 2018 03:10:45 -0700 (PDT)
Received: from [10.1.206.36] (e113632-lin.cambridge.arm.com [10.1.206.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E85C3F2EA;
        Thu,  5 Jul 2018 03:10:44 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Avoid divide by zero when rebalancing domains
To:     Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
References: <20180704142455.16035-1-matt@codeblueprint.co.uk>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <55afee27-4143-e08c-b254-0d68a05d5ee6@arm.com>
Date:   Thu, 5 Jul 2018 11:10:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704142455.16035-1-matt@codeblueprint.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/07/18 15:24, Matt Fleming wrote:
> It's possible that the CPU doing nohz idle balance hasn't had its own
> load updated for many seconds. This can lead to huge deltas between
> rq->avg_stamp and rq->clock when rebalancing, and has been seen to
> cause the following crash:
> 
>  divide error: 0000 [#1] SMP
>  Call Trace:
>   [<ffffffff810bcba8>] update_sd_lb_stats+0xe8/0x560
>   [<ffffffff810bd04d>] find_busiest_group+0x2d/0x4b0
>   [<ffffffff810bd640>] load_balance+0x170/0x950
>   [<ffffffff810be3ff>] rebalance_domains+0x13f/0x290
>   [<ffffffff810852bc>] __do_softirq+0xec/0x300
>   [<ffffffff8108578a>] irq_exit+0xfa/0x110
>   [<ffffffff816167d9>] reschedule_interrupt+0xc9/0xd0
> 

Do you have some sort of reproducer for that crash? If not I guess I can cook
something up with a quiet userspace & rt-app, though I've never seen that one
on arm64.

> Make sure we update the rq clock and load before balancing.
> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mike Galbraith <umgwanakikbuti@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
> ---
>  kernel/sched/fair.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2f0a0be4d344..2c81662c858a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9597,6 +9597,16 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>  	 */
>  	smp_mb();
>  
> +	/*
> +	 * Ensure this_rq's clock and load are up-to-date before we
> +	 * rebalance since it's possible that they haven't been
> +	 * updated for multiple schedule periods, i.e. many seconds.
> +	 */
> +	raw_spin_lock_irq(&this_rq->lock);
> +	update_rq_clock(this_rq);
> +	cpu_load_update_idle(this_rq);
> +	raw_spin_unlock_irq(&this_rq->lock);
> +

I'm failing to understand why the updates further down below are seemingly
not enough. After we've potentially done 

    update_rq_clock(rq);
    cpu_load_update_idle(rq);

for all nohz cpus != this_cpu, we still end up doing:

    if (idle != CPU_NEWLY_IDLE) {
	    update_blocked_averages(this_cpu);
	    has_blocked_load |= this_rq->has_blocked_load;
    }

which should properly update this_rq's clock and load before we attempt to do
any balancing on it.

>  	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
>  		if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
>  			continue;
> 
