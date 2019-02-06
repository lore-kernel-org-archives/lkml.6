Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CD720823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479069;
	bh=JUOC/pQwfJcp4lm1AESFYNxh400PhosDoclyJdtt8U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gO2v7ssO8y1bFNINc0q0sC1DQB5QMZ8bJluBU8rkTJWKgXiRLANNaWBp8wNwqFl8f
	 /NA/nM5RCEhpAr0J4jZVV0/S8I+Dobbbobn5CWIyKTu0NFhhQlLxe95zUvIqMOoYse
	 XxLIt42zjYnNeAdLES37f/LuSuuSnMfEsHWuFfcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfBFSvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfBFSvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:06 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA36206DD;
        Wed,  6 Feb 2019 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479064;
        bh=JUOC/pQwfJcp4lm1AESFYNxh400PhosDoclyJdtt8U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+j2JiT2dRIdRxWDVzLrIQkFjS37RdtOxD80dLHxJ1afCCwQQrrD7QL7rSy3M79J2
         m4pTtsrQSVndJjamYo7AWw9hZBF5KNJ7vm6W2GWcYFewi2Wzc8Nlkh8UUD13a/XIPk
         YC55nXVsM9vY3alnCdOt9LKtzOfZL1F4pSvRepGw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/53] perf report: Move symbol annotation to the resort phase
Date:   Wed,  6 Feb 2019 15:48:44 -0300
Message-Id: <20190206184903.24054-35-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently we make the annotation for the IPC column during the entry
display, already outside of the progress bar scope, so it appears like
'perf report' is stuck.

Move the annotation retrieval to the resort phase, so that all the data
are ready for display.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190204141808.23031-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

