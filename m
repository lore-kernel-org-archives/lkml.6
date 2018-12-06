Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC36C6783B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0117214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131930;
	bh=Bh57e7gQxHaR6C/PhGvVn94jBCnO8+WBH2afL96rebI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZQvnvOYxis9eabPLBMMqoixBvIKA83xDAwK8SXMSsqfgamSBHrn/ybaoQfTxV3wLY
	 BGPeuqBJbRungc/6t7r2RMghw5dk7FeWa1THEDzxZ4UE5ewisQ6AHe7ChuaWWNBESy
	 yGWhW+J8F+axFefYfG6ho/s+68rZWRcZH3kYuWP4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0117214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeLFVbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLFVbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:31:18 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F0E32146D;
        Thu,  6 Dec 2018 21:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131876;
        bh=Bh57e7gQxHaR6C/PhGvVn94jBCnO8+WBH2afL96rebI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlsQk0/8As6aOFk2AUhKwOgGMA2vVgNsqWhB+AGbB/J8aXb4OEE+RbY3x3lnS/GIz
         6t+w4QFpIFrz0FmNXtN9rcPNCPoLKMrZWjoE8Q0al53sbzs1z0my64hEJCrcFs+oco
         jygR7D5XTkgr9Pcs6sEn2VEs6gTeQuoW1YUcmC3I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dmitry Levin <ldv@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@uudg.org>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 73/75] perf trace: Move event delivery to a new deliver_event() function
Date:   Thu,  6 Dec 2018 18:26:00 -0300
Message-Id: <20181206212602.20474-74-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
@@ -2802,18 +2817,10 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
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
-- 
2.19.2

