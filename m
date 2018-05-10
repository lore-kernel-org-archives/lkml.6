Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933743AbeEJGFc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 02:05:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:10754 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeEJGFa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 02:05:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,384,1520924400";
   d="scan'208";a="53061509"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf annotate: Support multiple events without group
Date: Thu, 10 May 2018 21:59:22 +0800
Message-Id: <1525960762-19520-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See example,

perf record -e cycles,branches ./div
perf annotate main --stdio or
perf annotate main --stdio2 or
perf annotate main

The "perf annotate" should show both cycles and branches on the
left side, but actually it only shows one event cycles.

It works with events group like:
perf record -e "{cycles,branches}" ./div

It should work too even without group.

This patch uses 'symbol_conf.nr_events > 1' to check if it's the
multiple events case.

With this patch,

perf record -e cycles,branches ./div
perf annotate main --stdio2

  ......
                           for (i = 0; i < 2000000000; i++) {
                                   flag = compute_flag();
  4.85   5.83  38:   xor    %eax,%eax
  0.01   0.01      → callq  compute_flag

                                   count++;
  4.44   2.27        mov    count,%edx
  0.00   0.00        add    $0x1,%edx
  ......

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/annotate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5d74a30..ca8d4b1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1054,6 +1054,8 @@ annotation_line__new(struct annotate_args *args, size_t privsize)
 
 	if (perf_evsel__is_group_event(evsel))
 		nr = evsel->nr_members;
+	else if (symbol_conf.nr_events > nr)
+		nr = symbol_conf.nr_events;
 
 	size += sizeof(al->samples[0]) * nr;
 
@@ -1326,6 +1328,8 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 
 		if (perf_evsel__is_group_event(evsel))
 			width *= evsel->nr_members;
+		else if (symbol_conf.nr_events > 1)
+			width *= symbol_conf.nr_events;
 
 		if (!*al->line)
 			printf(" %*s:\n", width, " ");
@@ -1967,6 +1971,8 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 
 	if (perf_evsel__is_group_event(evsel))
 		width *= evsel->nr_members;
+	else if (symbol_conf.nr_events > 1)
+		width *= symbol_conf.nr_events;
 
 	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
 				  width, width, symbol_conf.show_total_period ? "Period" :
@@ -2578,6 +2584,8 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->nr_members;
+	else if (symbol_conf.nr_events > nr_pcnt)
+		nr_pcnt = symbol_conf.nr_events;
 
 	err = symbol__annotate(sym, map, evsel, 0, parch);
 	if (err)
-- 
2.7.4
