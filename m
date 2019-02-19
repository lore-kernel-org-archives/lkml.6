Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8408C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B758821738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfBSUGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:06:23 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43777 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfBSUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:06:22 -0500
Received: by mail-vs1-f68.google.com with SMTP id i15so9893860vsd.10;
        Tue, 19 Feb 2019 12:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrPDfFD419WXEO/Ox/P57kfC5mLoe6ykDtuRf6HwQCM=;
        b=JHLp+3/zJKpS5HzeXo/J85gRYj/sDd33Jg4KKSYZ+wAljaIWJ0oXTblRSr7lLWlhJW
         3fh6I49px4ZS+ZMkiBNzFDkMhrUjO3NFUIDphXotLKXNiq0mOXCgRo42OUaOpRXCkDLg
         wJtmy9mj3fH9a1yHpfGtVql6BU2fsANLBfdcv+XROlkNnumchBZ0vDJm7oHOixGriWYd
         f40g6784InPiEbdjxNZY8JoAQJpaLz5PXPwznPxJD5+ZLu8yenpfT4tVwHarTZg1eetC
         xooNV51YdCc76HXFsYciKv/9cd/SM2vT7hrtaa0ewqS61qs9q4o1LQp/F9XK9GMN6YMC
         WDTw==
X-Gm-Message-State: AHQUAuZVnyjBCJjWmQ8gUt/ciKfYnI+4+9kdHPS8/WwLxFG8CgApp5EQ
        GaUC9+eyi7iH+j2adVVbcsEYe44VQTkaystfeiE=
X-Google-Smtp-Source: AHgI3Ib18vAebzMi8QNZdyMzAby/KMYvso9+J5p1Ojoxw8uC/kqVFYjx0IxWnjTNVemie5I0XTSFanp0y00Ao6gKBz8=
X-Received: by 2002:a67:ead0:: with SMTP id s16mr12174157vso.63.1550606776640;
 Tue, 19 Feb 2019 12:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20190218210712.3503891-1-arnd@arndb.de> <20190218210712.3503891-5-arnd@arndb.de>
In-Reply-To: <20190218210712.3503891-5-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Feb 2019 21:06:04 +0100
Message-ID: <CAMuHMdVbz=_GFMnKx4PuxpmG9jpdA=Do2XnR3bY5wRZPM3G+Gw@mail.gmail.com>
Subject: Re: [PATCH 4/8] asm-generic: Make time32 syscall numbers optional
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
        linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Feb 19, 2019 at 3:34 AM Arnd Bergmann <arnd@arndb.de> wrote:
> We don't want new architectures to even provide the old 32-bit time_t
> based system calls any more, or define the syscall number macros.
>
> Add a new __ARCH_WANT_TIME32_SYSCALLS macro that gets enabled for all
> existing 32-bit architectures so we don't change any current behavior.

... (only) 32-bit architectures using the generic syscall list, right?

> Since this symbol is evaluated in user space as well, we cannot use
> a Kconfig CONFIG_* macro but have to define it in uapi/asm/unistd.h.
>
> On 64-bit architectures, the same system call numbers mostly refer to
> the system calls we want to keep, as they already pass 64-bit time_t.
>
> As new architectures no longer provide these, we need new exceptions
> in checksyscalls.sh.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arc/include/uapi/asm/unistd.h       |  1 +
>  arch/arm64/include/uapi/asm/unistd.h     |  1 +
>  arch/c6x/include/uapi/asm/unistd.h       |  1 +
>  arch/csky/include/uapi/asm/unistd.h      |  1 +
>  arch/h8300/include/uapi/asm/unistd.h     |  1 +
>  arch/hexagon/include/uapi/asm/unistd.h   |  1 +
>  arch/nds32/include/uapi/asm/unistd.h     |  1 +
>  arch/nios2/include/uapi/asm/unistd.h     |  1 +
>  arch/openrisc/include/uapi/asm/unistd.h  |  1 +
>  arch/riscv/include/uapi/asm/unistd.h     |  3 ++
>  arch/unicore32/include/uapi/asm/unistd.h |  1 +
>  include/uapi/asm-generic/unistd.h        | 36 ++++++++++++++++++++++++
>  scripts/checksyscalls.sh                 |  7 +++++
>  13 files changed, 56 insertions(+)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
