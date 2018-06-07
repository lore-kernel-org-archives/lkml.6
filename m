Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WTVbIq/nGFu/SgAAmS7hNA
	; Thu, 07 Jun 2018 08:11:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 369FA6089E; Thu,  7 Jun 2018 08:11:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6E47060115;
	Thu,  7 Jun 2018 08:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E47060115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeFGILf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:11:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbeFGILd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:11:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578BMmE2124782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:11:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578BMcx2124779;
        Thu, 7 Jun 2018 01:11:22 -0700
Date: Thu, 7 Jun 2018 01:11:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vpr7ys7ggvs2fzpg8wbjcw7e@git.kernel.org>
Cc: adrian.hunter@intel.com, jolsa@kernel.org, hpa@zytor.com,
        dsahern@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
        acme@redhat.com
Reply-To: tglx@linutronix.de, acme@redhat.com, wangnan0@huawei.com,
          namhyung@kernel.org, dsahern@gmail.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
          adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Pass annotation_options to
 symbol__annotate()
Git-Commit-ID: 380195e2b07b123fb2cd701bd60e78a31fbf3b25
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

Commit-ID:  380195e2b07b123fb2cd701bd60e78a31fbf3b25
Gitweb:     https://git.kernel.org/tip/380195e2b07b123fb2cd701bd60e78a31fbf3b25
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 11:27:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:53 -0300

perf annotate: Pass annotation_options to symbol__annotate()

Now all callers to symbol__disassemble() can hand it the per-tool
annotation_options, which will allow us to remove lots of stuff
from symbol_options, the kitchen sink of perf configs, reducing its
size and getting annotation specific stuff grouped together.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vpr7ys7ggvs2fzpg8wbjcw7e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c     | 2 +-
 tools/perf/ui/gtk/annotate.c | 2 +-
 tools/perf/util/annotate.c   | 7 +++++--
 tools/perf/util/annotate.h   | 1 +
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5e58cd4de90b..2c14ca61c657 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -133,7 +133,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(sym, map, evsel, 0, NULL);
+	err = symbol__annotate(sym, map, evsel, 0, &top->annotation_opts, NULL);
 	if (err == 0) {
 		top->sym_filter_entry = he;
 	} else {
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index aeeaf15029f0..48428c9acd89 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -169,7 +169,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(sym, map, evsel, 0, NULL);
+	err = symbol__annotate(sym, map, evsel, 0, &annotation__default_options, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index abcc7e24c365..502f9d124a44 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1067,6 +1067,7 @@ struct annotate_args {
 	struct arch		*arch;
 	struct map_symbol	 ms;
 	struct perf_evsel	*evsel;
+	struct annotation_options *options;
 	s64			 offset;
 	char			*line;
 	int			 line_nr;
@@ -1803,11 +1804,13 @@ void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel)
 
 int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct perf_evsel *evsel, size_t privsize,
+		     struct annotation_options *options,
 		     struct arch **parch)
 {
 	struct annotate_args args = {
 		.privsize	= privsize,
 		.evsel		= evsel,
+		.options	= options,
 	};
 	struct perf_env *env = perf_evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
@@ -2409,7 +2412,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
 
-	if (symbol__annotate(sym, map, evsel, 0, NULL) < 0)
+	if (symbol__annotate(sym, map, evsel, 0, opts, NULL) < 0)
 		return -1;
 
 	symbol__calc_percent(sym, evsel);
@@ -2655,7 +2658,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->nr_members;
 
-	err = symbol__annotate(sym, map, evsel, 0, parch);
+	err = symbol__annotate(sym, map, evsel, 0, options, parch);
 	if (err)
 		goto out_free_offsets;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 20f3326cc640..013d414b0e57 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -306,6 +306,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct perf_evsel *evsel, size_t privsize,
+		     struct annotation_options *options,
 		     struct arch **parch);
 int symbol__annotate2(struct symbol *sym, struct map *map,
 		      struct perf_evsel *evsel,
