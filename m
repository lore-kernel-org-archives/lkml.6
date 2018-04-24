Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeDXSVk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:21:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:3120 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbeDXSVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:21:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="35837948"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, ganapatrao.kulkarni@cavium.com,
        zhangshaokun@hisilicon.com, yao.jin@linux.intel.com,
        will.deacon@arm.com, ak@linux.intel.com, agustinv@codeaurora.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/5] perf evsel: Only fall back group read for leader
Date: Tue, 24 Apr 2018 11:20:12 -0700
Message-Id: <1524594014-79243-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
References: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
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
For the fallback request from members, it must be caused by an error. The
fallback only breaks the semantics of group.
Limit the group read fallback only for the leader.

Fixes:  82bf311e15d2 ("perf stat: Use group read for event groups")
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1ac8d92..391ef7c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1922,7 +1922,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
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
2.7.4
