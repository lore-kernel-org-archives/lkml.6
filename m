Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BA0C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446F02087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w5KFK4Mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446F02087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJLESF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeJLESF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:18:05 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11CA321470
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 20:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539290947;
        bh=XYtyvz9/iIeRtZ9DI6HakUMVjulnyPFa0BCn6lFuH7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w5KFK4Mq0YVRpp9b1xP7z/Z/fzXKaqzN9eaFAljUd7YI+fG21oL/qvHdPSRPKNF/m
         fhQPYkXkvRbJCQk0RqRwWsZ7POADwrdzJx+iGc6R6500+9oXH8ct1uXQtE/KDq2pZ9
         c5bJ65SmWTLGrZ+AZFflg9PFMcodNubBKL34Tjzk=
Received: by mail-wr1-f43.google.com with SMTP id d2-v6so11157131wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 13:49:06 -0700 (PDT)
X-Gm-Message-State: ABuFfog7KonjyuJM4Au4FqhG8i8EeWhrFW8dRRMOpDRHe06ZXKY0aiiA
        /XgZNJ9/krigY/FpDAeUVFyavgmbRaFHQDQtHSa0rQ==
X-Google-Smtp-Source: ACcGV60GEF2COOdvOlKVSwn1rtCnE1cDezApQozcKFLY5uTBSsAS0HCDhSYUtl1w2TjlBiusd9GdWCdLhaSjCdd+SmI=
X-Received: by 2002:a5d:610c:: with SMTP id v12-v6mr2959117wrt.308.1539290945477;
 Thu, 11 Oct 2018 13:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com>
In-Reply-To: <20181011185458.10186-1-kristen@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Oct 2018 13:48:54 -0700
X-Gmail-Original-Message-ID: <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com>
Message-ID: <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:55 AM Kristen Carlson Accardi
<kristen@linux.intel.com> wrote:
>
> This patch aims to make it harder to perform cache timing attacks on data
> left behind by system calls. If we have an error returned from a syscall,
> flush the L1 cache.
>
> It's important to note that this patch is not addressing any specific
> exploit, nor is it intended to be a complete defense against anything.
> It is intended to be a low cost way of eliminating some of side effects
> of a failed system call.
>
> A performance test using sysbench on one hyperthread and a script which
> attempts to repeatedly access files it does not have permission to access
> on the other hyperthread found no significant performance impact.
>
> Suggested-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  arch/x86/Kconfig        |  9 +++++++++
>  arch/x86/entry/common.c | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1a0be022f91d..bde978eb3b4e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -445,6 +445,15 @@ config RETPOLINE
>           code are eliminated. Since this includes the syscall entry path,
>           it is not entirely pointless.
>
> +config SYSCALL_FLUSH
> +       bool "Clear L1 Cache on syscall errors"
> +       default n
> +       help
> +         Selecting 'y' allows the L1 cache to be cleared upon return of
> +         an error code from a syscall if the CPU supports "flush_l1d".
> +         This may reduce the likelyhood of speculative execution style
> +         attacks on syscalls.
> +
>  config INTEL_RDT
>         bool "Intel Resource Director Technology support"
>         default n
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 3b2490b81918..26de8ea71293 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -268,6 +268,20 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
>         prepare_exit_to_usermode(regs);
>  }
>
> +__visible inline void l1_cache_flush(struct pt_regs *regs)
> +{
> +       if (IS_ENABLED(CONFIG_SYSCALL_FLUSH) &&
> +           static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> +               if (regs->ax == 0 || regs->ax == -EAGAIN ||
> +                   regs->ax == -EEXIST || regs->ax == -ENOENT ||
> +                   regs->ax == -EXDEV || regs->ax == -ETIMEDOUT ||
> +                   regs->ax == -ENOTCONN || regs->ax == -EINPROGRESS)

What about ax > 0?  (Or more generally, any ax outside the range of -1
.. -4095 or whatever the error range is.)  As it stands, it looks like
you'll flush on successful read(), write(), recv(), etc, and that
could seriously hurt performance on real workloads.

> +                       return;
> +
> +               wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> +       }
> +}
> +
>  #ifdef CONFIG_X86_64
>  __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>  {
> @@ -290,6 +304,8 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>                 regs->ax = sys_call_table[nr](regs);
>         }
>
> +       l1_cache_flush(regs);
> +
>         syscall_return_slowpath(regs);
>  }
>  #endif
> @@ -338,6 +354,8 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
>  #endif /* CONFIG_IA32_EMULATION */
>         }
>
> +       l1_cache_flush(regs);
> +
>         syscall_return_slowpath(regs);
>  }
>
> --
> 2.14.4
>
