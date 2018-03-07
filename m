Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933670AbeCGOEb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:04:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:30695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754457AbeCGODZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:03:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="36206824"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] perf intel-pt/bts: In auxtrace_record__init_intel() evlist is never NULL
Date: Wed,  7 Mar 2018 16:02:25 +0200
Message-Id: <1520431349-30689-6-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy auxtrace_record__init_intel() slightly by recognizing that evlist is
never NULL.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/auxtrace.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 6aa3f2a38321..b135af62011c 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -37,15 +37,11 @@ struct auxtrace_record *auxtrace_record__init_intel(struct perf_evlist *evlist,
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
 
-	if (evlist) {
-		evlist__for_each_entry(evlist, evsel) {
-			if (intel_pt_pmu &&
-			    evsel->attr.type == intel_pt_pmu->type)
-				found_pt = true;
-			if (intel_bts_pmu &&
-			    evsel->attr.type == intel_bts_pmu->type)
-				found_bts = true;
-		}
+	evlist__for_each_entry(evlist, evsel) {
+		if (intel_pt_pmu && evsel->attr.type == intel_pt_pmu->type)
+			found_pt = true;
+		if (intel_bts_pmu && evsel->attr.type == intel_bts_pmu->type)
+			found_bts = true;
 	}
 
 	if (found_pt && found_bts) {
-- 
1.9.1
