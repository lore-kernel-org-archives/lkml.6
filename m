Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ByvREdznGFtETAAAmS7hNA
	; Thu, 07 Jun 2018 08:07:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3956E6089E; Thu,  7 Jun 2018 08:07:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8508C607F7;
	Thu,  7 Jun 2018 08:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8508C607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbeFGIHx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:07:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52725 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeFGIHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:07:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5787fKo2124310
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:07:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5787fg62124307;
        Thu, 7 Jun 2018 01:07:41 -0700
Date: Thu, 7 Jun 2018 01:07:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-m7tienxk7dijh5ln62yln1m9@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, dsahern@gmail.com,
        tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
        adrian.hunter@intel.com, mingo@kernel.org, namhyung@kernel.org,
        wangnan0@huawei.com, jolsa@kernel.org
Reply-To: linux-kernel@vger.kernel.org, dsahern@gmail.com,
          tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          adrian.hunter@intel.com, mingo@kernel.org, namhyung@kernel.org,
          wangnan0@huawei.com, jolsa@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Replace symbol__alloc_hists() with
 symbol__hists()
Git-Commit-ID: 14c8dde170cc1ba6754a1275ff378092ab36b257
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

Commit-ID:  14c8dde170cc1ba6754a1275ff378092ab36b257
Gitweb:     https://git.kernel.org/tip/14c8dde170cc1ba6754a1275ff378092ab36b257
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 17:33:18 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:52 -0300

perf annotate: Replace symbol__alloc_hists() with symbol__hists()

Its a bit shorter, so ditch the old symbol__alloc_hists() function.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-m7tienxk7dijh5ln62yln1m9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c          |  8 +-------
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/util/annotate.c        | 21 ++-------------------
 tools/perf/util/annotate.h        |  2 +-
 4 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index bc71e899096d..04fe04885e99 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -123,14 +123,9 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	}
 
 	notes = symbol__annotation(sym);
-	if (notes->src != NULL) {
-		pthread_mutex_lock(&notes->lock);
-		goto out_assign;
-	}
-
 	pthread_mutex_lock(&notes->lock);
 
-	if (symbol__alloc_hist(sym) < 0) {
+	if (!symbol__hists(sym, top->evlist->nr_entries)) {
 		pthread_mutex_unlock(&notes->lock);
 		pr_err("Not enough memory for annotating '%s' symbol!\n",
 		       sym->name);
@@ -140,7 +135,6 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 
 	err = symbol__annotate(sym, map, evsel, 0, NULL);
 	if (err == 0) {
-out_assign:
 		top->sym_filter_entry = he;
 	} else {
 		char msg[BUFSIZ];
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8be40fa903aa..3bfe17e176fe 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -410,7 +410,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	notes = symbol__annotation(dl->ops.target.sym);
 	pthread_mutex_lock(&notes->lock);
 
-	if (notes->src == NULL && symbol__alloc_hist(dl->ops.target.sym) < 0) {
+	if (!symbol__hists(dl->ops.target.sym, evsel->evlist->nr_entries)) {
 		pthread_mutex_unlock(&notes->lock);
 		ui__warning("Not enough memory for annotating '%s' symbol!\n",
 			    dl->ops.target.sym->name);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7c194b04a2da..bcd5d3e17b85 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -689,7 +689,7 @@ static struct annotated_source *annotated_source__new(void)
 	return src;
 }
 
-static void annotated_source__delete(struct annotated_source *src)
+static __maybe_unused void annotated_source__delete(struct annotated_source *src)
 {
 	if (src == NULL)
 		return;
@@ -729,23 +729,6 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 	return src->histograms ? 0 : -1;
 }
 
-int symbol__alloc_hist(struct symbol *sym)
-{
-	size_t size = symbol__size(sym);
-	struct annotation *notes = symbol__annotation(sym);
-
-	notes->src = annotated_source__new();
-	if (notes->src == NULL)
-		return -1;
-
-	if (annotated_source__alloc_histograms(notes->src, size, symbol_conf.nr_events) < 0) {
-		annotated_source__delete(notes->src);
-		notes->src = NULL;
-		return -1;
-	}
-	return 0;
-}
-
 /* The cycles histogram is lazily allocated. */
 static int symbol__alloc_hist_cycles(struct symbol *sym)
 {
@@ -868,7 +851,7 @@ alloc_cycles_hist:
 	return notes->src->cycles_hist;
 }
 
-static struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
+struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 2a73f9084930..7ad503fbff74 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -292,7 +292,7 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
 				 struct perf_evsel *evsel, u64 addr);
 
-int symbol__alloc_hist(struct symbol *sym);
+struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct symbol *sym, struct map *map,
