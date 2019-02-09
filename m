Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224E4C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D155120823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBIMtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:49:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:49:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CmuYK2632368
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:48:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19Cmtfb2632365;
        Sat, 9 Feb 2019 04:48:55 -0800
Date:   Sat, 9 Feb 2019 04:48:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e4c38fd4a0f594d8ce0313db028af98b36edc8b3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, yao.jin@linux.intel.com,
        namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        acme@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        hpa@zytor.com, mingo@kernel.org
Reply-To: acme@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, yao.jin@linux.intel.com,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          mingo@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org
In-Reply-To: <20190204141808.23031-2-jolsa@kernel.org>
References: <20190204141808.23031-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf hists: Add argument to hists__resort_cb_t
 callback
Git-Commit-ID: e4c38fd4a0f594d8ce0313db028af98b36edc8b3
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

Commit-ID:  e4c38fd4a0f594d8ce0313db028af98b36edc8b3
Gitweb:     https://git.kernel.org/tip/e4c38fd4a0f594d8ce0313db028af98b36edc8b3
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 4 Feb 2019 15:18:06 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:39 -0300

perf hists: Add argument to hists__resort_cb_t callback

Add argument to hists__resort_cb_t so that we can pass data from upper
layers to the callback function. It will be used in the following
patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190204141808.23031-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c |  8 ++++----
 tools/perf/util/hist.c   | 11 ++++++-----
 tools/perf/util/hist.h   |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index b2bf117881f1..efaaab23c6fd 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1970,7 +1970,7 @@ static void calc_width(struct c2c_hist_entry *c2c_he)
 	set_nodestr(c2c_he);
 }
 
-static int filter_cb(struct hist_entry *he)
+static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 
@@ -1987,7 +1987,7 @@ static int filter_cb(struct hist_entry *he)
 	return 0;
 }
 
-static int resort_cl_cb(struct hist_entry *he)
+static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *c2c_hists;
@@ -2074,7 +2074,7 @@ static int setup_nodes(struct perf_session *session)
 
 #define HAS_HITMS(__h) ((__h)->stats.lcl_hitm || (__h)->stats.rmt_hitm)
 
-static int resort_hitm_cb(struct hist_entry *he)
+static int resort_hitm_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
@@ -2096,7 +2096,7 @@ static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t cb)
 		struct hist_entry *he;
 
 		he = rb_entry(next, struct hist_entry, rb_node);
-		ret = cb(he);
+		ret = cb(he, NULL);
 		if (ret)
 			break;
 		next = rb_next(&he->rb_node);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7f9df74ab893..64ad603a0592 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1721,7 +1721,8 @@ static void __hists__insert_output_entry(struct rb_root_cached *entries,
 }
 
 static void output_resort(struct hists *hists, struct ui_progress *prog,
-			  bool use_callchain, hists__resort_cb_t cb)
+			  bool use_callchain, hists__resort_cb_t cb,
+			  void *cb_arg)
 {
 	struct rb_root_cached *root;
 	struct rb_node *next;
@@ -1760,7 +1761,7 @@ static void output_resort(struct hists *hists, struct ui_progress *prog,
 		n = rb_entry(next, struct hist_entry, rb_node_in);
 		next = rb_next(&n->rb_node_in);
 
-		if (cb && cb(n))
+		if (cb && cb(n, cb_arg))
 			continue;
 
 		__hists__insert_output_entry(&hists->entries, n, min_callchain_hits, use_callchain);
@@ -1785,18 +1786,18 @@ void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *pro
 
 	use_callchain |= symbol_conf.show_branchflag_count;
 
-	output_resort(evsel__hists(evsel), prog, use_callchain, NULL);
+	output_resort(evsel__hists(evsel), prog, use_callchain, NULL, NULL);
 }
 
 void hists__output_resort(struct hists *hists, struct ui_progress *prog)
 {
-	output_resort(hists, prog, symbol_conf.use_callchain, NULL);
+	output_resort(hists, prog, symbol_conf.use_callchain, NULL, NULL);
 }
 
 void hists__output_resort_cb(struct hists *hists, struct ui_progress *prog,
 			     hists__resort_cb_t cb)
 {
-	output_resort(hists, prog, symbol_conf.use_callchain, cb);
+	output_resort(hists, prog, symbol_conf.use_callchain, cb, NULL);
 }
 
 static bool can_goto_child(struct hist_entry *he, enum hierarchy_move_dir hmd)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 6b872079ead5..69a367d4aeaf 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -163,7 +163,7 @@ int hist_entry__snprintf_alignment(struct hist_entry *he, struct perf_hpp *hpp,
 				   struct perf_hpp_fmt *fmt, int printed);
 void hist_entry__delete(struct hist_entry *he);
 
-typedef int (*hists__resort_cb_t)(struct hist_entry *he);
+typedef int (*hists__resort_cb_t)(struct hist_entry *he, void *arg);
 
 void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog);
 void hists__output_resort(struct hists *hists, struct ui_progress *prog);
