Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A49C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D83217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbeLTSA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:00:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbeLTSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:00:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI0msl3680035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:00:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI0mtB3680032;
        Thu, 20 Dec 2018 10:00:48 -0800
Date:   Thu, 20 Dec 2018 10:00:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lxwwf3238ta4neq2zh1y1h45@git.kernel.org>
Cc:     hpa@zytor.com, namhyung@kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, mingo@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: adrian.hunter@intel.com, acme@redhat.com, namhyung@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Rename delivery functions to ease
 making ordered_events selectable
Git-Commit-ID: 7ba61524fa0337a919b2ec5fcce26db23c611ca7
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

Commit-ID:  7ba61524fa0337a919b2ec5fcce26db23c611ca7
Gitweb:     https://git.kernel.org/tip/7ba61524fa0337a919b2ec5fcce26db23c611ca7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 10 Dec 2018 16:09:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:38 -0300

perf trace: Rename delivery functions to ease making ordered_events selectable

Just hide a bit more how events gets delivered, hiding ordered_events
details from the main loop.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lxwwf3238ta4neq2zh1y1h45@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 366ec3c8f580..1ff5603db940 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2641,7 +2641,7 @@ static int trace__set_filter_pids(struct trace *trace)
 	return err;
 }
 
-static int trace__deliver_event(struct trace *trace, union perf_event *event)
+static int __trace__deliver_event(struct trace *trace, union perf_event *event)
 {
 	struct perf_evlist *evlist = trace->evlist;
 	struct perf_sample sample;
@@ -2656,7 +2656,7 @@ static int trace__deliver_event(struct trace *trace, union perf_event *event)
 	return 0;
 }
 
-static int trace__flush_ordered_events(struct trace *trace)
+static int trace__flush_events(struct trace *trace)
 {
 	u64 first = ordered_events__first_time(&trace->oe.data);
 	u64 flush = trace->oe.last - NSEC_PER_SEC;
@@ -2668,7 +2668,7 @@ static int trace__flush_ordered_events(struct trace *trace)
 	return 0;
 }
 
-static int trace__deliver_ordered_event(struct trace *trace, union perf_event *event)
+static int trace__deliver_event(struct trace *trace, union perf_event *event)
 {
 	struct perf_evlist *evlist = trace->evlist;
 	int err;
@@ -2681,7 +2681,7 @@ static int trace__deliver_ordered_event(struct trace *trace, union perf_event *e
 	if (err)
 		return err;
 
-	return trace__flush_ordered_events(trace);
+	return trace__flush_events(trace);
 }
 
 static int ordered_events__deliver_event(struct ordered_events *oe,
@@ -2689,7 +2689,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 {
 	struct trace *trace = container_of(oe, struct trace, oe.data);
 
-	return trace__deliver_event(trace, event->event);
+	return __trace__deliver_event(trace, event->event);
 }
 
 static int trace__run(struct trace *trace, int argc, const char **argv)
@@ -2859,7 +2859,7 @@ again:
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			++trace->nr_events;
 
-			err = trace__deliver_ordered_event(trace, event);
+			err = trace__deliver_event(trace, event);
 			if (err)
 				goto out_disable;
 
@@ -2885,7 +2885,7 @@ again:
 
 			goto again;
 		} else {
-			if (trace__flush_ordered_events(trace))
+			if (trace__flush_events(trace))
 				goto out_disable;
 		}
 	} else {
