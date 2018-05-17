Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEQUP7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeEQUP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:15:57 -0400
Date: Thu, 17 May 2018 17:15:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>, Kim Phillips <kim.phillips@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 01/11] perf tests parse-events: Add intel_pt parse test
Message-ID: <20180517201553.GB25467@kernel.org>
References: <20180516144908.22212-1-acme@kernel.org>
 <20180516144908.22212-2-acme@kernel.org>
 <20180516163355.d8e4c669ad29d416e9ffb13e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516163355.d8e4c669ad29d416e9ffb13e@arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 16, 2018 at 04:33:55PM -0500, Kim Phillips escreveu:
> On Wed, 16 May 2018 11:48:58 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > To avoid regressions such as the one fixed by 4a35a9027f64 ("Revert
> > "perf pmu: Fix pmu events parsing rule""), where '-e intel_pt//u' got
> > broken, with this new entry in this 'perf tests' subtest, we would have
> > caught it before pushing upstream.
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Wang Nan <wangnan0@huawei.com>
> > Link: https://lkml.kernel.org/n/tip-kw62fys9bwdgsp722so2ln1l@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> 
> This causes a SEGV on Arm, and an Intel box without Intel-PT h/w:
> 
> (gdb) run test -F -v 6
> Starting program: /home/kimphi01/git/linux-perf-acme/tools/perf/perf test -F -v 6
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
>  6: Parse event definition strings             :
> --- start ---
> running test 0 'syscalls:sys_enter_openat'
> Using CPUID GenuineIntel-6-3C
> <SNIP>
> running test 51 'L1-dcache-misses/name=cachepmu/'
> running test 52 'intel_pt//u'
> 
> Program received signal SIGSEGV, Segmentation fault.
> __GI___vasprintf_chk (result_ptr=0x8, flags=1, format=<optimized out>, args=args@entry=0x7fffffffbf30)
>     at vasprintf_chk.c:88
> 88	vasprintf_chk.c: No such file or directory.
> (gdb) bt
> #0  __GI___vasprintf_chk (result_ptr=0x8, flags=1, format=<optimized out>, args=args@entry=0x7fffffffbf30)
>     at vasprintf_chk.c:88
> #1  0x00007ffff6456e6f in __asprintf_chk (result_ptr=result_ptr@entry=0x8, flags=flags@entry=1, 
>     format=format@entry=0x555555992e80 "Cannot find PMU `%s'. Missing kernel support?") at asprintf_chk.c:32
> #2  0x0000555555766836 in asprintf (__fmt=0x555555992e80 "Cannot find PMU `%s'. Missing kernel support?", __ptr=0x8)
>     at /usr/include/x86_64-linux-gnu/bits/stdio2.h:178
> #3  parse_events_add_pmu (parse_state=parse_state@entry=0x7fffffffdda0, list=list@entry=0x555555e137d0, 
>     name=0x5555563e84e0 "intel_pt", head_config=0x0, auto_merge_stats=auto_merge_stats@entry=false, 
>     use_alias=use_alias@entry=false) at util/parse-events.c:1236


Humm:

        struct parse_events_error *err = parse_state->error;

        pmu = perf_pmu__find(name);
        if (!pmu) {
                if (asprintf(&err->str,
                                "Cannot find PMU `%s'. Missing kernel support?",
                                name) < 0)

$ pahole -C parse_events_error ~/bin/perf
struct parse_events_error {
	int                        idx;                  /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     str;                  /*     8     8 */
	char *                     help;                 /*    16     8 */

	/* size: 24, cachelines: 1, members: 3 */
	/* sum members: 20, holes: 1, sum holes: 4 */
	/* last cacheline: 24 bytes */
};
$

So parse_state->error == NULL, Jiri, ideas?

- Arnaldo

> #4  0x00005555557aaaae in parse_events_parse (_parse_state=_parse_state@entry=0x7fffffffdda0, scanner=0x555555d38c40)
>     at util/parse-events.y:235
> #5  0x0000555555761ccf in parse_events__scanner (start_token=258, parse_state=0x7fffffffdda0, str=<optimized out>)
>     at util/parse-events.c:1796
> #6  parse_events (evlist=evlist@entry=0x555555d381f0, str=<optimized out>, err=err@entry=0x0)
>     at util/parse-events.c:1836
> #7  0x000055555571eb65 in test_event (e=0x555555bf4f80 <test.events+1248>, e=0x555555bf4f80 <test.events+1248>)
>     at tests/parse-events.c:1695
> #8  test_events (events=0x555555bf4aa0 <test.events>, cnt=53) at tests/parse-events.c:1717
> #9  test__parse_events (test=<optimized out>, subtest=<optimized out>) at tests/parse-events.c:1837
> #10 0x0000555555716a11 in run_test (subtest=-1, test=0x555555bfca78 <generic_tests+280>) at tests/builtin-test.c:348
> #11 test_and_print (t=t@entry=0x555555bfca78 <generic_tests+280>, force_skip=force_skip@entry=false, 
>     subtest=subtest@entry=-1) at tests/builtin-test.c:378
> #12 0x0000555555717e2f in __cmd_test (skiplist=0x0, argv=0x7fffffffe5c0, argc=1) at tests/builtin-test.c:570
> #13 cmd_test (argc=1, argv=0x7fffffffe5c0) at tests/builtin-test.c:709
> #14 0x0000555555738b41 in run_builtin (p=0x555555bfd848 <commands+552>, argc=4, argv=0x7fffffffe5c0) at perf.c:303
> #15 0x0000555555738e3e in handle_internal_command (argc=4, argv=0x7fffffffe5c0) at perf.c:355
> #16 0x00005555556b3901 in run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:399
> #17 main (argc=<optimized out>, argv=0x7fffffffe5c0) at perf.c:543
> (gdb) 
> 
> Thanks,
> 
> Kim
