Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755638AbeDYQBY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932099AbeDYQA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:00:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A317421838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/12] perf stat: Fix duplicate PMU name for interval print
Date: Wed, 25 Apr 2018 13:00:08 -0300
Message-Id: <20180425160008.3407-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425160008.3407-1-acme@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

PMU name is printed repeatedly for interval print, for example:

  perf stat --no-merge -e 'unc_m_clockticks' -a -I 1000
  #           time             counts unit events
     1.001053069        243,702,144      unc_m_clockticks [uncore_imc_4]
     1.001053069        244,268,304      unc_m_clockticks [uncore_imc_2]
     1.001053069        244,427,386      unc_m_clockticks [uncore_imc_0]
     1.001053069        244,583,760      unc_m_clockticks [uncore_imc_5]
     1.001053069        244,738,971      unc_m_clockticks [uncore_imc_3]
     1.001053069        244,880,309      unc_m_clockticks [uncore_imc_1]
     2.002024821        240,818,200      unc_m_clockticks [uncore_imc_4] [uncore_imc_4]
     2.002024821        240,767,812      unc_m_clockticks [uncore_imc_2] [uncore_imc_2]
     2.002024821        240,764,215      unc_m_clockticks [uncore_imc_0] [uncore_imc_0]
     2.002024821        240,759,504      unc_m_clockticks [uncore_imc_5] [uncore_imc_5]
     2.002024821        240,755,992      unc_m_clockticks [uncore_imc_3] [uncore_imc_3]
     2.002024821        240,750,403      unc_m_clockticks [uncore_imc_1] [uncore_imc_1]

For each print, the PMU name is unconditionally appended to the
counter->name.

Need to check the counter->name first. If the PMU name is already
appended, do nothing.

Committer notes:

Add and use perf_evsel->uniquified_name bool instead of doing the more
expensive strstr(event->name, pmu->name).

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 8c5421c016a4 ("perf pmu: Display pmu name when printing unmerged events in stat")
Link: http://lkml.kernel.org/r/1524594014-79243-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++++-
 tools/perf/util/evsel.h   | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 30e6b374e095..f17dc601b0f3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1284,7 +1284,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
 	char *new_name;
 	char *config;
 
-	if (!counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
+	if (counter->uniquified_name ||
+	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
 					   strlen(counter->pmu_name)))
 		return;
 
@@ -1302,6 +1303,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
 			counter->name = new_name;
 		}
 	}
+
+	counter->uniquified_name = true;
 }
 
 static void collect_all_aliases(struct perf_evsel *counter,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d3ee3af618ef..92ec009a292d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -115,6 +115,7 @@ struct perf_evsel {
 	unsigned int		sample_size;
 	int			id_pos;
 	int			is_pos;
+	bool			uniquified_name;
 	bool			snapshot;
 	bool 			supported;
 	bool 			needs_swap;
-- 
2.14.3
