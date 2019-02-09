Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFEDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9376C20855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBIMtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:49:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45105 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:49:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CnYIp2632409
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:49:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CnYgQ2632405;
        Sat, 9 Feb 2019 04:49:34 -0800
Date:   Sat, 9 Feb 2019 04:49:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5749618764c2dbbb0091035d84dd763529afe4e6@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, hpa@zytor.com,
        namhyung@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, kan.liang@linux.intel.com,
        yao.jin@linux.intel.com, jolsa@kernel.org, acme@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, namhyung@kernel.org,
          yao.jin@linux.intel.com, jolsa@kernel.org, acme@redhat.com,
          kan.liang@linux.intel.com
In-Reply-To: <20190204141808.23031-3-jolsa@kernel.org>
References: <20190204141808.23031-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Add output_resort_cb method
Git-Commit-ID: 5749618764c2dbbb0091035d84dd763529afe4e6
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

Commit-ID:  5749618764c2dbbb0091035d84dd763529afe4e6
Gitweb:     https://git.kernel.org/tip/5749618764c2dbbb0091035d84dd763529afe4e6
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 4 Feb 2019 15:18:07 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf evsel: Add output_resort_cb method

Add perf_evsel__output_resort_cb() so we have an interface with a
callback for each hist entry. It will be used in the following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190204141808.23031-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 10 ++++++++--
 tools/perf/util/hist.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 64ad603a0592..669f961316f0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1775,7 +1775,8 @@ static void output_resort(struct hists *hists, struct ui_progress *prog,
 	}
 }
 
-void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog)
+void perf_evsel__output_resort_cb(struct perf_evsel *evsel, struct ui_progress *prog,
+				  hists__resort_cb_t cb, void *cb_arg)
 {
 	bool use_callchain;
 
@@ -1786,7 +1787,12 @@ void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *pro
 
 	use_callchain |= symbol_conf.show_branchflag_count;
 
-	output_resort(evsel__hists(evsel), prog, use_callchain, NULL, NULL);
+	output_resort(evsel__hists(evsel), prog, use_callchain, cb, cb_arg);
+}
+
+void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog)
+{
+	return perf_evsel__output_resort_cb(evsel, prog, NULL, NULL);
 }
 
 void hists__output_resort(struct hists *hists, struct ui_progress *prog)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 69a367d4aeaf..4af27fbab24f 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -165,6 +165,8 @@ void hist_entry__delete(struct hist_entry *he);
 
 typedef int (*hists__resort_cb_t)(struct hist_entry *he, void *arg);
 
+void perf_evsel__output_resort_cb(struct perf_evsel *evsel, struct ui_progress *prog,
+				  hists__resort_cb_t cb, void *cb_arg);
 void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog);
 void hists__output_resort(struct hists *hists, struct ui_progress *prog);
 void hists__output_resort_cb(struct hists *hists, struct ui_progress *prog,
