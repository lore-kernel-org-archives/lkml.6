Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1579C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3D220847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQDjwEiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3D220847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeKCDyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeKCDyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:54:11 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4582084A;
        Fri,  2 Nov 2018 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184357;
        bh=VNSbBlSGdwHJgPvZ+XJdYJvSFpvdqNq5Odqko+duQgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQDjwEiYcRPvZiFW3czPu12vCVYHZazpYjCY70wUozUgTqIgI4wCmEAXLWQush1v4
         qc1Ge3AP2vbffhJnj5vI8Zfc02Z5oQ+U6PTYGHnuivdGhtpJAQJJBmoA2AJrbgolD5
         L7TcTLjtNxObPdYJ8tCTM+NxsT8gbMW3nEso4EvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 143/150] sparc64: Make corrupted user stacks more debuggable.
Date:   Fri,  2 Nov 2018 19:35:05 +0100
Message-Id: <20181102182912.436326786@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Miller <davem@redhat.com>

[ Upstream commit 5b4fc3882a649c9411dd0dcad2ddb78e911d340e ]

Right now if we get a corrupted user stack frame we do a
do_exit(SIGILL) which is not helpful.

If under a debugger, this behavior causes the inferior process to
exit.  So the register and other state cannot be examined at the time
of the event.

Instead, conditionally log a rate limited kernel log message and then
force a SIGSEGV.

With bits and ideas borrowed (as usual) from powerpc.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/include/asm/switch_to_64.h |    3 ++-
 arch/sparc/kernel/process_64.c        |   25 +++++++++++++++++++------
 arch/sparc/kernel/rtrap_64.S          |    1 +
 arch/sparc/kernel/signal32.c          |   12 ++++++++++--
 arch/sparc/kernel/signal_64.c         |    6 +++++-
 5 files changed, 37 insertions(+), 10 deletions(-)

--- a/arch/sparc/include/asm/switch_to_64.h
+++ b/arch/sparc/include/asm/switch_to_64.h
@@ -67,6 +67,7 @@ do {	save_and_clear_fpu();						\
 } while(0)
 
 void synchronize_user_stack(void);
-void fault_in_user_windows(void);
+struct pt_regs;
+void fault_in_user_windows(struct pt_regs *);
 
 #endif /* __SPARC64_SWITCH_TO_64_H */
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -36,6 +36,7 @@
 #include <linux/sysrq.h>
 #include <linux/nmi.h>
 #include <linux/context_tracking.h>
+#include <linux/signal.h>
 
 #include <linux/uaccess.h>
 #include <asm/page.h>
@@ -521,7 +522,12 @@ static void stack_unaligned(unsigned lon
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) sp, 0, current);
 }
 
-void fault_in_user_windows(void)
+static const char uwfault32[] = KERN_INFO \
+	"%s[%d]: bad register window fault: SP %08lx (orig_sp %08lx) TPC %08lx O7 %08lx\n";
+static const char uwfault64[] = KERN_INFO \
+	"%s[%d]: bad register window fault: SP %016lx (orig_sp %016lx) TPC %08lx O7 %016lx\n";
+
+void fault_in_user_windows(struct pt_regs *regs)
 {
 	struct thread_info *t = current_thread_info();
 	unsigned long window;
@@ -534,9 +540,9 @@ void fault_in_user_windows(void)
 		do {
 			struct reg_window *rwin = &t->reg_window[window];
 			int winsize = sizeof(struct reg_window);
-			unsigned long sp;
+			unsigned long sp, orig_sp;
 
-			sp = t->rwbuf_stkptrs[window];
+			orig_sp = sp = t->rwbuf_stkptrs[window];
 
 			if (test_thread_64bit_stack(sp))
 				sp += STACK_BIAS;
@@ -547,8 +553,16 @@ void fault_in_user_windows(void)
 				stack_unaligned(sp);
 
 			if (unlikely(copy_to_user((char __user *)sp,
-						  rwin, winsize)))
+						  rwin, winsize))) {
+				if (show_unhandled_signals)
+					printk_ratelimited(is_compat_task() ?
+							   uwfault32 : uwfault64,
+							   current->comm, current->pid,
+							   sp, orig_sp,
+							   regs->tpc,
+							   regs->u_regs[UREG_I7]);
 				goto barf;
+			}
 		} while (window--);
 	}
 	set_thread_wsaved(0);
@@ -556,8 +570,7 @@ void fault_in_user_windows(void)
 
 barf:
 	set_thread_wsaved(window + 1);
-	user_exit();
-	do_exit(SIGILL);
+	force_sig(SIGSEGV, current);
 }
 
 asmlinkage long sparc_do_fork(unsigned long clone_flags,
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -39,6 +39,7 @@ __handle_preemption:
 		 wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 
 __handle_user_windows:
+		add			%sp, PTREGS_OFF, %o0
 		call			fault_in_user_windows
 661:		 wrpr			%g0, RTRAP_PSTATE, %pstate
 		/* If userspace is using ADI, it could potentially pass
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -371,7 +371,11 @@ static int setup_frame32(struct ksignal
 		get_sigframe(ksig, regs, sigframe_size);
 	
 	if (invalid_frame_pointer(sf, sigframe_size)) {
-		do_exit(SIGILL);
+		if (show_unhandled_signals)
+			pr_info("%s[%d] bad frame in setup_frame32: %08lx TPC %08lx O7 %08lx\n",
+				current->comm, current->pid, (unsigned long)sf,
+				regs->tpc, regs->u_regs[UREG_I7]);
+		force_sigsegv(ksig->sig, current);
 		return -EINVAL;
 	}
 
@@ -501,7 +505,11 @@ static int setup_rt_frame32(struct ksign
 		get_sigframe(ksig, regs, sigframe_size);
 	
 	if (invalid_frame_pointer(sf, sigframe_size)) {
-		do_exit(SIGILL);
+		if (show_unhandled_signals)
+			pr_info("%s[%d] bad frame in setup_rt_frame32: %08lx TPC %08lx O7 %08lx\n",
+				current->comm, current->pid, (unsigned long)sf,
+				regs->tpc, regs->u_regs[UREG_I7]);
+		force_sigsegv(ksig->sig, current);
 		return -EINVAL;
 	}
 
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -370,7 +370,11 @@ setup_rt_frame(struct ksignal *ksig, str
 		get_sigframe(ksig, regs, sf_size);
 
 	if (invalid_frame_pointer (sf)) {
-		do_exit(SIGILL);	/* won't return, actually */
+		if (show_unhandled_signals)
+			pr_info("%s[%d] bad frame in setup_rt_frame: %016lx TPC %016lx O7 %016lx\n",
+				current->comm, current->pid, (unsigned long)sf,
+				regs->tpc, regs->u_regs[UREG_I7]);
+		force_sigsegv(ksig->sig, current);
 		return -EINVAL;
 	}
 


