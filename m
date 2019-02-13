Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542F5C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD22222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389868AbfBMJBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:01:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36519 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfBMJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:01:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D909gu196018
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:00:09 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D909sE196015;
        Wed, 13 Feb 2019 01:00:09 -0800
Date:   Wed, 13 Feb 2019 01:00:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-c13324a505c7790fe91a9df35be2e0462abccdb0@git.kernel.org>
Cc:     mathieu.desnoyers@efficios.com, mingo@kernel.org, hpa@zytor.com,
        mhiramat@kernel.org, acme@redhat.com,
        torvalds@linux-foundation.org, rostedt@goodmis.org,
        jolsa@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        righi.andrea@gmail.com, tglx@linutronix.de
Reply-To: acme@redhat.com, mathieu.desnoyers@efficios.com,
          mingo@kernel.org, jolsa@redhat.com, peterz@infradead.org,
          mhiramat@kernel.org, hpa@zytor.com, righi.andrea@gmail.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          rostedt@goodmis.org, torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <154998793571.31052.11301258949601150994.stgit@devbox>
References: <154998793571.31052.11301258949601150994.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] x86/kprobes: Prohibit probing on functions before
 kprobe_int3_handler()
Git-Commit-ID: c13324a505c7790fe91a9df35be2e0462abccdb0
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

Commit-ID:  c13324a505c7790fe91a9df35be2e0462abccdb0
Gitweb:     https://git.kernel.org/tip/c13324a505c7790fe91a9df35be2e0462abccdb0
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 13 Feb 2019 01:12:15 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:16:39 +0100

x86/kprobes: Prohibit probing on functions before kprobe_int3_handler()

Prohibit probing on the functions called before kprobe_int3_handler()
in do_int3(). More specifically, ftrace_int3_handler(),
poke_int3_handler(), and ist_enter(). And since rcu_nmi_enter() is
called by ist_enter(), it also should be marked as NOKPROBE_SYMBOL.

Since those are handled before kprobe_int3_handler(), probing those
functions can cause a breakpoint recursion and crash the kernel.

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
Link: http://lkml.kernel.org/r/154998793571.31052.11301258949601150994.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 3 ++-
 arch/x86/kernel/ftrace.c      | 3 ++-
 arch/x86/kernel/traps.c       | 1 +
 kernel/rcu/tree.c             | 2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ebeac487a20c..e8b628b1b279 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -11,6 +11,7 @@
 #include <linux/stop_machine.h>
 #include <linux/slab.h>
 #include <linux/kdebug.h>
+#include <linux/kprobes.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -764,8 +765,8 @@ int poke_int3_handler(struct pt_regs *regs)
 	regs->ip = (unsigned long) bp_int3_handler;
 
 	return 1;
-
 }
+NOKPROBE_SYMBOL(poke_int3_handler);
 
 /**
  * text_poke_bp() -- update instructions on live kernel on SMP
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 8257a59704ae..3e3789c8f8e1 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -269,7 +269,7 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ret;
 }
 
-static int is_ftrace_caller(unsigned long ip)
+static nokprobe_inline int is_ftrace_caller(unsigned long ip)
 {
 	if (ip == ftrace_update_func)
 		return 1;
@@ -299,6 +299,7 @@ int ftrace_int3_handler(struct pt_regs *regs)
 
 	return 1;
 }
+NOKPROBE_SYMBOL(ftrace_int3_handler);
 
 static int ftrace_write(unsigned long ip, const char *val, int size)
 {
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9b7c4ca8f0a7..e289ce1332ab 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -111,6 +111,7 @@ void ist_enter(struct pt_regs *regs)
 	/* This code is a bit fragile.  Test it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "ist_enter didn't work");
 }
+NOKPROBE_SYMBOL(ist_enter);
 
 void ist_exit(struct pt_regs *regs)
 {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9180158756d2..74db52a0a466 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -62,6 +62,7 @@
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
 #include <linux/tick.h>
+#include <linux/kprobes.h>
 
 #include "tree.h"
 #include "rcu.h"
@@ -872,6 +873,7 @@ void rcu_nmi_enter(void)
 {
 	rcu_nmi_enter_common(false);
 }
+NOKPROBE_SYMBOL(rcu_nmi_enter);
 
 /**
  * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
