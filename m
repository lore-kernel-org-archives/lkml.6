Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCWAd6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:33:58 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:55179 "EHLO smtp.polymtl.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbeCWAd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:33:57 -0400
Message-ID: <1521765208.19745.2.camel@polymtl.ca>
Subject: [PATCH] trace: instrument security and console initcall
From: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
To: rostedt@goodmis.org
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Mar 2018 20:33:28 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Poly-FromMTA: (dyn44.dorsal.polymtl.ca [132.207.72.44]) at Fri, 23 Mar 2018 00:33:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve, 
This is the patch for security & console initcall's instrumentation


Signed-off-by: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/printk/printk.c | 7 ++++++-
 security/security.c    | 8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f274fbef821d..0f10cfd1588e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -52,6 +52,7 @@
 #include <linux/uaccess.h>
 #include <asm/sections.h>
 
+#include <trace/events/boot.h>
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
index 1cd8526cb0b7..9de51d599bb4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,6 +30,8 @@
 #include <linux/string.h>
 #include <net/flow.h>
 
+#include <trace/events/boot.h>
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
2.11.0
