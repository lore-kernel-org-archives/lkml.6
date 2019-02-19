Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA034C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E572146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfBSJKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:10:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39757 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfBSJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:10:33 -0500
Received: by mail-qt1-f194.google.com with SMTP id o6so22302201qtk.6;
        Tue, 19 Feb 2019 01:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgZfbfGDAIrLHm8OGM0hyr2IUJKMkKhN5SqMTkRLPEM=;
        b=jTM5rDy+3XD3Crgti4ne/1LV6bTtbI3g/bTNlcisPf8fU2aWjaPuBAoUxUT3Je7EAk
         bVyAPpkZ8KLulunX2SaPdF8qBnWUh/EcavQ6vdUIQAMvLk39N9OUfO3Xk160yaxLHofm
         xcefHmQsVoD9L5uqCLAEGU7AYoAhUSN6/F1g7NFtNPVvDM0JTn9S0VS7m0glcAqjVV1t
         nF9BJizvV+3Zx+JWzSFN4LfJdooyCCxX3/g07PYCPGPtFz/GatdtyZa7Y0ch+PDt58ss
         1tg8viDOK2jiSiYaFp2+wTPFStFC+4YkaaDbLEblw3lr2foR7krnYCzqX93D4+bhyva6
         hNtg==
X-Gm-Message-State: AHQUAuaUoACDyq/y1lFiXo6+B38wLLirRdH5oZoO833XcxJti0qivMDF
        x/wHzPo4ix48rbKW7R8MP7G07DyQYTz52em2h2w=
X-Google-Smtp-Source: AHgI3Ib1oYxLVKiIDWh7U+TqJfRLgTvr9IGfVMPPSTo6RezHMX4HFg8tiIfwxKyn6Qj1jqFpKTa9fVhbXPrYEoLnrfI=
X-Received: by 2002:a0c:d791:: with SMTP id z17mr20279762qvi.149.1550567432050;
 Tue, 19 Feb 2019 01:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20190218210712.3503891-1-arnd@arndb.de> <20190218210712.3503891-3-arnd@arndb.de>
 <CAMuHMdUb47nLkorUpQ1ohD-WMaEG7d3DBAs7JWA6rvgKTZAGGw@mail.gmail.com>
In-Reply-To: <CAMuHMdUb47nLkorUpQ1ohD-WMaEG7d3DBAs7JWA6rvgKTZAGGw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Feb 2019 10:10:15 +0100
Message-ID: <CAK8P3a3RTZDfc-4womPK2qbPTwuaP0Jin6Nzq6Ep3G4SnFpZvw@mail.gmail.com>
Subject: Re: [PATCH 2/8] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
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

On Tue, Feb 19, 2019 at 9:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd, Yuri,
>
> On Tue, Feb 19, 2019 at 3:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > From: Yury Norov <ynorov@caviumnetworks.com>
> >
> > All new 32-bit architectures should have 64-bit userspace off_t type, but
> > existing architectures has 32-bit ones.
> >
> > To enforce the rule, new config option is added to arch/Kconfig that defaults
> > ARCH_32BIT_OFF_T to be disabled for new 32-bit architectures. All existing
> > 32-bit architectures enable it explicitly.
> >
> > New option affects force_o_largefile() behaviour. Namely, if userspace
> > off_t is 64-bits long, we have no reason to reject user to open big files.
> >
> > Note that even if architectures has only 64-bit off_t in the kernel
> > (arc, c6x, h8300, hexagon, nios2, openrisc, and unicore32),
> > a libc may use 32-bit off_t, and therefore want to limit the file size
> > to 4GB unless specified differently in the open flags.
> >
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Yury Norov <ynorov@marvell.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> >  arch/m68k/Kconfig       |  1 +
>
> For m68k:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -276,6 +276,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
> >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >         bool
> >
> > +config ARCH_32BIT_OFF_T
> > +       bool
> > +       depends on !64BIT
> > +       help
> > +         All new 32-bit architectures should have 64-bit off_t type on
> > +         userspace side which corresponds to the loff_t kernel type. This
> > +         is the requirement for modern ABIs. Some existing architectures
> > +         already have 32-bit off_t. This option is enabled for all such
>
> s/already/still/
>
> > +         architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> > +         h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> > +         nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> > +         unicore32, x86_32 and xtensa. This is the complete list. Any
>
> Do we really need this list here?  It's intended to shrink only.
> It includes removed architectures (blackfin, cris, frv, m32r, metag,
> mn10300, score, tile32), but lacks several new ones affected by this
> patch (c6x, csky, nds32, riscv).

Right, I (finally)  took Yury's patch that was already several years old
without checking this text (I did make sure all architectures are changed
correctly).

I'll just remove the list here.

      Arnd
