Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C9CC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4F424011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4F424011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbeGFBHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932379AbeGFBGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:06:40 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3583240C1;
        Fri,  6 Jul 2018 01:06:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fbFCo-0007Jr-Po; Thu, 05 Jul 2018 21:06:38 -0400
Message-Id: <20180706010638.697485209@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Jul 2018 21:06:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 5/6] ftrace: Nuke clear_ftrace_function
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yisheng Xie <xieyisheng1@huawei.com>

clear_ftrace_function is not used outside of ftrace.c and is not help to
use a function, so nuke it per Steve's suggestion.

Link: http://lkml.kernel.org/r/1517537689-34947-1-git-send-email-xieyisheng1@huawei.com

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  2 --
 kernel/trace/ftrace.c  | 13 +------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8154f4920fcb..ebb77674be90 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -223,7 +223,6 @@ extern enum ftrace_tracing_type_t ftrace_tracing_type;
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
index efed9c1cfb7e..caf9cbf35816 100644
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
@@ -6689,7 +6678,7 @@ void ftrace_kill(void)
 {
 	ftrace_disabled = 1;
 	ftrace_enabled = 0;
-	clear_ftrace_function();
+	ftrace_trace_function = ftrace_stub;
 }
 
 /**
-- 
2.17.1


