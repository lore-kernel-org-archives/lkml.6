Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71502C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3127A2150D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3127A2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbeHBOyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:54:53 -0400
Received: from foss.arm.com ([217.140.101.70]:57800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732267AbeHBOyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:54:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A53577A9;
        Thu,  2 Aug 2018 06:03:46 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B08003F2EA;
        Thu,  2 Aug 2018 06:03:42 -0700 (PDT)
Date:   Thu, 2 Aug 2018 14:03:38 +0100
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
Message-ID: <20180802130337.uf6tlac2hg4nkbwr@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-10-quentin.perret@arm.com>
 <20180802122629.GU2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802122629.GU2476@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 Aug 2018 at 14:26:29 (+0200), Peter Zijlstra wrote:
> On Tue, Jul 24, 2018 at 01:25:16PM +0100, Quentin Perret wrote:
> > @@ -5100,8 +5118,17 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  		update_cfs_group(se);
> >  	}
> >  
> > -	if (!se)
> > +	if (!se) {
> >  		add_nr_running(rq, 1);
> > +		/*
> > +		 * The utilization of a new task is 'wrong' so wait for it
> > +		 * to build some utilization history before trying to detect
> > +		 * the overutilized flag.
> > +		 */
> > +		if (flags & ENQUEUE_WAKEUP)
> > +			update_overutilized_status(rq);
> > +
> > +	}
> >  
> >  	hrtick_update(rq);
> >  }
> 
> That is a somewhat dodgy hack. There is no guarantee what so ever that
> when the task wakes next its history is any better. The comment doesn't
> reflect this I feel.

AFAICT the main use-case here is to avoid re-enabling the load balance
and ruining all the task placement because of a tiny task. I don't
really see how we can do that differently ...

Or am I missing something Morten ?

In the meantime, I can try to improve the comment at least :-)

Thanks,
Quentin
