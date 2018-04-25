Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbeDYQA7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755770AbeDYQAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:00:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBAA217D9
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
Subject: [PATCH 09/12] perf pmu: Fix core PMU alias list for X86 platform
Date: Wed, 25 Apr 2018 13:00:05 -0300
Message-Id: <20180425160008.3407-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425160008.3407-1-acme@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When counting uncore event with alias, core event is mistakenly
involved, for example:

  perf stat --no-merge -e "unc_m_cas_count.all" -C0  sleep 1

  Performance counter stats for 'CPU(s) 0':

                 0      unc_m_cas_count.all [uncore_imc_4]
                 0      unc_m_cas_count.all [uncore_imc_2]
                 0      unc_m_cas_count.all [uncore_imc_0]
           153,640      unc_m_cas_count.all [cpu]
                 0      unc_m_cas_count.all [uncore_imc_5]
            25,026      unc_m_cas_count.all [uncore_imc_3]
                 0      unc_m_cas_count.all [uncore_imc_1]

       1.001447890 seconds time elapsed

The reason is that current implementation doesn't check PMU name of a
event when adding its alias into the alias list for core PMU. The
uncore event aliases are mistakenly added.

This bug was introduced in:
  commit 14b22ae028de ("perf pmu: Add helper function is_pmu_core to
  detect PMU CORE devices")

Checking the PMU name for all PMUs on X86 and other architectures except
ARM.
There is no behavior change for ARM.

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
Fixes: 14b22ae028de ("perf pmu: Add helper function is_pmu_core to detect PMU CORE devices")
Link: http://lkml.kernel.org/r/1524594014-79243-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index af4bedf4cf98..d2fb597c9a8c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -539,9 +539,10 @@ static bool pmu_is_uncore(const char *name)
 
 /*
  *  PMU CORE devices have different name other than cpu in sysfs on some
- *  platforms. looking for possible sysfs files to identify as core device.
+ *  platforms.
+ *  Looking for possible sysfs files to identify the arm core device.
  */
-static int is_pmu_core(const char *name)
+static int is_arm_pmu_core(const char *name)
 {
 	struct stat st;
 	char path[PATH_MAX];
@@ -550,12 +551,6 @@ static int is_pmu_core(const char *name)
 	if (!sysfs)
 		return 0;
 
-	/* Look for cpu sysfs (x86 and others) */
-	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu", sysfs);
-	if ((stat(path, &st) == 0) &&
-			(strncmp(name, "cpu", strlen("cpu")) == 0))
-		return 1;
-
 	/* Look for cpu sysfs (specific to arm) */
 	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
 				sysfs, name);
@@ -668,6 +663,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	struct pmu_events_map *map;
 	struct pmu_event *pe;
 	const char *name = pmu->name;
+	const char *pname;
 
 	map = perf_pmu__find_map(pmu);
 	if (!map)
@@ -686,11 +682,9 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 			break;
 		}
 
-		if (!is_pmu_core(name)) {
-			/* check for uncore devices */
-			if (pe->pmu == NULL)
-				continue;
-			if (strncmp(pe->pmu, name, strlen(pe->pmu)))
+		if (!is_arm_pmu_core(name)) {
+			pname = pe->pmu ? pe->pmu : "cpu";
+			if (strncmp(pname, name, strlen(pname)))
 				continue;
 		}
 
-- 
2.14.3
