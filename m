Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D5C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24171208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24171208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeLESdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeLESdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:33:07 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00BEA20892;
        Wed,  5 Dec 2018 18:33:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUbyp-0007jB-U9; Wed, 05 Dec 2018 13:33:03 -0500
Message-Id: <20181205183303.828422192@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 12:48:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        keescook@chromium.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/2] ftrace: Allow ftrace_replace_code() to be schedulable
References: <20181205174852.435233070@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function ftrace_replace_code() is the ftrace engine that does the
work to modify all the nops into the calls to the function callback in
all the functions being traced.

The generic version which is normally called from stop machine, but an
architecture can implement a non stop machine version and still use the
generic ftrace_replace_code(). When an architecture does this,
ftrace_replace_code() may be called from a schedulable context, where
it can allow the code to be preemptible, and schedule out.

In order to allow an architecture to make ftrace_replace_code()
schedulable, a new command flag is added called:

 FTRACE_SCHEDULABLE

Which can be or'd to the command that is passed to
ftrace_modify_all_code() that calls ftrace_replace_code() and will have
it call cond_resched() in the loop that modifies the nops into the
calls to the ftrace trampolines.

Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  1 +
 kernel/trace/ftrace.c  | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index dd16e8218db3..c281b16baef9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -389,6 +389,7 @@ enum {
 	FTRACE_UPDATE_TRACE_FUNC	= (1 << 2),
 	FTRACE_START_FUNC_RET		= (1 << 3),
 	FTRACE_STOP_FUNC_RET		= (1 << 4),
+	FTRACE_SCHEDULABLE		= (1 << 5),
 };
 
 /*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 77734451cb05..74fdcacba514 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -77,6 +77,11 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
+enum {
+	FTRACE_MODIFY_ENABLE_FL		= (1 << 0),
+	FTRACE_MODIFY_SCHEDULABLE_FL	= (1 << 1),
+};
+
 static struct ftrace_ops ftrace_list_end __read_mostly = {
 	.func		= ftrace_stub,
 	.flags		= FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_STUB,
@@ -2415,10 +2420,12 @@ __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
 	return -1; /* unknow ftrace bug */
 }
 
-void __weak ftrace_replace_code(int enable)
+void __weak ftrace_replace_code(int mod_flags)
 {
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
+	int enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
+	int schedulable = mod_flags & FTRACE_MODIFY_SCHEDULABLE_FL;
 	int failed;
 
 	if (unlikely(ftrace_disabled))
@@ -2435,6 +2442,8 @@ void __weak ftrace_replace_code(int enable)
 			/* Stop processing */
 			return;
 		}
+		if (schedulable)
+			cond_resched();
 	} while_for_each_ftrace_rec();
 }
 
@@ -2548,8 +2557,12 @@ int __weak ftrace_arch_code_modify_post_process(void)
 void ftrace_modify_all_code(int command)
 {
 	int update = command & FTRACE_UPDATE_TRACE_FUNC;
+	int mod_flags = 0;
 	int err = 0;
 
+	if (command & FTRACE_SCHEDULABLE)
+		mod_flags = FTRACE_MODIFY_SCHEDULABLE_FL;
+
 	/*
 	 * If the ftrace_caller calls a ftrace_ops func directly,
 	 * we need to make sure that it only traces functions it
@@ -2567,9 +2580,9 @@ void ftrace_modify_all_code(int command)
 	}
 
 	if (command & FTRACE_UPDATE_CALLS)
-		ftrace_replace_code(1);
+		ftrace_replace_code(mod_flags | FTRACE_MODIFY_ENABLE_FL);
 	else if (command & FTRACE_DISABLE_CALLS)
-		ftrace_replace_code(0);
+		ftrace_replace_code(mod_flags);
 
 	if (update && ftrace_trace_function != ftrace_ops_list_func) {
 		function_trace_op = set_function_trace_op;
-- 
2.19.1


