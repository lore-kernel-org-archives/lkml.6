Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B488C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7438C21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391134AbeLUR45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:56:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388512AbeLUR45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:56:57 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9454D21939;
        Fri, 21 Dec 2018 17:56:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2d-0002HW-Md; Fri, 21 Dec 2018 12:56:55 -0500
Message-Id: <20181221175655.579715713@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [for-next][PATCH 02/24] arm64: ftrace: Set FTRACE_MAY_SLEEP before ftrace_modify_all_code()
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

It has been reported that ftrace_replace_code() which is called by
ftrace_modify_all_code() can cause a soft lockup warning for an
allmodconfig kernel. This is because all the debug options enabled
causes the loop in ftrace_replace_code() (which loops over all the
functions being enabled where there can be 10s of thousands), is too
slow, and never schedules out.

To solve this, setting FTRACE_MAY_SLEEP to the command passed into
ftrace_replace_code() will make it call cond_resched() in the loop,
which prevents the soft lockup warning from triggering.

Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org
Link: http://lkml.kernel.org/r/20181205183304.000714627@goodmis.org

Acked-by: Will Deacon <will.deacon@arm.com>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/kernel/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 57e962290df3..57d4e936a176 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -193,6 +193,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 
 void arch_ftrace_update_code(int command)
 {
+	command |= FTRACE_MAY_SLEEP;
 	ftrace_modify_all_code(command);
 }
 
-- 
2.19.2


