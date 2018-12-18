Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B466EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7EC218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170925;
	bh=YtoaQllviFMMYuufUvrusTbUTJiWHUrkHwp7X2TPuSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r3bnkKi3TH8GQY6rMu/d5Pr/H/OWuumCUXJYc2R4sN0p10YmI4hVJ0thWM+/N5pEq
	 VtDzmdu6hbxrqGz1xrW14utZQXdB1JYSO52pYMmjAuIpo9S7BaN3RH2eiKOHSNvXse
	 y/uCy4yPvIQK3nhKZH3PXQzgjwxugCrehPr7pcLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeLRWIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeLRWIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:08:43 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0B8217D9;
        Tue, 18 Dec 2018 22:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170922;
        bh=YtoaQllviFMMYuufUvrusTbUTJiWHUrkHwp7X2TPuSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOXN3UXbWn1k5ew3nTpuVngJR4nCjDDjTDTnTF8h8Rw2ZhX2eNd6hY3Crcg6GDad0
         gTB3ZC6THezRgsIbmv8p7gnO9lXhAobQh4g2nRGpSuDbu9weHrXpyizcL1zi2TLhxO
         we9Am27spUfW1cnxA7vBskdVlyDPV2XYzxyPXepo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 07/63] perf trace: Allow selecting use the use of the ordered_events code
Date:   Tue, 18 Dec 2018 19:06:37 -0300
Message-Id: <20181218220733.15839-8-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 
@@ -2897,7 +2905,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
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
-- 
2.19.2

