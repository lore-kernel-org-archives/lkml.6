Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755380AbeDWOZb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:25:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755110AbeDWOZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:25:29 -0400
Date: Mon, 23 Apr 2018 16:25:25 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 4/9] perf tools: Fix pmu events parsing rule
Message-ID: <20180423142525.GA8331@krava>
References: <20180423090823.32309-1-jolsa@kernel.org>
 <20180423090823.32309-5-jolsa@kernel.org>
 <20180423142057.GC30324@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423142057.GC30324@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:20:57AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 23, 2018 at 11:08:18AM +0200, Jiri Olsa escreveu:
> > Currently all the event parsing fails end up
> > in the event_pmu rule, and display misleading
> > help like:
> > 
> >   $ perf stat -e inst kill
> >   event syntax error: 'inst'
> >                        \___ Cannot find PMU `inst'. Missing kernel support?
> >   ...
> > 
> > The reason is that the event_pmu is too strong
> > and match also single string. Changing it to
> > force the '/' separators to be part of the rule,
> > and getting the proper error now:
> > 
> >   $ perf stat -e inst kill
> >   event syntax error: 'inst'
> >                        \___ parser error
> >   Run 'perf list' for a list of valid events
> 
> I added a Reported-by: Ingo after checking that that was the case in tha
> private conversation we had, but I think this has to be further
> improved: do we have enough context at this point to change that into:
> 
>    $ perf stat -e inst kill
>    event syntax error: 'inst'
>                         \___ unknown event
>    Run 'perf list' for a list of valid events
> 
> Instead of the generic "parser error"? That "list of valid events" helps
> tho, but if we're going to say something at that \___ MSG part...

yep, the plan is to display whatever match the user input
out of the all known event names..  in this case 'inst'
would match 'instructions' and some other arch related events

but it's some more work and this fix stands by itself ;-)

jirka
