Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754239AbeDYK4H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:56:07 -0400
Received: from foss.arm.com ([217.140.101.70]:37828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751965AbeDYK4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:56:04 -0400
Date: Wed, 25 Apr 2018 11:55:57 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
Message-ID: <20180425105557.GA10471@e108498-lin.cambridge.arm.com>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
 <20180424104304.GE4064@hirez.programming.kicks-ass.net>
 <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com>
 <20180424123523.GF4064@hirez.programming.kicks-ass.net>
 <20180425051509.aohopadqw7q5urbd@vireshk-i7>
 <20180425081334.GF14391@e108498-lin.cambridge.arm.com>
 <20180425090327.7mwm2pdheeptz6sd@vireshk-i7>
 <20180425093909.GI14391@e108498-lin.cambridge.arm.com>
 <20180425101313.zwxg7gz2ybnvlvtn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425101313.zwxg7gz2ybnvlvtn@vireshk-i7>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 Apr 2018 at 15:43:13 (+0530), Viresh Kumar wrote:
> On 25-04-18, 10:39, Quentin Perret wrote:
> > On Wednesday 25 Apr 2018 at 14:33:27 (+0530), Viresh Kumar wrote:
> > > On 25-04-18, 09:13, Quentin Perret wrote:
> > > > While you're at it, you could probably remove the one in wake_cap() ? I
> > > > think having just one in select_task_rq_fair() should be enough.
> > > 
> > > Just make it clear, you are asking me to remove sync_entity_load_avg()
> > > in wake_cap() ? But aren't we required to do that, as in the very next
> > > line we call task_util(p) ?
> > 
> > Right, we do need to call sync_entity_load_avg() at some point before
> > calling task_util(), but we don't need to re-call it in strf()
> > after in this case. So my point was just that if you want to re-work
> > the wake-up path and make sure we don't call sync_entity_load_avg()
> > if not needed then this might need fixing as well ... Or maybe we don't
> > care since re-calling sync_entity_load_avg() should be really cheap ...
> 
> These are in two very different paths and I am not sure of a clean way
> to avoid calling sync_entity_load_avg() again. Maybe will leave it as
> is for now.

Fair enough, I don't really like this double call but, looking into more
details, I'm not sure how to avoid it cleanly either ...
