Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeCHTwS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:52:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbeCHTwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BB62178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/54] perf intel-pt/bts: In auxtrace_record__init_intel() evlist is never NULL
Date: Thu,  8 Mar 2018 16:50:09 -0300
Message-Id: <20180308195029.14991-35-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Tidy auxtrace_record__init_intel() slightly by recognizing that evlist is
never NULL.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520431349-30689-6-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
