Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A763C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526EB218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbeLTSB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:01:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34815 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbeLTSB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:01:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI1M2x3680106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:01:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI1LwO3680103;
        Thu, 20 Dec 2018 10:01:21 -0800
Date:   Thu, 20 Dec 2018 10:01:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8ki7sld6rusnjhhtaly26i5o@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
        jolsa@kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
          acme@redhat.com, tglx@linutronix.de, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Allow selecting use the use of the
 ordered_events code
Git-Commit-ID: a761a8d102e2a6edfef3ad5bb22baeb715f93abd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a761a8d102e2a6edfef3ad5bb22baeb715f93abd
Gitweb:     https://git.kernel.org/tip/a761a8d102e2a6edfef3ad5bb22baeb715f93abd
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 10 Dec 2018 16:27:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:55 -0300

perf trace: Allow selecting use the use of the ordered_events code

I was trigger happy on this one, as using ordered_events as implemented
by Jiri for use with the --block code under discussion on lkml incurs
in delaying processing to form batches that then get ordered and then
printed.

With 'perf trace' we want to process the events as they go, without that
delay, and doing it that way works well for the common case which is to
trace a thread or a workload started by 'perf trace'.

So revert back to not using ordered_events but add an option to select
that mode so that users can experiment with their particular use case to
see if works better, i.e. if the added delay is not a problem and the
ordering helps.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8ki7sld6rusnjhhtaly26i5o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt |  6 ++++++
 tools/perf/builtin-trace.c              | 25 +++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index e113450503d2..631e687be4eb 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -205,6 +205,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	because the file may be huge. A time out is needed in such cases.
 	This option sets the time out limit. The default value is 500 ms.
 
+--sort-events::
+	Do sorting on batches of events, use when noticing out of order events that
+	may happen, for instance, when a thread gets migrated to a different CPU
+	while processing a syscall.
+
+
 PAGEFAULTS
 ----------
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1ff5603db940..406bceda6a2b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -110,6 +110,7 @@ struct trace {
 	} stats;
 	unsigned int		max_stack;
 	unsigned int		min_stack;
+	bool			sort_events;
 	bool			raw_augmented_syscalls;
 	bool			not_ev_qualifier;
 	bool			live;
@@ -2656,7 +2657,7 @@ static int __trace__deliver_event(struct trace *trace, union perf_event *event)
 	return 0;
 }
 
-static int trace__flush_events(struct trace *trace)
+static int __trace__flush_events(struct trace *trace)
 {
 	u64 first = ordered_events__first_time(&trace->oe.data);
 	u64 flush = trace->oe.last - NSEC_PER_SEC;
@@ -2668,12 +2669,19 @@ static int trace__flush_events(struct trace *trace)
 	return 0;
 }
 
+static int trace__flush_events(struct trace *trace)
+{
+	return !trace->sort_events ? 0 : __trace__flush_events(trace);
+}
+
 static int trace__deliver_event(struct trace *trace, union perf_event *event)
 {
-	struct perf_evlist *evlist = trace->evlist;
 	int err;
 
-	err = perf_evlist__parse_sample_timestamp(evlist, event, &trace->oe.last);
+	if (!trace->sort_events)
+		return __trace__deliver_event(trace, event);
+
+	err = perf_evlist__parse_sample_timestamp(trace->evlist, event, &trace->oe.last);
 	if (err && err != -1)
 		return err;
 
@@ -2897,7 +2905,8 @@ out_disable:
 
 	perf_evlist__disable(evlist);
 
-	ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
+	if (trace->sort_events)
+		ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
 
 	if (!err) {
 		if (trace->summary)
@@ -3516,6 +3525,8 @@ int cmd_trace(int argc, const char **argv)
 		     "Set the maximum stack depth when parsing the callchain, "
 		     "anything beyond the specified depth will be ignored. "
 		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
+	OPT_BOOLEAN(0, "sort-events", &trace.sort_events,
+			"Sort batch of events before processing, use if getting out of order events"),
 	OPT_BOOLEAN(0, "print-sample", &trace.print_sample,
 			"print the PERF_RECORD_SAMPLE PERF_SAMPLE_ info, for debugging"),
 	OPT_UINTEGER(0, "proc-map-timeout", &proc_map_timeout,
@@ -3609,8 +3620,10 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
-	ordered_events__init(&trace.oe.data, ordered_events__deliver_event, &trace);
-	ordered_events__set_copy_on_queue(&trace.oe.data, true);
+	if (trace.sort_events) {
+		ordered_events__init(&trace.oe.data, ordered_events__deliver_event, &trace);
+		ordered_events__set_copy_on_queue(&trace.oe.data, true);
+	}
 
 	/*
 	 * If we are augmenting syscalls, then combine what we put in the
