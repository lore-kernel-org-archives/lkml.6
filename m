Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755462AbeEANLB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:11:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:65261 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755345AbeEANK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:10:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,351,1520924400";
   d="scan'208";a="38382556"
From: changbin.du@intel.com
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 3/5] kernel hacking: new config NO_AUTO_INLINE to disable compiler atuo-inline optimizations
Date: Tue,  1 May 2018 21:00:12 +0800
Message-Id: <1525179614-14571-4-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
this option will make compiler not auto-inline kernel functions. By
enabling this option, all the kernel functions (including static ones)
will not be optimized out except those marked as inline or always_inline.
This is useful when you are using ftrace to understand the control flow
of kernel code or tracing some static functions.

Signed-off-by: Changbin Du <changbin.du@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 Makefile          |  6 ++++++
 lib/Kconfig.debug | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Makefile b/Makefile
index 619a85a..eb694f6 100644
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
index c40c7b7..90f35ad 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -198,6 +198,19 @@ config GDB_SCRIPTS
 	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
 	  for further details.
 
+config NO_AUTO_INLINE
+	bool "Disable compiler atuo-inline optimizations"
+	default n
+	help
+	  This will make compiler not auto-inline kernel functions for
+	  optimization. By enabling this option, all the kernel functions
+	  (including static ones) will not be optimized out except those
+	  marked as inline or always_inline. This is useful when you are
+	  using ftrace to understand the control flow of kernel code or
+	  tracing some static functions.
+
+	  Use only if you want to debug the kernel.
+
 config ENABLE_WARN_DEPRECATED
 	bool "Enable __deprecated logic"
 	default y
-- 
2.7.4
