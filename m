Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbeFESDu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752382AbeFERv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:29 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 16/46] perf annotate: Add comment about annotated_src->nr_histograms
Date: Tue,  5 Jun 2018 14:50:00 -0300
Message-Id: <20180605175030.32549-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we have multiple groups in an evlist, say:

  $ perf stat -e '{cycles,instructions},{cache-references,cache-misses}' sleep 1

   Performance counter stats for 'sleep 1':

           343,134      cycles:u
           249,292      instructions:u            #    0.73  insn per cycle
            15,556      cache-references:u
             8,925      cache-misses:u            #   57.373 % of all cache refs

       1.000957550 seconds time elapsed

  $

Then the perf_evsel instances for the two group leaders ("cycles" and
"cache-references") will have evsel->nr_members set to 2, while all the
evsel->evlist->nr_entries will be set to 4, so we can't use
evsel->evlist->nr_entries everywhere, as event groups need to be taken
into account.

But this probably requires us to audit at least the forced-group code,
where we want all of the events to be in a "group", to see them all in
the screen, one column for each, even knowing that they were not
necessarily scheduled to count at the same time by the kernel perf
subsystem.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2g0vwqnc49wl4ttjk8dvpgcc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 7ad503fbff74..3dc4ca1d6c08 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -202,6 +202,10 @@ struct cyc_hist {
 /** struct annotated_source - symbols with hits have this attached as in sannotation
  *
  * @histograms: Array of addr hit histograms per event being monitored
+ * nr_histograms: This may not be the same as evsel->evlist->nr_entries if
+ * 		  we have more than a group in a evlist, where we will want
+ * 		  to see each group separately, that is why symbol__annotate2()
+ * 		  sets src->nr_histograms to evsel->nr_members.
  * @lines: If 'print_lines' is specified, per source code line percentages
  * @source: source parsed from a disassembler like objdump -dS
  * @cyc_hist: Average cycles per basic block
-- 
2.14.3
