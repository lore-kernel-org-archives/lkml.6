Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeDZF7W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:59:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeDZF7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:59:19 -0400
Date: Wed, 25 Apr 2018 22:57:51 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-80ee8c588afde077cb0439e15129579a267916c4@git.kernel.org>
Cc: zhangshaokun@hisilicon.com, tglx@linutronix.de, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, hpa@zytor.com, jolsa@redhat.com,
        ak@linux.intel.com, acme@redhat.com, peterz@infradead.org,
        will.deacon@arm.com, yao.jin@linux.intel.com, mingo@kernel.org,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        agustinv@codeaurora.org
Reply-To: zhangshaokun@hisilicon.com, tglx@linutronix.de, namhyung@kernel.org,
        hpa@zytor.com, jolsa@redhat.com, ganapatrao.kulkarni@cavium.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, will.deacon@arm.com,
        peterz@infradead.org, acme@redhat.com, agustinv@codeaurora.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com
In-Reply-To: <1524594014-79243-5-git-send-email-kan.liang@linux.intel.com>
References: <1524594014-79243-5-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Fix duplicate PMU name for interval
 print
Git-Commit-ID: 80ee8c588afde077cb0439e15129579a267916c4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  80ee8c588afde077cb0439e15129579a267916c4
Gitweb:     https://git.kernel.org/tip/80ee8c588afde077cb0439e15129579a267916c4
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 24 Apr 2018 11:20:14 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Apr 2018 16:12:00 -0300

perf stat: Fix duplicate PMU name for interval print

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
