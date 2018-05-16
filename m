Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeEPRcl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:32:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:56911 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751430AbeEPRci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:32:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="41476023"
Message-ID: <1526491957.61700.53.camel@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 16 May 2018 10:32:37 -0700
In-Reply-To: <CAJZ5v0gFJQK4FbLx=cOpefSAp2idknC5v7yFm41q+kytK05p_g@mail.gmail.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
         <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
         <20180516071640.GU12217@hirez.programming.kicks-ass.net>
         <20180516072929.GN12235@hirez.programming.kicks-ass.net>
         <CAJZ5v0gFJQK4FbLx=cOpefSAp2idknC5v7yFm41q+kytK05p_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 11:07 +0200, Rafael J. Wysocki wrote:
> On Wed, May 16, 2018 at 9:29 AM, Peter Zijlstra <peterz@infradead.org
> > wrote:
> > On Wed, May 16, 2018 at 09:16:40AM +0200, Peter Zijlstra wrote:
> > > On Tue, May 15, 2018 at 09:49:03PM -0700, Srinivas Pandruvada
> > > wrote:
> > > > intel_pstate has two operating modes: active and passive. In
> > > > "active"
> > > > mode, the in-built scaling governor is used and in "passive"
> > > > mode,
> > > > the driver can be used with any governor like "schedutil". In
> > > > "active"
> > > > mode the utilization values from schedutil is not used and
> > > > there is
> > > > a requirement from high performance computing use cases, not to
> > > > read
> > > > any APERF/MPERF MSRs. In this case no need to use CPU cycles
> > > > for
> > > > frequency invariant accounting by reading APERF/MPERF MSRs.
> > > > With this change frequency invariant account is only enabled in
> > > > "passive" mode.
> > > 
> > > WTH is active/passive? Is passive when we select performance
> > > governor?
> > 
> > Bah, I cannot read it seems. active is when we use the intel_pstate
> > governor and passive is when we use schedutil and only use
> > intel_pstate
> > as a driver.
> > 
> > > Also; you have to explain why using APERF/MPERF is bad in that
> > > case. Why
> > > do they care if we read those MSRs during the tick?
> > 
> > That still stands.. this needs to be properly explained.
> 
> I guess this is from the intel_pstate perspective only.
> 
> The active mode is only used with HWP, so intel_pstate doesn't look
> at
> the utilization (in any form) in the passive mode today.
> 
> Still, there are other reasons for PELT to be scale-invariant, so ...
Not sure about the use case in active mode other than dynamic HWP boost
later in this series. If any, I can remove this patch.
