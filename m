Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79513C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431F522419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431F522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeKOHaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:30:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:30981 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeKOHaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:30:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 13:25:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,233,1539673200"; 
   d="scan'208";a="108290548"
Received: from otc-nc-01.jf.intel.com ([10.54.39.11])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2018 13:25:31 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf vendor events: Add stepping in CPUID string for x86
Date:   Wed, 14 Nov 2018 13:24:15 -0800
Message-Id: <20181114212416.15665-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf tools cannot find the proper event list for Cascadelake server.
Because Cascadelake server and Skylake server have the same CPU model
number, which are used by perf tools to find the event list.

The stepping for Skylake server is up to 4.
The stepping for Cascadelake server starts from 5.
The stepping can be used to distinguish between them.

The stepping is added in get_cpuid_str().
The stepping information for Skylake server is updated in mapfile.csv.
A x86 specific strcmp_cpuid_cmp() function is added to handle two CPUID
formats in mapfile.csv, "vendor-family-model-stepping" and
"vendor-family-model".
- If a cpuid-regular-expression from the mapfile.csv using the new
  stepping format, a cpuid-string generated on the machine must include
  stepping. Otherwise, it is a mismatch.
- If the cpuid-regular-expression using the old non-stepping format,
  the stepping in the cpuid-string will be ignored.

The script, which using environment string "PERF_CPUID" without stepping
on Skylake server, will be broken. If so, users must fix their scripts.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/header.c          | 67 +++++++++++++++++++++-
 tools/perf/pmu-events/arch/x86/mapfile.csv |  2 +-
 tools/perf/util/pmu.c                      |  2 +-
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index fb0d71afee8b..b428a4b00bf7 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <regex.h>
 
 #include "../../util/header.h"
 
@@ -70,9 +71,73 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *buf = malloc(128);
 
-	if (buf && __get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
+	if (buf && __get_cpuid(buf, 128, "%s-%u-%X-%X$") < 0) {
 		free(buf);
 		return NULL;
 	}
 	return buf;
 }
+
+/* Full CPUID format for x86 is vendor-family-model-stepping */
+static bool is_full_cpuid(const char *cpuid)
+{
+	const char *tmp = cpuid;
+	int count = 0;
+
+	while ((tmp = strchr(tmp, '-')) != NULL) {
+		count++;
+		tmp++;
+	}
+
+	if (count == 3)
+		return true;
+
+	return false;
+}
+
+int strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
+{
+	regex_t re;
+	regmatch_t pmatch[1];
+	int match;
+	bool full_mapcpuid = is_full_cpuid(mapcpuid);
+	bool full_cpuid = is_full_cpuid(cpuid);
+
+	/*
+	 * Full CPUID format is required to identify a platform.
+	 * Error out if the cpuid string is incomplete.
+	 */
+	if (full_mapcpuid && !full_cpuid) {
+		pr_info("Invalid CPUID %s. Full CPUID is required, "
+			"vendor-family-model-stepping\n", cpuid);
+		return 1;
+	}
+
+	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
+		/* Warn unable to generate match particular string. */
+		pr_info("Invalid regular expression %s\n", mapcpuid);
+		return 1;
+	}
+
+	match = !regexec(&re, cpuid, 1, pmatch, 0);
+	regfree(&re);
+	if (match) {
+		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
+		size_t cpuid_len;
+
+		/* If the full CPUID format isn't required,
+		 * ignoring the stepping.
+		 */
+		if (!full_mapcpuid && full_cpuid)
+			cpuid_len = strrchr(cpuid, '-') - cpuid;
+		else
+			cpuid_len = strlen(cpuid);
+
+
+		/* Verify the entire string matched. */
+		if (match_len == cpuid_len)
+			return 0;
+	}
+
+	return 1;
+}
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 7e3cce3bcf3b..183a42c99251 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -31,4 +31,4 @@ GenuineIntel-6-2A,v15,sandybridge,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
-GenuineIntel-6-55,v1,skylakex,core
+GenuineIntel-6-55-[01234],v1,skylakex,core
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index afd68524ffa9..0996260178f7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -670,7 +670,7 @@ char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
  * cpuid string generated on this platform.
  * Otherwise return non-zero.
  */
-int strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
+int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
 {
 	regex_t re;
 	regmatch_t pmatch[1];
-- 
2.17.1

