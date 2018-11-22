Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31DCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9150B20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9150B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392406AbeKVRzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:55:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49577 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbeKVRzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:55:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM7GSLF3692726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:16:28 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM7GSix3692723;
        Wed, 21 Nov 2018 23:16:28 -0800
Date:   Wed, 21 Nov 2018 23:16:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-f4a0742b3cc1d03b2ff448017b8c714a77e5a261@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        kan.liang@linux.intel.com, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com
Reply-To: mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          tglx@linutronix.de, jolsa@kernel.org
In-Reply-To: <20181121164939.13482-1-kan.liang@linux.intel.com>
References: <20181121164939.13482-1-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf pmu: Move *_cpuid_str() weak functions to
 header.c
Git-Commit-ID: f4a0742b3cc1d03b2ff448017b8c714a77e5a261
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f4a0742b3cc1d03b2ff448017b8c714a77e5a261
Gitweb:     https://git.kernel.org/tip/f4a0742b3cc1d03b2ff448017b8c714a77e5a261
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Wed, 21 Nov 2018 08:49:39 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 22:39:59 -0300

perf pmu: Move *_cpuid_str() weak functions to header.c

The weak functions, strcmp_cpuid_str() and get_cpuid_str(), are defined
in pmu.c.

Most of the cpuid related functions, including *_cpuid_str()'s
declaration and platform specific definition, are in header.c/h.

To make the declaration and definition of all cpuid related functions in
a consistent place, move the weak functions to header.c.

There is no functional change.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Link: http://lkml.kernel.org/r/20181121164939.13482-1-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 39 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c    | 39 ---------------------------------------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4fd45be95a43..e31f52845e77 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -987,6 +987,45 @@ static int write_group_desc(struct feat_fd *ff,
 	return 0;
 }
 
+/*
+ * Return the CPU id as a raw string.
+ *
+ * Each architecture should provide a more precise id string that
+ * can be use to match the architecture's "mapfile".
+ */
+char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+{
+	return NULL;
+}
+
+/* Return zero when the cpuid from the mapfile.csv matches the
+ * cpuid string generated on this platform.
+ * Otherwise return non-zero.
+ */
+int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
+{
+	regex_t re;
+	regmatch_t pmatch[1];
+	int match;
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
+
+		/* Verify the entire string matched. */
+		if (match_len == strlen(cpuid))
+			return 0;
+	}
+	return 1;
+}
+
 /*
  * default get_cpuid(): nothing gets recorded
  * actual implementation must be in arch/$(SRCARCH)/util/header.c
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c660625d7d4b..11a234740632 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -655,45 +655,6 @@ static int is_arm_pmu_core(const char *name)
 	return 0;
 }
 
-/*
- * Return the CPU id as a raw string.
- *
- * Each architecture should provide a more precise id string that
- * can be use to match the architecture's "mapfile".
- */
-char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
-{
-	return NULL;
-}
-
-/* Return zero when the cpuid from the mapfile.csv matches the
- * cpuid string generated on this platform.
- * Otherwise return non-zero.
- */
-int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
-{
-	regex_t re;
-	regmatch_t pmatch[1];
-	int match;
-
-	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
-		/* Warn unable to generate match particular string. */
-		pr_info("Invalid regular expression %s\n", mapcpuid);
-		return 1;
-	}
-
-	match = !regexec(&re, cpuid, 1, pmatch, 0);
-	regfree(&re);
-	if (match) {
-		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
-
-		/* Verify the entire string matched. */
-		if (match_len == strlen(cpuid))
-			return 0;
-	}
-	return 1;
-}
-
 static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 {
 	char *cpuid;
