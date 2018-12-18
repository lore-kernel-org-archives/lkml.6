Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF4921871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeLRO2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:28:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLRO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:28:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIES8lX2858190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:28:08 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIES8Cu2858187;
        Tue, 18 Dec 2018 06:28:08 -0800
Date:   Tue, 18 Dec 2018 06:28:08 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1f44b3e2fc5d7a2c5f6d1e67c80ebc226d6bd25f@git.kernel.org>
Cc:     acme@redhat.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, lclaudio@uudg.org, namhyung@kernel.org,
        peterz@infradead.org, ldv@altlinux.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        esyr@redhat.com, jolsa@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org
Reply-To: rostedt@goodmis.org, hpa@zytor.com, jolsa@kernel.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          ldv@altlinux.org, lclaudio@uudg.org, namhyung@kernel.org,
          esyr@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          acme@redhat.com, fweisbec@gmail.com, tglx@linutronix.de
In-Reply-To: <20181205160509.1168-8-jolsa@kernel.org>
References: <20181205160509.1168-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Move event delivery to a new
 deliver_event() function
Git-Commit-ID: 1f44b3e2fc5d7a2c5f6d1e67c80ebc226d6bd25f
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

Commit-ID:  1f44b3e2fc5d7a2c5f6d1e67c80ebc226d6bd25f
Gitweb:     https://git.kernel.org/tip/1f44b3e2fc5d7a2c5f6d1e67c80ebc226d6bd25f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 5 Dec 2018 17:05:08 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 15:02:17 -0300

perf trace: Move event delivery to a new deliver_event() function

Mov event delivery code to a new trace__deliver_event() function, so
it's easier to add ordered delivery coming in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Luis Cláudio Gonçalves <lclaudio@uudg.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181205160509.1168-8-jolsa@kernel.org
[ Add trace__ prefix to the deliver_event method ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 98aff12af9e6..3b6b1fecf2bb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2637,6 +2637,21 @@ static int trace__set_filter_pids(struct trace *trace)
 	return err;
 }
 
+static int trace__deliver_event(struct trace *trace, union perf_event *event)
+{
+	struct perf_evlist *evlist = trace->evlist;
+	struct perf_sample sample;
+	int err;
+
+	err = perf_evlist__parse_sample(evlist, event, &sample);
+	if (err)
+		fprintf(trace->output, "Can't parse sample, err = %d, skipping...\n", err);
+	else
+		trace__handle_event(trace, event, &sample);
+
+	return 0;
+}
+
 static int trace__run(struct trace *trace, int argc, const char **argv)
 {
 	struct perf_evlist *evlist = trace->evlist;
@@ -2802,18 +2817,10 @@ again:
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
-			struct perf_sample sample;
-
 			++trace->nr_events;
 
-			err = perf_evlist__parse_sample(evlist, event, &sample);
-			if (err) {
-				fprintf(trace->output, "Can't parse sample, err = %d, skipping...\n", err);
-				goto next_event;
-			}
+			trace__deliver_event(trace, event);
 
-			trace__handle_event(trace, event, &sample);
-next_event:
 			perf_mmap__consume(md);
 
 			if (interrupted)
