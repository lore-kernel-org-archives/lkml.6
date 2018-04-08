Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeDHUMm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751919AbeDHUMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:12:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6691E2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201204.319568252@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:10:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 4/4] init: Have initcall_debug still work without CONFIG_TRACEPOINTS
References: <20180408201000.540816094@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0004-init-Have-initcall_debug-still-work-without-CONFIG_T.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add macros around the initcall_debug tracepoint code to have the code to
default back to the old method if CONFIG_TRACEPOINTS is not enabled.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 589d1226016e..6f6e6fc6f4b9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -496,7 +496,14 @@ void __init __weak mem_encrypt_init(void) { }
 
 bool initcall_debug;
 core_param(initcall_debug, initcall_debug, bool, 0644);
+
+#ifdef TRACEPOINTS_ENABLED
 static void __init initcall_debug_enable(void);
+#else
+static inline void initcall_debug_enable(void)
+{
+}
+#endif
 
 /*
  * Set up kernel memory allocators
@@ -832,6 +839,7 @@ trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
 
 static ktime_t initcall_calltime;
 
+#ifdef TRACEPOINTS_ENABLED
 static void __init initcall_debug_enable(void)
 {
 	int ret;
@@ -842,6 +850,22 @@ static void __init initcall_debug_enable(void)
 					      &initcall_calltime);
 	WARN(ret, "Failed to register initcall tracepoints\n");
 }
+# define do_trace_initcall_start	trace_initcall_start
+# define do_trace_initcall_finish	trace_initcall_finish
+#else
+static inline void do_trace_initcall_start(initcall_t fn)
+{
+	if (!initcall_debug)
+		return;
+	trace_initcall_start_cb(&initcall_calltime, fn);
+}
+static inline void do_trace_initcall_finish(initcall_t fn, int ret)
+{
+	if (!initcall_debug)
+		return;
+	trace_initcall_finish_cb(&initcall_calltime, fn, ret);
+}
+#endif /* !TRACEPOINTS_ENABLED */
 
 int __init_or_module do_one_initcall(initcall_t fn)
 {
@@ -852,9 +876,9 @@ int __init_or_module do_one_initcall(initcall_t fn)
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
-	trace_initcall_start(fn);
+	do_trace_initcall_start(fn);
 	ret = fn();
-	trace_initcall_finish(fn, ret);
+	do_trace_initcall_finish(fn, ret);
 
 	msgbuf[0] = 0;
 
-- 
2.16.3
