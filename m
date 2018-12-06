Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE83C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFFD20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHmEBsHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFFD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeLFQr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:47:59 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44797 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:47:58 -0500
Received: by mail-yb1-f196.google.com with SMTP id j145so898738ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwCJ/l0ExQEEZ6VCTiFIiDTYVjuXXSdUnCk3ofmsV7w=;
        b=JHmEBsHYRNp+z5ErKNOYB2ayeCvlBAHMEGrNujYfGdksbsOwdsv2lebxVwA9B9xqCQ
         BjTQIbIzbmma3mtqtRbAPqUPecwL2EiCquL/mXRp3lmU82EkaiLDc75sSa1ltE8vqw5a
         XaQURGo1zBME3WybHog+BScj4OcuHGkDhTwEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwCJ/l0ExQEEZ6VCTiFIiDTYVjuXXSdUnCk3ofmsV7w=;
        b=t1ie2MwZsae7c0PmRtQOlWkzOXmipY5YWdceoDQv72idfmqMpf/AhIEt83+Iv2+kQr
         MnawVOLaTyt+XHLQTGabvwuSnSLzKpK45UOc59CwRnUFgGsDPn3wRYBtpONkzVuitOVS
         FpTh1tB3yapK3Qqmfys5kC038w88PLXfmhJ2wkIh1f8vDVLYKLOrMYRULC7RPr5xqBqy
         9xjpjgfGTzArQ+fseZKspvmeMdPEYBvN88/ngTydlEGGyNu3OtrYvIziOqj83HxXtAJB
         5Va5k6Zvv5DFunMJhkhUdKGOhFF4duc09OWpHmNcTIAzN4uPqG5V9AZFw8h+MP2FQ+Vp
         zkUg==
X-Gm-Message-State: AA+aEWZ5N91RGsB4/kYoEh+/0pRk7PMXgPwsSjCnbWJ9VSl/DhpLGet+
        BxIHLDiTq4acnxo03jduZFO2w3NJLeY=
X-Google-Smtp-Source: AFSGD/UuJd+AuL+1TY0v0IRm13F2e6XI2kAqooJBoGarynPyZxN7TZ+X5CAf3H0Naf3aKcC8Gr0hPw==
X-Received: by 2002:a5b:310:: with SMTP id j16-v6mr28771287ybp.320.1544114875812;
        Thu, 06 Dec 2018 08:47:55 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id j65sm297324ywf.21.2018.12.06.08.47.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:47:54 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id d187so925854ybb.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:47:54 -0800 (PST)
X-Received: by 2002:a25:b783:: with SMTP id n3mr2639193ybh.141.1544114873483;
 Thu, 06 Dec 2018 08:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20181206150156.28210-1-david.abdurachmanov@gmail.com> <20181206150156.28210-2-david.abdurachmanov@gmail.com>
In-Reply-To: <20181206150156.28210-2-david.abdurachmanov@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Dec 2018 08:47:41 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJkQjyhz5GP+mCPTA9yH8rLds=Vuz9g_ed+hZ0Co7Lqeg@mail.gmail.com>
Message-ID: <CAGXu5jJkQjyhz5GP+mCPTA9yH8rLds=Vuz9g_ed+hZ0Co7Lqeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: add support for SECCOMP incl. filters
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, green.hu@gmail.com,
        deanbo422@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 7:02 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> The patch adds support for SECCOMP and SECCOMP_FILTER (BPF).
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> ---
>  arch/riscv/Kconfig                   | 14 ++++++++++++++
>  arch/riscv/include/asm/thread_info.h |  5 ++++-
>  arch/riscv/kernel/entry.S            | 27 +++++++++++++++++++++++++--
>  arch/riscv/kernel/ptrace.c           |  8 ++++++++
>  4 files changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a4f48f757204..49cd8e251547 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -29,6 +29,7 @@ config RISCV
>         select GENERIC_SMP_IDLE_THREAD
>         select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
>         select HAVE_ARCH_AUDITSYSCALL
> +       select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_MEMBLOCK_NODE_MAP
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_FUTEX_CMPXCHG if FUTEX
> @@ -228,6 +229,19 @@ menu "Kernel features"
>
>  source "kernel/Kconfig.hz"
>
> +config SECCOMP
> +       bool "Enable seccomp to safely compute untrusted bytecode"
> +       help
> +         This kernel feature is useful for number crunching applications
> +         that may need to compute untrusted bytecode during their
> +         execution. By using pipes or other transports made available to
> +         the process as file descriptors supporting the read/write
> +         syscalls, it's possible to isolate those applications in
> +         their own address space using seccomp. Once seccomp is
> +         enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
> +         and the task is only allowed to execute a few safe syscalls
> +         defined by each seccomp mode.
> +
>  endmenu
>
>  menu "Boot options"
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 1c9cc8389928..1fd6e4130cab 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -81,6 +81,7 @@ struct thread_info {
>  #define TIF_MEMDIE             5       /* is terminating due to OOM killer */
>  #define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrumentation */
>  #define TIF_SYSCALL_AUDIT      7       /* syscall auditing */
> +#define TIF_SECCOMP                    8       /* syscall secure computing */
>
>  #define _TIF_SYSCALL_TRACE     (1 << TIF_SYSCALL_TRACE)
>  #define _TIF_NOTIFY_RESUME     (1 << TIF_NOTIFY_RESUME)
> @@ -88,11 +89,13 @@ struct thread_info {
>  #define _TIF_NEED_RESCHED      (1 << TIF_NEED_RESCHED)
>  #define _TIF_SYSCALL_TRACEPOINT        (1 << TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_SYSCALL_AUDIT     (1 << TIF_SYSCALL_AUDIT)
> +#define _TIF_SECCOMP           (1 << TIF_SECCOMP)
>
>  #define _TIF_WORK_MASK \
>         (_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED)
>
>  #define _TIF_SYSCALL_WORK \
> -       (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
> +       (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT \
> +        _TIF_SECCOMP )
>
>  #endif /* _ASM_RISCV_THREAD_INFO_H */
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 355166f57205..e88ccbfa61ee 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -207,8 +207,25 @@ check_syscall_nr:
>         /* Check to make sure we don't jump to a bogus syscall number. */
>         li t0, __NR_syscalls
>         la s0, sys_ni_syscall
> -       /* Syscall number held in a7 */
> -       bgeu a7, t0, 1f
> +       /*
> +        * The tracer can change syscall number to valid/invalid value.
> +        * We use syscall_set_nr helper in syscall_trace_enter thus we
> +        * cannot trust the current value in a7 and have to reload from
> +        * the current task pt_regs.
> +        */
> +       REG_L a7, PT_A7(sp)
> +       /*
> +        * Syscall number held in a7.
> +        * If syscall number is above allowed value, redirect to ni_syscall.
> +        */
> +       bge a7, t0, 1f
> +       /*
> +        * Check if syscall is rejected by tracer or seccomp, i.e., a7 == -1.
> +        * If yes, we pretend it was executed.
> +        */
> +       li t1, -1
> +       beq a7, t1, ret_from_syscall_rejected
> +       /* Call syscall */
>         la s0, sys_call_table
>         slli t0, a7, RISCV_LGPTR
>         add s0, s0, t0
> @@ -219,6 +236,12 @@ check_syscall_nr:
>  ret_from_syscall:
>         /* Set user a0 to kernel a0 */
>         REG_S a0, PT_A0(sp)
> +       /*
> +        * We didn't execute the actual syscall.
> +        * Seccomp already set return value for the current task pt_regs.
> +        * (If it was configured with SECCOMP_RET_ERRNO/TRACE)
> +        */
> +ret_from_syscall_rejected:
>         /* Trace syscalls, but only if requested by the user. */
>         REG_L t0, TASK_TI_FLAGS(tp)
>         andi t0, t0, _TIF_SYSCALL_WORK
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index c1b51539c3e2..598e48b8ca2b 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -160,6 +160,14 @@ void do_syscall_trace_enter(struct pt_regs *regs)
>                 if (tracehook_report_syscall_entry(regs))
>                         syscall_set_nr(current, regs, -1);
>
> +       /*
> +        * Do the secure computing after ptrace; failures should be fast.
> +        * If this fails we might have return value in a0 from seccomp
> +        * (via SECCOMP_RET_ERRNO/TRACE).
> +        */
> +       if (secure_computing(NULL) == -1)
> +               syscall_set_nr(current, regs, -1);

On a -1 return, this should return immediately -- it should not
continue to process trace_sys_enter(), etc.

-Kees

> +
>  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
>         if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>                 trace_sys_enter(regs, syscall_get_nr(current, regs));
> --
> 2.19.2
>


-- 
Kees Cook
