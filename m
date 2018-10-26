Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4406C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8279220834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8279220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeJZQKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:10:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48571 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJZQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:10:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7XvOC137172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:33:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7Xu8E137169;
        Fri, 26 Oct 2018 00:33:56 -0700
Date:   Fri, 26 Oct 2018 00:33:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-cbb5df7e96070f1f728ff7885443646ebba703d4@git.kernel.org>
Cc:     peterz@infradead.org, eranian@google.com, hpa@zytor.com,
        namhyung@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, acme@redhat.com, yao.jin@linux.intel.com,
        tglx@linutronix.de
Reply-To: namhyung@kernel.org, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, eranian@google.com, hpa@zytor.com,
          acme@redhat.com, tglx@linutronix.de, yao.jin@linux.intel.com,
          mingo@kernel.org
In-Reply-To: <20181022093015.9106-1-jolsa@kernel.org>
References: <20181022093015.9106-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Poll for monitored tasks being alive
Git-Commit-ID: cbb5df7e96070f1f728ff7885443646ebba703d4
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

Commit-ID:  cbb5df7e96070f1f728ff7885443646ebba703d4
Gitweb:     https://git.kernel.org/tip/cbb5df7e96070f1f728ff7885443646ebba703d4
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 22 Oct 2018 11:30:15 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 22 Oct 2018 12:37:52 -0300

perf stat: Poll for monitored tasks being alive

Adding the check for tasks we monitor via -p/-t options, and finish stat
if there's no longer task to monitor.

Requested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/r/20181022093015.9106-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b86aba1c8028..d1028d7755bb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -409,6 +409,28 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
 	return leader;
 }
 
+static bool is_target_alive(struct target *_target,
+			    struct thread_map *threads)
+{
+	struct stat st;
+	int i;
+
+	if (!target__has_task(_target))
+		return true;
+
+	for (i = 0; i < threads->nr; i++) {
+		char path[PATH_MAX];
+
+		scnprintf(path, PATH_MAX, "%s/%d", procfs__mountpoint(),
+			  threads->map[i].pid);
+
+		if (!stat(path, &st))
+			return true;
+	}
+
+	return false;
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -579,6 +601,8 @@ try_again:
 		enable_counters();
 		while (!done) {
 			nanosleep(&ts, NULL);
+			if (!is_target_alive(&target, evsel_list->threads))
+				break;
 			if (timeout)
 				break;
 			if (interval) {
