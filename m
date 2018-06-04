Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbeFDM6R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:58:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:38826 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753078AbeFDM6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:58:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="46607132"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf tests kmod-path: Add tests for vdso32 and vdsox32
Date: Mon,  4 Jun 2018 15:56:53 +0300
Message-Id: <1528117014-30032-2-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528117014-30032-1-git-send-email-adrian.hunter@intel.com>
References: <1528117014-30032-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for vdso32 and vdsox32. This will cause the overall test to fail
because __kmod_path__parse() does not handle vdso32 or vdsox32.

Fixes: 1f121b03d058 ("perf tools: Deal with kernel module names in '[]' correctly")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
-- 
1.9.1
