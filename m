Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947DFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B5020844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B5020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbeIFSFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:05:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56749 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbeIFSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:05:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DTE6v308312
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:29:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DTEtx308309;
        Thu, 6 Sep 2018 06:29:14 -0700
Date:   Thu, 6 Sep 2018 06:29:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-0174820a8ba108f2e72dac5caaea3500c8ca6323@git.kernel.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, mingo@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, acme@redhat.com, andi@firstfloor.org
Reply-To: andi@firstfloor.org, tglx@linutronix.de, mingo@kernel.org,
          namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, dsahern@gmail.com,
          peterz@infradead.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180830063252.23729-17-jolsa@kernel.org>
References: <20180830063252.23729-17-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move STAT_RECORD out of
 perf_evlist__print_counters()
Git-Commit-ID: 0174820a8ba108f2e72dac5caaea3500c8ca6323
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

Commit-ID:  0174820a8ba108f2e72dac5caaea3500c8ca6323
Gitweb:     https://git.kernel.org/tip/0174820a8ba108f2e72dac5caaea3500c8ca6323
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:25 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:22 -0300

perf stat: Move STAT_RECORD out of perf_evlist__print_counters()

It's stat related and should stay in the 'perf stat' command.  The
perf_evlist__print_counters function will be moved out in the following
patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index db11832bbdbc..4ffbb6594eb6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1701,10 +1701,6 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	struct perf_evsel *counter;
 	char buf[64], *prefix = NULL;
 
-	/* Do not print anything if we record to the pipe. */
-	if (STAT_RECORD && perf_stat.data.is_pipe)
-		return;
-
 	if (interval)
 		print_interval(prefix = buf, ts);
 	else
@@ -1766,6 +1762,10 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 
 static void print_counters(struct timespec *ts, int argc, const char **argv)
 {
+	/* Do not print anything if we record to the pipe. */
+	if (STAT_RECORD && perf_stat.data.is_pipe)
+		return;
+
 	perf_evlist__print_counters(evsel_list, ts, argc, argv);
 }
 
