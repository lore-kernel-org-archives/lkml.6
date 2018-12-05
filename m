Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE45C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B3020892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B3020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeLEXse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:48:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbeLEXsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:30 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC0C21707;
        Wed,  5 Dec 2018 23:48:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu5-00008F-8X; Wed, 05 Dec 2018 18:48:29 -0500
Message-Id: <20181205234829.164618323@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:47:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 05/30] arm64: function_graph: Remove use of FTRACE_NOTRACE_DEPTH
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Functions in the set_graph_notrace no longer subtract FTRACE_NOTRACE_DEPTH
from curr_ret_stack, as that is now implemented via the trace_recursion
flags. Access to curr_ret_stack no longer needs to worry about checking for
this. curr_ret_stack is still initialized to -1, when there's not a shadow
stack allocated.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/kernel/stacktrace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 4989f7ea1e59..7723dadf25be 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -61,9 +61,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 			(frame->pc == (unsigned long)return_to_handler)) {
 		if (WARN_ON_ONCE(frame->graph == -1))
 			return -EINVAL;
-		if (frame->graph < -1)
-			frame->graph += FTRACE_NOTRACE_DEPTH;
-
 		/*
 		 * This is a case where function graph tracer has
 		 * modified a return address (LR) in a stack frame
-- 
2.19.1


