Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeFDG7c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752179AbeFDG72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Perches <joe@perches.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 06/29] tools include: Introduce linux/compiler-gcc.h
Date: Mon,  4 Jun 2018 08:58:02 +0200
Message-Id: <20180604065802.412382941@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 tools/include/linux/compiler-gcc.h |   14 ++++++++++++++
 tools/include/linux/compiler.h     |   10 +++++-----
 tools/perf/MANIFEST                |    1 +
 3 files changed, 20 insertions(+), 5 deletions(-)

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
@@ -128,11 +132,7 @@ static __always_inline void __write_once
 
 
 #ifndef __fallthrough
-# if defined(__GNUC__) && __GNUC__ >= 7
-#  define __fallthrough __attribute__ ((fallthrough))
-# else
-#  define __fallthrough
-# endif
+# define __fallthrough
 #endif
 
 #endif /* _TOOLS_LINUX_COMPILER_H */
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
