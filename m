Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B55AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBA720671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBA720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbeGYVyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:54:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeGYVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:54:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKePun498453
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:40:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKePat498450;
        Wed, 25 Jul 2018 13:40:25 -0700
Date:   Wed, 25 Jul 2018 13:40:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ohqyisr6qge79qa95ojslptx@git.kernel.org>
Cc:     namhyung@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        mingo@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, wangnan0@huawei.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, wangnan0@huawei.com,
          dsahern@gmail.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
          namhyung@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf hists: Clarify callchain disabling when
 available
Git-Commit-ID: e9de7e2f7e22989fefc760cf0920062c58b2b2b1
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

Commit-ID:  e9de7e2f7e22989fefc760cf0920062c58b2b2b1
Gitweb:     https://git.kernel.org/tip/e9de7e2f7e22989fefc760cf0920062c58b2b2b1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 20 Jun 2018 15:58:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:37:33 -0300

perf hists: Clarify callchain disabling when available

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
@@ -529,7 +529,7 @@ out:
 
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
