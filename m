Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeDXSUz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:20:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:3113 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbeDXSUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:20:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="35837883"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, ganapatrao.kulkarni@cavium.com,
        zhangshaokun@hisilicon.com, yao.jin@linux.intel.com,
        will.deacon@arm.com, ak@linux.intel.com, agustinv@codeaurora.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/5] perf pmu: Fix core PMU alias list for X86 platform
Date: Tue, 24 Apr 2018 11:20:10 -0700
Message-Id: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
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

Fixes: 14b22ae028de ("perf pmu: Add helper function is_pmu_core to detect PMU CORE devices")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 064bdcb..0df2a02 100644
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
@@ -662,6 +657,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	struct pmu_events_map *map;
 	struct pmu_event *pe;
 	const char *name = pmu->name;
+	const char *pname;
 
 	map = perf_pmu__find_map(pmu);
 	if (!map)
@@ -680,11 +676,9 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
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
2.7.4
