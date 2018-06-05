Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbeFER64 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751988AbeFERwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:14 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 31/46] perf hists: Do not allocate space for callchains for evsels without them
Date: Tue,  5 Jun 2018 14:50:15 -0300
Message-Id: <20180605175030.32549-32-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is another case were a big switch for callchains,
symbol_conf.use_callchain, is inconvenient, as we can have both events
with and without callchains, no point in checking a single switch to
decide to allocate space for callchains.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-62q64m7x7kqpb4g7boqc2nde@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 34864c87cd3c..496913eeed75 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -461,14 +461,19 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 					  bool sample_self)
 {
 	struct hist_entry_ops *ops = template->ops;
+	struct perf_evsel *evsel = hists_to_evsel(template->hists);
 	size_t callchain_size = 0;
 	struct hist_entry *he;
 	int err = 0;
 
 	if (!ops)
 		ops = template->ops = &default_ops;
-
-	if (symbol_conf.use_callchain)
+	/*
+	 * It is possible to have callchains for some evsels but not for others,
+	 * e.g.:  'perf record -e cycles,cache-misses/max-stack=10/', so lets
+	 * not waste space for that.
+	 */
+	if (symbol_conf.use_callchain && evsel__has_callchain(evsel))
 		callchain_size = sizeof(struct callchain_root);
 
 	he = ops->new(callchain_size);
-- 
2.14.3
