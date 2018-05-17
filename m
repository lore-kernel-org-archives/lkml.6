Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeEQU6T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:58:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750938AbeEQU6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:58:17 -0400
Date: Thu, 17 May 2018 22:58:11 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Kim Phillips <kim.phillips@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 01/11] perf tests parse-events: Add intel_pt parse test
Message-ID: <20180517205811.GE12497@krava>
References: <20180516144908.22212-1-acme@kernel.org>
 <20180516144908.22212-2-acme@kernel.org>
 <20180516163355.d8e4c669ad29d416e9ffb13e@arm.com>
 <20180517201553.GB25467@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517201553.GB25467@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 05:15:53PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 16, 2018 at 04:33:55PM -0500, Kim Phillips escreveu:
> > On Wed, 16 May 2018 11:48:58 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > To avoid regressions such as the one fixed by 4a35a9027f64 ("Revert
> > > "perf pmu: Fix pmu events parsing rule""), where '-e intel_pt//u' got
> > > broken, with this new entry in this 'perf tests' subtest, we would have
> > > caught it before pushing upstream.
> > > 
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Andi Kleen <ak@linux.intel.com>
> > > Cc: David Ahern <dsahern@gmail.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Wang Nan <wangnan0@huawei.com>
> > > Link: https://lkml.kernel.org/n/tip-kw62fys9bwdgsp722so2ln1l@git.kernel.org
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > 
> > This causes a SEGV on Arm, and an Intel box without Intel-PT h/w:
> > 
> > (gdb) run test -F -v 6
> > Starting program: /home/kimphi01/git/linux-perf-acme/tools/perf/perf test -F -v 6
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> >  6: Parse event definition strings             :
> > --- start ---
> > running test 0 'syscalls:sys_enter_openat'
> > Using CPUID GenuineIntel-6-3C
> > <SNIP>
> > running test 51 'L1-dcache-misses/name=cachepmu/'
> > running test 52 'intel_pt//u'
> > 
> > Program received signal SIGSEGV, Segmentation fault.
> > __GI___vasprintf_chk (result_ptr=0x8, flags=1, format=<optimized out>, args=args@entry=0x7fffffffbf30)
> >     at vasprintf_chk.c:88
> > 88	vasprintf_chk.c: No such file or directory.
> > (gdb) bt
> > #0  __GI___vasprintf_chk (result_ptr=0x8, flags=1, format=<optimized out>, args=args@entry=0x7fffffffbf30)
> >     at vasprintf_chk.c:88
> > #1  0x00007ffff6456e6f in __asprintf_chk (result_ptr=result_ptr@entry=0x8, flags=flags@entry=1, 
> >     format=format@entry=0x555555992e80 "Cannot find PMU `%s'. Missing kernel support?") at asprintf_chk.c:32
> > #2  0x0000555555766836 in asprintf (__fmt=0x555555992e80 "Cannot find PMU `%s'. Missing kernel support?", __ptr=0x8)
> >     at /usr/include/x86_64-linux-gnu/bits/stdio2.h:178
> > #3  parse_events_add_pmu (parse_state=parse_state@entry=0x7fffffffdda0, list=list@entry=0x555555e137d0, 
> >     name=0x5555563e84e0 "intel_pt", head_config=0x0, auto_merge_stats=auto_merge_stats@entry=false, 
> >     use_alias=use_alias@entry=false) at util/parse-events.c:1236
> 
> 
> Humm:
> 
>         struct parse_events_error *err = parse_state->error;
> 
>         pmu = perf_pmu__find(name);
>         if (!pmu) {
>                 if (asprintf(&err->str,
>                                 "Cannot find PMU `%s'. Missing kernel support?",
>                                 name) < 0)
> 
> $ pahole -C parse_events_error ~/bin/perf
> struct parse_events_error {
> 	int                        idx;                  /*     0     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	char *                     str;                  /*     8     8 */
> 	char *                     help;                 /*    16     8 */
> 
> 	/* size: 24, cachelines: 1, members: 3 */
> 	/* sum members: 20, holes: 1, sum holes: 4 */
> 	/* last cacheline: 24 bytes */
> };
> $
> 
> So parse_state->error == NULL, Jiri, ideas?

yep, we don't use it in tests.. and when trying intel_pt on
system without that pmu, the parse_events_add_pmu fails
and store the error to NULL.. we should check on that err pointer

wrt to the test itself, how about we add callback
to check if the test is valid before we run it,
something like below
jirka



---
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 6829dd416a99..8efefead2c04 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1309,6 +1309,11 @@ static int test__checkevent_config_cache(struct perf_evlist *evlist)
 	return 0;
 }
 
+static bool test__intel_pt_valid(void)
+{
+	return !!perf_pmu__find("intel_pt");
+}
+
 static int test__intel_pt(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = perf_evlist__first(evlist);
@@ -1374,6 +1379,7 @@ struct evlist_test {
 	const char *name;
 	__u32 type;
 	const int id;
+	bool (*valid)(void);
 	int (*check)(struct perf_evlist *evlist);
 };
 
@@ -1647,6 +1653,7 @@ static struct evlist_test test__events[] = {
 	},
 	{
 		.name  = "intel_pt//u",
+		.valid = test__intel_pt_valid,
 		.check = test__intel_pt,
 		.id    = 52,
 	},
@@ -1685,17 +1692,23 @@ static struct terms_test test__terms[] = {
 
 static int test_event(struct evlist_test *e)
 {
+	struct parse_events_error err;
 	struct perf_evlist *evlist;
 	int ret;
 
+	if (e->valid && !e->valid()) {
+		pr_debug("... SKIP");
+		return 0;
+	}
+
 	evlist = perf_evlist__new();
 	if (evlist == NULL)
 		return -ENOMEM;
 
-	ret = parse_events(evlist, e->name, NULL);
+	ret = parse_events(evlist, e->name, &err);
 	if (ret) {
-		pr_debug("failed to parse event '%s', err %d\n",
-			 e->name, ret);
+		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
+			 e->name, ret, err.str);
 	} else {
 		ret = e->check(evlist);
 	}
@@ -1713,10 +1726,11 @@ static int test_events(struct evlist_test *events, unsigned cnt)
 	for (i = 0; i < cnt; i++) {
 		struct evlist_test *e = &events[i];
 
-		pr_debug("running test %d '%s'\n", e->id, e->name);
+		pr_debug("running test %d '%s'", e->id, e->name);
 		ret1 = test_event(e);
 		if (ret1)
 			ret2 = ret1;
+		pr_debug("\n");
 	}
 
 	return ret2;
@@ -1798,7 +1812,7 @@ static int test_pmu_events(void)
 	}
 
 	while (!ret && (ent = readdir(dir))) {
-		struct evlist_test e;
+		struct evlist_test e = { };
 		char name[2 * NAME_MAX + 1 + 12 + 3];
 
 		/* Names containing . are special and cannot be used directly */
