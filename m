Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85357C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B5F21D62
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wj4xXNXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B5F21D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbeHIRZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIRZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:04 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78E6214FF;
        Thu,  9 Aug 2018 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826786;
        bh=P+f/qyzcDoduA67QUUnfkbKzx0enn64R47F31g970vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wj4xXNXFZdiVdDi7M4Wf6syOTG4WygUuWycXHLVJGg8GEcXMJNmhvj0SOo9GjBnbn
         NX/JLiArxxhmVR3VEoepGAp2lbF3z0MyP2R6HeD7dMimKo83+aUCZusDreKF//Q8nu
         yW4NbvVcONfEny4zu4+rKxQZ6jVAXeRGLznhqcz4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/44] perf annotate: Get rid of annotation__scnprintf_samples_period()
Date:   Thu,  9 Aug 2018 11:57:53 -0300
Message-Id: <20180809145822.21391-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We have more current function tto get the title for annotation,
which is hists__scnprintf_title. They both have same output as
far as the annotation's header line goes.

They differ in counting of the nr_samples, hists__scnprintf_title
provides more accurate number based on the setup of the
symbol_conf.filter_relative variable.

Plus it also displays any uid/thread/dso/socket filters/zooms
if there are set any, which annotation__scnprintf_samples_period
does not.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  3 +--
 tools/perf/util/annotate.c        | 44 ++-------------------------------------
 tools/perf/util/annotate.h        |  7 -------
 3 files changed, 3 insertions(+), 51 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3b4f1c10ff57..d264916d2648 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -624,8 +624,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 	char title[256];
 	int key;
 
-	annotation__scnprintf_samples_period(notes, title, sizeof(title), evsel);
-
+	hists__scnprintf_title(hists, title, sizeof(title));
 	if (annotate_browser__show(&browser->b, title, help) < 0)
 		return -1;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 956c9b19d81c..0d40cee13f6b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2389,7 +2389,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 {
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
-	struct annotation *notes = symbol__annotation(sym);
+	struct hists *hists = evsel__hists(evsel);
 	char buf[1024];
 
 	if (symbol__annotate2(sym, map, evsel, opts, NULL) < 0)
@@ -2401,7 +2401,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 		print_summary(&source_line, dso->long_name);
 	}
 
-	annotation__scnprintf_samples_period(notes, buf, sizeof(buf), evsel);
+	hists__scnprintf_title(hists, buf, sizeof(buf));
 	fprintf(stdout, "%s\n%s() %s\n", buf, sym->name, dso->long_name);
 	symbol__annotate_fprintf2(sym, stdout);
 
@@ -2689,46 +2689,6 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 	return -1;
 }
 
-int __annotation__scnprintf_samples_period(struct annotation *notes,
-					   char *bf, size_t size,
-					   struct perf_evsel *evsel,
-					   bool show_freq)
-{
-	const char *ev_name = perf_evsel__name(evsel);
-	char buf[1024], ref[30] = " show reference callgraph, ";
-	char sample_freq_str[64] = "";
-	unsigned long nr_samples = 0;
-	int nr_members = 1;
-	bool enable_ref = false;
-	u64 nr_events = 0;
-	char unit;
-	int i;
-
-	if (perf_evsel__is_group_event(evsel)) {
-		perf_evsel__group_desc(evsel, buf, sizeof(buf));
-		ev_name = buf;
-                nr_members = evsel->nr_members;
-	}
-
-	for (i = 0; i < nr_members; i++) {
-		struct sym_hist *ah = annotation__histogram(notes, evsel->idx + i);
-
-		nr_samples += ah->nr_samples;
-		nr_events  += ah->period;
-	}
-
-	if (symbol_conf.show_ref_callgraph && strstr(ev_name, "call-graph=no"))
-		enable_ref = true;
-
-	if (show_freq)
-		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
-
-	nr_samples = convert_unit(nr_samples, &unit);
-	return scnprintf(bf, size, "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
-			 nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
-			 ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
-}
-
 #define ANNOTATION__CFG(n) \
 	{ .name = #n, .value = &annotation__default_options.n, }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index a93502d0c582..d06f14c656c6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -177,13 +177,6 @@ int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   struct perf_evsel *evsel,
 					   bool show_freq);
 
-static inline int annotation__scnprintf_samples_period(struct annotation *notes,
-						       char *bf, size_t size,
-						       struct perf_evsel *evsel)
-{
-	return __annotation__scnprintf_samples_period(notes, bf, size, evsel, true);
-}
-
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
-- 
2.14.4

