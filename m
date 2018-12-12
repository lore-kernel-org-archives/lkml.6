Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA70C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCD920851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IjtZeB9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCD920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeLLRuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:50:54 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36983 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeLLRux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:50:53 -0500
Received: by mail-yb1-f194.google.com with SMTP id f4so8008096ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KiA5/WdjpRwlFUUpr7dF8lh/5i+oUE3Oturfa5exLE=;
        b=IjtZeB9FvRSQGisWutRPkI21c2s7/qnB2zAEG7Prax6ujYoY3Y/QSpir04yWqcw+iq
         IR3/S47cVNRQ9tNqRrAQw93G9RitHFv6W6aQiSD8/WOFI4FSNIHq2fgj3iU8tes9+MtB
         Pwa0eowKgHGDBDuoHzxQU2mBSVAMZWUZFGQ6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KiA5/WdjpRwlFUUpr7dF8lh/5i+oUE3Oturfa5exLE=;
        b=jCaOXrMevVG8Ujr5L9NM+jbikmyMf7MTid5HroRh+DNIC0YXAA77K48jUQBZM/NAl4
         7rRUUhgO8wq13es23pOHJIOPgGbMmL44odMYqV0blTkFDpC0THYzD+7URApir5paIxFb
         7efm/Me9pCe1/9sbOdVf22HthSIoqfIgN1JXeZyFvL24xwwAvyGqicjPDGR57AwD+V7k
         r4hRHb4BVTaUxZyG3PFgWJxV0v1sO/QAsz9kokek0YXyswV1j7INOj8lviwi7wjFabUI
         t5+GehGyGbrFOs9hroMw3Llkgv5EsYrvf9cuFJ4ysRngXXlth6AuVWD1JzherdjbUjYQ
         nTxw==
X-Gm-Message-State: AA+aEWbafO+2q0EDmCcAJgYvZ0CHNl8Jck7p7TSkH1uzKuQqSzQnW4wl
        ACDxnPLNs+r/MACH8yQGeiF81MYqfaE=
X-Google-Smtp-Source: AFSGD/VTNo+DEAsTXfugSiKGLpWiiJm3cThRqyv2x7JGAo3STBteQ1VJeraJb2er8xx5s8oNV5x4TA==
X-Received: by 2002:a25:d9d2:: with SMTP id q201mr2931264ybg.151.1544637051395;
        Wed, 12 Dec 2018 09:50:51 -0800 (PST)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id x4sm12746894ywj.80.2018.12.12.09.50.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 09:50:50 -0800 (PST)
Received: by mail-yw1-f44.google.com with SMTP id q11so7326315ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:50:49 -0800 (PST)
X-Received: by 2002:a81:98e:: with SMTP id 136mr21314411ywj.47.1544637049189;
 Wed, 12 Dec 2018 09:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20181212120844.19268-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181212120844.19268-1-ard.biesheuvel@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Dec 2018 09:50:37 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK50pY-bOxfE0mjBew_dqFcecKT6_1dd+rYQ5T54-fuDg@mail.gmail.com>
Message-ID: <CAGXu5jK50pY-bOxfE0mjBew_dqFcecKT6_1dd+rYQ5T54-fuDg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: enable per-task stack canaries
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        linux-hardened@lists.openwall.com,
        Laura Abbott <labbott@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 4:08 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> This enables the use of per-task stack canary values if GCC has
> support for emitting the stack canary reference relative to the
> value of sp_el0, which holds the task struct pointer in the arm64
> kernel.
>
> The $(eval) extends KBUILD_CFLAGS at the moment the make rule is
> applied, which means asm-offsets.o (which we rely on for the offset
> value) is built without the arguments, and everything built afterwards
> has the options set.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> v3: add all 3 options to the Kconfig cc-option check, to avoid relying on
>     implementation defined logic in the compiler regarding which options
>     need to appear together.
>
>  arch/arm64/Kconfig                      |  7 +++++++
>  arch/arm64/Makefile                     | 10 ++++++++++
>  arch/arm64/include/asm/stackprotector.h |  3 ++-
>  arch/arm64/kernel/asm-offsets.c         |  3 +++
>  arch/arm64/kernel/process.c             |  2 +-
>  5 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ea2ab0330e3a..e355946cde97 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1272,6 +1272,13 @@ config RANDOMIZE_MODULE_REGION_FULL
>           a limited range that contains the [_stext, _etext] interval of the
>           core kernel, so branch relocations are always in range.
>
> +config CC_HAVE_STACKPROTECTOR_SYSREG
> +       def_bool $(cc-option,-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=0)
> +
> +config STACKPROTECTOR_PER_TASK
> +       def_bool y
> +       depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
> +
>  endmenu
>
>  menu "Boot options"
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6cb9fc7e9382..79d927542322 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -56,6 +56,16 @@ KBUILD_AFLAGS        += $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS  += $(call cc-option,-mabi=lp64)
>  KBUILD_AFLAGS  += $(call cc-option,-mabi=lp64)
>
> +ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> +prepare: stack_protector_prepare
> +stack_protector_prepare: prepare0
> +       $(eval KBUILD_CFLAGS += -mstack-protector-guard=sysreg            \
> +                               -mstack-protector-guard-reg=sp_el0        \
> +                               -mstack-protector-guard-offset=$(shell    \
> +                       awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
> +                                       include/generated/asm-offsets.h))
> +endif
> +
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS        += -mbig-endian
>  CHECKFLAGS     += -D__AARCH64EB__
> diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
> index 58d15be11c4d..5884a2b02827 100644
> --- a/arch/arm64/include/asm/stackprotector.h
> +++ b/arch/arm64/include/asm/stackprotector.h
> @@ -34,7 +34,8 @@ static __always_inline void boot_init_stack_canary(void)
>         canary &= CANARY_MASK;
>
>         current->stack_canary = canary;
> -       __stack_chk_guard = current->stack_canary;
> +       if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
> +               __stack_chk_guard = current->stack_canary;
>  }
>
>  #endif /* _ASM_STACKPROTECTOR_H */
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 323aeb5f2fe6..65b8afc84466 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -46,6 +46,9 @@ int main(void)
>    DEFINE(TSK_TI_TTBR0,         offsetof(struct task_struct, thread_info.ttbr0));
>  #endif
>    DEFINE(TSK_STACK,            offsetof(struct task_struct, stack));
> +#ifdef CONFIG_STACKPROTECTOR
> +  DEFINE(TSK_STACK_CANARY,     offsetof(struct task_struct, stack_canary));
> +#endif
>    BLANK();
>    DEFINE(THREAD_CPU_CONTEXT,   offsetof(struct task_struct, thread.cpu_context));
>    BLANK();
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index d9a4c2d6dd8b..8a2d68f04e0d 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -59,7 +59,7 @@
>  #include <asm/processor.h>
>  #include <asm/stacktrace.h>
>
> -#ifdef CONFIG_STACKPROTECTOR
> +#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
>  #include <linux/stackprotector.h>
>  unsigned long __stack_chk_guard __read_mostly;
>  EXPORT_SYMBOL(__stack_chk_guard);
> --
> 2.19.2
>
> s



-- 
Kees Cook
