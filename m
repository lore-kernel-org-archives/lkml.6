Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE99C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEAE20844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3vS5kqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEAE20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbeGZOBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbeGZOBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:01:08 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B91B20844;
        Thu, 26 Jul 2018 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532609067;
        bh=qlaQnoTCwXDaPDd0kR1V3I423Qm0vaJvoM7GFz4uY3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3vS5kqen2NFv22TLMVSod8J0XUNkBr8bFwY3BCbf2WEzTrpUkb82SDQFb8v1aTq4
         VE1K+35cJO7N9GLoe7ZlrtsPfDXhDYL5xz41IG9muJtObZJSm6xixpKTdyBDhPvIl8
         IkGR+gWgy/p+RH+yRkQsYse+a6W5m39mRIns2J5c=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tracing: Remove orphaned function using_ftrace_ops_list_func().
Date:   Thu, 26 Jul 2018 21:44:04 +0900
Message-Id: <153260904427.12474.9952096317439329851.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153260898648.12474.8316095450186108842.stgit@devbox>
References: <153260898648.12474.8316095450186108842.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove using_ftrace_ops_list_func() since it is no more
used.

using_ftrace_ops_list_func() has been introduced by commit
7eea4fce0246 ("tracing/stack_trace: Skip 4 instead of 3
when using ftrace_ops_list_func") as a helper function,
but its caller has been removed by commit 72ac426a5bb0
("tracing: Clean up stack tracing and fix fentry updates").
So it is not called anymore.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index caf9cbf35816..b8b3324ca1c8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -313,11 +313,6 @@ static void update_ftrace_function(void)
 	ftrace_trace_function = func;
 }
 
-int using_ftrace_ops_list_func(void)
-{
-	return ftrace_trace_function == ftrace_ops_list_func;
-}
-
 static void add_ftrace_ops(struct ftrace_ops __rcu **list,
 			   struct ftrace_ops *ops)
 {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f8f86231ad90..a5d27d7943e7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -937,7 +937,6 @@ void ftrace_destroy_function_files(struct trace_array *tr);
 void ftrace_init_global_array_ops(struct trace_array *tr);
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func);
 void ftrace_reset_array_ops(struct trace_array *tr);
-int using_ftrace_ops_list_func(void);
 void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 void ftrace_init_tracefs_toplevel(struct trace_array *tr,
 				  struct dentry *d_tracer);

