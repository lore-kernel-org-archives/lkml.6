Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbeDXSVV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:21:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:3127 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752198AbeDXSVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:21:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="35837977"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, ganapatrao.kulkarni@cavium.com,
        zhangshaokun@hisilicon.com, yao.jin@linux.intel.com,
        will.deacon@arm.com, ak@linux.intel.com, agustinv@codeaurora.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/5] perf stat: Fix duplicate PMU name for interval print
Date: Tue, 24 Apr 2018 11:20:14 -0700
Message-Id: <1524594014-79243-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
References: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
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
     2.002024821        240,818,200      unc_m_clockticks [uncore_imc_4]
[uncore_imc_4]
     2.002024821        240,767,812      unc_m_clockticks [uncore_imc_2]
[uncore_imc_2]
     2.002024821        240,764,215      unc_m_clockticks [uncore_imc_0]
[uncore_imc_0]
     2.002024821        240,759,504      unc_m_clockticks [uncore_imc_5]
[uncore_imc_5]
     2.002024821        240,755,992      unc_m_clockticks [uncore_imc_3]
[uncore_imc_3]
     2.002024821        240,750,403      unc_m_clockticks [uncore_imc_1]
[uncore_imc_1]

For each print, the PMU name is unconditionally appended to the
counter->name.
Need to check the counter->name first. If the PMU name is already
appended, do nothing.

Fixes: 8c5421c016a4 ("perf pmu: Display pmu name when printing unmerged events in stat")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 30e6b37..e22c213 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1296,6 +1296,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
 			counter->name = new_name;
 		}
 	} else {
+		if (strstr(counter->name, counter->pmu_name))
+			return;
 		if (asprintf(&new_name,
 			     "%s [%s]", counter->name, counter->pmu_name) > 0) {
 			free(counter->name);
-- 
2.7.4
