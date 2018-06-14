Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1AD1CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4281208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4281208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965055AbeFNWcQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964907AbeFNWcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:32:14 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA4B208BA;
        Thu, 14 Jun 2018 22:32:12 +0000 (UTC)
Date:   Thu, 14 Jun 2018 18:32:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, dave@stgolabs.net,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 173/268] sched/rt: Fix rq->clock_update_flags <
 RQCF_ACT_SKIP warning
Message-ID: <20180614183211.0beacf67@gandalf.local.home>
In-Reply-To: <1529013356.2289.200.camel@codethink.co.uk>
References: <20180528100202.045206534@linuxfoundation.org>
        <20180528100221.993481294@linuxfoundation.org>
        <1529013356.2289.200.camel@codethink.co.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 22:55:56 +0100
Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:

> On Mon, 2018-05-28 at 12:02 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > [ Upstream commit d29a20645d5e929aa7e8616f28e5d8e1c49263ec ]
> > 
> > While running rt-tests' pi_stress program I got the following splat:
> > 
> >   rq->clock_update_flags < RQCF_ACT_SKIP
> >   WARNING: CPU: 27 PID: 0 at kernel/sched/sched.h:960 assert_clock_updated.isra.38.part.39+0x13/0x20
> > 
> >   [...]
> > 
> >   <IRQ>
> >   enqueue_top_rt_rq+0xf4/0x150
> >   ? cpufreq_dbs_governor_start+0x170/0x170
> >   sched_rt_rq_enqueue+0x65/0x80
> >   sched_rt_period_timer+0x156/0x360
> >   ? sched_rt_rq_enqueue+0x80/0x80
> >   __hrtimer_run_queues+0xfa/0x260
> >   hrtimer_interrupt+0xcb/0x220
> >   smp_apic_timer_interrupt+0x62/0x120
> >   apic_timer_interrupt+0xf/0x20
> >   </IRQ>
> > 
> >   [...]
> > 
> >   do_idle+0x183/0x1e0
> >   cpu_startup_entry+0x5f/0x70
> >   start_secondary+0x192/0x1d0
> >   secondary_startup_64+0xa5/0xb0
> > 
> > We can get rid of it be the "traditional" means of adding an
> > update_rq_clock() call after acquiring the rq->lock in
> > do_sched_rt_period_timer().
> > 
> > The case for the RT task throttling (which this workload also hits)
> > can be ignored in that the skip_update call is actually bogus and
> > quite the contrary (the request bits are removed/reverted).
> > 
> > By setting RQCF_UPDATED we really don't care if the skip is happening
> > or not and will therefore make the assert_clock_updated() check happy.  
> 
> There is no such flag or assertion in 4.4 or 4.9, so does this change
> still make sense there?

I believe the assert was added to catch bugs like this.

Although the change log is a bit ambiguous in if it is fixing an actual
miss update, or if it is just quieting a false positive.

Davidlohr?

-- Steve


> 
> Ben.
> 
> > Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> > Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Mike Galbraith <efault@gmx.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: dave@stgolabs.net
> > Cc: linux-kernel@vger.kernel.org
> > Cc: rostedt@goodmis.org
> > Link: http://lkml.kernel.org/r/20180402164954.16255-1-dave@stgolabs.net
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/sched/rt.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -822,6 +822,8 @@ static int do_sched_rt_period_timer(stru
> >  		struct rq *rq = rq_of_rt_rq(rt_rq);
> >  
> >  		raw_spin_lock(&rq->lock);
> > +		update_rq_clock(rq);
> > +
> >  		if (rt_rq->rt_time) {
> >  			u64 runtime;
> >  
> > 
> > 
> >   

