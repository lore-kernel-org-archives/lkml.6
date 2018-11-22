Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AFEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B15220878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwPqy0nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B15220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404532AbeKVOPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404518AbeKVOPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:15:13 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323ED20878;
        Thu, 22 Nov 2018 03:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857867;
        bh=h4YfUUmSHIHlZFvm/WsaAAU5SXxmuAjYguXdanLlja4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwPqy0nnFbxJ1cgOHymE5nyVFUIvCgcOBZax3I0/Qv9VEbe0giNH7LLcMAvPcyWYZ
         DENHa/298PN5SiDOyZOQ/JKG1pJ/vTc9xJQWrgLJeP9htFmmsyEVVEaxVhJu6DPyj2
         sw2vcAtE0xWvUHzveLVxgbhJpDybyDq+gus41oZo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/28] perf pmu: Move *_cpuid_str() weak functions to header.c
Date:   Thu, 22 Nov 2018 00:36:11 -0300
Message-Id: <20181122033611.15890-29-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
-- 
2.14.5

