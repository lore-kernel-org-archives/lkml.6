Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBBU27 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:28:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752110AbeBBU2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:28:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CE521785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 2 Feb 2018 17:28:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephane Eranian <eranian@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 1/3] perf tools: Fix period/freq terms setup
Message-ID: <20180202202849.GA8297@kernel.org>
References: <20180201083812.11359-1-jolsa@kernel.org>
 <20180201083812.11359-2-jolsa@kernel.org>
 <CABPqkBSkbq9NnufY1k2de-Fa-Qb0vhN_MGu6mhqNOV-p3CaVLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSkbq9NnufY1k2de-Fa-Qb0vhN_MGu6mhqNOV-p3CaVLQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 02, 2018 at 10:45:46AM -0800, Stephane Eranian escreveu:
> Jiri,
> 
> On Thu, Feb 1, 2018 at 12:38 AM, Jiri Olsa <jolsa@kernel.org> wrote:
> > Stephane reported that we don't set properly PERIOD
> > sample type for events with period term defined.
> >
> > Before:
> >   $ perf record -e cpu/cpu-cycles,period=1000/u ls
> >   $ perf evlist -v
> >   cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME|PERIOD, ...
> >
> > After:
> >   $ perf record -e cpu/cpu-cycles,period=1000/u ls
> >   $ perf evlist -v
> >   cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME, ...
> >
> > Setting PERIOD sample type based on period term setup.
> >
> there is still one problem remaining here. It has to do with the handling
> of cycles:pp or :p or :ppp. Suppose I want to set a period for it while I am
> also sampling on other events: Something like:
> 
> $ perf record -e
> cycles:pp,instructions,cpu/event=0xd0,umaks=0x81,period=100000/ .....
> 
> I want to set the period for cycles:pp, but not for instructions. I
> cannot use -c because
> it would also force a period on instructions. I could use the raw hw
> raw event code for cycles:pp.
> But that does not work because recent kernels prevent use of hw
> filters on events programmed
> for PEBS, e.g., cpu/event=0xc2,umask=0x1,cmask=16,inv/pp is rejected.
> PEBS does not support filters.
> It works in the case of cycles:pp simply by the nature on the
> underlying event and the stalls.
> 
> To get precise cycles, the only event syntax you can use is cycles:pp,
> but then you cannot specify
> an event-specific period. This needs to be fixed as well.
> 
> I'd like to be able to say:
> 
> $ perf record -e
> cycles:pp:period=10000001,cpu/event=0xd0,umaks=0x81,period=100000/
> 
> Or something equivalent.
> 
> Otherwise, I tested what you have written so far and it works.

So I take that as a Tested-by: Stephane and will apply the patches, Jiri
can continue working on these other aspects, right?

- Arnaldo
 
> Thanks.
> 
> 
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Link: http://lkml.kernel.org/n/tip-anrtntkwfto5rqulegfwitn5@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/evsel.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 66fa45198a11..f2f2eaafde6d 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -745,12 +745,14 @@ static void apply_config_terms(struct perf_evsel *evsel,
> >                         if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
> >                                 attr->sample_period = term->val.period;
> >                                 attr->freq = 0;
> > +                               perf_evsel__reset_sample_bit(evsel, PERIOD);
> >                         }
> >                         break;
> >                 case PERF_EVSEL__CONFIG_TERM_FREQ:
> >                         if (!(term->weak && opts->user_freq != UINT_MAX)) {
> >                                 attr->sample_freq = term->val.freq;
> >                                 attr->freq = 1;
> > +                               perf_evsel__set_sample_bit(evsel, PERIOD);
> >                         }
> >                         break;
> >                 case PERF_EVSEL__CONFIG_TERM_TIME:
> > --
> > 2.13.6
> >
