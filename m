Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988E9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0A22086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0A22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeKSWoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:44:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbeKSWoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:44:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 609AE3082E4C;
        Mon, 19 Nov 2018 12:20:43 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6316B45F35;
        Mon, 19 Nov 2018 12:20:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 09/12] perf top: Drop samples which are behind more than refresh rate
Date:   Mon, 19 Nov 2018 13:20:13 +0100
Message-Id: <20181119122016.22423-10-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 19 Nov 2018 12:20:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropping samples from processing thread if they get behind the
latest event read from kernel maps. If it gets behind more than
the refresh rate (-d option), dropping the sample.

Link: http://lkml.kernel.org/n/tip-wf56z076006vfs5f5qd28d7n@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ce542cc1e84f..a509d8c0a846 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -833,6 +833,8 @@ perf_top__process_lost_samples(struct perf_top *top,
 	hists->stats.total_lost_samples += event->lost_samples.lost;
 }
 
+static u64 last_timestamp;
+
 static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 {
 	struct record_opts *opts = &top->record_opts;
@@ -845,14 +847,13 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		return;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
-		u64 timestamp = -1ULL;
 		int ret;
 
-		ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
+		ret = perf_evlist__parse_sample_timestamp(evlist, event, &last_timestamp);
 		if (ret && ret != -1)
 			break;
 
-		ret = ordered_events__queue(top->qe.in, event, timestamp, 0);
+		ret = ordered_events__queue(top->qe.in, event, last_timestamp, 0);
 		if (ret)
 			break;
 
@@ -1084,6 +1085,21 @@ static void *process_thread(void *arg)
 	return NULL;
 }
 
+/*
+ * Allow only 'top->delay_secs' seconds behind samples.
+ */
+static int should_drop(struct ordered_event *qevent, struct perf_top *top)
+{
+	union perf_event *event = qevent->event;
+	u64 delay_timestamp;
+
+	if (event->header.type != PERF_RECORD_SAMPLE)
+		return false;
+
+	delay_timestamp = qevent->timestamp + top->delay_secs * NSEC_PER_SEC;
+	return delay_timestamp < last_timestamp;
+}
+
 static int deliver_event(struct ordered_events *qe,
 			 struct ordered_event *qevent)
 {
@@ -1096,6 +1112,9 @@ static int deliver_event(struct ordered_events *qe,
 	struct machine *machine;
 	int ret = -1;
 
+	if (should_drop(qevent, top))
+		return 0;
+
 	ret = perf_evlist__parse_sample(evlist, event, &sample);
 	if (ret) {
 		pr_err("Can't parse sample, err = %d\n", ret);
-- 
2.17.2

