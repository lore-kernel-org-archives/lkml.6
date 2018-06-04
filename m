Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeFDTRI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbeFDTRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:17:05 -0400
Date: Mon, 4 Jun 2018 16:16:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3]: perf record: enable arbitrary event names thru name=
 modifier
Message-ID: <20180604191659.GM3397@kernel.org>
References: <c194b060-761d-0d50-3b21-bb4ed680002d@linux.intel.com>
 <20180604075600.GA10484@krava>
 <20180604135849.GE3397@kernel.org>
 <3269ec8e-88b0-8254-6419-da1896c083df@linux.intel.com>
 <20180604142340.GJ3397@kernel.org>
 <ed38dfcc-be73-e1d7-4eb5-862468955766@linux.intel.com>
 <20180604145844.GL3397@kernel.org>
 <80a37269-e54d-0992-712a-ee72555a04d4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80a37269-e54d-0992-712a-ee72555a04d4@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 04, 2018 at 06:22:43PM +0300, Alexey Budankov escreveu:
> On 04.06.2018 17:58, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jun 04, 2018 at 05:51:03PM +0300, Alexey Budankov escreveu:
> >> event names quoted there. If such cases were pointed out then they also 
> >> could be addressed along with the unit/regression testing mentioned above.

> > So lests stick to just the unit/regression testing, can you take a look
> > at that?
 
> Sure. Is it enough to run perf record with some quoted event name to make 
> sure it runs successfully?

I mentioned tools/perf/tests/attr/, for checking if the perf_event_attr
was setup the way you intended, and tools/perf/tests/parse-events.c,
which probably is what we want here, see, for instance, this cset I've
added recently to have we testing intel_pt event parsing:

$ git show b3f58c8da64bc63bd0c0a06a4e2cf258a3d20be6
commit b3f58c8da64bc63bd0c0a06a4e2cf258a3d20be6
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri May 11 11:48:54 2018 -0300

    perf tests parse-events: Add intel_pt parse test
    
    To avoid regressions such as the one fixed by 4a35a9027f64 ("Revert
    "perf pmu: Fix pmu events parsing rule""), where '-e intel_pt//u' got
    broken, with this new entry in this 'perf tests' subtest, we would have
    caught it before pushing upstream.
    
    Acked-by: Jiri Olsa <jolsa@kernel.org>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Wang Nan <wangnan0@huawei.com>
    Link: https://lkml.kernel.org/n/tip-kw62fys9bwdgsp722so2ln1l@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 18b06444f230..6829dd416a99 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1309,6 +1309,14 @@ static int test__checkevent_config_cache(struct perf_evlist *evlist)
 	return 0;
 }
 
+static int test__intel_pt(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel = perf_evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "intel_pt//u") == 0);
+	return 0;
+}
+
 static int count_tracepoints(void)
 {
 	struct dirent *events_ent;
@@ -1637,6 +1645,11 @@ static struct evlist_test test__events[] = {
 		.check = test__checkevent_config_cache,
 		.id    = 51,
 	},
+	{
+		.name  = "intel_pt//u",
+		.check = test__intel_pt,
+		.id    = 52,
+	},
 };
 
 static struct evlist_test test__events_pmu[] = {

See also this one:

static int
test__checkevent_breakpoint_len_rw_modifier(struct perf_evlist *evlist)
{
        struct perf_evsel *evsel = perf_evlist__first(evlist);

        TEST_ASSERT_VAL("wrong exclude_user", !evsel->attr.exclude_user);
        TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
        TEST_ASSERT_VAL("wrong exclude_hv", evsel->attr.exclude_hv);
        TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);

        return test__checkevent_breakpoint_rw(evlist);
}
        {
                .name  = "mem:0/4:rw:u",
                .check = test__checkevent_breakpoint_len_rw_modifier,
                .id    = 44
        },


I.e. have as many TEST_ASSERT_VAL as you need, checking how parsing the
event name ends up setting up the evsel, evlist and perf_event_attr.

- Arnaldo
