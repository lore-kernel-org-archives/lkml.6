Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1317AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27FB2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27FB2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeIFR5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:57:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbeIFR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:57:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DL6h3305793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:21:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DL5ae305790;
        Thu, 6 Sep 2018 06:21:05 -0700
Date:   Thu, 6 Sep 2018 06:21:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d50ed0ce820414dbe249a6ad5c9830e29cc46fcc@git.kernel.org>
Cc:     namhyung@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org, acme@redhat.com,
        andi@firstfloor.org, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Reply-To: mingo@kernel.org, hpa@zytor.com, jolsa@kernel.org,
          namhyung@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, dsahern@gmail.com,
          linux-kernel@vger.kernel.org, andi@firstfloor.org,
          acme@redhat.com
In-Reply-To: <20180830063252.23729-2-jolsa@kernel.org>
References: <20180830063252.23729-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Use evsel->threads in
 create_perf_stat_counter()
Git-Commit-ID: d50ed0ce820414dbe249a6ad5c9830e29cc46fcc
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

Commit-ID:  d50ed0ce820414dbe249a6ad5c9830e29cc46fcc
Gitweb:     https://git.kernel.org/tip/d50ed0ce820414dbe249a6ad5c9830e29cc46fcc
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:10 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:21 -0300

perf stat: Use evsel->threads in create_perf_stat_counter()

Get rid of the evsel_list dependency, here we can use the evsel->threads
copy of the struct thread_map.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d097b5b47eb8..d389ed623715 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -293,7 +293,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel)
 	if (target__has_cpu(&target) && !target__has_per_thread(&target))
 		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
 
-	return perf_evsel__open_per_thread(evsel, evsel_list->threads);
+	return perf_evsel__open_per_thread(evsel, evsel->threads);
 }
 
 static int process_synthesized_event(struct perf_tool *tool __maybe_unused,
