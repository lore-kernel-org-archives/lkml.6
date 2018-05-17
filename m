Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeEQIUF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:20:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeEQIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:20:02 -0400
Date: Thu, 17 May 2018 10:19:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 05/10] cpufreq: intel_pstate: HWP boost
 performance on IO Wake
Message-ID: <20180517081948.GM12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-6-srinivas.pandruvada@linux.intel.com>
 <20180516073701.GW12217@hirez.programming.kicks-ass.net>
 <1526493313.61700.61.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526493313.61700.61.camel@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 10:55:13AM -0700, Srinivas Pandruvada wrote:
> On Wed, 2018-05-16 at 09:37 +0200, Peter Zijlstra wrote:
> > On Tue, May 15, 2018 at 09:49:06PM -0700, Srinivas Pandruvada wrote:

> > Hurmph, this looks like you're starting to duplicate the schedutil
> > iowait logic. Why didn't you copy the gradual boosting thing?

> I tried what we implemented in intel_pstate in legacy mode, which gave
> the best performance for servers (ramp up faster and slow ramp down).
> This caused regression on some workloads, as each time we can call
> HWP_REQUEST, we spend 1200+ cycles in issuing MSR. So keeping it at max
> for timeout. Even keeping at P1 didn't help in power numbers.

> > > - If the IO flags are notified multiple ticks apart, this may not be
> > > IO bound task. Othewise idle system gets periodic boosts for one
> > > IO wake.

That is what made me think of the gradual boosting. Because that is very
similar to the scenario that made us do that.

But like said elsewhere, ideally we'd use schedutil exclusively and
reduce intel_pstate to a pure driver. The normal way do deal with slow
transitions is rate limiting. Another option is for the slow HWP msr
driver we could choose to only issue the update when we reach max_freq.
But if the MSR ever gets cheaper we can issue it more often/finer
grained.
