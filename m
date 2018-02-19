Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeBSKTl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:19:41 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:36828 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbeBSKTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:19:40 -0500
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 19 Feb 2018 19:19:36 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCH 6/9] perf tools: Don't search for active kernel start in
 __machine__create_kernel_maps
Message-ID: <20180219101936.GD1583@sejong>
References: <20180215122635.24029-1-jolsa@kernel.org>
 <20180215122635.24029-7-jolsa@kernel.org>
 <20180219022036.GB1583@sejong>
 <20180219100140.GA17630@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180219100140.GA17630@krava>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 11:01:40AM +0100, Jiri Olsa wrote:
> On Mon, Feb 19, 2018 at 11:20:36AM +0900, Namhyung Kim wrote:
> 
> SNIP
> 
> > > +static void machine__set_kernel_mmap(struct machine *machine,
> > > +				     u64 start, u64 end)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < MAP__NR_TYPES; i++) {
> > > +		machine->vmlinux_maps[i]->start = start;
> > > +		machine->vmlinux_maps[i]->end   = end;
> > > +
> > > +		/*
> > > +		 * Be a bit paranoid here, some perf.data file came with
> > > +		 * a zero sized synthesized MMAP event for the kernel.
> > > +		 */
> > > +		if (machine->vmlinux_maps[i]->end == 0)
> > > +			machine->vmlinux_maps[i]->end = ~0ULL;
> > 
> > Hmm.. this will make map_groups__fixup_end() below not working since
> > it only updates if the end address of a map is zero.
> > 
> > And about the paranoid check, AFAIK the only case it cares is the
> > machine__process_kernel_mmap_event() which calls it with
> > event->mmap.start and event->mmap.start + event->mmap.len.  Thus, in
> > order for the end to be zero, both start and len should be zero.  Then
> > I think this condition can be changed like below:
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index fe27ef55cbb9..c8acb603c359 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1226,7 +1226,7 @@ static void machine__set_kernel_mmap(struct machine *machine,
> >                  * Be a bit paranoid here, some perf.data file came with
> >                  * a zero sized synthesized MMAP event for the kernel.
> >                  */
> > -               if (machine->vmlinux_maps[i]->end == 0)
> > +               if (start == 0 && end == 0)
> >                         machine->vmlinux_maps[i]->end = ~0ULL;
> >         }
> 
> right, the call from machine__create_kernel_maps will have always
> the start != 0 and there will be subsequent map_groups__fixup_end
> call..
> 
> seems ok to me.. will you send the patch?

Sure. :)


>From b736729e83b62f97d716a011ccf4e430b614fecd Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 19 Feb 2018 19:00:46 +0900
Subject: [PATCH] perf tools: Fix paranoid check in machine__set_kernel_mmap()

The machine__set_kernel_mmap() is to setup addresses of the kernel map
using external info.  But it has a check when the address is given
from an incorrect input which should have the start and end address of
0 (i.e. machine__process_kernel_mmap_event).

But we also use the end address of 0 for a valid input so change it to
check both start and end addresses.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fe27ef55cbb9..12b7427444a3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1226,7 +1226,7 @@ static void machine__set_kernel_mmap(struct machine *machine,
 		 * Be a bit paranoid here, some perf.data file came with
 		 * a zero sized synthesized MMAP event for the kernel.
 		 */
-		if (machine->vmlinux_maps[i]->end == 0)
+		if (start == 0 && end == 0)
 			machine->vmlinux_maps[i]->end = ~0ULL;
 	}
 }
-- 
2.16.1
