Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4789C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DAC2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DAC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJYSDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:03:01 -0400
Received: from foss.arm.com ([217.140.101.70]:53686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbeJYSDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:03:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4D99341;
        Thu, 25 Oct 2018 02:31:05 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFCEC3F627;
        Thu, 25 Oct 2018 02:31:02 -0700 (PDT)
Date:   Thu, 25 Oct 2018 10:31:00 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     "Ye, Xiaolong" <xiaolong.ye@intel.com>,
        Joel Fernandes <joelaf@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steve Muckle <smuckle@google.com>, "lkp@01.org" <lkp@01.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chris Redpath <chris.redpath@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [lkp-robot] [sched/fair] d519329f72: unixbench.score -9.9%
 regression
Message-ID: <20181025093100.GB13236@e110439-lin>
References: <20180402032000.GD3101@yexl-desktop>
 <20181024064100.GA27054@intel.com>
 <20181024170137.GA13236@e110439-lin>
 <20181025085629.GA18146@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025085629.GA18146@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-Oct 16:56, Aaron Lu wrote:
> On Wed, Oct 24, 2018 at 06:01:37PM +0100, Patrick Bellasi wrote:
> > On 24-Oct 14:41, Aaron Lu wrote:
> > > On Mon, Apr 02, 2018 at 11:20:00AM +0800, Ye, Xiaolong wrote:
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed a -9.9% regression of unixbench.score due to commit:
> > > > 
> > > > 
> > > > commit: d519329f72a6f36bc4f2b85452640cfe583b4f81 ("sched/fair: Update util_est only on util_avg updates")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > 
> > > > in testcase: unixbench
> > > > on test machine: 8 threads Intel(R) Core(TM) i7 CPU 870 @ 2.93GHz with 6G memory
> > > > with following parameters:
> > > > 
> > > >         runtime: 300s
> > > >         nr_task: 100%
> > > >         test: execl
> > > > 
> > > > test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> > > > test-url: https://github.com/kdlucas/byte-unixbench
> > 
> > Hi Aaron,
> >  
> > > I tested this workload on different machines with this commit
> > > d519329f72a6f36bc4f2b85452 and its parent a07630b8b2c16f82, I also
> > > tested with v4.19-rc8 to see if the regression is gone -
> > > the performance drop is there with v4.19-rc8 and with different
> > > machines so I assume this regression is not solved yet.
> > >
> > > Here are detailed data:
> > > 
> > > cmdline used to run this workload:
> > > ./Run execl -c $nr_cpu -i 30
> > 
> > I had a better look into this issue and found that something like this
> > could be the cure for the execl throughput regression:
> 
> Good news, yes they are!

Great.

> > ---8<---
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 908c9cdae2f0..c34d41b542fc 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6258,8 +6258,17 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
> >  	 * covered by the following code when estimated utilization is
> >  	 * enabled.
> >  	 */
> > -	if (sched_feat(UTIL_EST))
> > -		util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
> > +	if (sched_feat(UTIL_EST)) {
> > +		unsigned int estimated =
> > +			READ_ONCE(cfs_rq->avg.util_est.enqueued);
> > +
> > +		if (unlikely(current == p)) {
> > +			estimated -= min_t(unsigned int, estimated,
> > +				(_task_util_est(p) | UTIL_AVG_UNCHANGED));
> > +		}
> > +
> > +		util = max(util, estimated);
> > +	}
> > 
> >  	/*
> >  	 * Utilization (estimated) can exceed the CPU capacity, thus let's
> > ---8<---
> > 
> > I'll test this better on a machine on my side and send out a proper
> > patch by tomorrow.
> > 
> > > Please let me know if you need other information, thanks.
> > 
> > Would be nice if you can test the above on your side too.
> > 
> 
> commit cbcb74a95c5af32f9127a102feca323139ba2c49 is the commit I made
> from your diff and it restored performance for the two desktops. the
> result on the skylake server isn't quite stable so I think the
> performance gap is due to noise.
> 
> lkp-ivb-d04:
> cbcb74a95c5af32f9127a102feca323139ba2c49/avg.json:  "unixbench.score": 2946.0,
> d519329f72a6f36bc4f2b85452640cfe583b4f81/avg.json:  "unixbench.score": 2669.5333333333333,
> a07630b8b2c16f82fd5b71d890079f4dd7599c1d/avg.json:  "unixbench.score": 2924.3333333333335,
> 
> lkp-hsw-d01:
> cbcb74a95c5af32f9127a102feca323139ba2c49/avg.json:  "unixbench.score": 7013.533333333333,
> d519329f72a6f36bc4f2b85452640cfe583b4f81/avg.json:  "unixbench.score": 6421.233333333333,
> a07630b8b2c16f82fd5b71d890079f4dd7599c1d/avg.json:  "unixbench.score": 7090.400000000001,
> 
> lkp-skl-2sp2:
> cbcb74a95c5af32f9127a102feca323139ba2c49/avg.json:  "unixbench.score": 9347.02,
> d519329f72a6f36bc4f2b85452640cfe583b4f81/avg.json:  "unixbench.score": 9362.76,
> a07630b8b2c16f82fd5b71d890079f4dd7599c1d/avg.json:  "unixbench.score": 9520.86,

I've measured a ~15% speedup with the patch in wrt v4.19.0 on a
40 CPUs Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz.

################################################################################
### Mainline (v4.19.0):

Benchmark Run: Wed Oct 24 2018 16:13:34 - 16:19:04
40 CPUs in system; running 40 parallel copies of tests

Execl Throughput                              48136.5 lps   (29.9 s, 7 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
Execl Throughput                                 43.0      48136.5  11194.5
                                                                   ========
System Benchmarks Index Score (Partial Only)                        11194.5

################################################################################
### Mainline (v4.19.0) + patch:

Benchmark Run: Wed Oct 24 2018 16:29:56 - 16:35:26
40 CPUs in system; running 40 parallel copies of tests

Execl Throughput                              55373.6 lps   (29.9 s, 7 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
Execl Throughput                                 43.0      55373.6  12877.6
                                                                   ========
System Benchmarks Index Score (Partial Only)                        12877.6

################################################################################

Thanks again reporting and testing on your side, I'll post soon a proper
patch.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
