Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D145C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6B621871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeLRO3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:29:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60825 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeLRO3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:29:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIETIbg2858277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:29:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIETIg02858271;
        Tue, 18 Dec 2018 06:29:18 -0800
Date:   Tue, 18 Dec 2018 06:29:18 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-028713aa8389d960cb1935a9954327bdaa163cf8@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, lclaudio@uudg.org,
        rostedt@goodmis.org, namhyung@kernel.org, esyr@redhat.com,
        mingo@kernel.org, acme@redhat.com, fweisbec@gmail.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, ldv@altlinux.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, ldv@altlinux.org, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          fweisbec@gmail.com, esyr@redhat.com, acme@redhat.com,
          mingo@kernel.org, namhyung@kernel.org, rostedt@goodmis.org,
          lclaudio@uudg.org
In-Reply-To: <20181205160509.1168-9-jolsa@kernel.org>
References: <20181205160509.1168-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Add ordered processing
Git-Commit-ID: 028713aa8389d960cb1935a9954327bdaa163cf8
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

Commit-ID:  028713aa8389d960cb1935a9954327bdaa163cf8
Gitweb:     https://git.kernel.org/tip/028713aa8389d960cb1935a9954327bdaa163cf8
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 5 Dec 2018 17:05:09 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 15:21:17 -0300

perf trace: Add ordered processing

Sort events to provide the precise outcome of ordered events, just like
is done with 'perf report' and 'perf top'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Luis Cláudio Gonçalves <lclaudio@uudg.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181205160509.1168-9-jolsa@kernel.org
[ split from a larger patch, added trace__ prefixes to new 'struct trace' methods ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 52 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3b6b1fecf2bb..366ec3c8f580 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,10 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
+	struct {
+		struct ordered_events	data;
+		u64			last;
+	} oe;
 };
 
 struct tp_field {
@@ -2652,6 +2656,42 @@ static int trace__deliver_event(struct trace *trace, union perf_event *event)
 	return 0;
 }
 
+static int trace__flush_ordered_events(struct trace *trace)
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
+static int trace__deliver_ordered_event(struct trace *trace, union perf_event *event)
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
+	return trace__flush_ordered_events(trace);
+}
+
+static int ordered_events__deliver_event(struct ordered_events *oe,
+					 struct ordered_event *event)
+{
+	struct trace *trace = container_of(oe, struct trace, oe.data);
+
+	return trace__deliver_event(trace, event->event);
+}
+
 static int trace__run(struct trace *trace, int argc, const char **argv)
 {
 	struct perf_evlist *evlist = trace->evlist;
@@ -2819,7 +2859,9 @@ again:
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			++trace->nr_events;
 
-			trace__deliver_event(trace, event);
+			err = trace__deliver_ordered_event(trace, event);
+			if (err)
+				goto out_disable;
 
 			perf_mmap__consume(md);
 
@@ -2842,6 +2884,9 @@ again:
 				draining = true;
 
 			goto again;
+		} else {
+			if (trace__flush_ordered_events(trace))
+				goto out_disable;
 		}
 	} else {
 		goto again;
@@ -2852,6 +2897,8 @@ out_disable:
 
 	perf_evlist__disable(evlist);
 
+	ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
+
 	if (!err) {
 		if (trace->summary)
 			trace__fprintf_thread_summary(trace, trace->output);
@@ -3562,6 +3609,9 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
+	ordered_events__init(&trace.oe.data, ordered_events__deliver_event, &trace);
+	ordered_events__set_copy_on_queue(&trace.oe.data, true);
+
 	/*
 	 * If we are augmenting syscalls, then combine what we put in the
 	 * __augmented_syscalls__ BPF map with what is in the
