Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeFCMdM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbeFCM1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:27:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/29] tools include: Adopt __compiletime_error
Date: Sun,  3 Jun 2018 14:26:31 +0200
Message-Id: <20180603122652.17453-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 4900653829175f60356efc279695bb23c59483c3 upstream.

>From the kernel, get the gcc one and provide the fallback so that we can
continue build with other compilers, such as with clang.

Will be used by tools/arch/x86/include/asm/cmpxchg.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-pecgz6efai4a9euuk4rxuotr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/compiler-gcc.h | 4 ++++
 tools/include/linux/compiler.h     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index 48af2f10a42d..616935f1ff56 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -12,3 +12,7 @@
 #if GCC_VERSION >= 70000 && !defined(__CHECKER__)
 # define __fallthrough __attribute__ ((fallthrough))
 #endif
+
+#if GCC_VERSION >= 40300
+# define __compiletime_error(message) __attribute__((error(message)))
+#endif /* GCC_VERSION >= 40300 */
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 8de163b17c0d..c9e65e8faacd 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -5,6 +5,10 @@
 #include <linux/compiler-gcc.h>
 #endif
 
+#ifndef __compiletime_error
+# define __compiletime_error(message)
+#endif
+
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
 #define barrier() __asm__ __volatile__("": : :"memory")
-- 
2.17.1
