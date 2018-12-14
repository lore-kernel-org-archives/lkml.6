Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431CE206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbeLNUtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:49:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45711 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbeLNUtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:49:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKnWx81457970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:49:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKnVkD1457967;
        Fri, 14 Dec 2018 12:49:31 -0800
Date:   Fri, 14 Dec 2018 12:49:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-x533ra5c1pgofvbtsizzuydd@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, davem@davemloft.net, peterz@infradead.org,
        mingo@kernel.org
Reply-To: davem@davemloft.net, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Drop samples which are behind the refresh
 rate
Git-Commit-ID: bdbc7bcf0f9ac6196b23244b10632c30efb8653a
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

Commit-ID:  bdbc7bcf0f9ac6196b23244b10632c30efb8653a
Gitweb:     https://git.kernel.org/tip/bdbc7bcf0f9ac6196b23244b10632c30efb8653a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 11 Nov 2018 19:52:06 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:34 -0300

perf top: Drop samples which are behind the refresh rate

Drop samples from processing thread if they get behind the latest event
read from the kernel maps. If it gets behind more than the refresh rate
(-d option), drop the sample.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-x533ra5c1pgofvbtsizzuydd@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
