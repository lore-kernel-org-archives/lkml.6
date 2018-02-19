Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeBSKBq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:01:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752224AbeBSKBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:01:45 -0500
Date: Mon, 19 Feb 2018 11:01:40 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCH 6/9] perf tools: Don't search for active kernel start in
 __machine__create_kernel_maps
Message-ID: <20180219100140.GA17630@krava>
References: <20180215122635.24029-1-jolsa@kernel.org>
 <20180215122635.24029-7-jolsa@kernel.org>
 <20180219022036.GB1583@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219022036.GB1583@sejong>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 11:20:36AM +0900, Namhyung Kim wrote:

SNIP

> > +static void machine__set_kernel_mmap(struct machine *machine,
> > +				     u64 start, u64 end)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < MAP__NR_TYPES; i++) {
> > +		machine->vmlinux_maps[i]->start = start;
> > +		machine->vmlinux_maps[i]->end   = end;
> > +
> > +		/*
> > +		 * Be a bit paranoid here, some perf.data file came with
> > +		 * a zero sized synthesized MMAP event for the kernel.
> > +		 */
> > +		if (machine->vmlinux_maps[i]->end == 0)
> > +			machine->vmlinux_maps[i]->end = ~0ULL;
> 
> Hmm.. this will make map_groups__fixup_end() below not working since
> it only updates if the end address of a map is zero.
> 
> And about the paranoid check, AFAIK the only case it cares is the
> machine__process_kernel_mmap_event() which calls it with
> event->mmap.start and event->mmap.start + event->mmap.len.  Thus, in
> order for the end to be zero, both start and len should be zero.  Then
> I think this condition can be changed like below:
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index fe27ef55cbb9..c8acb603c359 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1226,7 +1226,7 @@ static void machine__set_kernel_mmap(struct machine *machine,
>                  * Be a bit paranoid here, some perf.data file came with
>                  * a zero sized synthesized MMAP event for the kernel.
>                  */
> -               if (machine->vmlinux_maps[i]->end == 0)
> +               if (start == 0 && end == 0)
>                         machine->vmlinux_maps[i]->end = ~0ULL;
>         }

right, the call from machine__create_kernel_maps will have always
the start != 0 and there will be subsequent map_groups__fixup_end
call..

seems ok to me.. will you send the patch?

thanks,
jirka
