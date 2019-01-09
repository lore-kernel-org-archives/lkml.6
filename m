Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248792173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfAILsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:48:36 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56119 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbfAILsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:48:30 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghCLQ-0007Al-BL; Wed, 09 Jan 2019 12:48:24 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 02/22] x86/fpu: Remove fpu__restore()
Date:   Wed,  9 Jan 2019 12:47:24 +0100
Message-Id: <20190109114744.10936-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109114744.10936-1-bigeasy@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users of fpu__restore() so it is time to remove it.
The comment regarding fpu__restore() and TS bit is stale since commit
  b3b0870ef3ffe ("i387: do not preload FPU state at task switch time")
and has no meaning since.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/preempt-locking.txt   |  1 -
 arch/x86/include/asm/fpu/internal.h |  1 -
 arch/x86/kernel/fpu/core.c          | 24 ------------------------
 arch/x86/kernel/process_32.c        |  4 +---
 arch/x86/kernel/process_64.c        |  4 +---
 5 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/Documentation/preempt-locking.txt b/Documentation/preempt-locking.txt
index 509f5a422d571..dce336134e54a 100644
--- a/Documentation/preempt-locking.txt
+++ b/Documentation/preempt-locking.txt
@@ -52,7 +52,6 @@ preemption must be disabled around such regions.
 
 Note, some FPU functions are already explicitly preempt safe.  For example,
 kernel_fpu_begin and kernel_fpu_end will disable and enable preemption.
-However, fpu__restore() must be called with preemption disabled.
 
 
 RULE #3: Lock acquire and release must be performed by same task
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index fa2c93cb42a27..67675d023d4f8 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -28,7 +28,6 @@ extern void fpu__initialize(struct fpu *fpu);
 extern void fpu__prepare_read(struct fpu *fpu);
 extern void fpu__prepare_write(struct fpu *fpu);
 extern void fpu__save(struct fpu *fpu);
-extern void fpu__restore(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
 extern int  fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2e5003fef51a9..1d3ae7988f7f2 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -303,30 +303,6 @@ void fpu__prepare_write(struct fpu *fpu)
 	}
 }
 
-/*
- * 'fpu__restore()' is called to copy FPU registers from
- * the FPU fpstate to the live hw registers and to activate
- * access to the hardware registers, so that FPU instructions
- * can be used afterwards.
- *
- * Must be called with kernel preemption disabled (for example
- * with local interrupts disabled, as it is in the case of
- * do_device_not_available()).
- */
-void fpu__restore(struct fpu *fpu)
-{
-	fpu__initialize(fpu);
-
-	/* Avoid __kernel_fpu_begin() right after fpregs_activate() */
-	kernel_fpu_disable();
-	trace_x86_fpu_before_restore(fpu);
-	fpregs_activate(fpu);
-	copy_kernel_to_fpregs(&fpu->state);
-	trace_x86_fpu_after_restore(fpu);
-	kernel_fpu_enable();
-}
-EXPORT_SYMBOL_GPL(fpu__restore);
-
 /*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index e471d8e6f0b24..7888a41a03cdb 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -267,9 +267,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/*
 	 * Leave lazy mode, flushing any hypercalls made here.
 	 * This must be done before restoring TLS segments so
-	 * the GDT and LDT are properly updated, and must be
-	 * done before fpu__restore(), so the TS bit is up
-	 * to date.
+	 * the GDT and LDT are properly updated.
 	 */
 	arch_end_context_switch(next_p);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6a62f4af9fcf7..e1983b3a16c43 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -538,9 +538,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/*
 	 * Leave lazy mode, flushing any hypercalls made here.  This
 	 * must be done after loading TLS entries in the GDT but before
-	 * loading segments that might reference them, and and it must
-	 * be done before fpu__restore(), so the TS bit is up to
-	 * date.
+	 * loading segments that might reference them.
 	 */
 	arch_end_context_switch(next_p);
 
-- 
2.20.1

