Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeDDJLT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:11:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32844 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeDDJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:11:18 -0400
Date: Wed, 4 Apr 2018 11:11:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Shivappa Vikas <vikas.shivappa@intel.com>
cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/6] x86/intel_rdt/mba_sc: Add documentation for MBA
 software controller
In-Reply-To: <alpine.DEB.2.10.1804031118410.27913@vshiva-Udesk>
Message-ID: <alpine.DEB.2.21.1804041037090.2056@nanos.tec.linutronix.de>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com> <1522362376-3505-2-git-send-email-vikas.shivappa@linux.intel.com> <alpine.DEB.2.21.1803302153280.1479@nanos.tec.linutronix.de> <alpine.DEB.2.10.1804031118410.27913@vshiva-Udesk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018, Shivappa Vikas wrote:
> On Tue, 3 Apr 2018, Thomas Gleixner wrote:
> > On Thu, 29 Mar 2018, Vikas Shivappa wrote:
> > The L2 external bandwidth is higher than the L3 external bandwidth.
> > 
> >  Is there any information available from CPUID or whatever source which
> >  allows us to retrieve the bandwidth ratio or the absolute maximum
> >  bandwidth per level?
> 
> There is no information in cpuid on the bandwidth available. Also we have seen
> from our experiments that the increase is not perfectly linear (delta
> bandwidth increase from 30% to 40% may not be same as 70% to 80%). So we
> currently dynamically caliberate this delta for the software controller.

I assume you mean: calibrate

Though I don't see anything which looks remotely like calibration.
Calibration means that you determine the exact parameters by observation and
then can use the calibrated values afterwards. But that's not what you are
doing. So please don't claim its calibration.

You observe behaviour which depends on the workload and other
factors. That's not calibration. If you change the MSR by a granularity
value then you calculate the bandwidth delta vs. the previous MSR
value. That only makes sense and works when the application is having the
same memory access patterns accross both observation periods.

And of course, this won't be necessarily linear because if you throttle the
application then it gets less work done per CPU time slice and the
resulting stalls will also have side effects on the requested amount of
memory and therefore distort the measurement. Ditto the other way
around.

There are too many factors influencing this, so claiming that it's
calibration is window dressing at best. Even worse it suggests that it's
something accurate, which subverts your goal of reducing confusion.

Adaptive control might be an acceptable description, though given the
amount of factors which play into that it's still an euphemism for
'heuristic'.

> > What's also missing from your explanation is how that feedback loop behaves
> > under different workloads.
> > 
> >  Is this assuming that the involved threads/cpus actually try to utilize
> >  the bandwidth completely?
> 
> No, the feedback loop only guarentees that the usage will not exceed what the
> user specifies as max bandwidth. If it is using below the max value it does
> not matter how much less it is using.
> > 
> >  What happens if the threads/cpus are only using a small set because they
> >  are idle or their computations are mostly cache local and do not need
> >  external bandwidth? Looking at the implementation I don't see how that is
> >  taken into account.
> 
> The feedback only kicks into action if a rdtgroup uses more bandwidth than the
> max specified by the user. I specified that it is always "ensure the "actual
> b/w
> 354 < user b/w" " and can add more explanation on these scenarios.

Please finally stop to use this horrible 'b/w' thingy. It makes my eyes bleed
everytime.

> Also note that we are using the MBM counters for this feedback loop. Now that
> the interface is much more useful because we have the same rdtgroup that is
> being monitored and controlled. (vs. if we had the perf mbm the group of
> threads in resctrl mba and in mbm could be different and would be hard to
> measure what the threads/cpus in the resctrl are using).

Why does that make me smile?

Thanks,

	tglx
