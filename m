Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE87C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4614B2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4614B2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbeKFS1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:27:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:16724 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbeKFS1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:27:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 01:03:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="97984282"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 06 Nov 2018 01:03:39 -0800
Received: from [10.125.252.37] (abudanko-mobl.ccr.corp.intel.com [10.125.252.37])
        by linux.intel.com (Postfix) with ESMTP id D05BB580213;
        Tue,  6 Nov 2018 01:03:36 -0800 (PST)
Subject: [PATCH v15 1/3]: perf util: map data buffer for preserving collected
 data
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <75e779bf-dc6b-ea24-67a5-f53a39bb7374@linux.intel.com>
Organization: Intel Corp.
Message-ID: <5fcda10c-6c63-68df-383a-c6d9e5d1f918@linux.intel.com>
Date:   Tue, 6 Nov 2018 12:03:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <75e779bf-dc6b-ea24-67a5-f53a39bb7374@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The map->data buffer is used to preserve map->base profiling data 
for writing to disk. AIO map->cblock is used to queue corresponding 
map->data buffer for asynchronous writing.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v15:
 - implemented libaio feature check and defined HAVE_AIO_SUPPORT accordingly
Changes in v13:
 - grouped aio functions under single #ifdef HAVE_AIO_SUPPORT
Changes in v12:
 - applied stub functions design for the whole patch kit
 - grouped AIO related data into a struct under struct perf_mmap
Changes in v10:
 - moved specific code to perf_mmap__aio_mmap(), perf_mmap__aio_munmap()
 - adjusted error reporting by using %m
Changes in v9:
  - implemented NO_AIO and HAVE_AIO_SUPPORT defines to cover cases of 
    libc implementations without Posix AIO API support
Changes in v7:
  - implemented handling record.aio setting from perfconfig file
 Changes in v6:
  - adjusted setting of priorities for cblocks;
 Changes in v5:
  - reshaped layout of data structures;
  - implemented --aio option;
 Changes in v4:
  - converted mmap()/munmap() to malloc()/free() for mmap->data buffer management 
 Changes in v2:
  - converted zalloc() to calloc() for allocation of mmap_aio array,
  - cleared typo and adjusted fallback branch code;
---
 tools/build/Makefile.feature      |  6 +++--
 tools/build/feature/Makefile      |  6 ++++-
 tools/build/feature/test-all.c    |  5 ++++
 tools/build/feature/test-libaio.c | 16 +++++++++++++
 tools/perf/Makefile.config        |  6 +++++
 tools/perf/Makefile.perf          |  7 +++++-
 tools/perf/util/evlist.c          |  2 +-
 tools/perf/util/mmap.c            | 49 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/mmap.h            | 11 ++++++++-
 9 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index f216b2f5c3d7..185b1932b25a 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -68,7 +68,8 @@ FEATURE_TESTS_BASIC :=                  \
         sched_getcpu			\
         sdt				\
         setns				\
-        libopencsd
+        libopencsd			\
+        libaio
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -114,7 +115,8 @@ FEATURE_DISPLAY ?=              \
          zlib                   \
          lzma                   \
          get_cpuid              \
-         bpf
+         bpf			\
+         libaio
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0516259be70f..468817a6bc44 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -58,7 +58,8 @@ FILES=                                          \
          test-libopencsd.bin			\
          test-clang.bin				\
          test-llvm.bin				\
-         test-llvm-version.bin
+         test-llvm-version.bin			\
+         test-libaio.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -285,6 +286,9 @@ $(OUTPUT)test-clang.bin:
 
 -include $(OUTPUT)*.d
 
+$(OUTPUT)test-libaio.bin:
+	$(BUILD) -lrt
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 8dc20a61341f..19ca9c87cc61 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -166,6 +166,10 @@
 # include "test-libopencsd.c"
 #undef main
 
+#define main main_test_libaio
+# include "test-libaio.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -204,6 +208,7 @@ int main(int argc, char *argv[])
 	main_test_sdt();
 	main_test_setns();
 	main_test_libopencsd();
+	main_test_libaio();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-libaio.c b/tools/build/feature/test-libaio.c
new file mode 100644
index 000000000000..932133c9a265
--- /dev/null
+++ b/tools/build/feature/test-libaio.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <aio.h>
+
+int main(void)
+{
+	struct aiocb aiocb;
+
+	aiocb.aio_fildes  = 0;
+	aiocb.aio_offset  = 0;
+	aiocb.aio_buf     = 0;
+	aiocb.aio_nbytes  = 0;
+	aiocb.aio_reqprio = 0;
+	aiocb.aio_sigevent.sigev_notify = 1 /*SIGEV_NONE*/;
+
+	return (int)aio_return(&aiocb);
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f6d1a03c7523..533282da45ae 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -357,6 +357,12 @@ ifeq ($(feature-glibc), 1)
   CFLAGS += -DHAVE_GLIBC_SUPPORT
 endif
 
+ifeq ($(feature-libaio), 1)
+  ifndef NO_AIO
+    CFLAGS += -DHAVE_AIO_SUPPORT
+  endif
+endif
+
 ifdef NO_DWARF
   NO_LIBDW_DWARF_UNWIND := 1
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 92514fb3689f..7becc6a72cf2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -97,8 +97,13 @@ include ../scripts/utilities.mak
 # Define LIBCLANGLLVM if you DO want builtin clang and llvm support.
 # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
 # llvm-config is not in $PATH.
-
+#
 # Define NO_CORESIGHT if you do not want support for CoreSight trace decoding.
+#
+# Define NO_AIO if you do not want support of Posix AIO based trace
+# streaming for record mode. Currently Posix AIO trace streaming is
+# supported only when linking with glibc.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index be440df29615..1a83bf2c069c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1028,7 +1028,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp;
+	struct mmap_params mp = { .nr_cblocks = 0 };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index cdb95b3a1213..47cdc3ad6546 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -153,8 +153,55 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 {
 }
 
+#ifdef HAVE_AIO_SUPPORT
+static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
+{
+	int delta_max;
+
+	if (mp->nr_cblocks) {
+		map->aio.data = malloc(perf_mmap__mmap_len(map));
+		if (!map->aio.data) {
+			pr_debug2("failed to allocate data buffer, error %m\n");
+			return -1;
+		}
+		/*
+		 * Use cblock.aio_fildes value different from -1
+		 * to denote started aio write operation on the
+		 * cblock so it requires explicit record__aio_sync()
+		 * call prior the cblock may be reused again.
+		 */
+		map->aio.cblock.aio_fildes = -1;
+		/*
+		 * Allocate cblock with max priority delta to
+		 * have faster aio write system calls.
+		 */
+		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
+		map->aio.cblock.aio_reqprio = delta_max;
+	}
+
+	return 0;
+}
+
+static void perf_mmap__aio_munmap(struct perf_mmap *map)
+{
+	if (map->aio.data)
+		zfree(&map->aio.data);
+}
+#else
+static int perf_mmap__aio_mmap(struct perf_mmap *map __maybe_unused,
+			       struct mmap_params *mp __maybe_unused)
+{
+	return 0;
+}
+
+static void perf_mmap__aio_munmap(struct perf_mmap *map __maybe_unused)
+{
+}
+#endif
+
 void perf_mmap__munmap(struct perf_mmap *map)
 {
+	perf_mmap__aio_munmap(map);
 	if (map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -197,7 +244,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
 
-	return 0;
+	return perf_mmap__aio_mmap(map, mp);
 }
 
 static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e603314dc792..a46dbdcdcc8a 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -6,6 +6,9 @@
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include <stdbool.h>
+#ifdef HAVE_AIO_SUPPORT
+#include <aio.h>
+#endif
 #include "auxtrace.h"
 #include "event.h"
 
@@ -26,6 +29,12 @@ struct perf_mmap {
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+#ifdef HAVE_AIO_SUPPORT
+	struct {
+		void 		 *data;
+		struct aiocb	 cblock;
+	} aio;
+#endif
 };
 
 /*
@@ -57,7 +66,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask;
+	int			    prot, mask, nr_cblocks;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
