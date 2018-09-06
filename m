Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32597C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA122064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA122064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeIFSM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:12:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36923 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:12:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86Db0No309632
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:37:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86Db0RX309628;
        Thu, 6 Sep 2018 06:37:00 -0700
Date:   Thu, 6 Sep 2018 06:37:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-77e0faf8552c9329d58a4de460928e03252647c6@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, namhyung@kernel.org,
        andi@firstfloor.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Reply-To: namhyung@kernel.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, andi@firstfloor.org,
          acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, dsahern@gmail.com
In-Reply-To: <20180830063252.23729-31-jolsa@kernel.org>
References: <20180830063252.23729-31-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Pass 'evlist' to aggr_update_shadow()
Git-Commit-ID: 77e0faf8552c9329d58a4de460928e03252647c6
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

Commit-ID:  77e0faf8552c9329d58a4de460928e03252647c6
Gitweb:     https://git.kernel.org/tip/77e0faf8552c9329d58a4de460928e03252647c6
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:39 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:24 -0300

perf stat: Pass 'evlist' to aggr_update_shadow()

Pass a 'evlist' argument to aggr_update_shadow(), to get rid of the
global 'evsel_list' variable dependency.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-31-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f5ac6545af34..2711d8f6e4b8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1099,7 +1099,8 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	}
 }
 
-static void aggr_update_shadow(struct perf_stat_config *config)
+static void aggr_update_shadow(struct perf_stat_config *config,
+			       struct perf_evlist *evlist)
 {
 	int cpu, s2, id, s;
 	u64 val;
@@ -1107,7 +1108,7 @@ static void aggr_update_shadow(struct perf_stat_config *config)
 
 	for (s = 0; s < aggr_map->nr; s++) {
 		id = aggr_map->map[s];
-		evlist__for_each_entry(evsel_list, counter) {
+		evlist__for_each_entry(evlist, counter) {
 			val = 0;
 			for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
 				s2 = aggr_get_id(evsel_list->cpus, cpu);
@@ -1238,7 +1239,7 @@ static void print_aggr(struct perf_stat_config *config,
 	if (!(aggr_map || aggr_get_id))
 		return;
 
-	aggr_update_shadow(config);
+	aggr_update_shadow(config, evlist);
 
 	/*
 	 * With metric_only everything is on a single line.
