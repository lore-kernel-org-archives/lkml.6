Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeEQPEY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:04:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35458 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeEQPEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:04:23 -0400
X-Google-Smtp-Source: AB8JxZpmssDN5uq31TKczLOnUnvFxcPe0ZrKNZ9BtLq1EgmLo9VaqTEykjn/Ca+sGFDwHGdIH6ZoSA==
Date: Thu, 17 May 2018 17:04:18 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
Message-ID: <20180517150418.GF22493@localhost.localdomain>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
 <20180516151925.GO28366@localhost.localdomain>
 <20180516154733.GF12198@hirez.programming.kicks-ass.net>
 <20180516163105.GP28366@localhost.localdomain>
 <20180517105907.GC22493@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517105907.GC22493@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/18 12:59, Juri Lelli wrote:
> On 16/05/18 18:31, Juri Lelli wrote:
> > On 16/05/18 17:47, Peter Zijlstra wrote:
> > > On Wed, May 16, 2018 at 05:19:25PM +0200, Juri Lelli wrote:
> > > 
> > > > Anyway, FWIW I started testing this on a E5-2609 v3 and I'm not seeing
> > > > hackbench regressions so far (running with schedutil governor).
> > > 
> > > https://en.wikipedia.org/wiki/Haswell_(microarchitecture)#Server_processors
> > > 
> > > Lists the E5 2609 v3 as not having turbo at all, which is basically a
> > > best case scenario for this patch.
> > > 
> > > As I wrote earlier today; when turbo exists, like say the 2699, then
> > > when we're busy we'll run at U=2.3/3.6 ~ .64, which might confuse
> > > things.
> > 
> > Indeed. I was mostly trying to see if adding this to the tick might
> > introduce noticeable overhead.
> 
> Blindly testing on an i5-5200U (2.2/2.7 GHz) gave the following
> 
> # perf bench sched messaging --pipe --thread --group 2 --loop 20000
> 
>                       count       mean       std     min     50%       95%       99%     max
> hostname kernel                                                                             
> i5-5200U test_after    30.0  13.843433  0.590605  12.369  13.810  14.85635  15.08205  15.127
>          test_before   30.0  13.571167  0.999798  12.228  13.302  15.57805  16.40029  16.690
> 
> It might be interesting to see what happens when using a single CPU
> only?
> 
> Also, I will look at how the util signals look when a single CPU is
> busy..

And this is showing where the problem is (as you were saying [1]):

https://gist.github.com/jlelli/f5438221186e5ed3660194e4f645fe93

Just look at the plots (and ignore setup).

First one (pid:4483) shows a single task busy running on a single CPU,
which seems to be able to sustain turbo for 5 sec. So task util reaches
~1024.

Second one (pid:4283) shows the same task, but running together with
other 3 tasks (each one pinned to a different CPU). In this case util
saturates at ~943, which is due to the fact that max freq is still
considered to be the turbo one. :/

[1] https://marc.info/?l=linux-kernel&m=152646464017810&w=2
