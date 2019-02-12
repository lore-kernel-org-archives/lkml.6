Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BBAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB484217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549987962;
	bh=eDQAQSChJXi5b7ULWr405cpMSDe2ysCPangIzwv5xzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KpcQ6LoxSN6pbN1AlMZzpR2LfH5ZNtA0HJCk4S7YiZneAEm5yTUKvt6BPHGLJ8tMH
	 BneJyqou2AIdm5csS/VhlDDmm/SmkZEIRC7sQD+L3IZv4/4no6KippzbeLZzV1/+rh
	 xO1u8DdhEtTdiMio4e562EvBmNVzMSUhHQr1BH5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfBLQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbfBLQMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:12:40 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A211E21773;
        Tue, 12 Feb 2019 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549987958;
        bh=eDQAQSChJXi5b7ULWr405cpMSDe2ysCPangIzwv5xzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyYst/mpdN1eLcwG9kEiuM2SemxHORRF1iaaBtg6cdjR6BqSBZChKMdgfdQ/1x/EJ
         ooOVeOwkZsvha22rFKkTXYmuYJYNronMWUuKdlUgM6OOmXICPIYgx53sPi2AfubxS1
         yjHO6GafzyPlDtUqYqoH3HqmBH/FowycNaai7MgM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip v3 03/10] x86/kprobes: Prohibit probing on functions before kprobe_int3_handler()
Date:   Wed, 13 Feb 2019 01:12:15 +0900
Message-Id: <154998793571.31052.11301258949601150994.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998785011.31052.1475728497912659748.stgit@devbox>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
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
index d458c7973c56..9a79c7808f9c 100644
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
index 2684a9d11e66..d26f9e9c3d83 100644
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

