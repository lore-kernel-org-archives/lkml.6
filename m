Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C807C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D872147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfBSI4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:56:35 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42279 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfBSI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:56:34 -0500
Received: by mail-vs1-f66.google.com with SMTP id b20so11237261vsl.9;
        Tue, 19 Feb 2019 00:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Z96Mit5A0RP1D3yPXOdSSsquopD04jVi68cG2LIdIw=;
        b=I8FPUwRKDj+ozMbiIE5QYGRa6AF8g0BQ4SElOj7bx/LRr+JWa4uMHXfOPxEjpN0rxY
         lTtPqUghIovbC4QtCDkTJFaYE8MwynESbNyuaoYosGqjHS1OpCt/pojtbi1p8aaRpByi
         Qec0uKGsVk8VIo4WPYbyUo4abbkyGUdWf2ySmC0jdGJ6xEh5xdey+TQ4FqhikTbZOYye
         HYrSB05RWBhi/D2hV7myEUgl0wYrZqLfsYdaq7yjW+SecFx7CZnBRMxCPs/QqspKtdmK
         hqxSWxRB03UzAHDyX8tqMOPRdjTM8sR+PC4urW+Z1tXABLsk7YHcek8cnskpfkmPlGsQ
         TaHA==
X-Gm-Message-State: AHQUAuYSUnRWGuKvUByuOJnKbd3kXugUdwWjxRT9Dv78EqC7AIKaoDoU
        gZC+Ef8zNoNRziwiGa87wX92vJdIeDPTMKUL1nBywBMz
X-Google-Smtp-Source: AHgI3IaBOteeD8XcyuO2KC96bVmy4eTd0zI+tF1qCYdBD9H8eP7eGBbe8hQOqvC/8adj6Tp81qOwBIgzVUFSf/q61VU=
X-Received: by 2002:a67:ead0:: with SMTP id s16mr10597233vso.63.1550566592527;
 Tue, 19 Feb 2019 00:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20190218210712.3503891-1-arnd@arndb.de> <20190218210712.3503891-3-arnd@arndb.de>
In-Reply-To: <20190218210712.3503891-3-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Feb 2019 09:56:19 +0100
Message-ID: <CAMuHMdUb47nLkorUpQ1ohD-WMaEG7d3DBAs7JWA6rvgKTZAGGw@mail.gmail.com>
Subject: Re: [PATCH 2/8] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
To:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
        linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Yury Norov <ynorov@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Yuri,

On Tue, Feb 19, 2019 at 3:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
> From: Yury Norov <ynorov@caviumnetworks.com>
>
> All new 32-bit architectures should have 64-bit userspace off_t type, but
> existing architectures has 32-bit ones.
>
> To enforce the rule, new config option is added to arch/Kconfig that defaults
> ARCH_32BIT_OFF_T to be disabled for new 32-bit architectures. All existing
> 32-bit architectures enable it explicitly.
>
> New option affects force_o_largefile() behaviour. Namely, if userspace
> off_t is 64-bits long, we have no reason to reject user to open big files.
>
> Note that even if architectures has only 64-bit off_t in the kernel
> (arc, c6x, h8300, hexagon, nios2, openrisc, and unicore32),
> a libc may use 32-bit off_t, and therefore want to limit the file size
> to 4GB unless specified differently in the open flags.
>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yury Norov <ynorov@marvell.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/Kconfig       |  1 +

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -276,6 +276,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
>  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
>         bool
>
> +config ARCH_32BIT_OFF_T
> +       bool
> +       depends on !64BIT
> +       help
> +         All new 32-bit architectures should have 64-bit off_t type on
> +         userspace side which corresponds to the loff_t kernel type. This
> +         is the requirement for modern ABIs. Some existing architectures
> +         already have 32-bit off_t. This option is enabled for all such

s/already/still/

> +         architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> +         h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> +         nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> +         unicore32, x86_32 and xtensa. This is the complete list. Any

Do we really need this list here?  It's intended to shrink only.
It includes removed architectures (blackfin, cris, frv, m32r, metag,
mn10300, score, tile32), but lacks several new ones affected by this
patch (c6x, csky, nds32, riscv).

> +         new 32-bit architecture should declare 64-bit off_t type on user
> +         side and so should not enable this option.
> +
>  config HAVE_REGS_AND_STACK_ACCESS_API
>         bool
>         help

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
