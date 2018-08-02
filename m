Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E337FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FE22150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FE22150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeHBPKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:10:11 -0400
Received: from foss.arm.com ([217.140.101.70]:58088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732270AbeHBPKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:10:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C0707A9;
        Thu,  2 Aug 2018 06:19:00 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 277BC3F2EA;
        Thu,  2 Aug 2018 06:18:56 -0700 (PDT)
Date:   Thu, 2 Aug 2018 14:18:51 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180802131849.mqpt5lbtcqrxbwig@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-10-quentin.perret@arm.com>
 <20180802122629.GU2476@hirez.programming.kicks-ass.net>
 <20180802130337.uf6tlac2hg4nkbwr@queper01-lin>
 <20180802130801.GL2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802130801.GL2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 Aug 2018 at 15:08:01 (+0200), Peter Zijlstra wrote:
> On Thu, Aug 02, 2018 at 02:03:38PM +0100, Quentin Perret wrote:
> > On Thursday 02 Aug 2018 at 14:26:29 (+0200), Peter Zijlstra wrote:
> > > On Tue, Jul 24, 2018 at 01:25:16PM +0100, Quentin Perret wrote:
> > > > @@ -5100,8 +5118,17 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > >  		update_cfs_group(se);
> > > >  	}
> > > >  
> > > > -	if (!se)
> > > > +	if (!se) {
> > > >  		add_nr_running(rq, 1);
> > > > +		/*
> > > > +		 * The utilization of a new task is 'wrong' so wait for it
> > > > +		 * to build some utilization history before trying to detect
> > > > +		 * the overutilized flag.
> > > > +		 */
> > > > +		if (flags & ENQUEUE_WAKEUP)
> > > > +			update_overutilized_status(rq);
> > > > +
> > > > +	}
> > > >  
> > > >  	hrtick_update(rq);
> > > >  }
> > > 
> > > That is a somewhat dodgy hack. There is no guarantee what so ever that
> > > when the task wakes next its history is any better. The comment doesn't
> > > reflect this I feel.
> > 
> > AFAICT the main use-case here is to avoid re-enabling the load balance
> > and ruining all the task placement because of a tiny task. I don't
> > really see how we can do that differently ...
> 
> Sure I realize that.. but it doesn't completely avoid it. Suppose this
> new task instantly blocks and wakes up again. Then its util signal will
> be exactly what you didn't want but we'll account it and cause the above
> scenario you wanted to avoid.

That is true. ... I also realize now that this patch was written long
before util_est, and that also has an impact here, especially in the
scenario you described where the task blocks. So any wake-up after the
first enqueue will risk to overutilize the system, even if the task
blocked for ages.

Hmm ...
