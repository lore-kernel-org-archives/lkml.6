Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeDFTNm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbeDFTNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:13:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65D121837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406191334.497702511@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 15:08:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: [PATCH 4/4 v2] init: Have initcall_debug still work without CONFIG_TRACEPOINTS
References: <20180406190854.875810797@goodmis.org>
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
 init/main.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 589d1226016e..07f56d667c33 100644
--- a/init/main.c
+++ b/init/main.c
@@ -832,6 +832,7 @@ trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
 
 static ktime_t initcall_calltime;
 
+#ifdef TRACEPOINTS_ENABLED
 static void __init initcall_debug_enable(void)
 {
 	int ret;
@@ -842,6 +843,25 @@ static void __init initcall_debug_enable(void)
 					      &initcall_calltime);
 	WARN(ret, "Failed to register initcall tracepoints\n");
 }
+# define do_trace_initcall_start	trace_initcall_start
+# define do_trace_initcall_finish	trace_initcall_finish
+#else
+static inline initcall_debug_enable(void)
+{
+}
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
@@ -852,9 +872,9 @@ int __init_or_module do_one_initcall(initcall_t fn)
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
-	trace_initcall_start(fn);
+	do_trace_initcall_start(fn);
 	ret = fn();
-	trace_initcall_finish(fn, ret);
+	do_trace_initcall_finish(fn, ret);
 
 	msgbuf[0] = 0;
 
-- 
2.15.1
