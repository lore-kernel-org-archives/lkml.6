Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031693AbeEZMJT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 08:09:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031444AbeEZMJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 08:09:18 -0400
Date: Sat, 26 May 2018 09:09:14 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Stephane Eranian <eranian@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        mingo@elte.hu, Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [BUG] perf/inject: crash in pipe mode
Message-ID: <20180526120914.GA11944@redhat.com>
References: <CABPqkBRi5T2-hqgywLundiu=w1ekbjdAeKCrzRaUUrMSPSxvFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRi5T2-hqgywLundiu=w1ekbjdAeKCrzRaUUrMSPSxvFw@mail.gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 25, 2018 at 05:19:54PM -0700, Stephane Eranian escreveu:
> Hi,
> 
> 
> With the latest tip.git perf, if you run
> 
> $ perf record -a -o - sleep 2 | perf inject -b -i - | perf buildid-list -i -
> SEGFAULT in perf inject:
> free_dup_event (oe=0x555555d25b88, oe=0x555555d25b88,
> event=0x3030310931303031) at util/ordered-events.c:86
> 86 oe->cur_alloc_size -= event->header.size;
> (gdb) bt
> #0  free_dup_event (oe=0x555555d25b88, oe=0x555555d25b88,
> event=0x3030310931303031) at util/ordered-events.c:86
> #1  ordered_events__free (oe=oe@entry=0x555555d25b88) at
> util/ordered-events.c:310
> #2  0x00005555557964f8 in __perf_session__process_pipe_events
> (session=0x555555d1f910) at util/session.c:1778
> #3  perf_session__process_events (session=session@entry=0x555555d1f910) at
> util/session.c:1958
> #4  0x00005555556ef9b2 in __cmd_inject (inject=0x7fffffffda40) at
> builtin-inject.c:697
> #5  cmd_inject (argc=<optimized out>, argv=<optimized out>) at
> builtin-inject.c:871
> #6  0x000055555572e8b1 in run_builtin (p=0x555555be8f98 <commands+600>,
> argc=4, argv=0x7fffffffe460) at perf.c:303
> #7  0x000055555572ebae in handle_internal_command (argc=4,
> argv=0x7fffffffe460) at perf.c:355
> #8  0x00005555556ae1e1 in run_argv (argcp=<synthetic pointer>,
> argv=<synthetic pointer>) at perf.c:399
> #9  main (argc=<optimized out>, argv=0x7fffffffe460) at perf.c:521
> 
> In general I think the pipe mode is not very well tested. I think it could
> be made the default file format. I believe perf can
> autodetect file vs. pipe mode perf.data using the header.size field. This
> would simplify a few things inside perf and ensure
> the pipe mode format is well tested.

I'll investigate and add a test in tools/perf/tests/shell/ so that it
gets tested before sending pull requests to upstreamers.

- Arnaldo
