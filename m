Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CEAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B92A222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191638;
	bh=IVLhfASoypl3z8WYTNYk4lND0tvsWAiBJKNOwfiLGhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VaEtbRA5PdNGAZYVW4JZU1CSK6w29oMBeenZYJlBVlagKzEcWNB3DkbJ/E1BHYeoo
	 f5TlH8wfWQDcM8eyPwhJzW9x2Z2RFUxhT/yu0tULHtW3/CWZebSWENkUcYmgdhH1jQ
	 2hNlL8rOLHiQsl6mcnGmn4TS9aI9zAn+X2EVkbhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbfBOArR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388994AbfBOArP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:15 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 878342229F;
        Fri, 15 Feb 2019 00:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191634;
        bh=IVLhfASoypl3z8WYTNYk4lND0tvsWAiBJKNOwfiLGhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2sOaYvmnD/oUb8iTqdX//vIa/fXvjnwDDX6NdVdClwZjCFqb3yeP5D45U9Z6VUxzC
         sK9etQgeYNq5EwaZt4VzSvmk/XN5Wsy6KZmqm5oG7klwpNqrtms2ygjnRsS33BDOHK
         wk01bCjSXn4jLjZzEVh6aXOMuJUnBm64poNwicHY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        He Kuang <hekuang@huawei.com>,
        Jean Pihet <jean.pihet@linaro.org>,
        Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 20/43] perf unwind: Do not put libunwind-{x86,aarch64} in FEATURE_TESTS_BASIC
Date:   Thu, 14 Feb 2019 21:45:16 -0300
Message-Id: <20190215004539.23571-21-acme@kernel.org>
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
-- 
2.19.1

