Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98C8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B342E2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B342E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391467AbeKWAgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:36:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:42295 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389105AbeKWAgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:36:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 05:57:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="110452813"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2018 05:57:19 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tests record: Allow for 'sleep' being 'coreutils'
Date:   Thu, 22 Nov 2018 15:55:45 +0200
Message-Id: <20181122135545.16295-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the 'sleep' command is provided by coreutils, then the "PERF_RECORD_*
events & perf_sample fields" test will fail because the MMAP name is
'coreutils' not 'sleep', and there is an extra COMM event. Fix the test to
detect that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/perf-record.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 34394cc05077..07f6bd8ed719 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -58,6 +58,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	char *bname, *mmap_filename;
 	u64 prev_time = 0;
 	bool found_cmd_mmap = false,
+	     found_coreutils_mmap = false,
 	     found_libc_mmap = false,
 	     found_vdso_mmap = false,
 	     found_ld_mmap = false;
@@ -254,6 +255,8 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 					if (bname != NULL) {
 						if (!found_cmd_mmap)
 							found_cmd_mmap = !strcmp(bname + 1, cmd);
+						if (!found_coreutils_mmap)
+							found_coreutils_mmap = !strcmp(bname + 1, "coreutils");
 						if (!found_libc_mmap)
 							found_libc_mmap = !strncmp(bname + 1, "libc", 4);
 						if (!found_ld_mmap)
@@ -292,7 +295,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	}
 
 found_exit:
-	if (nr_events[PERF_RECORD_COMM] > 1) {
+	if (nr_events[PERF_RECORD_COMM] > 1 + !!found_coreutils_mmap) {
 		pr_debug("Excessive number of PERF_RECORD_COMM events!\n");
 		++errs;
 	}
@@ -302,7 +305,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 		++errs;
 	}
 
-	if (!found_cmd_mmap) {
+	if (!found_cmd_mmap && !found_coreutils_mmap) {
 		pr_debug("PERF_RECORD_MMAP for %s missing!\n", cmd);
 		++errs;
 	}
-- 
2.17.1

