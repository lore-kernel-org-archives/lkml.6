Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC2C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C94D217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WQkRl9ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfAYPSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:18:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60928 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfAYPSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:18:49 -0500
Received: from zn.tnic (p200300EC2BCAC5007D55ACDD64304473.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:c500:7d55:acdd:6430:4473])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E20671EC027A;
        Fri, 25 Jan 2019 16:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548429528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RiS6G30gJtOFHUAhupwQyDrsFVbRBa625O/IM0AgeLw=;
        b=WQkRl9aeYEfU6dIA+svKqx6nEJzKQ0n6mhDwpBIQMhKleUoyfCqLi5asA8pU6VT9T01JCX
        qEGwHnhprl+XbPDwvaG4YBGLSxP/1lkqPcXvfRuIvyVBjQ4yzefq2Z4doIlJQTydUAsIbR
        beKypoqj+6usYMX4kWxHcryBO0crS94=
Date:   Fri, 25 Jan 2019 16:18:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 08/22] x86/fpu: Remove user_fpu_begin()
Message-ID: <20190125151840.GG27998@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-9-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-9-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:30PM +0100, Sebastian Andrzej Siewior wrote:
> user_fpu_begin() sets fpu_fpregs_owner_ctx to task's fpu struct. This is
> always the case since there is no lazy FPU anymore.
> 
> fpu_fpregs_owner_ctx is used during context switch to decide if it needs
> to load the saved registers or if the currently loaded registers are
> valid. It could be skipped during
> 	taskA -> kernel thread -> taskA
> 
> because the switch to kernel thread would not alter the CPU's FPU state.
> 
> Since this field is always updated during context switch and never
> invalidated, setting it manually (in user context) makes no difference.
> A kernel thread with kernel_fpu_begin() block could set
> fpu_fpregs_owner_ctx to NULL but a kernel thread does not use
> user_fpu_begin().
> This is a leftover from the lazy-FPU time.
> 
> Remove user_fpu_begin(), it does not change fpu_fpregs_owner_ctx's
> content.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h | 17 -----------------
>  arch/x86/kernel/fpu/core.c          |  4 +---
>  arch/x86/kernel/fpu/signal.c        |  1 -
>  3 files changed, 1 insertion(+), 21 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

Should we do this microoptimization in addition, to save us the
activation when the kernel thread here:

	taskA -> kernel thread -> taskA

doesn't call kernel_fpu_begin() and thus fpu_fpregs_owner_ctx remains
the same?

It would be a bit more correct as it won't invoke the
trace_x86_fpu_regs_activated() TP in case the FPU context is the same.

---
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index bfe0bfc7d0d1..ee1ac46a7820 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -510,7 +510,7 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  * Set up the userspace FPU context for the new task, if the task
  * has used the FPU.
  */
-static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
+static inline void switch_fpu_finish(struct fpu *prev_fpu, struct fpu *new_fpu, int cpu)
 {
 	if (static_cpu_has(X86_FEATURE_FPU)) {
 		if (!fpregs_state_valid(new_fpu, cpu)) {
@@ -518,7 +518,8 @@ static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 				copy_kernel_to_fpregs(&new_fpu->state);
 		}
 
-		fpregs_activate(new_fpu);
+		if (prev_fpu != new_fpu)
+			fpregs_activate(new_fpu);
 	}
 }
 
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 77d9eb43ccac..f8205df2df1d 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -290,7 +290,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	this_cpu_write(current_task, next_p);
 
-	switch_fpu_finish(next_fpu, cpu);
+	switch_fpu_finish(prev_fpu, next_fpu, cpu);
 
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ffea7c557963..5f153b963180 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -572,7 +572,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
-	switch_fpu_finish(next_fpu, cpu);
+	switch_fpu_finish(prev_fpu, next_fpu, cpu);
 
 	/* Reload sp0. */
 	update_task_stack(next_p);


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
