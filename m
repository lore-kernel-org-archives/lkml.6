Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7E5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66C6222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191635;
	bh=+hE+qlOmRMqLG/tS2/yHWVVTDT/v4Eay2XDgTd6ofWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nGhp18OG96Yh9o73b2MRhDgtgm8G3sQRE6TrpI4bx56/5z14wWqws4xjXnpitsLeM
	 M/5+pVrfjYV84DpeAaGurLFt2kShrZRkb0uEiVt3Hm2msPPuG5IpWhKXdS9GII/FG8
	 swR8rZnXl02C8nNarQXPGZBQhyazRXdlxDllelPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbfBOArN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388994AbfBOArL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:11 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B547521B68;
        Fri, 15 Feb 2019 00:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191630;
        bh=+hE+qlOmRMqLG/tS2/yHWVVTDT/v4Eay2XDgTd6ofWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3rMYQH8FXs5Ba6G2BHGy/VAT/F/5IVIddbrO8i8aebpIyJOHQaS/1ymQTRxJpWV0
         hDLdo/XJZSgXFdJ8XRxufx8UxFxmPMUNb1Q11yaS6/glS8h+4Kn3bexUhHb/dsFvfC
         AQNearcf4LmPbK4YnwjJhvz/Y9uBwoFukJ66xQg4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>
Subject: [PATCH 19/43] perf coresight: Do not test for libopencsd by default
Date:   Thu, 14 Feb 2019 21:45:15 -0300
Message-Id: <20190215004539.23571-20-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since it is not yet that generally available, avoid testing for the
presence of libcoresight in the fast path test-all.bin feature test.

  # dnf search opencsd
  No matches found.
  # dnf search OpenCSD
  No matches found.
  # cat /etc/fedora-release
  Fedora release 29 (Twenty Nine)
  #

I.e. right now, in my system test-all.bin is failing all the time since
Fedora29 doesn't have libopencsd available:

  $ cat /tmp/build/perf/feature/test-all.make.output
  In file included from test-all.c:174:
  test-libopencsd.c:2:10: fatal error: opencsd/c_api/opencsd_c_api.h: No such file or directory
   #include <opencsd/c_api/opencsd_c_api.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  compilation terminated.

See:

  6ab2b762befd ("perf build: Disable libbabeltrace check by default")

For the rationale, as soon as libopencsd becomes more generally packaged
and available, we do the same thing we did with babeltrace, enabling it
by default, as done in:

  24787afbcd01 ("perf tools: Enable LIBBABELTRACE by default")

For now, to explicitely ask for opencsd, make sure you have it installed
and use:

   make -C tools/perf CORESIGHT=1

The feature test output will be there as an empty file:

  $ ls -la /tmp/build/perf/feature/test-libopencsd.make.output

Because the binary used for the feature check was successfully built:

  $ ls -la /tmp/build/perf/feature/test-libopencsd.bin
  -rwxrwxr-x. 1 acme acme 18336 Feb 12 14:49 /tmp/build/perf/feature/test-libopencsd.bin
  $ ldd /tmp/build/perf/feature/test-libopencsd.bin
	linux-vdso.so.1 (0x00007fffe18cc000)
	libopencsd_c_api.so.0 => /lib64/libopencsd_c_api.so.0 (0x00007fb8e67f6000)
	libopencsd.so.0 => /lib64/libopencsd.so.0 (0x00007fb8e676f000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fb8e65a9000)
	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007fb8e6411000)
	libm.so.6 => /lib64/libm.so.6 (0x00007fb8e628d000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fb8e6272000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fb8e6828000)
  $

And the resulting perf binary will be linked with it:

  -rw-rw-r--. 1 acme acme 0 Feb 12 14:49 /tmp/build/perf/feature/test-libopencsd.make.output
  $ ldd ~/bin/perf | grep opencsd
	libopencsd_c_api.so.0 => /lib64/libopencsd_c_api.so.0 (0x00007fd43097f000)
	libopencsd.so.0 => /lib64/libopencsd.so.0 (0x00007fd4308f8000)
  $

To make sure this gets built before pushing things upstream I have a
ubuntu:19.04-x-arm64 container that has:

  [root@quaco x-arm64]# grep CORESIGHT Dockerfile
  ENV EXTRA_MAKE_ARGS=CORESIGHT=1
  [root@quaco x-arm64]#

So that I always build with libopencsd before pushing things upstream.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-20vyy39jw9jgrijesi30fgox@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature   | 2 +-
 tools/build/feature/test-all.c | 5 -----
 tools/perf/Makefile.config     | 3 ++-
 tools/perf/Makefile.perf       | 2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 5467c6bf9ceb..bb9dca65eb5f 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -70,7 +70,6 @@ FEATURE_TESTS_BASIC :=                  \
         sched_getcpu			\
         sdt				\
         setns				\
-        libopencsd			\
         libaio
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
@@ -84,6 +83,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libbabeltrace                  \
          libbfd-liberty                 \
          libbfd-liberty-z               \
+         libopencsd                     \
          libunwind-debug-frame          \
          libunwind-debug-frame-arm      \
          libunwind-debug-frame-aarch64  \
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 20cdaa4fc112..74329957553a 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -170,10 +170,6 @@
 # include "test-setns.c"
 #undef main
 
-#define main main_test_libopencsd
-# include "test-libopencsd.c"
-#undef main
-
 #define main main_test_libaio
 # include "test-libaio.c"
 #undef main
@@ -217,7 +213,6 @@ int main(int argc, char *argv[])
 	main_test_sched_getcpu();
 	main_test_sdt();
 	main_test_setns();
-	main_test_libopencsd();
 	main_test_libaio();
 
 	return 0;
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e6360d47e73a..cf4a8329c4c0 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -388,7 +388,8 @@ ifeq ($(feature-setns), 1)
   $(call detected,CONFIG_SETNS)
 endif
 
-ifndef NO_CORESIGHT
+ifdef CORESIGHT
+  $(call feature_check,libopencsd)
   ifeq ($(feature-libopencsd), 1)
     CFLAGS += -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
     LDFLAGS += $(LIBOPENCSD_LDFLAGS)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 09df1c8a4ec9..c2ccc54618d1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -102,7 +102,7 @@ include ../scripts/utilities.mak
 # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
 # llvm-config is not in $PATH.
 #
-# Define NO_CORESIGHT if you do not want support for CoreSight trace decoding.
+# Define CORESIGHT if you DO WANT support for CoreSight trace decoding.
 #
 # Define NO_AIO if you do not want support of Posix AIO based trace
 # streaming for record mode. Currently Posix AIO trace streaming is
-- 
2.19.1

