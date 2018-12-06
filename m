Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51FCC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8836E2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131642;
	bh=5G5M8/I8eLYrwtjlyw75+YEHhVzIbt9wFuAwQj6KD54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=koxNa/O2ZTT4PAvgpVXE3Ov3qdW2MKj+bXNavShuegKEWPxmiUX+/5qYY1/ToPR1K
	 NC2x6zxOGZ0WWTRopnYNcftySHlezjDTe74uioCFXEcLxivZl9Z3+EkJFY58x3+L+U
	 zRObslnqyFO3KQ1Bpavp6mL8wHrRzj+lufICfhZQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8836E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeLFV1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:27:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbeLFV1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:27:17 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E39D208E7;
        Thu,  6 Dec 2018 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131637;
        bh=5G5M8/I8eLYrwtjlyw75+YEHhVzIbt9wFuAwQj6KD54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkRuLMYuvZvAJYZkfqtiGpLhNCng8eDCZbeLBAVCkIw3hJS1muu3gRpM2FgOCNcbb
         oZ9pQJIDx/aIGMtN6mFWjScmYzfkyJ2fZT0pQE+WYR2TF+IwCiVrXuq5cn5EyMvf1F
         7/KPpdr8VYLixgYYwe9yu9uQMHruUSRA3z/WZLCU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/75] perf tests record: Allow for 'sleep' being 'coreutils'
Date:   Thu,  6 Dec 2018 18:24:58 -0300
Message-Id: <20181206212602.20474-12-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

If the 'sleep' command is provided by coreutils, then the "PERF_RECORD_*
events & perf_sample fields" test will fail because the MMAP name is
'coreutils' not 'sleep', and there is an extra COMM event. Fix the test
to detect that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181122135545.16295-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.19.2

