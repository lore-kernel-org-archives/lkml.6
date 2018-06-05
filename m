Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeFERwY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752769AbeFERwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:16 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 32/46] perf hists: Introduce hist_entry__has_callchain() method
Date: Tue,  5 Jun 2018 14:50:16 -0300
Message-Id: <20180605175030.32549-33-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll use this helper more frequently when reworking
symbol_conf.use_callchain logic, where knowing if a hist_entry has
callchains is the important bit, so make going from hist_entry to hists
to evsel easier, compact.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qg8nadz3p7fuufzjx1z2orf0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 3 +--
 tools/perf/util/sort.h | 6 ++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 496913eeed75..6173dd489f39 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -461,7 +461,6 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 					  bool sample_self)
 {
 	struct hist_entry_ops *ops = template->ops;
-	struct perf_evsel *evsel = hists_to_evsel(template->hists);
 	size_t callchain_size = 0;
 	struct hist_entry *he;
 	int err = 0;
@@ -473,7 +472,7 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 	 * e.g.:  'perf record -e cycles,cache-misses/max-stack=10/', so lets
 	 * not waste space for that.
 	 */
-	if (symbol_conf.use_callchain && evsel__has_callchain(evsel))
+	if (hist_entry__has_callchains(template) && symbol_conf.use_callchain)
 		callchain_size = sizeof(struct callchain_root);
 
 	he = ops->new(callchain_size);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index f007a26d6f6d..1a046157bfef 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -151,6 +151,12 @@ struct hist_entry {
 	struct callchain_root	callchain[0]; /* must be last member */
 };
 
+static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
+{
+	const struct perf_evsel *evsel = hists_to_evsel(he->hists);
+	return evsel__has_callchain(evsel);
+}
+
 static inline bool hist_entry__has_pairs(struct hist_entry *he)
 {
 	return !list_empty(&he->pairs.node);
-- 
2.14.3
