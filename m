Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57190C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FB0206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfALJXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 04:23:10 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41622 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfALJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 04:23:09 -0500
Received: by mail-vs1-f68.google.com with SMTP id t17so10775072vsc.8;
        Sat, 12 Jan 2019 01:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3HeU2LQ/cz2Nrnvukv2BjoWfScL8eqQD3jP6qUNUCE=;
        b=sLQxDRUG85MnY2vSkQsFm2026ZqSYhLQKj9JcELwZk4BJL7SwEz+/TEYHP/rsfHpHb
         mu0dYTR/356Itv5u3rLpRztquY3xz7YPIHbiJF+PAszGbSL/clFGhJWxq/Lw0cveBCpA
         R1eUmND2T7zLmF8EnEv21IyK12TaPW0KicvNDLUxYuqYRT07q3bnpT7C+kC108Wi9pCu
         KnAoo5e1k+5Ezd7jaUNcn6tbfXK/yaW4Xr33ecWZe4PaFE+SiI79eIizXJODNpmTuTFq
         6FZQmytap/7c0uIy8HYdEpLF2Ug1oTF1jNl0SEnLkoZ/JqyHlJDY/87rjGw/CANqte7O
         K0Gw==
X-Gm-Message-State: AJcUukctROZUKidFSXoMhKx78look9BhutkFOxKTWsLNFo01BNHlOU4H
        8vis069Vz28BRAaTXL5hdNWVazLaYjs2DAa7Hvw=
X-Google-Smtp-Source: ALg8bN79osmCDPndVCdoP3Td76wczipf1/s4RmmrvcLBlDa66E+mqz+0MUQ1OfAWTzfGfc4YIGSM4Q58LzJuA1p+UFQ=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr7621758vsm.152.1547284988136;
 Sat, 12 Jan 2019 01:23:08 -0800 (PST)
MIME-Version: 1.0
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
 <1546443445-21075-3-git-send-email-firoz.khan@linaro.org> <20190110235428.GA10016@roeck-us.net>
In-Reply-To: <20190110235428.GA10016@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 12 Jan 2019 10:22:56 +0100
Message-ID: <CAMuHMdXuo1wMvwx-FZB6uBJahSSbqrmnxEAfepnhAS_odQkHDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sh: generate uapi header and syscall table header files
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Firoz Khan <firoz.khan@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 1:37 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Jan 02, 2019 at 09:07:25PM +0530, Firoz Khan wrote:
> > Unified system call table generation script must be run to
> > generate unistd_32.h and syscall_table.h files. This patch
> > will have changes which will invokes the script.
> >
> > This patch will generate unistd_32.h and syscall_table.h
> > files by the syscall table generation script invoked by
> > sh/Makefile and the generated files against the removed
> > files must be identical.
> >
> > The generated uapi header file will be included in uapi/-
> > asm/unistd.h and generated system call table header file
> > will be included by kernel/syscall_32.S file.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Have you tested this patch ?

All these series depend on "scripts: unify system call table generation
scripts"
https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Yeah, 0day also didn't know that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
