Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C051AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CA42086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbeLNUTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:19:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36175 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbeLNUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:19:55 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKJXlx1450693
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:19:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKJWVG1450689;
        Fri, 14 Dec 2018 12:19:32 -0800
Date:   Fri, 14 Dec 2018 12:19:32 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-6e269c85dcea8a41faac44dbd5130843080f0576@git.kernel.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, ravi.bangoria@linux.ibm.com,
        yao.jin@linux.intel.com, acme@redhat.com, mingo@kernel.org,
        tmricht@linux.vnet.ibm.com, anton@samba.org, hpa@zytor.com
Reply-To: mingo@kernel.org, anton@samba.org, tmricht@linux.vnet.ibm.com,
          hpa@zytor.com, acme@redhat.com, jolsa@redhat.com,
          ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
          jolsa@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20181116042843.24067-1-ravi.bangoria@linux.ibm.com>
References: <20181116042843.24067-1-ravi.bangoria@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Fix shadow stats for clock events
Git-Commit-ID: 6e269c85dcea8a41faac44dbd5130843080f0576
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

Commit-ID:  6e269c85dcea8a41faac44dbd5130843080f0576
Gitweb:     https://git.kernel.org/tip/6e269c85dcea8a41faac44dbd5130843080f0576
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Fri, 16 Nov 2018 09:58:43 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:46 -0300

perf stat: Fix shadow stats for clock events

Commit 0aa802a79469 ("perf stat: Get rid of extra clock display
function") introduced scale and unit for clock events. Thus,
perf_stat__update_shadow_stats() now saves scaled values of clock events
in msecs, instead of original nsecs. But while calculating values of
shadow stats we still consider clock event values in nsecs. This results
in a wrong shadow stat values. Ex,

  # ./perf stat -e task-clock,cycles ls
    <SNIP>
              2.60 msec task-clock:u    #    0.877 CPUs utilized
         2,430,564      cycles:u        # 1215282.000 GHz

Fix this by saving original nsec values for clock events in
perf_stat__update_shadow_stats(). After patch:

  # ./perf stat -e task-clock,cycles ls
    <SNIP>
              3.14 msec task-clock:u    #    0.839 CPUs utilized
         3,094,528      cycles:u        #    0.985 GHz

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: yuzhoujian@didichuxing.com
Fixes: 0aa802a79469 ("perf stat: Get rid of extra clock display function")
Link: http://lkml.kernel.org/r/20181116042843.24067-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index f0a8cec55c47..3c22c58b3e90 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -209,11 +209,12 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 				    int cpu, struct runtime_stat *st)
 {
 	int ctx = evsel_context(counter);
+	u64 count_ns = count;
 
 	count *= counter->scale;
 
 	if (perf_evsel__is_clock(counter))
-		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
+		update_runtime_stat(st, STAT_NSECS, 0, cpu, count_ns);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
