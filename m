Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9224C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898012054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeVKUKfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898012054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeIAAVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbeIAAVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:21:08 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5601F2054F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 20:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535746324;
        bh=RQs6/yOMhTugsxkaVXMJVTMjqd/H0yGR+OD5UmvxOB8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=AeVKUKfj3kdQChz0ixm61mhW9NCMtY3qXkfb0i9KjIyalXUomaGoApqIEE3ZtAY5m
         GPrDffWH9BAa4mIVpCcxwGqcWa8levzw9WOrdQnnGDzsLRdLqW/slQH56rKqVtSqZB
         OO3S0ZqgFGL7MfkmHhT/LF2vLUwMjxL7kUzf8U0Q=
Received: by mail-wm0-f53.google.com with SMTP id o18-v6so6433108wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:12:04 -0700 (PDT)
X-Gm-Message-State: APzg51BGoB6e8heDSUvaKRZMpl+yiNdVwAyCeSBPk/Zxj6aN6z3BFAVB
        yzZKZjvEVXZNnJf+am5fhTsYn8UhZ2dl718abL25/Q==
X-Google-Smtp-Source: ANB0VdZxPT3HPyXXTMdFqesOOjV4JEqZJHw6IU55vUwAKcSqVw5sOAipVjT0pjTCqaOovUMgX+1t5w4bFzh4+bUqPDY=
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr5362424wmq.36.1535746322847;
 Fri, 31 Aug 2018 13:12:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9045:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 13:11:42
 -0700 (PDT)
In-Reply-To: <20180831194151.123586-1-jannh@google.com>
References: <20180831194151.123586-1-jannh@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 Aug 2018 13:11:42 -0700
X-Gmail-Original-Message-ID: <CALCETrUMhg8nxeMr0VtBEveKDKAMk+16amDWGFduhAJWaU3O6A@mail.gmail.com>
Message-ID: <CALCETrUMhg8nxeMr0VtBEveKDKAMk+16amDWGFduhAJWaU3O6A@mail.gmail.com>
Subject: Re: [PATCH] x86/process: don't mix user/kernel regs in 64bit __show_regs
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bpetkov@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:41 PM, Jann Horn <jannh@google.com> wrote:
> When the kernel.print-fatal-signals sysctl has been enabled (I don't know
> whether anyone actually enables it), a simple userspace crash will cause
> the kernel to write a crash dump that contains, among other things, the
> kernel gsbase into dmesg.
>
> As suggested by Andy, limit output to pt_regs, FS_BASE and KERNEL_GS_BASE
> in this case.
>
> This also moves the bitness-specific logic from show_regs() into
> process_{32,64}.c.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> Fixes: 45807a1df9f5 ("vdso: print fatal signals")
> ---
> @Andy: Does this look like what you had in mind?

Yes.

Although there's another option: remove print-fatal-signals.

>
> Does this need a CC stable tag? I haven't put one on it for now.

Probably.

>
>  arch/x86/include/asm/kdebug.h | 12 +++++++++++-
>  arch/x86/kernel/dumpstack.c   | 11 +++--------
>  arch/x86/kernel/process_32.c  |  4 ++--
>  arch/x86/kernel/process_64.c  | 12 ++++++++++--
>  4 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
> index 395c9631e000..75f1e35e7c15 100644
> --- a/arch/x86/include/asm/kdebug.h
> +++ b/arch/x86/include/asm/kdebug.h
> @@ -22,10 +22,20 @@ enum die_val {
>         DIE_NMIUNKNOWN,
>  };
>
> +enum show_regs_mode {
> +       SHOW_REGS_SHORT,
> +       /*
> +        * For when userspace crashed, but we don't think it's our fault, and
> +        * therefore don't print kernel registers.
> +        */
> +       SHOW_REGS_USER,
> +       SHOW_REGS_ALL
> +};
> +
>  extern void die(const char *, struct pt_regs *,long);
>  extern int __must_check __die(const char *, struct pt_regs *, long);
>  extern void show_stack_regs(struct pt_regs *regs);
> -extern void __show_regs(struct pt_regs *regs, int all);
> +extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
>  extern void show_iret_regs(struct pt_regs *regs);
>  extern unsigned long oops_begin(void);
>  extern void oops_end(unsigned long, struct pt_regs *, int signr);
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 9c8652974f8e..574fe5d97ba2 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -135,7 +135,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
>          * they can be printed in the right context.
>          */
>         if (!partial && on_stack(info, regs, sizeof(*regs))) {
> -               __show_regs(regs, 0);
> +               __show_regs(regs, SHOW_REGS_SHORT);
>
>         } else if (partial && on_stack(info, (void *)regs + IRET_FRAME_OFFSET,
>                                        IRET_FRAME_SIZE)) {
> @@ -333,7 +333,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
>         oops_exit();
>
>         /* Executive summary in case the oops scrolled away */
> -       __show_regs(&exec_summary_regs, true);
> +       __show_regs(&exec_summary_regs, SHOW_REGS_ALL);
>
>         if (!signr)
>                 return;
> @@ -393,14 +393,9 @@ void die(const char *str, struct pt_regs *regs, long err)
>
>  void show_regs(struct pt_regs *regs)
>  {
> -       bool all = true;
> -
>         show_regs_print_info(KERN_DEFAULT);
>
> -       if (IS_ENABLED(CONFIG_X86_32))
> -               all = !user_mode(regs);
> -
> -       __show_regs(regs, all);
> +       __show_regs(regs, user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
>
>         /*
>          * When in-kernel, we also print out the stack at the time of the fault..
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 2924fd447e61..5046a3c9dec2 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -59,7 +59,7 @@
>  #include <asm/intel_rdt_sched.h>
>  #include <asm/proto.h>
>
> -void __show_regs(struct pt_regs *regs, int all)
> +void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
>  {
>         unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
>         unsigned long d0, d1, d2, d3, d6, d7;
> @@ -85,7 +85,7 @@ void __show_regs(struct pt_regs *regs, int all)
>         printk(KERN_DEFAULT "DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x EFLAGS: %08lx\n",
>                (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss, regs->flags);
>
> -       if (!all)
> +       if (mode != SHOW_REGS_ALL)
>                 return;
>
>         cr0 = read_cr0();
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index a451bc374b9b..ea5ea850348d 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -62,7 +62,7 @@
>  __visible DEFINE_PER_CPU(unsigned long, rsp_scratch);
>
>  /* Prints also some state that isn't saved in the pt_regs */
> -void __show_regs(struct pt_regs *regs, int all)
> +void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
>  {
>         unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L, fs, gs, shadowgs;
>         unsigned long d0, d1, d2, d3, d6, d7;
> @@ -87,9 +87,17 @@ void __show_regs(struct pt_regs *regs, int all)
>         printk(KERN_DEFAULT "R13: %016lx R14: %016lx R15: %016lx\n",
>                regs->r13, regs->r14, regs->r15);
>
> -       if (!all)
> +       if (mode == SHOW_REGS_SHORT)
>                 return;
>
> +       if (mode == SHOW_REGS_USER) {
> +               rdmsrl(MSR_FS_BASE, fs);
> +               rdmsrl(MSR_KERNEL_GS_BASE, shadowgs);
> +               printk(KERN_DEFAULT "FS:  %016lx GS:  %016lx\n",
> +                      fs, shadowgs);
> +               return;
> +       }
> +
>         asm("movl %%ds,%0" : "=r" (ds));
>         asm("movl %%cs,%0" : "=r" (cs));
>         asm("movl %%es,%0" : "=r" (es));
> --
> 2.19.0.rc1.350.ge57e33dbd1-goog
>
