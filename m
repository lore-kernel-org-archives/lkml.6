Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeCaJfw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 05:35:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33850 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeCaJfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 05:35:50 -0400
X-Google-Smtp-Source: AIpwx485x7HtLRCbfKBv/6V78z2G1jjoGfJj8EFxGqhcA1nqe2ENE8+HU4Opu/3SYtKo4DPLayyX6Q==
Date: Sat, 31 Mar 2018 11:35:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Markus Metzger <markus.t.metzger@intel.com>
Subject: Re: [PATCH] perf: Allow suppressing AUX records
Message-ID: <20180331093546.ac7ygm4iz4l7hg4x@gmail.com>
References: <20171115120022.o7hmfdb7vpeikvjl@hirez.programming.kicks-ass.net>
 <20180115150020.8509-1-alexander.shishkin@linux.intel.com>
 <20180329115429.GX4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329115429.GX4043@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jan 15, 2018 at 05:00:20PM +0200, Alexander Shishkin wrote:
> > It has been pointed out to me many times that it is useful to be able
> > to switch off AUX records to save the bandwidth for records that actually
> > matter, for example, in AUX overwrite mode.
> > 
> > The usefulness of PERF_RECORD_AUX is in some of its flags, like the
> > TRUNCATED flag that tells the decoder where exactly gaps in the trace are.
> > The OVERWRITE flag, on the other hand will be set on every single record
> > in overwrite mode. However, a PERF_RECORD_AUX[flags=OVERWRITE] is
> > generated on every target task's sched_out, which over time adds up to
> > a lot of useless information.
> > 
> > In case the existing userspace depends on AUX records in the overwrite
> > mode, we preserve the original behavior and add an opt-in for the new
> > behavior, wherein the 'useless' records get suppressed.
> > 
> > This patch adds an attribute bit to the described effect.
> > 
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Markus Metzger <markus.t.metzger@intel.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  include/uapi/linux/perf_event.h |  3 ++-
> >  kernel/events/core.c            |  5 +++++
> >  kernel/events/ring_buffer.c     | 13 +++++++++++--
> >  3 files changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index c77c9a2ebbbb..d7a981130561 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -370,7 +370,8 @@ struct perf_event_attr {
> >  				context_switch :  1, /* context switch data */
> >  				write_backward :  1, /* Write ring buffer from end to beginning */
> >  				namespaces     :  1, /* include namespaces data */
> > -				__reserved_1   : 35;
> > +				suppress_aux   :  1, /* don't generate PERF_RECORD_AUX */
> > +				__reserved_1   : 34;
> >  
> >  	union {
> >  		__u32		wakeup_events;	  /* wakeup every n events */
> 
> So I'm basically fine with this patch, however I wonder if we really
> need this suppress flag and can't just unconditionally drop these
> events.
> 
> Ash said that as far as he knows no Intel-PT user actually relies on it;
> Will is there anything ARM that is known to rely on them?
> 
> In anycase, tentative ACK on this, unless we wants to be brave and forgo
> this flag.
> 
> Ingo, any opinions?

Yeah, I'd suggest we just supress those record, and wait for complaints - let's 
not complicate the ABI if not necessary?

Thanks,

	Ingo
