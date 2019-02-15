Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FF0C10F0C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BEF222E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393079AbfBOJhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:37:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393049AbfBOJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:37:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9bUVI1117813
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:37:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9bU7R1117810;
        Fri, 15 Feb 2019 01:37:30 -0800
Date:   Fri, 15 Feb 2019 01:37:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vs6kwqsvwk7oxhs6z9mq87pp@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org, jean.pihet@linaro.org,
        acme@redhat.com, hekuang@huawei.com, will.deacon@arm.com,
        jolsa@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        wangnan0@huawei.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, wangnan0@huawei.com, hekuang@huawei.com,
          will.deacon@arm.com, jolsa@kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, mingo@kernel.org, jean.pihet@linaro.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf unwind: Do not put libunwind-{x86,aarch64} in
 FEATURE_TESTS_BASIC
Git-Commit-ID: 5c4d7c82c0dceccfdcf37062bd100322a69bd160
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

Commit-ID:  5c4d7c82c0dceccfdcf37062bd100322a69bd160
Gitweb:     https://git.kernel.org/tip/5c4d7c82c0dceccfdcf37062bd100322a69bd160
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 12 Feb 2019 16:34:32 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:05 -0300

perf unwind: Do not put libunwind-{x86,aarch64} in FEATURE_TESTS_BASIC

As it is not normally available on x86_64 not being tested on test-all.c
but being in FEATURE_TESTS_BASIC ends up implying that those features
are present, which leads to trying to link with those libraries and a
build failure now that test-all.c is finally again building
successfully:

  /usr/bin/ld: cannot find -lunwind-x86
  /usr/bin/ld: cannot find -lunwind-aarch64
  collect2: error: ld returned 1 exit status
  make[3]: *** [Makefile:199: /tmp/build/perf/plugin_jbd2.so] Error 1
  make[3]: *** Waiting for unfinished jobs....
  /usr/bin/ld: cannot find -lunwind-x86
  /usr/bin/ld: cannot find -lunwind-aarch64

So remove those features from there and explicitely test them.

And then move this patch to just before the last one that allows this to
be exposed, so that we keep the tree bisectable.

With all this in place we get, at this point:

  $ ldd /tmp/build/perf/feature/test-libunwind.bin
	linux-vdso.so.1 (0x00007fffa09c6000)
	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007fbcf4451000)
	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007fbcf4435000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007fbcf440c000)
	libelf.so.1 => /lib64/libelf.so.1 (0x00007fbcf43f2000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fbcf422c000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fbcf4211000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fbcf4491000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fbcf41ed000)
	libz.so.1 => /lib64/libz.so.1 (0x00007fbcf41d3000)
  $ cat /tmp/build/perf/feature/test-libunwind-x86.make.output
  test-libunwind-x86.c:2:10: fatal error: libunwind-x86.h: No such file or directory
   #include <libunwind-x86.h>
            ^~~~~~~~~~~~~~~~~
  compilation terminated.
  $ cat /tmp/build/perf/feature/test-libunwind-aarch64.make.output
  test-libunwind-aarch64.c:2:10: fatal error: libunwind-aarch64.h: No such file or directory
  #include <libunwind-aarch64.h>
           ^~~~~~~~~~~~~~~~~~~~~
  compilation terminated.
  $
  $ ldd ~/bin/perf | grep unwind
	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f5ceb24b000)
	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f5ceb22f000)
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Jean Pihet <jean.pihet@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-vs6kwqsvwk7oxhs6z9mq87pp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature | 8 ++++----
 tools/perf/Makefile.config   | 7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index bb9dca65eb5f..61e46d54a67c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -53,10 +53,6 @@ FEATURE_TESTS_BASIC :=                  \
         libslang                        \
         libcrypto                       \
         libunwind                       \
-        libunwind-x86                   \
-        libunwind-x86_64                \
-        libunwind-arm                   \
-        libunwind-aarch64               \
         pthread-attr-setaffinity-np     \
         pthread-barrier     		\
         reallocarray                    \
@@ -84,6 +80,10 @@ FEATURE_TESTS_EXTRA :=                  \
          libbfd-liberty                 \
          libbfd-liberty-z               \
          libopencsd                     \
+         libunwind-x86                  \
+         libunwind-x86_64               \
+         libunwind-arm                  \
+         libunwind-aarch64              \
          libunwind-debug-frame          \
          libunwind-debug-frame-arm      \
          libunwind-debug-frame-aarch64  \
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index cf4a8329c4c0..4b735042cad7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -109,6 +109,11 @@ FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
 FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
 
+FEATURE_CHECK_LDFLAGS-libunwind-arm = -lunwind -lunwind-arm
+FEATURE_CHECK_LDFLAGS-libunwind-aarch64 = -lunwind -lunwind-aarch64
+FEATURE_CHECK_LDFLAGS-libunwind-x86 = -lunwind -llzma -lunwind-x86
+FEATURE_CHECK_LDFLAGS-libunwind-x86_64 = -lunwind -llzma -lunwind-x86_64
+
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
@@ -485,6 +490,7 @@ endif
 ifndef NO_LIBUNWIND
   have_libunwind :=
 
+  $(call feature_check,libunwind-x86)
   ifeq ($(feature-libunwind-x86), 1)
     $(call detected,CONFIG_LIBUNWIND_X86)
     CFLAGS += -DHAVE_LIBUNWIND_X86_SUPPORT
@@ -493,6 +499,7 @@ ifndef NO_LIBUNWIND
     have_libunwind = 1
   endif
 
+  $(call feature_check,libunwind-aarch64)
   ifeq ($(feature-libunwind-aarch64), 1)
     $(call detected,CONFIG_LIBUNWIND_AARCH64)
     CFLAGS += -DHAVE_LIBUNWIND_AARCH64_SUPPORT
