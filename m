Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A890C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1BA20894
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWeNuO7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1BA20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbeGYTNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYTNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:13:20 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A256A2088E;
        Wed, 25 Jul 2018 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541634;
        bh=/iZxqnAKbx0ZEKxnFej3BvyZn8B4ZVaQEaufDpEEnxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWeNuO7S7W9v3A3Kw0sKzd0Vj3PhOHisyfE+ODwPY5E7s19YitUsMKjLzKmABoHF8
         GAVWtuzSafzRMWyN/dV23DgA+beYcXV1vBM5gBcwBhhlEBv3ewVgMB85Xnh1aRpmjH
         twMbC0/jp13/KZyIykXltFgLZl25TLlhVux95XbA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 02/27] perf hists: Clarify callchain disabling when available
Date:   Wed, 25 Jul 2018 14:59:36 -0300
Message-Id: <20180725180001.15108-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We want to allow having mixed events with/without callchains, not
using a global flag to show callchains, but allowing supressing
callchains when they are present.

So invert the logic of the last parameter to hists__fprint() to
that effect.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ohqyisr6qge79qa95ojslptx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c    | 4 ++--
 tools/perf/builtin-diff.c   | 2 +-
 tools/perf/builtin-report.c | 4 ++--
 tools/perf/builtin-top.c    | 2 +-
 tools/perf/ui/stdio/hist.c  | 8 ++++----
 tools/perf/util/hist.h      | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 6a8738f7ead3..f2ea85ee573f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2193,7 +2193,7 @@ static void print_cacheline(struct c2c_hists *c2c_hists,
 	fprintf(out, "%s\n", bf);
 	fprintf(out, "  -------------------------------------------------------------\n");
 
-	hists__fprintf(&c2c_hists->hists, false, 0, 0, 0, out, true);
+	hists__fprintf(&c2c_hists->hists, false, 0, 0, 0, out, false);
 }
 
 static void print_pareto(FILE *out)
@@ -2268,7 +2268,7 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	fprintf(out, "=================================================\n");
 	fprintf(out, "#\n");
 
-	hists__fprintf(&c2c.hists.hists, true, 0, 0, 0, stdout, false);
+	hists__fprintf(&c2c.hists.hists, true, 0, 0, 0, stdout, true);
 
 	fprintf(out, "\n");
 	fprintf(out, "=================================================\n");
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index d660cb7b222b..39db2ee32d48 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -696,7 +696,7 @@ static void hists__process(struct hists *hists)
 	hists__output_resort(hists, NULL);
 
 	hists__fprintf(hists, !quiet, 0, 0, 0, stdout,
-		       symbol_conf.use_callchain);
+		       !symbol_conf.use_callchain);
 }
 
 static void data__fprintf(void)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c04dc7b53797..02f7a3c27761 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -478,8 +478,8 @@ static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
 
 		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
 		hists__fprintf(hists, !quiet, 0, 0, rep->min_percent, stdout,
-			       symbol_conf.use_callchain ||
-			       symbol_conf.show_branchflag_count);
+			       !(symbol_conf.use_callchain ||
+			         symbol_conf.show_branchflag_count));
 		fprintf(stdout, "\n\n");
 	}
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ffdc2769ff9f..d21d8751e749 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -307,7 +307,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
 	hists__output_recalc_col_len(hists, top->print_entries - printed);
 	putchar('\n');
 	hists__fprintf(hists, false, top->print_entries - printed, win_width,
-		       top->min_percent, stdout, symbol_conf.use_callchain);
+		       top->min_percent, stdout, !symbol_conf.use_callchain);
 }
 
 static void prompt_integer(int *target, const char *msg)
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 69b7a28f7a1c..74c4ae1f0a05 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -529,7 +529,7 @@ static int hist_entry__hierarchy_fprintf(struct hist_entry *he,
 
 static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 			       char *bf, size_t bfsz, FILE *fp,
-			       bool use_callchain)
+			       bool ignore_callchains)
 {
 	int ret;
 	int callchain_ret = 0;
@@ -550,7 +550,7 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 
 	ret = fprintf(fp, "%s\n", bf);
 
-	if (hist_entry__has_callchains(he) && use_callchain)
+	if (hist_entry__has_callchains(he) && !ignore_callchains)
 		callchain_ret = hist_entry_callchain__fprintf(he, total_period,
 							      0, fp);
 
@@ -755,7 +755,7 @@ int hists__fprintf_headers(struct hists *hists, FILE *fp)
 
 size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		      int max_cols, float min_pcnt, FILE *fp,
-		      bool use_callchain)
+		      bool ignore_callchains)
 {
 	struct rb_node *nd;
 	size_t ret = 0;
@@ -799,7 +799,7 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		if (percent < min_pcnt)
 			continue;
 
-		ret += hist_entry__fprintf(h, max_cols, line, linesz, fp, use_callchain);
+		ret += hist_entry__fprintf(h, max_cols, line, linesz, fp, ignore_callchains);
 
 		if (max_rows && ++nr_rows >= max_rows)
 			break;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 73049f7f0f60..3badd7f1e1b8 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -181,7 +181,7 @@ size_t events_stats__fprintf(struct events_stats *stats, FILE *fp);
 
 size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		      int max_cols, float min_pcnt, FILE *fp,
-		      bool use_callchain);
+		      bool ignore_callchains);
 size_t perf_evlist__fprintf_nr_events(struct perf_evlist *evlist, FILE *fp);
 
 void hists__filter_by_dso(struct hists *hists);
-- 
2.14.4

