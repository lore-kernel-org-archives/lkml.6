Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeFCM1t (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751477AbeFCM1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:27:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Perches <joe@perches.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 06/29] tools include: Introduce linux/compiler-gcc.h
Date: Sun,  3 Jun 2018 14:26:29 +0200
Message-Id: <20180603122652.17453-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 192614010a5052fe92611c7076ef664fd9bb60e8 upstream.

To match the kernel headers structure, setting up things that are
specific to gcc or to some specific version of gcc.

It gets included by linux/compiler.h when gcc is the compiler being
used.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Perches <joe@perches.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-fabcqfq4asodq9t158hcs8t3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/compiler-gcc.h | 14 ++++++++++++++
 tools/include/linux/compiler.h     | 10 +++++-----
 tools/perf/MANIFEST                |  1 +
 3 files changed, 20 insertions(+), 5 deletions(-)
 create mode 100644 tools/include/linux/compiler-gcc.h

diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
new file mode 100644
index 000000000000..48af2f10a42d
--- /dev/null
+++ b/tools/include/linux/compiler-gcc.h
@@ -0,0 +1,14 @@
+#ifndef _TOOLS_LINUX_COMPILER_H_
+#error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
+#endif
+
+/*
+ * Common definitions for all gcc versions go here.
+ */
+#define GCC_VERSION (__GNUC__ * 10000		\
+		     + __GNUC_MINOR__ * 100	\
+		     + __GNUC_PATCHLEVEL__)
+
+#if GCC_VERSION >= 70000 && !defined(__CHECKER__)
+# define __fallthrough __attribute__ ((fallthrough))
+#endif
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index d94179f94caa..6326ede9aece 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -1,6 +1,10 @@
 #ifndef _TOOLS_LINUX_COMPILER_H_
 #define _TOOLS_LINUX_COMPILER_H_
 
+#ifdef __GNUC__
+#include <linux/compiler-gcc.h>
+#endif
+
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
 #define barrier() __asm__ __volatile__("": : :"memory")
@@ -128,11 +132,7 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 
 
 #ifndef __fallthrough
-# if defined(__GNUC__) && __GNUC__ >= 7
-#  define __fallthrough __attribute__ ((fallthrough))
-# else
-#  define __fallthrough
-# endif
+# define __fallthrough
 #endif
 
 #endif /* _TOOLS_LINUX_COMPILER_H */
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index a511e5f31e36..8672f835ae4e 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -61,6 +61,7 @@ tools/include/asm-generic/bitops.h
 tools/include/linux/atomic.h
 tools/include/linux/bitops.h
 tools/include/linux/compiler.h
+tools/include/linux/compiler-gcc.h
 tools/include/linux/coresight-pmu.h
 tools/include/linux/filter.h
 tools/include/linux/hash.h
-- 
2.17.1
