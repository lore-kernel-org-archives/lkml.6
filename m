Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7920BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453962070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfACNLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:11:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60421 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfACNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:11:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DBGbZ1383761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:11:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DBGX61383758;
        Thu, 3 Jan 2019 05:11:16 -0800
Date:   Thu, 3 Jan 2019 05:11:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stanislav Fomichev <tipbot@zytor.com>
Message-ID: <tip-14541b1e7e723859ff2c75c6fc10cdbbec6b8c34@git.kernel.org>
Cc:     mathieu.poirier@linaro.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, mingo@kernel.org, sdf@google.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, sdf@google.com, tglx@linutronix.de,
          namhyung@kernel.org, hpa@zytor.com, peterz@infradead.org,
          jolsa@kernel.org, mathieu.poirier@linaro.org,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          mingo@kernel.org
In-Reply-To: <4dfc634cfcfb236883971b5107cf3c28ec8a31be.1542328222.git.sdf@google.com>
References: <4dfc634cfcfb236883971b5107cf3c28ec8a31be.1542328222.git.sdf@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf build: Don't unconditionally link the libbfd
 feature test to -liberty and -lz
Git-Commit-ID: 14541b1e7e723859ff2c75c6fc10cdbbec6b8c34
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

Commit-ID:  14541b1e7e723859ff2c75c6fc10cdbbec6b8c34
Gitweb:     https://git.kernel.org/tip/14541b1e7e723859ff2c75c6fc10cdbbec6b8c34
Author:     Stanislav Fomichev <sdf@google.com>
AuthorDate: Thu, 15 Nov 2018 16:32:01 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 21 Dec 2018 09:42:46 -0300

perf build: Don't unconditionally link the libbfd feature test to -liberty and -lz

Current libbfd feature test unconditionally links against -liberty and -lz.
While it's required on some systems (e.g. opensuse), it's completely
unnecessary on the others, where only -lbdf is sufficient (debian).
This patch streamlines (and renames) the following feature checks:

feature-libbfd           - only link against -lbfd (debian),
                           see commit 2cf9040714f3 ("perf tools: Fix bfd
			   dependency libraries detection")
feature-libbfd-liberty   - link against -lbfd and -liberty
feature-libbfd-liberty-z - link against -lbfd, -liberty and -lz (opensuse),
                           see commit 280e7c48c3b8 ("perf tools: fix BFD
			   detection on opensuse")

(feature-liberty{,-z} were renamed to feature-libbfd-liberty{,z}
for clarity)

The main motivation is to fix this feature test for bpftool which is
currently broken on debian (libbfd feature shows OFF, but we still
unconditionally link against -lbfd and it works).

Tested on debian with only -lbfd installed (without -liberty); I'd
appreciate if somebody on the other systems can test this new detection
method.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/4dfc634cfcfb236883971b5107cf3c28ec8a31be.1542328222.git.sdf@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature |  4 ++--
 tools/build/feature/Makefile | 10 +++++-----
 tools/perf/Makefile.config   | 44 +++++++++++++++++++++++---------------------
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index d47b8f73e2e7..5467c6bf9ceb 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -82,8 +82,8 @@ FEATURE_TESTS_EXTRA :=                  \
          cplus-demangle                 \
          hello                          \
          libbabeltrace                  \
-         liberty                        \
-         liberty-z                      \
+         libbfd-liberty                 \
+         libbfd-liberty-z               \
          libunwind-debug-frame          \
          libunwind-debug-frame-arm      \
          libunwind-debug-frame-aarch64  \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 2dbcc0d00f52..7ceb4441b627 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -17,8 +17,8 @@ FILES=                                          \
          test-libbfd.bin                        \
          test-disassembler-four-args.bin        \
          test-reallocarray.bin			\
-         test-liberty.bin                       \
-         test-liberty-z.bin                     \
+         test-libbfd-liberty.bin                \
+         test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
@@ -210,7 +210,7 @@ $(OUTPUT)test-libpython-version.bin:
 	$(BUILD)
 
 $(OUTPUT)test-libbfd.bin:
-	$(BUILD) -DPACKAGE='"perf"' -lbfd -lz -liberty -ldl
+	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
 
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
@@ -218,10 +218,10 @@ $(OUTPUT)test-disassembler-four-args.bin:
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
 
-$(OUTPUT)test-liberty.bin:
+$(OUTPUT)test-libbfd-liberty.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
 
-$(OUTPUT)test-liberty-z.bin:
+$(OUTPUT)test-libbfd-liberty-z.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
 
 $(OUTPUT)test-cplus-demangle.bin:
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 07c1857c3d7a..b441c88cafa1 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -702,18 +702,20 @@ endif
 
 ifeq ($(feature-libbfd), 1)
   EXTLIBS += -lbfd
+else
+  # we are on a system that requires -liberty and (maybe) -lz
+  # to link against -lbfd; test each case individually here
 
   # call all detections now so we get correct
   # status in VF output
-  $(call feature_check,liberty)
-  $(call feature_check,liberty-z)
-  $(call feature_check,cplus-demangle)
+  $(call feature_check,libbfd-liberty)
+  $(call feature_check,libbfd-liberty-z)
 
-  ifeq ($(feature-liberty), 1)
-    EXTLIBS += -liberty
+  ifeq ($(feature-libbfd-liberty), 1)
+    EXTLIBS += -lbfd -liberty
   else
-    ifeq ($(feature-liberty-z), 1)
-      EXTLIBS += -liberty -lz
+    ifeq ($(feature-libbfd-liberty-z), 1)
+      EXTLIBS += -lbfd -liberty -lz
     endif
   endif
 endif
@@ -723,24 +725,24 @@ ifdef NO_DEMANGLE
 else
   ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
     EXTLIBS += -liberty
-    CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
   else
-    ifneq ($(feature-libbfd), 1)
-      ifneq ($(feature-liberty), 1)
-        ifneq ($(feature-liberty-z), 1)
-          # we dont have neither HAVE_CPLUS_DEMANGLE_SUPPORT
-          # or any of 'bfd iberty z' trinity
-          ifeq ($(feature-cplus-demangle), 1)
-            EXTLIBS += -liberty
-            CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
-          else
-            msg := $(warning No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling)
-            CFLAGS += -DNO_DEMANGLE
-          endif
-        endif
+    ifeq ($(filter -liberty,$(EXTLIBS)),)
+      $(call feature_check,cplus-demangle)
+
+      # we dont have neither HAVE_CPLUS_DEMANGLE_SUPPORT
+      # or any of 'bfd iberty z' trinity
+      ifeq ($(feature-cplus-demangle), 1)
+        EXTLIBS += -liberty
+      else
+        msg := $(warning No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling)
+        CFLAGS += -DNO_DEMANGLE
       endif
     endif
   endif
+
+  ifneq ($(filter -liberty,$(EXTLIBS)),)
+    CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
+  endif
 endif
 
 ifneq ($(filter -lbfd,$(EXTLIBS)),)
