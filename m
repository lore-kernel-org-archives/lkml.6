Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeBIOJQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:09:16 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:52105 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbeBIOJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:09:12 -0500
Date: Fri, 9 Feb 2018 15:09:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH V3 1/5] perf/x86/intel: fix event update for auto-reload
Message-ID: <20180209140905.GG25181@hirez.programming.kicks-ass.net>
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
 <1517243373-355481-2-git-send-email-kan.liang@linux.intel.com>
 <20180206150648.GK2249@hirez.programming.kicks-ass.net>
 <ae4c7aff-da12-8cb3-4fac-4637ab001060@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae4c7aff-da12-8cb3-4fac-4637ab001060@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 12:58:23PM -0500, Liang, Kan wrote:
> 
> 
> > With the exception of handling 'empty' buffers, I ended up with the
> > below. Please try again.
> > 
> 
> There are two small errors. After fixing them, the patch works well.

Well, it still doesn't do A, two read()s without PEBS record in between.
So that needs fixing. What 3/5 does, call x86_perf_event_update() after
drain_pebs() is actively wrong after this patch.

> > +
> > +	/*
> > +	 * Careful, not all hw sign-extends above the physical width
> > +	 * of the counter.
> > +	 */
> > +	delta = (new_raw_count << shift) - (prev_raw_count << shift);
> > +	delta >>= shift;
> 
> new_raw_count could be smaller than prev_raw_count.
> The sign bit will be set. The delta>> could be wrong.
> 
> I think we can add a period here to prevent it.
> +       delta = (period << shift) + (new_raw_count << shift) -
> +               (prev_raw_count << shift);
> +       delta >>= shift;
> ......
> +       local64_add(delta + period * (count - 1), &event->count);
> 

Right it does, but that wrecks case A again, because then we get here
with !@count.

Maybe something like:


	s64 new, old;

	new = ((s64)(new_raw_count << shift) >> shift);
	old = ((s64)(old_raw_count << shift) >> shift);

	local64_add(new - old + count * period, &event->count);


And then make intel_pmu_drain_pebs_*(), call this function even when !n.
