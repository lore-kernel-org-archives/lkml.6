Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E873921527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsxt2SFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E873921527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbeKVA76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbeKVA76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:59:58 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BAA7214DE;
        Wed, 21 Nov 2018 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542810319;
        bh=4FTV9eTZQZK0CeGrHSIQhDEj+B2KO5FKcUgr7SupIZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nsxt2SFwdeOY/DSjA5ypQZdfM2KN9YrRG55uazknDt2ZfiNbMA0Ql/JW0ddfd5hqB
         fouh1Q1wqunWm2zbumoWMqGte2bmI8Hvg3bTDpFAI1sDSPgRiP8SLit+hnxKSyWzyT
         95pF9r7XjK3vrF+xqukmIANvE7oL2uE++SUH91/k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 2/7] tools build feature: Check if get_current_dir_name() is available
Date:   Wed, 21 Nov 2018 11:25:00 -0300
Message-Id: <20181121142505.27379-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181121142505.27379-1-acme@kernel.org>
References: <20181121142505.27379-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As the namespace support code will use this, which is not available in
some non _GNU_SOURCE libraries such as Android's bionic used in my
container build tests (r12b and r15c at the moment).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-x56ypm940pwclwu45d7jfj47@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                    |  1 +
 tools/build/feature/Makefile                    |  4 ++++
 tools/build/feature/test-all.c                  |  5 +++++
 tools/build/feature/test-get_current_dir_name.c | 10 ++++++++++
 tools/perf/Makefile.config                      |  5 +++++
 tools/perf/util/Build                           |  1 +
 tools/perf/util/get_current_dir_name.c          | 18 ++++++++++++++++++
 tools/perf/util/util.h                          |  4 ++++
 8 files changed, 48 insertions(+)
 create mode 100644 tools/build/feature/test-get_current_dir_name.c
 create mode 100644 tools/perf/util/get_current_dir_name.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index f216b2f5c3d7..d74bb9414d7c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -33,6 +33,7 @@ FEATURE_TESTS_BASIC :=                  \
         dwarf_getlocations              \
         fortify-source                  \
         sync-compare-and-swap           \
+        get_current_dir_name            \
         glibc                           \
         gtk2                            \
         gtk2-infobar                    \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0516259be70f..304b984f11b9 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -7,6 +7,7 @@ FILES=                                          \
          test-dwarf_getlocations.bin            \
          test-fortify-source.bin                \
          test-sync-compare-and-swap.bin         \
+         test-get_current_dir_name.bin          \
          test-glibc.bin                         \
          test-gtk2.bin                          \
          test-gtk2-infobar.bin                  \
@@ -101,6 +102,9 @@ $(OUTPUT)test-bionic.bin:
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-get_current_dir_name.bin:
+	$(BUILD)
+
 $(OUTPUT)test-glibc.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 8dc20a61341f..56722bfe6bdd 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -34,6 +34,10 @@
 # include "test-libelf-mmap.c"
 #undef main
 
+#define main main_test_get_current_dir_name
+# include "test-get_current_dir_name.c"
+#undef main
+
 #define main main_test_glibc
 # include "test-glibc.c"
 #undef main
@@ -174,6 +178,7 @@ int main(int argc, char *argv[])
 	main_test_hello();
 	main_test_libelf();
 	main_test_libelf_mmap();
+	main_test_get_current_dir_name();
 	main_test_glibc();
 	main_test_dwarf();
 	main_test_dwarf_getlocations();
diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/build/feature/test-get_current_dir_name.c
new file mode 100644
index 000000000000..573000f93212
--- /dev/null
+++ b/tools/build/feature/test-get_current_dir_name.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdlib.h>
+
+int main(void)
+{
+	free(get_current_dir_name());
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e30d20fb482d..a0e8c23f9125 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -299,6 +299,11 @@ ifndef NO_BIONIC
   endif
 endif
 
+ifeq ($(feature-get_current_dir_name), 1)
+  CFLAGS += -DHAVE_GET_CURRENT_DIR_NAME
+endif
+
+
 ifdef NO_LIBELF
   NO_DWARF := 1
   NO_DEMANGLE := 1
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ecd9f9ceda77..b7bf201fe8a8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -10,6 +10,7 @@ libperf-y += evlist.o
 libperf-y += evsel.o
 libperf-y += evsel_fprintf.o
 libperf-y += find_bit.o
+libperf-y += get_current_dir_name.o
 libperf-y += kallsyms.o
 libperf-y += levenshtein.o
 libperf-y += llvm-utils.o
diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
new file mode 100644
index 000000000000..267aa609a582
--- /dev/null
+++ b/tools/perf/util/get_current_dir_name.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+//
+#ifndef HAVE_GET_CURRENT_DIR_NAME
+#include "util.h"
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdlib.h>
+
+/* Android's 'bionic' library, for one, doesn't have this */
+
+char *get_current_dir_name(void)
+{
+	char pwd[PATH_MAX];
+
+	return getcwd(pwd, sizeof(pwd)) == NULL ? NULL : strdup(pwd);
+}
+#endif // HAVE_GET_CURRENT_DIR_NAME
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 14508ee7707a..ece040b799f6 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -59,6 +59,10 @@ int fetch_kernel_version(unsigned int *puint,
 
 const char *perf_tip(const char *dirpath);
 
+#ifndef HAVE_GET_CURRENT_DIR_NAME
+char *get_current_dir_name(void);
+#endif
+
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
-- 
2.14.5

