Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842E5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF36222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbfBMJBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:01:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48977 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfBMJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:01:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D8xWw1195711
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 00:59:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D8xVZi195708;
        Wed, 13 Feb 2019 00:59:31 -0800
Date:   Wed, 13 Feb 2019 00:59:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-877b145f0f4723133f934be402b8dfc769eb971f@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        rostedt@goodmis.org, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        torvalds@linux-foundation.org, righi.andrea@gmail.com
Reply-To: mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
          jolsa@redhat.com, mhiramat@kernel.org,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          hpa@zytor.com, righi.andrea@gmail.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          acme@redhat.com, tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <154998790744.31052.3016106262944915510.stgit@devbox>
References: <154998790744.31052.3016106262944915510.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] x86/kprobes: Move trampoline code into RODATA
Git-Commit-ID: 877b145f0f4723133f934be402b8dfc769eb971f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  877b145f0f4723133f934be402b8dfc769eb971f
Gitweb:     https://git.kernel.org/tip/877b145f0f4723133f934be402b8dfc769eb971f
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 13 Feb 2019 01:11:47 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:16:39 +0100

x86/kprobes: Move trampoline code into RODATA

Move optprobe trampoline code into RODATA since it is
not executed, but copied and modified to be used on
a trampoline buffer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154998790744.31052.3016106262944915510.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 544bd41a514c..f14262952015 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -97,6 +97,7 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 }
 
 asm (
+			".pushsection .rodata\n"
 			"optprobe_template_func:\n"
 			".global optprobe_template_entry\n"
 			"optprobe_template_entry:\n"
@@ -136,16 +137,10 @@ asm (
 #endif
 			".global optprobe_template_end\n"
 			"optprobe_template_end:\n"
-			".type optprobe_template_func, @function\n"
-			".size optprobe_template_func, .-optprobe_template_func\n");
+			".popsection\n");
 
 void optprobe_template_func(void);
 STACK_FRAME_NON_STANDARD(optprobe_template_func);
-NOKPROBE_SYMBOL(optprobe_template_func);
-NOKPROBE_SYMBOL(optprobe_template_entry);
-NOKPROBE_SYMBOL(optprobe_template_val);
-NOKPROBE_SYMBOL(optprobe_template_call);
-NOKPROBE_SYMBOL(optprobe_template_end);
 
 #define TMPL_MOVE_IDX \
 	((long)optprobe_template_val - (long)optprobe_template_entry)
