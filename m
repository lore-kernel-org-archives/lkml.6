Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512EEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226892082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549289898;
	bh=0SKws5m0gVQ9vOXSbayYORsVp0jt9A8XvbhcA6tvTlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nN2Vcu/5qwMwkoCiRq22f1CldT39CQjT05xI5FFNka1gom9zJw7lccbwI3IH5sfK2
	 rqI9UcpQnZzHzXniqcwUbX7LBo3IMwnNZ5Vive/7w17x/ggPUdKok4Dmoy1DJAGOPn
	 B3/g5oPS9ZNo+/FN/ys2h9ygUJezdCxqvFsvsfko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfBDOSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:18:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbfBDOSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:18:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9307E3E1E;
        Mon,  4 Feb 2019 14:18:13 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDC7078B28;
        Mon,  4 Feb 2019 14:18:11 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/3] perf tools: Add argument to hists__resort_cb_t callback
Date:   Mon,  4 Feb 2019 15:18:06 +0100
Message-Id: <20190204141808.23031-2-jolsa@kernel.org>
In-Reply-To: <20190204141808.23031-1-jolsa@kernel.org>
References: <20190204141808.23031-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 04 Feb 2019 14:18:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding argument to hists__resort_cb_t so we could pass
data from upper layers to callback function. It will be
used in following patches.

Link: http://lkml.kernel.org/n/tip-o5z31ieiejppymvebyv2u596@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.17.2

