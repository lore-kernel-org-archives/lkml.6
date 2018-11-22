Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B41C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390D6208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lthS4o4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390D6208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404438AbeKVOOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404425AbeKVOOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:42 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C822075B;
        Thu, 22 Nov 2018 03:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857836;
        bh=Y7HdIIVKh7Ost+xG7gUnUyjg8QCUzjBUhEjK6d5gRTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lthS4o4wzc2mf33Tcy47Am35yMqzoCNBoqgDwkBsYoaWK3Q3Lmdr6X5T/atukJCcH
         ZPb8favfjVpIJnOLXq8pvuhW8OelNRys3e80OaxS3d8tuqRKO5WF3q0P55QqxGE+KB
         HY6idDgCSzBr1q4LuwGTtbsH0QRHgC+h6hvR7rkQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@gmail.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 18/28] tools build feature: Check if eventfd() is available
Date:   Thu, 22 Nov 2018 00:36:01 -0300
Message-Id: <20181122033611.15890-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A new 'perf bench epoll' will use this, and to disable it for older
systems, add a feature test for this API.

This is just a simple program that if successfully compiled, means that
the feature is present, at least at the library level, in a build that
sets the output directory to /tmp/build/perf (using O=/tmp/build/perf),
we end up with:

  $ ls -la /tmp/build/perf/feature/test-eventfd*
  -rwxrwxr-x. 1 acme acme 8176 Nov 21 15:58 /tmp/build/perf/feature/test-eventfd.bin
  -rw-rw-r--. 1 acme acme  588 Nov 21 15:58 /tmp/build/perf/feature/test-eventfd.d
  -rw-rw-r--. 1 acme acme    0 Nov 21 15:58 /tmp/build/perf/feature/test-eventfd.make.output
  $ ldd /tmp/build/perf/feature/test-eventfd.bin
	  linux-vdso.so.1 (0x00007fff3bf3f000)
	  libc.so.6 => /lib64/libc.so.6 (0x00007fa984061000)
	  /lib64/ld-linux-x86-64.so.2 (0x00007fa984417000)
  $ grep eventfd -A 2 -B 2 /tmp/build/perf/FEATURE-DUMP
  feature-dwarf=1
  feature-dwarf_getlocations=1
  feature-eventfd=1
  feature-fortify-source=1
  feature-sync-compare-and-swap=1
  $

The main thing here is that in the end we'll have -DHAVE_EVENTFD in
CFLAGS, and then the 'perf bench' entry needing that API can be
selectively pruned.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-wkeldwob7dpx6jvtuzl8164k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature       | 1 +
 tools/build/feature/Makefile       | 4 ++++
 tools/build/feature/test-all.c     | 5 +++++
 tools/build/feature/test-eventfd.c | 9 +++++++++
 tools/perf/Makefile.config         | 5 ++++-
 5 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-eventfd.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index d74bb9414d7c..8a123834a2a3 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -31,6 +31,7 @@ FEATURE_TESTS_BASIC :=                  \
         backtrace                       \
         dwarf                           \
         dwarf_getlocations              \
+        eventfd                         \
         fortify-source                  \
         sync-compare-and-swap           \
         get_current_dir_name            \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 304b984f11b9..325087a0429c 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -5,6 +5,7 @@ FILES=                                          \
          test-bionic.bin                        \
          test-dwarf.bin                         \
          test-dwarf_getlocations.bin            \
+         test-eventfd.bin                       \
          test-fortify-source.bin                \
          test-sync-compare-and-swap.bin         \
          test-get_current_dir_name.bin          \
@@ -102,6 +103,9 @@ $(OUTPUT)test-bionic.bin:
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-eventfd.bin:
+	$(BUILD)
+
 $(OUTPUT)test-get_current_dir_name.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 56722bfe6bdd..58f01b950195 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -50,6 +50,10 @@
 # include "test-dwarf_getlocations.c"
 #undef main
 
+#define main main_test_eventfd
+# include "test-eventfd.c"
+#undef main
+
 #define main main_test_libelf_getphdrnum
 # include "test-libelf-getphdrnum.c"
 #undef main
@@ -182,6 +186,7 @@ int main(int argc, char *argv[])
 	main_test_glibc();
 	main_test_dwarf();
 	main_test_dwarf_getlocations();
+	main_test_eventfd();
 	main_test_libelf_getphdrnum();
 	main_test_libelf_gelf_getnote();
 	main_test_libelf_getshdrstrndx();
diff --git a/tools/build/feature/test-eventfd.c b/tools/build/feature/test-eventfd.c
new file mode 100644
index 000000000000..f4de7ef00ccb
--- /dev/null
+++ b/tools/build/feature/test-eventfd.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+
+#include <sys/eventfd.h>
+
+int main(void)
+{
+	return eventfd(0, EFD_NONBLOCK);
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a0e8c23f9125..376d1f78be04 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -299,11 +299,14 @@ ifndef NO_BIONIC
   endif
 endif
 
+ifeq ($(feature-eventfd), 1)
+  CFLAGS += -DHAVE_EVENTFD
+endif
+
 ifeq ($(feature-get_current_dir_name), 1)
   CFLAGS += -DHAVE_GET_CURRENT_DIR_NAME
 endif
 
-
 ifdef NO_LIBELF
   NO_DWARF := 1
   NO_DEMANGLE := 1
-- 
2.14.5

