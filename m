Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934491AbeEII5n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:57:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:47882 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934229AbeEII4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:56:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="38541942"
From: changbin.du@intel.com
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH v4 2/4] kernel hacking: new config NO_AUTO_INLINE to disable compiler auto-inline optimizations
Date: Wed,  9 May 2018 16:43:14 +0800
Message-Id: <1525855396-7908-3-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525855396-7908-1-git-send-email-changbin.du@intel.com>
References: <1525855396-7908-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
this option will prevent the compiler from optimizing the kernel by
auto-inlining functions not marked with the inline keyword.

With this option, only functions explicitly marked with "inline" will
be inlined. This will allow the function tracer to trace more functions
because it only traces functions that the compiler has not inlined.

Signed-off-by: Changbin Du <changbin.du@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>

---
v2: Some grammar updates from Steven.
---
 Makefile          |  6 ++++++
 lib/Kconfig.debug | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Makefile b/Makefile
index d0d2652..6720c40 100644
--- a/Makefile
+++ b/Makefile
@@ -775,6 +775,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
 endif
 
+ifdef CONFIG_NO_AUTO_INLINE
+KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
+		   $(call cc-option, -fno-inline-small-functions) \
+		   $(call cc-option, -fno-inline-functions-called-once)
+endif
+
 ifdef CONFIG_FUNCTION_TRACER
 ifndef CC_FLAGS_FTRACE
 CC_FLAGS_FTRACE := -pg
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c40c7b7..da52243 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -198,6 +198,23 @@ config GDB_SCRIPTS
 	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
 	  for further details.
 
+config NO_AUTO_INLINE
+	bool "Disable compiler auto-inline optimizations"
+	help
+	  This will prevent the compiler from optimizing the kernel by
+	  auto-inlining functions not marked with the inline keyword.
+	  With this option, only functions explicitly marked with
+	  "inline" will be inlined. This will allow the function tracer
+	  to trace more functions because it only traces functions that
+	  the compiler has not inlined.
+
+	  Enabling this function can help debugging a kernel if using
+	  the function tracer. But it can also change how the kernel
+	  works, because inlining functions may change the timing,
+	  which could make it difficult while debugging race conditions.
+
+	  If unsure, select N.
+
 config ENABLE_WARN_DEPRECATED
 	bool "Enable __deprecated logic"
 	default y
-- 
2.7.4
