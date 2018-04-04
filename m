Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeDDS7V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:59:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:17360 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeDDS7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:59:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,407,1517904000";
   d="scan'208";a="40708552"
Date: Wed, 4 Apr 2018 11:56:16 -0700 (PDT)
From: Shivappa Vikas <vikas.shivappa@intel.com>
X-X-Sender: vikas@vshiva-Udesk
To: Thomas Gleixner <tglx@linutronix.de>
cc: Shivappa Vikas <vikas.shivappa@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/6] x86/intel_rdt/mba_sc: Add documentation for MBA
 software controller
In-Reply-To: <alpine.DEB.2.21.1804041037090.2056@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.10.1804041153010.27913@vshiva-Udesk>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com> <1522362376-3505-2-git-send-email-vikas.shivappa@linux.intel.com> <alpine.DEB.2.21.1803302153280.1479@nanos.tec.linutronix.de> <alpine.DEB.2.10.1804031118410.27913@vshiva-Udesk>
 <alpine.DEB.2.21.1804041037090.2056@nanos.tec.linutronix.de>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Apr 2018, Thomas Gleixner wrote:

> On Tue, 3 Apr 2018, Shivappa Vikas wrote:
> > On Tue, 3 Apr 2018, Thomas Gleixner wrote:
> > > On Thu, 29 Mar 2018, Vikas Shivappa wrote:
> > > The L2 external bandwidth is higher than the L3 external bandwidth.
> > > 
> > >  Is there any information available from CPUID or whatever source which
> > >  allows us to retrieve the bandwidth ratio or the absolute maximum
> > >  bandwidth per level?
> > 
> > There is no information in cpuid on the bandwidth available. Also we have seen
> > from our experiments that the increase is not perfectly linear (delta
> > bandwidth increase from 30% to 40% may not be same as 70% to 80%). So we
> > currently dynamically caliberate this delta for the software controller.
> 
> I assume you mean: calibrate
> 
> Though I don't see anything which looks remotely like calibration.
> Calibration means that you determine the exact parameters by observation and
> then can use the calibrated values afterwards. But that's not what you are
> doing. So please don't claim its calibration.
> 
> You observe behaviour which depends on the workload and other
> factors. That's not calibration. If you change the MSR by a granularity
> value then you calculate the bandwidth delta vs. the previous MSR
> value. That only makes sense and works when the application is having the
> same memory access patterns accross both observation periods.
> 
> And of course, this won't be necessarily linear because if you throttle the
> application then it gets less work done per CPU time slice and the
> resulting stalls will also have side effects on the requested amount of
> memory and therefore distort the measurement. Ditto the other way
> around.
> 
> There are too many factors influencing this, so claiming that it's
> calibration is window dressing at best. Even worse it suggests that it's
> something accurate, which subverts your goal of reducing confusion.
> 
> Adaptive control might be an acceptable description, though given the
> amount of factors which play into that it's still an euphemism for
> 'heuristic'.

Agree we donot really caliberate and the only thing we guarentee is that 
the actual bandwidth in bytes < user specified bandwidth bytes. This is 
what the hardware guarenteed when we specified the values in percentage 
as well but just that it was confusing.

> 
> > > What's also missing from your explanation is how that feedback loop behaves
> > > under different workloads.
> > > 
> > >  Is this assuming that the involved threads/cpus actually try to utilize
> > >  the bandwidth completely?
> > 
> > No, the feedback loop only guarentees that the usage will not exceed what the
> > user specifies as max bandwidth. If it is using below the max value it does
> > not matter how much less it is using.
> > > 
> > >  What happens if the threads/cpus are only using a small set because they
> > >  are idle or their computations are mostly cache local and do not need
> > >  external bandwidth? Looking at the implementation I don't see how that is
> > >  taken into account.
> > 
> > The feedback only kicks into action if a rdtgroup uses more bandwidth than the
> > max specified by the user. I specified that it is always "ensure the "actual
> > b/w
> > 354 < user b/w" " and can add more explanation on these scenarios.
> 
> Please finally stop to use this horrible 'b/w' thingy. It makes my eyes bleed
> everytime.

Will fix - this was a text from already existing documentation.

> 
> > Also note that we are using the MBM counters for this feedback loop. Now that
> > the interface is much more useful because we have the same rdtgroup that is
> > being monitored and controlled. (vs. if we had the perf mbm the group of
> > threads in resctrl mba and in mbm could be different and would be hard to
> > measure what the threads/cpus in the resctrl are using).
> 
> Why does that make me smile?

I know why :) Full credits to you as you had suggested to rewrite the 
cqm/mbm in resctrl which is definitely very good in long term !

Thanks,
Vikas

> 
> Thanks,
> 
> 	tglx
> 
