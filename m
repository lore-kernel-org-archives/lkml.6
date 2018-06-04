Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeFDG7f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbeFDG7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 08/29] tools include: Adopt __compiletime_error
Date: Mon,  4 Jun 2018 08:58:04 +0200
Message-Id: <20180604065802.496045482@linuxfoundation.org>
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
 tools/include/linux/compiler-gcc.h |    4 ++++
 tools/include/linux/compiler.h     |    4 ++++
 2 files changed, 8 insertions(+)

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
