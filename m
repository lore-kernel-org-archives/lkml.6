Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeBEK6Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:58:24 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36336 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBEK6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:58:17 -0500
X-Google-Smtp-Source: AH8x226vsNMwnGzeG9U9OW+tntFXzj8wpZjL2C8qMM6PeFVdBs6zyObJd3huySHqH6m2he2V9QZaUg==
Date: Mon, 5 Feb 2018 11:58:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180205105812.feaw45dqjufhu3g7@gmail.com>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <3838689.GpfBVtfPr0@aspire.rjw.lan>
 <20180201091104.GW2269@hirez.programming.kicks-ass.net>
 <8930678.7E2iWGoJnn@aspire.rjw.lan>
 <20180202124647.GK2269@hirez.programming.kicks-ass.net>
 <20180202140817.GP2295@hirez.programming.kicks-ass.net>
 <1517675448.21379.2.camel@linux.intel.com>
 <20180205104412.GJ2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205104412.GJ2249@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Feb 03, 2018 at 08:30:48AM -0800, Srinivas Pandruvada wrote:
> > On Fri, 2018-02-02 at 15:08 +0100, Peter Zijlstra wrote:
> > > On Fri, Feb 02, 2018 at 01:46:47PM +0100, Peter Zijlstra wrote:
> > > 
> > > > +static void __intel_pstate_hwp_set_desired(int val)
> > > > +{
> > > > +	u64 value;
> > > > +
> > > > +	value = rdmsrl(MSR_HWP_REQUEST);
> > > > +	value &= ~GENMASK_ULL(23, 16);
> > > > +	value |= (val & 0xff) << 16;
> > > > +	wrmsrl(MSR_HWP_REQUEST, val);
> > > > +}
> > > 
> > > Also, if we keep a software shadow of that MSR, we can avoid the
> > > rdmsr, which might also help.
> > The reason we don't keep a software shadow as users can use x86-energy-
> > perf utility or via BMC to adjust.  CCed  to Len. 
> 
> Total NAK on that. People using /dev/msr to prod at state get to keep
> whatever pieces they end up with.
> 
> We _really_ should make /dev/msr taint the kernel on write. Ingo,
> Thomas, can we pretty please just do that?

Sure - mind sending a patch?

Thanks,

	Ingo
