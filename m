Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92112C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B41218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170920;
	bh=78TnZNcgsBUT0YgfIJR7QVeooW1JFkmAYaKFI6DG0tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AMt2PRBw8j3dRCWpXQnAeL6e/M1KYbKyKzwlvQEkwJ1uYm7JSEv2Cusp4EsM5uhXT
	 jiPBXCEB4z9yB1OXxrRZOFqRrfvyukPtUgmahcbyWYu6eGhhnEIb7ZhYqWRFuCsScr
	 p8XVl5/WQs+z9xXDMAItFS4Yop4LsRKQNIrm5d6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeLRWIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeLRWIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:08:36 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91C95218A2;
        Tue, 18 Dec 2018 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170916;
        bh=78TnZNcgsBUT0YgfIJR7QVeooW1JFkmAYaKFI6DG0tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cS01bX/wBLpWzbgsyGFi9tqYb2Lb8W33qK5Q//226HGKYXZ8xaUd6fwnO1NFIwqMO
         kApAUQU9v12X2GVflhGdvE+yLQO7LnUPCdIol2neQ66dvwlNwL0LB3Pah+bQWM5ukY
         uS2e4Zcl7dRacM+itsF3TW4dgCBwmybz4g9+syQs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 06/63] perf trace: Rename delivery functions to ease making ordered_events selectable
Date:   Tue, 18 Dec 2018 19:06:36 -0300
Message-Id: <20181218220733.15839-7-acme@kernel.org>
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
@@ -2859,7 +2859,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			++trace->nr_events;
 
-			err = trace__deliver_ordered_event(trace, event);
+			err = trace__deliver_event(trace, event);
 			if (err)
 				goto out_disable;
 
@@ -2885,7 +2885,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 			goto again;
 		} else {
-			if (trace__flush_ordered_events(trace))
+			if (trace__flush_events(trace))
 				goto out_disable;
 		}
 	} else {
-- 
2.19.2

