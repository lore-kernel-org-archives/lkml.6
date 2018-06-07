Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YYvsDuvpGFvfVwAAmS7hNA
	; Thu, 07 Jun 2018 08:17:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 11838608C9; Thu,  7 Jun 2018 08:17:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7BD2960115;
	Thu,  7 Jun 2018 08:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BD2960115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932503AbeFGIRj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:17:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42701 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeFGIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:17:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578HTpt2125593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:17:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578HTwG2125590;
        Thu, 7 Jun 2018 01:17:29 -0700
Date: Thu, 7 Jun 2018 01:17:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-dcaeae4e2c266452e04dc3d83b10469be9fe419e@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com, adrian.hunter@intel.com, jolsa@redhat.com
Reply-To: adrian.hunter@intel.com, jolsa@redhat.com, hpa@zytor.com,
          wangnan0@huawei.com, tglx@linutronix.de, mingo@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1528117014-30032-2-git-send-email-adrian.hunter@intel.com>
References: <1528117014-30032-2-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests kmod-path: Add tests for vdso32 and
 vdsox32
Git-Commit-ID: dcaeae4e2c266452e04dc3d83b10469be9fe419e
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

Commit-ID:  dcaeae4e2c266452e04dc3d83b10469be9fe419e
Gitweb:     https://git.kernel.org/tip/dcaeae4e2c266452e04dc3d83b10469be9fe419e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 4 Jun 2018 15:56:53 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:03 -0300

perf tests kmod-path: Add tests for vdso32 and vdsox32

Add tests for vdso32 and vdsox32. This will cause the overall test to
fail because __kmod_path__parse() does not handle vdso32 or vdsox32.

Fixes: 1f121b03d058 ("perf tools: Deal with kernel module names in '[]' correctly")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1528117014-30032-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/kmod-path.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index 8e57d46109de..148dd31cc201 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -127,6 +127,22 @@ int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_un
 	M("[vdso]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vdso]", PERF_RECORD_MISC_USER, false);
 
+	T("[vdso32]", true      , true     , false, false, "[vdso32]", NULL);
+	T("[vdso32]", false     , true     , false, false, NULL    , NULL);
+	T("[vdso32]", true      , false    , false, false, "[vdso32]", NULL);
+	T("[vdso32]", false     , false    , false, false, NULL    , NULL);
+	M("[vdso32]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
+	M("[vdso32]", PERF_RECORD_MISC_KERNEL, false);
+	M("[vdso32]", PERF_RECORD_MISC_USER, false);
+
+	T("[vdsox32]", true      , true     , false, false, "[vdsox32]", NULL);
+	T("[vdsox32]", false     , true     , false, false, NULL    , NULL);
+	T("[vdsox32]", true      , false    , false, false, "[vdsox32]", NULL);
+	T("[vdsox32]", false     , false    , false, false, NULL    , NULL);
+	M("[vdsox32]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
+	M("[vdsox32]", PERF_RECORD_MISC_KERNEL, false);
+	M("[vdsox32]", PERF_RECORD_MISC_USER, false);
+
 	/* path         alloc_name  alloc_ext  kmod   comp   name          ext */
 	T("[vsyscall]", true      , true     , false, false, "[vsyscall]", NULL);
 	T("[vsyscall]", false     , true     , false, false, NULL        , NULL);
