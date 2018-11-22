Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7D6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27047206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8bO/581"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27047206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404554AbeKVOPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:15:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404467AbeKVOPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:15:00 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 588712075B;
        Thu, 22 Nov 2018 03:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857854;
        bh=VLhqDPawxRe/WY0uXvllMaRrjcVe2F00oUJoD5b/UGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8bO/581FaZ2JJBtneYNS1m/kf/uNYpq8aGZBtt9sKq7cXo3gLeEzfw5Hh2YA/hXa
         +GzdOCSMKhB/DWmx+quepq3tyMtCzX1iIo2poeGcEcRmJ19kYEGiZZKpKpJU2b4yXc
         6yBsGM7/j+aqqJKPOIOCQXmkl2UgluLjrsFty+dE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/28] perf vendor events: Add stepping in CPUID string for x86
Date:   Thu, 22 Nov 2018 00:36:07 -0300
Message-Id: <20181122033611.15890-25-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf tools cannot find the proper event list for the Cascadelake
server.  Because the Cascadelake server and the Skylake server have the
same CPU model number, which are used by the perf tools to find the
event list.

The stepping for Skylake server is up to 4.

The stepping for Cascadelake server starts from 5.

The stepping can be used to distinguish between them.

The stepping is added in get_cpuid_str().

The stepping information for Skylake server is updated in mapfile.csv.

A x86 specific strcmp_cpuid_cmp() function is added to handle two CPUID
formats in mapfile.csv, "vendor-family-model-stepping" and
"vendor-family-model":

- If a cpuid-regular-expression from the mapfile.csv using the new
  stepping format, a cpuid-string generated on the machine must include
  stepping. Otherwise, it is a mismatch.

- If the cpuid-regular-expression using the old non-stepping format,
  the stepping in the cpuid-string will be ignored.

The script, using environment string "PERF_CPUID" without stepping on
Skylake server, will be broken. If so, users must fix their scripts.

Committer notes:

Fixed this build error on centos:6 and debian:7:

  arch/x86/util/header.c: In function 'is_full_cpuid':
  arch/x86/util/header.c:82:39: error: declaration of 'cpuid' shadows a global declaration [-Werror=shadow]
  arch/x86/util/header.c:12:1: error: shadowed declaration is here [-Werror=shadow]
  arch/x86/util/header.c: In function 'strcmp_cpuid_str':
  arch/x86/util/header.c:98:56: error: declaration of 'cpuid' shadows a global declaration [-Werror=shadow]
  arch/x86/util/header.c:12:1: error: shadowed declaration is here [-Werror=shadow]
  cc1: all warnings being treated as errors

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181114212416.15665-1-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/header.c          | 66 +++++++++++++++++++++++++++++-
 tools/perf/pmu-events/arch/x86/mapfile.csv |  2 +-
 tools/perf/util/pmu.c                      |  2 +-
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index fb0d71afee8b..af9a9f2600be 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <regex.h>
 
 #include "../../util/header.h"
 
@@ -70,9 +71,72 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
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
+static bool is_full_cpuid(const char *id)
+{
+	const char *tmp = id;
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
+int strcmp_cpuid_str(const char *mapcpuid, const char *id)
+{
+	regex_t re;
+	regmatch_t pmatch[1];
+	int match;
+	bool full_mapcpuid = is_full_cpuid(mapcpuid);
+	bool full_cpuid = is_full_cpuid(id);
+
+	/*
+	 * Full CPUID format is required to identify a platform.
+	 * Error out if the cpuid string is incomplete.
+	 */
+	if (full_mapcpuid && !full_cpuid) {
+		pr_info("Invalid CPUID %s. Full CPUID is required, "
+			"vendor-family-model-stepping\n", id);
+		return 1;
+	}
+
+	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
+		/* Warn unable to generate match particular string. */
+		pr_info("Invalid regular expression %s\n", mapcpuid);
+		return 1;
+	}
+
+	match = !regexec(&re, id, 1, pmatch, 0);
+	regfree(&re);
+	if (match) {
+		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
+		size_t cpuid_len;
+
+		/* If the full CPUID format isn't required,
+		 * ignoring the stepping.
+		 */
+		if (!full_mapcpuid && full_cpuid)
+			cpuid_len = strrchr(id, '-') - id;
+		else
+			cpuid_len = strlen(id);
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
index 7348eea0248f..c660625d7d4b 100644
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
2.14.5

