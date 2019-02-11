Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EE221874
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbfBKUV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:21:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:17265 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfBKUVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:21:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 12:21:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="115389713"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 11 Feb 2019 12:21:25 -0800
Received: from [10.252.27.66] (abudanko-mobl.ccr.corp.intel.com [10.252.27.66])
        by linux.intel.com (Postfix) with ESMTP id C488C5802BB;
        Mon, 11 Feb 2019 12:21:22 -0800 (PST)
Subject: [PATCH v2 1/4] feature: realize libzstd check, LIBZSTD_DIR and
 NO_LIBZSTD defines
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0aa49e03-c0df-d0a4-3dd7-a566fce0fc16@linux.intel.com>
Date:   Mon, 11 Feb 2019 23:21:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement libzstd feature check, NO_LIBZSTD and LIBZSTD_DIR defines
to override Zstd library sources or disable the feature from the
command line:

  $ make -C tools/perf LIBZSTD_DIR=/root/abudanko/zstd-1.3.7 clean all
  $ make -C tools/perf NO_LIBZSTD=1 clean all

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/build/Makefile.feature       |  6 ++++--
 tools/build/feature/Makefile       |  6 +++++-
 tools/build/feature/test-all.c     |  5 +++++
 tools/build/feature/test-libzstd.c | 12 ++++++++++++
 tools/perf/Makefile.config         | 20 ++++++++++++++++++++
 tools/perf/Makefile.perf           |  3 +++
 6 files changed, 49 insertions(+), 3 deletions(-)
 create mode 100644 tools/build/feature/test-libzstd.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 5467c6bf9ceb..25088c8f05b2 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -71,7 +71,8 @@ FEATURE_TESTS_BASIC :=                  \
         sdt				\
         setns				\
         libopencsd			\
-        libaio
+        libaio				\
+        libzstd
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -118,7 +119,8 @@ FEATURE_DISPLAY ?=              \
          lzma                   \
          get_cpuid              \
          bpf			\
-         libaio
+         libaio			\
+         libzstd
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7ceb4441b627..4b8244ee65ce 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -62,7 +62,8 @@ FILES=                                          \
          test-clang.bin				\
          test-llvm.bin				\
          test-llvm-version.bin			\
-         test-libaio.bin
+         test-libaio.bin			\
+         test-libzstd.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -301,6 +302,9 @@ $(OUTPUT)test-clang.bin:
 $(OUTPUT)test-libaio.bin:
 	$(BUILD) -lrt
 
+$(OUTPUT)test-libzstd.bin:
+	$(BUILD) -lzstd
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 20cdaa4fc112..5af329b6ffef 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -178,6 +178,10 @@
 # include "test-libaio.c"
 #undef main
 
+#define main main_test_zstd
+# include "test-libzstd.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -219,6 +223,7 @@ int main(int argc, char *argv[])
 	main_test_setns();
 	main_test_libopencsd();
 	main_test_libaio();
+	main_test_libzstd();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-libzstd.c b/tools/build/feature/test-libzstd.c
new file mode 100644
index 000000000000..55268c01b84d
--- /dev/null
+++ b/tools/build/feature/test-libzstd.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <zstd.h>
+
+int main(void)
+{
+	ZSTD_CStream	*cstream;
+
+	cstream = ZSTD_createCStream();
+	ZSTD_freeCStream(cstream);
+
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b441c88cafa1..1dccd776a4aa 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -145,6 +145,13 @@ endif
 FEATURE_CHECK_CFLAGS-libbabeltrace := $(LIBBABELTRACE_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf
 
+ifdef LIBZSTD_DIR
+  LIBZSTD_CFLAGS  := -I$(LIBZSTD_DIR)/lib
+  LIBZSTD_LDFLAGS := -L$(LIBZSTD_DIR)/lib
+endif
+FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
+
 FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 # include ARCH specific config
 -include $(src-perf)/arch/$(SRCARCH)/Makefile
@@ -770,6 +777,19 @@ ifndef NO_LZMA
   endif
 endif
 
+ifndef NO_LIBZSTD
+  ifeq ($(feature-libzstd), 1)
+    CFLAGS += -DHAVE_ZSTD_SUPPORT
+    CFLAGS += $(LIBZSTD_CFLAGS)
+    LDFLAGS += $(LIBZSTD_LDFLAGS)
+    EXTLIBS += -lzstd
+    $(call detected,CONFIG_ZSTD)
+  else
+    msg := $(warning No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR);
+    NO_LIBZSTD := 1
+  endif
+endif
+
 ifndef NO_BACKTRACE
   ifeq ($(feature-backtrace), 1)
     CFLAGS += -DHAVE_BACKTRACE_SUPPORT
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 09df1c8a4ec9..6e95e90a7b7b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -108,6 +108,9 @@ include ../scripts/utilities.mak
 # streaming for record mode. Currently Posix AIO trace streaming is
 # supported only when linking with glibc.
 #
+# Define NO_LIBZSTD if you do not want support of Zstandard based runtime
+# trace compression in record mode.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
