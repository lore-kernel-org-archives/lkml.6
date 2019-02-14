Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C576F21B1C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CjWgBq3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436567AbfBNTeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:34:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388779AbfBNTen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wAWlSc8WUsfd6EBHvaF0wPD58l9UhJKsmBtO3VlkGyA=; b=CjWgBq3Ax+WZX3gM7wzLHPdZk
        V4tNSceGnj1iBL4IkOxIO5BVz16F/kH1xjvHMKhkWgAG8ilpZCzibPnxHfO8p+SbCowqnWPoUPQV+
        1Jj7oI3MDQltSy4Zs35oW8qJbixqCMq1daFnTYanrS9l5pLQWC/lhjPGXnFW8vNNgRw8dnd2Fvibr
        MICIPPcqoR7DckRH7qwt2XllesnNnXuOdaqPcchON9gY7z0XZXXCWMPwJBH71n/Y+J2FKL7HPNPzz
        SODfx4L8dw8o0xdHG+dXwrE2nkiqrRQw5Ft1R0jdJTJ+Pwp/hmI1qZgHVZCFIfJHJPKn+Tpsd2R42
        jo+cccHBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guMmH-0007cB-QL; Thu, 14 Feb 2019 19:34:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45F2E20297D44; Thu, 14 Feb 2019 20:34:32 +0100 (CET)
Date:   Thu, 14 Feb 2019 20:34:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, valentin.schneider@arm.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190214193432.GR32477@hirez.programming.kicks-ass.net>
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:18:01AM -0500, Brian Gerst wrote:

> > --- a/arch/x86/include/asm/switch_to.h
> > +++ b/arch/x86/include/asm/switch_to.h
> > @@ -40,6 +40,7 @@ asmlinkage void ret_from_fork(void);
> >   * order of the fields must match the code in __switch_to_asm().
> >   */
> >  struct inactive_task_frame {
> > +       unsigned long flags;
> >  #ifdef CONFIG_X86_64
> >         unsigned long r15;
> >         unsigned long r14;
> 
> flags should be initialized in copy_thread_tls().  I think the new
> stack is zeroed already, but it would be better to explicitly set it.

Ah indeed. I somehow misread that code and thought we got initialized
with a copy of current.

Something like the below, right?

---

--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -127,6 +127,7 @@ int copy_thread_tls(unsigned long clone_
 	struct task_struct *tsk;
 	int err;
 
+	frame->flags = 0;
 	frame->bp = 0;
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -392,6 +392,7 @@ int copy_thread_tls(unsigned long clone_
 	childregs = task_pt_regs(p);
 	fork_frame = container_of(childregs, struct fork_frame, regs);
 	frame = &fork_frame->frame;
+	frame->flags = 0;
 	frame->bp = 0;
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
