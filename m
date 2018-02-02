Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755191AbeBBCYK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 21:24:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38745 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754363AbeBBCYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 21:24:03 -0500
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <rostedt@goodmis.org>, <mingo@redhat.com>
CC: <linux-kernel@vger.kernel.org>, Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH] ftrace: nuke clear_ftrace_function
Date: Fri, 2 Feb 2018 10:14:49 +0800
Message-ID: <1517537689-34947-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_ftrace_function is not used outside of ftrace.c and is not help to
use a function, so nuke it per Steve's suggestion.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 include/linux/ftrace.h |  2 --
 kernel/trace/ftrace.c  | 13 +------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9c3c9a3..15518b5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -223,7 +223,6 @@ enum ftrace_tracing_type_t {
  */
 int register_ftrace_function(struct ftrace_ops *ops);
 int unregister_ftrace_function(struct ftrace_ops *ops);
-void clear_ftrace_function(void);
 
 extern void ftrace_stub(unsigned long a0, unsigned long a1,
 			struct ftrace_ops *op, struct pt_regs *regs);
@@ -239,7 +238,6 @@ static inline int ftrace_nr_registered_ops(void)
 {
 	return 0;
 }
-static inline void clear_ftrace_function(void) { }
 static inline void ftrace_kill(void) { }
 static inline void ftrace_free_init_mem(void) { }
 static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index dabd9d1..6263a98 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -192,17 +192,6 @@ static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 	op->saved_func(ip, parent_ip, op, regs);
 }
 
-/**
- * clear_ftrace_function - reset the ftrace function
- *
- * This NULLs the ftrace function and in essence stops
- * tracing.  There may be lag
- */
-void clear_ftrace_function(void)
-{
-	ftrace_trace_function = ftrace_stub;
-}
-
 static void ftrace_sync(struct work_struct *work)
 {
 	/*
@@ -6691,7 +6680,7 @@ void ftrace_kill(void)
 {
 	ftrace_disabled = 1;
 	ftrace_enabled = 0;
-	clear_ftrace_function();
+	ftrace_trace_function = ftrace_stub;
 }
 
 /**
-- 
1.7.12.4
