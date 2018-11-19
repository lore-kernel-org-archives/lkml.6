Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1116C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5B520823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5B520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeKSWoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:44:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbeKSWoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:44:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51522811AC;
        Mon, 19 Nov 2018 12:20:36 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE86F45F35;
        Mon, 19 Nov 2018 12:20:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 06/12] perf top: Add processing thread
Date:   Mon, 19 Nov 2018 13:20:10 +0100
Message-Id: <20181119122016.22423-7-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 19 Nov 2018 12:20:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new thread that takes care of the hist creating
to alleviate the main reader thread so it can keep
perf mmaps served in time and we won't lose events.

The perf top command now spawns 2 extra threads,
the data processing is following:

  1) main thread reads the data from mmaps
     and queues them to ordered events object
  2) processing threads takes the data from
     the ordered events object and create
     initial histogram
  3) gui thread periodically sorts the initial
     histogram and presents it

Passing the data between threads 1 and 2 is dont by
having 2 ordered events queues. One is always being
stored to by thread 1 while the other is flushed
out in thread 2.

Passing the data between threads 2 and 3 stays the
same as was initialy for threads 1 and 3.

Link: http://lkml.kernel.org/n/tip-hhf4hllgkmle9wl1aly1jli0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c         | 202 +++++++++++++++++++++----------
 tools/perf/util/ordered-events.c |   4 +-
 tools/perf/util/ordered-events.h |   1 +
 tools/perf/util/top.h            |   6 +
 4 files changed, 151 insertions(+), 62 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1d77aa7650da..f8dcdf0f54e1 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -46,6 +46,7 @@
 #include "arch/common.h"
 
 #include "util/debug.h"
+#include "util/ordered-events.h"
 
 #include <assert.h>
 #include <elf.h>
@@ -830,78 +831,28 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 {
 	struct record_opts *opts = &top->record_opts;
 	struct perf_evlist *evlist = top->evlist;
-	struct perf_sample sample;
-	struct perf_evsel *evsel;
 	struct perf_mmap *md;
-	struct perf_session *session = top->session;
 	union perf_event *event;
-	struct machine *machine;
-	int ret;
 
 	md = opts->overwrite ? &evlist->overwrite_mmap[idx] : &evlist->mmap[idx];
 	if (perf_mmap__read_init(md) < 0)
 		return;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
-		ret = perf_evlist__parse_sample(evlist, event, &sample);
-		if (ret) {
-			pr_err("Can't parse sample, err = %d\n", ret);
-			goto next_event;
-		}
-
-		evsel = perf_evlist__id2evsel(session->evlist, sample.id);
-		assert(evsel != NULL);
+		u64 timestamp = -1ULL;
+		int ret;
 
-		if (event->header.type == PERF_RECORD_SAMPLE)
-			++top->samples;
-
-		switch (sample.cpumode) {
-		case PERF_RECORD_MISC_USER:
-			++top->us_samples;
-			if (top->hide_user_symbols)
-				goto next_event;
-			machine = &session->machines.host;
-			break;
-		case PERF_RECORD_MISC_KERNEL:
-			++top->kernel_samples;
-			if (top->hide_kernel_symbols)
-				goto next_event;
-			machine = &session->machines.host;
+		ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
+		if (ret && ret != -1)
 			break;
-		case PERF_RECORD_MISC_GUEST_KERNEL:
-			++top->guest_kernel_samples;
-			machine = perf_session__find_machine(session,
-							     sample.pid);
-			break;
-		case PERF_RECORD_MISC_GUEST_USER:
-			++top->guest_us_samples;
-			/*
-			 * TODO: we don't process guest user from host side
-			 * except simple counting.
-			 */
-			goto next_event;
-		default:
-			if (event->header.type == PERF_RECORD_SAMPLE)
-				goto next_event;
-			machine = &session->machines.host;
-			break;
-		}
 
+		pthread_mutex_lock(&top->qe.lock);
+		ret = ordered_events__queue(top->qe.in, event, timestamp, 0);
+		pthread_mutex_unlock(&top->qe.lock);
 
-		if (event->header.type == PERF_RECORD_SAMPLE) {
-			perf_event__process_sample(&top->tool, event, evsel,
-						   &sample, machine);
-		} else if (event->header.type == PERF_RECORD_LOST) {
-			perf_top__process_lost(top, event, evsel);
-		} else if (event->header.type == PERF_RECORD_LOST_SAMPLES) {
-			perf_top__process_lost_samples(top, event, evsel);
-		} else if (event->header.type < PERF_RECORD_MAX) {
-			hists__inc_nr_events(evsel__hists(evsel), event->header.type);
-			machine__process_event(machine, event, &sample);
-		} else
-			++session->evlist->stats.nr_unknown_events;
-next_event:
 		perf_mmap__consume(md);
+		if (ret)
+			break;
 	}
 
 	perf_mmap__read_done(md);
@@ -1084,6 +1035,125 @@ static int callchain_param__setup_sample_type(struct callchain_param *callchain)
 	return 0;
 }
 
+static struct ordered_events *rotate_queues(struct perf_top *top)
+{
+	struct ordered_events *in = top->qe.in;
+
+	if (top->qe.in == &top->qe.data[1])
+		top->qe.in = &top->qe.data[0];
+	else
+		top->qe.in = &top->qe.data[1];
+
+	return in;
+}
+
+static void *process_thread(void *arg)
+{
+	struct perf_top *top = arg;
+
+	while (!done) {
+		struct ordered_events *out, *in = top->qe.in;
+
+		if (!in->nr_events) {
+			usleep(100);
+			continue;
+		}
+
+		pthread_mutex_lock(&top->qe.lock);
+		out = rotate_queues(top);
+		pthread_mutex_unlock(&top->qe.lock);
+
+		if (ordered_events__flush(out, OE_FLUSH__TOP))
+			pr_err("failed to process events\n");
+	}
+
+	return NULL;
+}
+
+static int deliver_event(struct ordered_events *qe,
+			 struct ordered_event *qevent)
+{
+	struct perf_top *top = qe->data;
+	struct perf_evlist *evlist = top->evlist;
+	struct perf_session *session = top->session;
+	union perf_event *event = qevent->event;
+	struct perf_sample sample;
+	struct perf_evsel *evsel;
+	struct machine *machine;
+	int ret = -1;
+
+	ret = perf_evlist__parse_sample(evlist, event, &sample);
+	if (ret) {
+		pr_err("Can't parse sample, err = %d\n", ret);
+		goto next_event;
+	}
+
+	evsel = perf_evlist__id2evsel(session->evlist, sample.id);
+	assert(evsel != NULL);
+
+	if (event->header.type == PERF_RECORD_SAMPLE)
+		++top->samples;
+
+	switch (sample.cpumode) {
+	case PERF_RECORD_MISC_USER:
+		++top->us_samples;
+		if (top->hide_user_symbols)
+			goto next_event;
+		machine = &session->machines.host;
+		break;
+	case PERF_RECORD_MISC_KERNEL:
+		++top->kernel_samples;
+		if (top->hide_kernel_symbols)
+			goto next_event;
+		machine = &session->machines.host;
+		break;
+	case PERF_RECORD_MISC_GUEST_KERNEL:
+		++top->guest_kernel_samples;
+		machine = perf_session__find_machine(session,
+						     sample.pid);
+		break;
+	case PERF_RECORD_MISC_GUEST_USER:
+		++top->guest_us_samples;
+		/*
+		 * TODO: we don't process guest user from host side
+		 * except simple counting.
+		 */
+		goto next_event;
+	default:
+		if (event->header.type == PERF_RECORD_SAMPLE)
+			goto next_event;
+		machine = &session->machines.host;
+		break;
+	}
+
+	if (event->header.type == PERF_RECORD_SAMPLE) {
+		perf_event__process_sample(&top->tool, event, evsel,
+					   &sample, machine);
+	} else if (event->header.type == PERF_RECORD_LOST) {
+		perf_top__process_lost(top, event, evsel);
+	} else if (event->header.type == PERF_RECORD_LOST_SAMPLES) {
+		perf_top__process_lost_samples(top, event, evsel);
+	} else if (event->header.type < PERF_RECORD_MAX) {
+		hists__inc_nr_events(evsel__hists(evsel), event->header.type);
+		machine__process_event(machine, event, &sample);
+	} else
+		++session->evlist->stats.nr_unknown_events;
+
+	ret = 0;
+next_event:
+	return ret;
+}
+
+static void init_process_thread(struct perf_top *top)
+{
+	ordered_events__init(&top->qe.data[0], deliver_event, top);
+	ordered_events__init(&top->qe.data[1], deliver_event, top);
+	ordered_events__set_copy_on_queue(&top->qe.data[0], true);
+	ordered_events__set_copy_on_queue(&top->qe.data[1], true);
+	top->qe.in = &top->qe.data[0];
+	pthread_mutex_init(&top->qe.lock, NULL);
+}
+
 static int __cmd_top(struct perf_top *top)
 {
 	char msg[512];
@@ -1091,7 +1161,7 @@ static int __cmd_top(struct perf_top *top)
 	struct perf_evsel_config_term *err_term;
 	struct perf_evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
-	pthread_t thread;
+	pthread_t thread, thread_process;
 	int ret;
 
 	top->session = perf_session__new(NULL, false, NULL);
@@ -1115,6 +1185,8 @@ static int __cmd_top(struct perf_top *top)
 	if (top->nr_threads_synthesize > 1)
 		perf_set_multithreaded();
 
+	init_process_thread(top);
+
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->threads, false,
 				    opts->proc_map_timeout,
@@ -1156,10 +1228,15 @@ static int __cmd_top(struct perf_top *top)
                 perf_evlist__enable(top->evlist);
 
 	ret = -1;
+	if (pthread_create(&thread_process, NULL, process_thread, top)) {
+		ui__error("Could not create process thread.\n");
+		goto out_delete;
+	}
+
 	if (pthread_create(&thread, NULL, (use_browser > 0 ? display_thread_tui :
 							    display_thread), top)) {
 		ui__error("Could not create display thread.\n");
-		goto out_delete;
+		goto out_join_thread;
 	}
 
 	if (top->realtime_prio) {
@@ -1194,6 +1271,8 @@ static int __cmd_top(struct perf_top *top)
 	ret = 0;
 out_join:
 	pthread_join(thread, NULL);
+out_join_thread:
+	pthread_join(thread_process, NULL);
 out_delete:
 	perf_session__delete(top->session);
 	top->session = NULL;
@@ -1286,6 +1365,7 @@ int cmd_top(int argc, const char **argv)
 			 * stays in overwrite mode. -acme
 			 * */
 			.overwrite	= 0,
+			.sample_time	= true,
 		},
 		.max_stack	     = sysctl__max_stack(),
 		.annotation_opts     = annotation__default_options,
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index d053aa0a7582..c5412db05683 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -279,8 +279,10 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 
 	switch (how) {
 	case OE_FLUSH__FINAL:
-		oe->next_flush = ULLONG_MAX;
 		show_progress = true;
+		__fallthrough;
+	case OE_FLUSH__TOP:
+		oe->next_flush = ULLONG_MAX;
 		break;
 
 	case OE_FLUSH__HALF:
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 507b4e4df79e..0c6e26aec0e3 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -18,6 +18,7 @@ enum oe_flush {
 	OE_FLUSH__FINAL,
 	OE_FLUSH__ROUND,
 	OE_FLUSH__HALF,
+	OE_FLUSH__TOP,
 };
 
 struct ordered_events;
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 1fbcbd79720a..5f503293cfd8 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -40,6 +40,12 @@ struct perf_top {
 	const char	   *sym_filter;
 	float		   min_percent;
 	unsigned int	   nr_threads_synthesize;
+
+	struct {
+		struct ordered_events	*in;
+		struct ordered_events	 data[2];
+		pthread_mutex_t		 lock;
+	} qe;
 };
 
 #define CONSOLE_CLEAR "[H[2J"
-- 
2.17.2

