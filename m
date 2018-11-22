Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5164C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7441020866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405015AbeKVRxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:53:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41249 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404883AbeKVRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:53:53 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM7FLWN3692669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:15:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM7FKc43692666;
        Wed, 21 Nov 2018 23:15:20 -0800
Date:   Wed, 21 Nov 2018 23:15:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-dd1d0044dd1c1bf84a9b3e1f24e43347b26b96a0@git.kernel.org>
Cc:     acme@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, ben.gainey@arm.com, hpa@zytor.com,
        jolsa@kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, gduarte@redhat.com
Reply-To: gduarte@redhat.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, jolsa@kernel.org, hpa@zytor.com,
          namhyung@kernel.org, eranian@google.com, ben.gainey@arm.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          peterz@infradead.org, acme@redhat.com
In-Reply-To: <20181121154341.21521-1-jolsa@kernel.org>
References: <20181121154341.21521-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf jvmti: Separate jvmti cmlr check
Git-Commit-ID: dd1d0044dd1c1bf84a9b3e1f24e43347b26b96a0
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

Commit-ID:  dd1d0044dd1c1bf84a9b3e1f24e43347b26b96a0
Gitweb:     https://git.kernel.org/tip/dd1d0044dd1c1bf84a9b3e1f24e43347b26b96a0
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 21 Nov 2018 16:43:41 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 22:39:58 -0300

perf jvmti: Separate jvmti cmlr check

The Compiled Method Load Record (cmlr) is JDK specific interface to
access JVM stack info. This makes the jvmti agent code not compile under
another jdk, which does not support that.

Separating jvmti cmlr check into special feature check, and adding
HAVE_JVMTI_CMLR macro to indicate that.

Mark cmlr code in jvmti/libjvmti.c with HAVE_JVMTI_CMLR, so we can
compile it on system without cmlr support.

This change makes the jvmti compile with java-1.8.0-ibm package. It's
without the line numbers support, but the rest works.

Adding NO_JVMTI_CMLR compile variable for testing.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ben Gainey <ben.gainey@arm.com>
Cc: Gustavo Luiz Duarte <gduarte@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20181121154341.21521-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile          |  4 ++++
 tools/build/feature/test-jvmti-cmlr.c | 11 +++++++++++
 tools/build/feature/test-jvmti.c      |  1 -
 tools/perf/Makefile.config            |  7 +++++++
 tools/perf/Makefile.perf              |  3 +++
 tools/perf/jvmti/libjvmti.c           | 12 ++++++++++++
 6 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 325087a0429c..38c22e122cb0 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -55,6 +55,7 @@ FILES=                                          \
          test-sdt.bin                           \
          test-cxx.bin                           \
          test-jvmti.bin				\
+         test-jvmti-cmlr.bin			\
          test-sched_getcpu.bin			\
          test-setns.bin				\
          test-libopencsd.bin			\
@@ -267,6 +268,9 @@ $(OUTPUT)test-cxx.bin:
 $(OUTPUT)test-jvmti.bin:
 	$(BUILD)
 
+$(OUTPUT)test-jvmti-cmlr.bin:
+	$(BUILD)
+
 $(OUTPUT)test-llvm.bin:
 	$(BUILDXX) -std=gnu++11 				\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
diff --git a/tools/build/feature/test-jvmti-cmlr.c b/tools/build/feature/test-jvmti-cmlr.c
new file mode 100644
index 000000000000..c27b5b71a0f6
--- /dev/null
+++ b/tools/build/feature/test-jvmti-cmlr.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <jvmti.h>
+#include <jvmticmlr.h>
+
+int main(void)
+{
+	jvmtiCompiledMethodLoadInlineRecord	rec __attribute__((unused));
+	jvmtiCompiledMethodLoadRecordHeader	hdr __attribute__((unused));
+	PCStackInfo				p   __attribute__((unused));
+	return 0;
+}
diff --git a/tools/build/feature/test-jvmti.c b/tools/build/feature/test-jvmti.c
index 5cf31192f204..799916d2e3e3 100644
--- a/tools/build/feature/test-jvmti.c
+++ b/tools/build/feature/test-jvmti.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <jvmti.h>
-#include <jvmticmlr.h>
 
 int main(void)
 {
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 376d1f78be04..e110010e7faa 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -855,6 +855,13 @@ ifndef NO_JVMTI
   $(call feature_check,jvmti)
   ifeq ($(feature-jvmti), 1)
     $(call detected_var,JDIR)
+    ifndef NO_JVMTI_CMLR
+      FEATURE_CHECK_CFLAGS-jvmti-cmlr := $(FEATURE_CHECK_CFLAGS-jvmti)
+      $(call feature_check,jvmti-cmlr)
+      ifeq ($(feature-jvmti-cmlr), 1)
+        CFLAGS += -DHAVE_JVMTI_CMLR
+      endif
+    endif # NO_JVMTI_CMLR
   else
     $(warning No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel)
     NO_JVMTI := 1
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d95655489f7e..239e7b3270f4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -95,6 +95,9 @@ include ../scripts/utilities.mak
 #
 # Define NO_JVMTI if you do not want jvmti agent built
 #
+# Define NO_JVMTI_CMLR (debug only) if you do not want to process CMLR
+# data for java source lines.
+#
 # Define LIBCLANGLLVM if you DO want builtin clang and llvm support.
 # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
 # llvm-config is not in $PATH.
diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index 6add3e982614..aea7b1fe85aa 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -6,7 +6,9 @@
 #include <stdlib.h>
 #include <err.h>
 #include <jvmti.h>
+#ifdef HAVE_JVMTI_CMLR
 #include <jvmticmlr.h>
+#endif
 #include <limits.h>
 
 #include "jvmti_agent.h"
@@ -27,6 +29,7 @@ static void print_error(jvmtiEnv *jvmti, const char *msg, jvmtiError ret)
 	}
 }
 
+#ifdef HAVE_JVMTI_CMLR
 static jvmtiError
 do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
 		    jvmti_line_info_t *tab, jint *nr)
@@ -125,6 +128,15 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
 	*nr_lines = lines_total;
 	return JVMTI_ERROR_NONE;
 }
+#else /* HAVE_JVMTI_CMLR */
+
+static jvmtiError
+get_line_numbers(jvmtiEnv *jvmti __maybe_unused, const void *compile_info __maybe_unused,
+		 jvmti_line_info_t **tab __maybe_unused, int *nr_lines __maybe_unused)
+{
+	return JVMTI_ERROR_NONE;
+}
+#endif /* HAVE_JVMTI_CMLR */
 
 static void
 copy_class_filename(const char * class_sign, const char * file_name, char * result, size_t max_length)
