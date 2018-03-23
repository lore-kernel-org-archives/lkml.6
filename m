Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeCWPN3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbeCWPNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:13:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DA021841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180323151322.979520302@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 23 Mar 2018 11:02:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        =?ISO-8859-15?q?Am=C3=A9rico=20Wang?= <xiyou.wangcong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 3/3] init, tracing: instrument security and console initcall trace events
References: <20180323150241.878778199@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-init-tracing-instrument-security-and-console-initcal.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>

Trace events have been added around the initcall functions defined in
init/main.c. But console and security have their own initcalls. This adds
the trace events associated for those initcall functions.

Link: http://lkml.kernel.org/r/1521765208.19745.2.camel@polymtl.ca

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/printk/printk.c | 7 ++++++-
 security/security.c    | 8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f274fbef821d..cb5b35341d69 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -52,6 +52,7 @@
 #include <linux/uaccess.h>
 #include <asm/sections.h>
 
+#include <trace/events/initcall.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/printk.h>
 
@@ -2781,6 +2782,7 @@ EXPORT_SYMBOL(unregister_console);
  */
 void __init console_init(void)
 {
+	int ret;
 	initcall_t *call;
 
 	/* Setup the default TTY line discipline. */
@@ -2791,8 +2793,11 @@ void __init console_init(void)
 	 * inform about problems etc..
 	 */
 	call = __con_initcall_start;
+	trace_initcall_level("console");
 	while (call < __con_initcall_end) {
-		(*call)();
+		trace_initcall_start((*call));
+		ret = (*call)();
+		trace_initcall_finish((*call), ret);
 		call++;
 	}
 }
diff --git a/security/security.c b/security/security.c
index 1cd8526cb0b7..987afe3d464c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,6 +30,8 @@
 #include <linux/string.h>
 #include <net/flow.h>
 
+#include <trace/events/initcall.h>
+
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
@@ -45,10 +47,14 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 
 static void __init do_security_initcalls(void)
 {
+	int ret;
 	initcall_t *call;
 	call = __security_initcall_start;
+	trace_initcall_level("security");
 	while (call < __security_initcall_end) {
-		(*call) ();
+		trace_initcall_start((*call));
+		ret = (*call) ();
+		trace_initcall_finish((*call), ret);
 		call++;
 	}
 }
-- 
2.15.1
