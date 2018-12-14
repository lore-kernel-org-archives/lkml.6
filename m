Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0236DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3EC2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbeLNUYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:24:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57003 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbeLNUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:24:53 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKOkkv1453127
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:24:46 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKOkOl1453123;
        Fri, 14 Dec 2018 12:24:46 -0800
Date:   Fri, 14 Dec 2018 12:24:46 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-2e9ed1958a8412622b7f45d8a0e2658b4463dcec@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          hpa@zytor.com, mingo@kernel.org, acme@redhat.com
In-Reply-To: <20181122135545.16295-1-adrian.hunter@intel.com>
References: <20181122135545.16295-1-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests record: Allow for 'sleep' being
 'coreutils'
Git-Commit-ID: 2e9ed1958a8412622b7f45d8a0e2658b4463dcec
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

Commit-ID:  2e9ed1958a8412622b7f45d8a0e2658b4463dcec
Gitweb:     https://git.kernel.org/tip/2e9ed1958a8412622b7f45d8a0e2658b4463dcec
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 22 Nov 2018 15:55:45 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:48 -0300

perf tests record: Allow for 'sleep' being 'coreutils'

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
@@ -302,7 +305,7 @@ found_exit:
 		++errs;
 	}
 
-	if (!found_cmd_mmap) {
+	if (!found_cmd_mmap && !found_coreutils_mmap) {
 		pr_debug("PERF_RECORD_MMAP for %s missing!\n", cmd);
 		++errs;
 	}
