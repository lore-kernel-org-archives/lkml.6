Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeBQLms (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:42:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43995 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeBQLmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:42:45 -0500
Date: Sat, 17 Feb 2018 03:30:23 -0800
From: tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-796bfadd831bdef0de06cd0253398c3fe011e459@git.kernel.org>
Cc: jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com
Reply-To: alexander.shishkin@linux.intel.com, acme@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@redhat.com, mathieu.poirier@linaro.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1518478737-24649-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518478737-24649-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Properly deal with cpu maps
Git-Commit-ID: 796bfadd831bdef0de06cd0253398c3fe011e459
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

Commit-ID:  796bfadd831bdef0de06cd0253398c3fe011e459
Gitweb:     https://git.kernel.org/tip/796bfadd831bdef0de06cd0253398c3fe011e459
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Mon, 12 Feb 2018 16:38:57 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:41 -0300

perf cs-etm: Properly deal with cpu maps

This patch allows the CoreSight AUX info section to fit topologies where
only a subset of all available CPUs are present, avoiding at the same
time accessing the ETM configuration areas of CPUs that have been
offlined.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1518478737-24649-1-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 51 +++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index fbfc055..5c655ad 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -298,12 +298,17 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 {
 	int i;
 	int etmv3 = 0, etmv4 = 0;
-	const struct cpu_map *cpus = evlist->cpus;
+	struct cpu_map *event_cpus = evlist->cpus;
+	struct cpu_map *online_cpus = cpu_map__new(NULL);
 
 	/* cpu map is not empty, we have specific CPUs to work with */
-	if (!cpu_map__empty(cpus)) {
-		for (i = 0; i < cpu_map__nr(cpus); i++) {
-			if (cs_etm_is_etmv4(itr, cpus->map[i]))
+	if (!cpu_map__empty(event_cpus)) {
+		for (i = 0; i < cpu__max_cpu(); i++) {
+			if (!cpu_map__has(event_cpus, i) ||
+			    !cpu_map__has(online_cpus, i))
+				continue;
+
+			if (cs_etm_is_etmv4(itr, i))
 				etmv4++;
 			else
 				etmv3++;
@@ -311,6 +316,9 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	} else {
 		/* get configuration for all CPUs in the system */
 		for (i = 0; i < cpu__max_cpu(); i++) {
+			if (!cpu_map__has(online_cpus, i))
+				continue;
+
 			if (cs_etm_is_etmv4(itr, i))
 				etmv4++;
 			else
@@ -318,6 +326,8 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		}
 	}
 
+	cpu_map__put(online_cpus);
+
 	return (CS_ETM_HEADER_SIZE +
 	       (etmv4 * CS_ETMV4_PRIV_SIZE) +
 	       (etmv3 * CS_ETMV3_PRIV_SIZE));
@@ -447,7 +457,9 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	int i;
 	u32 offset;
 	u64 nr_cpu, type;
-	const struct cpu_map *cpus = session->evlist->cpus;
+	struct cpu_map *cpu_map;
+	struct cpu_map *event_cpus = session->evlist->cpus;
+	struct cpu_map *online_cpus = cpu_map__new(NULL);
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
@@ -458,8 +470,21 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->nr_mmaps)
 		return -EINVAL;
 
-	/* If the cpu_map is empty all CPUs are involved */
-	nr_cpu = cpu_map__empty(cpus) ? cpu__max_cpu() : cpu_map__nr(cpus);
+	/* If the cpu_map is empty all online CPUs are involved */
+	if (cpu_map__empty(event_cpus)) {
+		cpu_map = online_cpus;
+	} else {
+		/* Make sure all specified CPUs are online */
+		for (i = 0; i < cpu_map__nr(event_cpus); i++) {
+			if (cpu_map__has(event_cpus, i) &&
+			    !cpu_map__has(online_cpus, i))
+				return -EINVAL;
+		}
+
+		cpu_map = event_cpus;
+	}
+
+	nr_cpu = cpu_map__nr(cpu_map);
 	/* Get PMU type as dynamically assigned by the core */
 	type = cs_etm_pmu->type;
 
@@ -472,15 +497,11 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 
 	offset = CS_ETM_SNAPSHOT + 1;
 
-	/* cpu map is not empty, we have specific CPUs to work with */
-	if (!cpu_map__empty(cpus)) {
-		for (i = 0; i < cpu_map__nr(cpus) && offset < priv_size; i++)
-			cs_etm_get_metadata(cpus->map[i], &offset, itr, info);
-	} else {
-		/* get configuration for all CPUs in the system */
-		for (i = 0; i < cpu__max_cpu(); i++)
+	for (i = 0; i < cpu__max_cpu() && offset < priv_size; i++)
+		if (cpu_map__has(cpu_map, i))
 			cs_etm_get_metadata(i, &offset, itr, info);
-	}
+
+	cpu_map__put(online_cpus);
 
 	return 0;
 }
