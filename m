Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229BC65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967842146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131804;
	bh=siGGuLXRPUOF913EMBK2ewCWjgBf+fVUBBJprLbGWok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GRlhEnW4eoteRWFp8n3JmMFh8UbW3U9Hdtd14jPokFcUOy5azKbGqT9dGSXHMjlQC
	 LQC/94QEPt729cr6y9fj0m4f0JDcDsPidSifJaSQrarIoFMayxj6nVWB5sE+/rD/6f
	 UvkbcojmPxTsECYnyTDvo4ANQCSLhb8ZJId4yWJo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967842146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeLFVaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbeLFVaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:30:01 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E4320989;
        Thu,  6 Dec 2018 21:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131800;
        bh=siGGuLXRPUOF913EMBK2ewCWjgBf+fVUBBJprLbGWok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sea5ZH40saUi74Jn1yjaKA6nw5ehnci9A1Cbd22Hx/Xm25tX+P8rV+1AyG2Ml4wqK
         Y5I9LhDs2dZxDX/Bstsk33C54vnOfgCSiUzPipyv0wHZd4LFfsjdfSf2MQd7DNZG7+
         YNR4etDJ0EZ/r3gjGx0UF33CRO5f/siV2upEmwh0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 53/75] perf top: Drop samples which are behind the refresh rate
Date:   Thu,  6 Dec 2018 18:25:40 -0300
Message-Id: <20181206212602.20474-54-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Drop samples from processing thread if they get behind the latest event
read from the kernel maps. If it gets behind more than the refresh rate
(-d option), drop the sample.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-x533ra5c1pgofvbtsizzuydd@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 50ec01eb7f57..234232d538c2 100644
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
2.19.2

