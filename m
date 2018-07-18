Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32E4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D17B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="BNA3GuFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D17B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbeGRKUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:20:44 -0400
Received: from 8bytes.org ([81.169.241.247]:54154 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbeGRKSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:34 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5952936B; Wed, 18 Jul 2018 11:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906881; bh=3R2HhEqt5TJK5cFHOcV7KJz4gbKUbE1kTAG5HEApY64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNA3GuFGYQ0pr6VppZFnJKSDhDhnyJsGQnxZSBzokJul1nEBoToH16vU0v5AdJVTL
         fH1w+2nJQrcAi95SKNL7VtLRlh/aXnPoeIVo7U8FwE0gaz5K8XAmzJaY0Tyvu3/o5/
         APnZsEWb8A4MeOG7zFmUAfcM3YsTz/pGkBM5nIFAZsgFo0socfxwetr68nXg88axmJ
         LS5jmDJYUslq9/sNcjOSJLiTmo0d63zUHg0iWt/B9LI3zAOVKFFtsqA9Hvukqnl/sS
         o+f1n0Sa73lM7nDDHNzzEBsfznlV3Jk/fL0uOX0ZR+MRSgZVHANsQQ7NSdjCgQ3jI8
         2e2ZkD6xZdW3Q==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 14/39] x86/entry: Rename update_sp0 to update_task_stack
Date:   Wed, 18 Jul 2018 11:40:51 +0200
Message-Id: <1531906876-13451-15-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function does not update sp0 anymore but updates makes
the task-stack visible for entry code. This is by either
writing it to sp1 or by doing a hypercall. Rename the
function to get rid of the misleading name.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/switch_to.h | 2 +-
 arch/x86/kernel/process_32.c     | 2 +-
 arch/x86/kernel/process_64.c     | 2 +-
 arch/x86/kernel/vm86_32.c        | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 8bc2f70..36bd243 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -87,7 +87,7 @@ static inline void refresh_sysenter_cs(struct thread_struct *thread)
 #endif
 
 /* This is used when switching tasks or entering/exiting vm86 mode. */
-static inline void update_sp0(struct task_struct *task)
+static inline void update_task_stack(struct task_struct *task)
 {
 	/* sp0 always points to the entry trampoline stack, which is constant: */
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0ae659d..2924fd4 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -285,7 +285,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	 * current_thread_info().  Refresh the SYSENTER configuration in
 	 * case prev or next is vm86.
 	 */
-	update_sp0(next_p);
+	update_task_stack(next_p);
 	refresh_sysenter_cs(next);
 	this_cpu_write(cpu_current_top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 12bb445..476e3dd 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -478,7 +478,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
 	/* Reload sp0. */
-	update_sp0(next_p);
+	update_task_stack(next_p);
 
 	/*
 	 * Now maybe reload the debug registers and handle I/O bitmaps
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 9d0b5af..1c03e4a 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -149,7 +149,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	preempt_disable();
 	tsk->thread.sp0 = vm86->saved_sp0;
 	tsk->thread.sysenter_cs = __KERNEL_CS;
-	update_sp0(tsk);
+	update_task_stack(tsk);
 	refresh_sysenter_cs(&tsk->thread);
 	vm86->saved_sp0 = 0;
 	preempt_enable();
@@ -374,7 +374,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 		refresh_sysenter_cs(&tsk->thread);
 	}
 
-	update_sp0(tsk);
+	update_task_stack(tsk);
 	preempt_enable();
 
 	if (vm86->flags & VM86_SCREEN_BITMAP)
-- 
2.7.4

