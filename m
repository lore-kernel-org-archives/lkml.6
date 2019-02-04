Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10880C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58B52082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549289903;
	bh=nQB1eu1KmrS7msg8qMlkYuUL5gK1cNOwE8Bt07iYhdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hg76D1Evb1L5tZVqayehaplbiwrSL2+u2X3Q8//Jue5Ay8Ev13M6Me8EcfnfcosJQ
	 SZEnxqj0gnblWaCgIp1g1PgiBKu2QbKGfFo8HpDprRnRqHL/4n3+T5OG0nOA4FHxWG
	 jfmAUDItAMHOR2imCPrFSP3qtVHu6h7brJUwM4jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfBDOSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:18:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbfBDOSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:18:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09BBC8764F;
        Mon,  4 Feb 2019 14:18:18 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EFC078B59;
        Mon,  4 Feb 2019 14:18:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/3] perf tools: Move symbol annotation to resort
Date:   Mon,  4 Feb 2019 15:18:08 +0100
Message-Id: <20190204141808.23031-4-jolsa@kernel.org>
In-Reply-To: <20190204141808.23031-1-jolsa@kernel.org>
References: <20190204141808.23031-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 04 Feb 2019 14:18:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the we make annotation for ipc column during the
entry display, already outside the progress bar scope, so
it appears like perf report is stuck.

Moving the annotation retrieval to the resort phase, so all
the data are ready for display.

Link: http://lkml.kernel.org/n/tip-gvqlawikmwbg5iq7f6gyuesy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c | 21 +++++++++++++++++++--
 tools/perf/util/sort.c      |  7 -------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index a007ea9a3874..2e8c74d6430c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -616,6 +616,21 @@ static int report__collapse_hists(struct report *rep)
 	return ret;
 }
 
+static int hists__resort_cb(struct hist_entry *he, void *arg)
+{
+	struct report *rep = arg;
+	struct symbol *sym = he->ms.sym;
+
+	if (rep->symbol_ipc && sym && !sym->annotate2) {
+		struct perf_evsel *evsel = hists_to_evsel(he->hists);
+
+		symbol__annotate2(sym, he->ms.map, evsel,
+				  &annotation__default_options, NULL);
+	}
+
+	return 0;
+}
+
 static void report__output_resort(struct report *rep)
 {
 	struct ui_progress prog;
@@ -623,8 +638,10 @@ static void report__output_resort(struct report *rep)
 
 	ui_progress__init(&prog, rep->nr_entries, "Sorting events for output...");
 
-	evlist__for_each_entry(rep->session->evlist, pos)
-		perf_evsel__output_resort(pos, &prog);
+	evlist__for_each_entry(rep->session->evlist, pos) {
+		perf_evsel__output_resort_cb(pos, &prog,
+					     hists__resort_cb, rep);
+	}
 
 	ui_progress__finish();
 }
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 79e794406bef..2b6c1ccb878c 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -429,8 +429,6 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 {
 
 	struct symbol *sym = he->ms.sym;
-	struct map *map = he->ms.map;
-	struct perf_evsel *evsel = hists_to_evsel(he->hists);
 	struct annotation *notes;
 	double ipc = 0.0, coverage = 0.0;
 	char tmp[64];
@@ -438,11 +436,6 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 	if (!sym)
 		return repsep_snprintf(bf, size, "%-*s", width, "-");
 
-	if (!sym->annotate2 && symbol__annotate2(sym, map, evsel,
-		&annotation__default_options, NULL) < 0) {
-		return 0;
-	}
-
 	notes = symbol__annotation(sym);
 
 	if (notes->hit_cycles)
-- 
2.17.2

