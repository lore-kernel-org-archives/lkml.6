Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965739AbeEJAS3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:18:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37601 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933499AbeEJAS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:18:28 -0400
Subject: [PATCH v3] ftrace: nuke clear_ftrace_function
To: Steven Rostedt <rostedt@goodmis.org>
References: <1525858436-10900-1-git-send-email-xieyisheng1@huawei.com>
 <20180509085643.4001dc9c@gandalf.local.home>
CC: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <f65a966e-5602-b9da-59c1-36e50e06f76a@huawei.com>
Date: Thu, 10 May 2018 08:17:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20180509085643.4001dc9c@gandalf.local.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_ftrace_function is not used outside of ftrace.c and is not help to
use a function, so nuke it per Steve's suggestion.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v3:
 - remove clear_ftrace_function() but make comment in line. - per Steve

v2:
 - nuke clear_ftrace_function instead of use it - per Steve

v1:
 - https://lkml.org/lkml/2018/1/29/944

 include/linux/ftrace.h |  2 --
 kernel/trace/ftrace.c  | 14 ++------------
 2 files changed, 2 insertions(+), 14 deletions(-)

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
index 8d83bcf..46e40a4 100644
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
@@ -6689,7 +6678,8 @@ void ftrace_kill(void)
 {
 	ftrace_disabled = 1;
 	ftrace_enabled = 0;
-	clear_ftrace_function();
+	/* This will stop tracing, but there may be a lag */
+	ftrace_trace_function = ftrace_stub;
 }

 /**
-- 
1.7.12.4
