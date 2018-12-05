Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B0C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF772084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025940;
	bh=Iqbb5sf9/F0jA5m8mqOPrPY3tymx50wB4wFNYYdcd4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rS+7ig5YVJwSFBynBisnL7bY0Yl3Y7FkuI/34AZtFXeUqyWbY1TFu7xdmf0yZYH2K
	 nj0e6qJTXYDlzvWqyelCgAgcBCiHdgn5GSatDG88lo1g3gFxMR4oPfvknyi+s4AxkK
	 2mvJv1f97GbyUCSluviEJ24r1LloLXBfZ7k3wufE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF772084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeLEQFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:05:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbeLEQFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:05:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F185A28831;
        Wed,  5 Dec 2018 16:05:35 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C6D117504;
        Wed,  5 Dec 2018 16:05:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 8/8] perf trace: Add ordered processing for --block option
Date:   Wed,  5 Dec 2018 17:05:09 +0100
Message-Id: <20181205160509.1168-9-jolsa@kernel.org>
In-Reply-To: <20181205160509.1168-1-jolsa@kernel.org>
References: <20181205160509.1168-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 05 Dec 2018 16:05:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to sort the trace events if --block option is set.
In this mode we don't loose events, and we are potentionally slow
by definition, because the traced process could be blocked.

In this case it makes sense to sort events and provide the precise
outcome of ordered events.

Link: http://lkml.kernel.org/n/tip-me69opepwec6tjtpy2cxrrzd@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-trace.c       | 59 +++++++++++++++++++++++++++++++-
 tools/perf/util/ordered-events.c | 11 ++++++
 tools/perf/util/ordered-events.h |  1 +
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b4b1dafe882a..d650d8cd421b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,11 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
+
+	struct {
+		struct ordered_events	data;
+		u64			last;
+	} oe;
 };
 
 struct tp_field {
@@ -2656,6 +2661,43 @@ static int deliver_event(struct trace *trace, union perf_event *event)
 	return 0;
 }
 
+
+static int flush_ordered_events(struct trace *trace)
+{
+	u64 first = ordered_events__first_time(&trace->oe.data);
+	u64 flush = trace->oe.last - NSEC_PER_SEC;
+
+	/* Is there some thing to flush.. */
+	if (first && first < flush)
+		return ordered_events__flush_time(&trace->oe.data, flush);
+
+	return 0;
+}
+
+static int deliver_ordered_event(struct trace *trace, union perf_event *event)
+{
+	struct perf_evlist *evlist = trace->evlist;
+	int err;
+
+	err = perf_evlist__parse_sample_timestamp(evlist, event, &trace->oe.last);
+	if (err && err != -1)
+		return err;
+
+	err = ordered_events__queue(&trace->oe.data, event, trace->oe.last, 0);
+	if (err)
+		return err;
+
+	return flush_ordered_events(trace);
+}
+
+static int ordered_events__deliver_event(struct ordered_events *oe,
+					 struct ordered_event *event)
+{
+	struct trace *trace = container_of(oe, struct trace, oe.data);
+
+	return deliver_event(trace, event->event);
+}
+
 static int trace__run(struct trace *trace, int argc, const char **argv)
 {
 	struct perf_evlist *evlist = trace->evlist;
@@ -2823,7 +2865,13 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			++trace->nr_events;
 
-			deliver_event(trace, event);
+			if (trace->opts.block) {
+				err = deliver_ordered_event(trace, event);
+				if (err)
+					goto out_disable;
+			} else {
+				deliver_event(trace, event);
+			}
 
 			perf_mmap__consume(md);
 
@@ -2846,6 +2894,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 				draining = true;
 
 			goto again;
+		} else {
+			if (trace->opts.block && flush_ordered_events(trace))
+				goto out_disable;
 		}
 	} else {
 		goto again;
@@ -2856,6 +2907,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	perf_evlist__disable(evlist);
 
+	if (trace->opts.block)
+		ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
+
 	if (!err) {
 		if (trace->summary)
 			trace__fprintf_thread_summary(trace, trace->output);
@@ -3520,6 +3574,9 @@ int cmd_trace(int argc, const char **argv)
 			pr_err("ERROR: Can't use --block on non task targets\n");
 			goto out;
 		}
+
+		ordered_events__init(&trace.oe.data, ordered_events__deliver_event, &trace);
+		ordered_events__set_copy_on_queue(&trace.oe.data, true);
 	}
 
 	evsel = bpf__setup_output_event(trace.evlist, "__augmented_syscalls__");
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index b5c6a854379f..6bd9f50ac83e 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -343,6 +343,17 @@ int ordered_events__flush_time(struct ordered_events *oe, u64 time)
 	return __ordered_events__flush(oe, OE_FLUSH__TIME, time);
 }
 
+u64 ordered_events__first_time(struct ordered_events *oe)
+{
+	struct ordered_event *event;
+
+	if (list_empty(&oe->events))
+		return 0;
+
+	event = list_first_entry(&oe->events, struct ordered_event, list);
+	return event->timestamp;
+}
+
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data)
 {
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 6ef81e5be052..4f75f1d2f9db 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -61,6 +61,7 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
 			  void *data);
 void ordered_events__free(struct ordered_events *oe);
 void ordered_events__reinit(struct ordered_events *oe);
+u64 ordered_events__first_time(struct ordered_events *oe);
 
 static inline
 void ordered_events__set_alloc_size(struct ordered_events *oe, u64 size)
-- 
2.17.2

