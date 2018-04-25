Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755785AbeDYQBE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755847AbeDYQAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:00:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5B921789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/12] perf evsel: Only fall back group read for leader
Date: Wed, 25 Apr 2018 13:00:07 -0300
Message-Id: <20180425160008.3407-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425160008.3407-1-acme@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf doesn't support mixed events from different PMUs (except software
event) in a group. The perf stat should output <not counted>/<not
supported> for all events, but it doesn't. For example,

  perf stat -e '{cycles,uncore_imc_5/umask=0xF,event=0x4/,instructions}'
       <not counted>      cycles
       <not supported>    uncore_imc_5/umask=0xF,event=0x4/
           1,024,300      instructions

If perf fails to open an event, it doesn't error out directly. It will
disable some features and retry, until the event is opened or all
features are disabled. The disabled features will not be re-enabled. The
group read is one of these features.

For the example as above, the IMC event and the leader event "cycles"
are from different PMUs. Opening the IMC event must fail. The group read
feature must be disabled for IMC event and the followed event
"instructions". The "instructions" event has the same PMU as the leader
"cycles". It can be opened successfully. Since the group read feature
has been disabled, the "instructions" event will be read as a single
event, which definitely has a value.

The group read fallback is still useful for the case which kernel
doesn't support group read. It is good enough to be handled only by the
leader.

For the fallback request from members, it must be caused by an error.
The fallback only breaks the semantics of group.  Limit the group read
fallback only for the leader.

Committer testing:

On a broadwell t450s notebook:

Before:

  # perf stat -e '{cycles,unc_cbo_cache_lookup.read_i,instructions}' sleep 1

  Performance counter stats for 'sleep 1':

     <not counted>      cycles
   <not supported>      unc_cbo_cache_lookup.read_i
           818,206      instructions

       1.003170887 seconds time elapsed

  Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog

After:

  # perf stat -e '{cycles,unc_cbo_cache_lookup.read_i,instructions}' sleep 1

  Performance counter stats for 'sleep 1':

     <not counted>      cycles
   <not supported>      unc_cbo_cache_lookup.read_i
     <not counted>      instructions

       1.001380511 seconds time elapsed

  Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
  #

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes:  82bf311e15d2 ("perf stat: Use group read for event groups")
Link: http://lkml.kernel.org/r/1524594014-79243-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 26bdeecc0452..4cd2cf93f726 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1925,7 +1925,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.group_read &&
 		    evsel->attr.inherit &&
-		   (evsel->attr.read_format & PERF_FORMAT_GROUP)) {
+		   (evsel->attr.read_format & PERF_FORMAT_GROUP) &&
+		   perf_evsel__is_group_leader(evsel)) {
 		perf_missing_features.group_read = true;
 		pr_debug2("switching off group read\n");
 		goto fallback_missing_features;
-- 
2.14.3
