Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4B3C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00942173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547088953;
	bh=jCKgUH7uqc/x2GAyDS7k9iEgFpZYL45XwdcibUh1WEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q9cJ9dmN4v0L/4dBrlUeBIWjCwtYYpdnIM9QmI0772DoCqFTMs2vQdU7TzID9ePKn
	 7lnMy9JQ8HXHXX/F3ZnDnyOelZFoDDSeJU2MN3ko5X/Sy7iCaNudLWlxc/rE+U3hgl
	 KaVEfSL4lCxAKJ9wRyztPXxQzF4TAXm8mk2oWLsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfAJCzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfAJCzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:55:51 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 904C520665;
        Thu, 10 Jan 2019 02:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547088950;
        bh=jCKgUH7uqc/x2GAyDS7k9iEgFpZYL45XwdcibUh1WEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DF/jVkx/0ZWUisGlDbZqo75016fBqheE28Wkbr6sRbvL55rn074oPY7Ku9Z9dejYH
         tv8ZmDW9NLM+b5JkKUyTu1oWbb5F7ttz17KCWsxmv5iOBXvE7LT1HpCr4cPobWZIzl
         CiHgp8XGAMF1zJ7dncQjvsENrXNCLDhFyO4gETxI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH 3/9] x86/kprobes: Prohibit probing on functions before kprobe_int3_handler()
Date:   Thu, 10 Jan 2019 11:55:27 +0900
Message-Id: <154708892758.6325.11141493993747688257.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154708884117.6325.4454464467156828009.stgit@devbox>
References: <154708884117.6325.4454464467156828009.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prohibit probing on the functions called before kprobe_int3_handler()
in do_int3(). More specifically, ftrace_int3_handler(),
poke_int3_handler(), and ist_enter(). And since rcu_nmi_enter() is
called by ist_enter(), it also should be marked as NOKPROBE_SYMBOL.

Since those are handled before kprobe_int3_handler(), probing those
functions can cause a breakpoint recursion and crash the kernel.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/alternative.c |    3 ++-
 arch/x86/kernel/ftrace.c      |    3 ++-
 arch/x86/kernel/traps.c       |    1 +
 kernel/rcu/tree.c             |    2 ++
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
index 7ee8067cbf45..22a548919228 100644
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

