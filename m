Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67705C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C5A208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C5A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965103AbeFNV4E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:56:04 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46864 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965023AbeFNV4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:56:02 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fTaDl-00082M-L1; Thu, 14 Jun 2018 22:55:57 +0100
Message-ID: <1529013356.2289.200.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 173/268] sched/rt: Fix rq->clock_update_flags <
 RQCF_ACT_SKIP warning
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Davidlohr Bueso <dbueso@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, dave@stgolabs.net,
        rostedt@goodmis.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Jun 2018 22:55:56 +0100
In-Reply-To: <20180528100221.993481294@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100221.993481294@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:02 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> [ Upstream commit d29a20645d5e929aa7e8616f28e5d8e1c49263ec ]
> 
> While running rt-tests' pi_stress program I got the following splat:
> 
>   rq->clock_update_flags < RQCF_ACT_SKIP
>   WARNING: CPU: 27 PID: 0 at kernel/sched/sched.h:960 assert_clock_updated.isra.38.part.39+0x13/0x20
> 
>   [...]
> 
>   <IRQ>
>   enqueue_top_rt_rq+0xf4/0x150
>   ? cpufreq_dbs_governor_start+0x170/0x170
>   sched_rt_rq_enqueue+0x65/0x80
>   sched_rt_period_timer+0x156/0x360
>   ? sched_rt_rq_enqueue+0x80/0x80
>   __hrtimer_run_queues+0xfa/0x260
>   hrtimer_interrupt+0xcb/0x220
>   smp_apic_timer_interrupt+0x62/0x120
>   apic_timer_interrupt+0xf/0x20
>   </IRQ>
> 
>   [...]
> 
>   do_idle+0x183/0x1e0
>   cpu_startup_entry+0x5f/0x70
>   start_secondary+0x192/0x1d0
>   secondary_startup_64+0xa5/0xb0
> 
> We can get rid of it be the "traditional" means of adding an
> update_rq_clock() call after acquiring the rq->lock in
> do_sched_rt_period_timer().
> 
> The case for the RT task throttling (which this workload also hits)
> can be ignored in that the skip_update call is actually bogus and
> quite the contrary (the request bits are removed/reverted).
> 
> By setting RQCF_UPDATED we really don't care if the skip is happening
> or not and will therefore make the assert_clock_updated() check happy.

There is no such flag or assertion in 4.4 or 4.9, so does this change
still make sense there?

Ben.

> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: dave@stgolabs.net
> Cc: linux-kernel@vger.kernel.org
> Cc: rostedt@goodmis.org
> Link: http://lkml.kernel.org/r/20180402164954.16255-1-dave@stgolabs.net
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/sched/rt.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -822,6 +822,8 @@ static int do_sched_rt_period_timer(stru
>  		struct rq *rq = rq_of_rt_rq(rt_rq);
>  
>  		raw_spin_lock(&rq->lock);
> +		update_rq_clock(rq);
> +
>  		if (rt_rq->rt_time) {
>  			u64 runtime;
>  
> 
> 
> 
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
