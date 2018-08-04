Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66849C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4D6217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4D6217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbeHDPGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20D2B8185342;
        Sat,  4 Aug 2018 13:05:29 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3CCA215670D;
        Sat,  4 Aug 2018 13:05:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 03/20] perf annotate: Get rid of annotation__scnprintf_samples_period
Date:   Sat,  4 Aug 2018 15:05:04 +0200
Message-Id: <20180804130521.11408-4-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:29 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have more current function tto get the title for annotation,
which is hists__scnprintf_title. They both have same output as
far as the annotation's header line goes.

They differ in counting of the nr_samples, hists__scnprintf_title
provides more accurate number based on the setup of the
symbol_conf.filter_relative variable.

Plus it also displays any uid/thread/dso/socket filters/zooms
if there are set any, which annotation__scnprintf_samples_period
does not.

Link: http://lkml.kernel.org/n/tip-62qw9sep9mqep1qtvlns0dww@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/ui/browsers/annotate.c |  3 +--
 tools/perf/util/annotate.c        | 44 ++-----------------------------
 tools/perf/util/annotate.h        |  7 -----
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
2.17.1

