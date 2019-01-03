Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6856206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfACLn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:43:28 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45328 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfACLn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:43:27 -0500
Received: by mail-vs1-f65.google.com with SMTP id x28so20559270vsh.12;
        Thu, 03 Jan 2019 03:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sogc6oog6qbXkkDnDYVGxzws1ncfpWDJnuKXWr/cDJk=;
        b=nzn8F7LM2UdchNKZxUzjJNHPrYGfJSoT2Jx/EMLTLrt7eAakNa2l+OKIDsRlTOBwAO
         Wd+zOyM6vKdXLDtoYDZE7vGydDjJO/LLJL/MJGxGEB8UA1/rrFy0N5eO5W50lugO20iY
         of5i2Ty0RZ3F+LKRGWn1wKPSaFi006cbtIA65Ezham3X5M9or6b1TAH1uKeCpZh4Hy0i
         OJgZmFI30s68n0y0S+H4FgEyeiXn79cpjNSVd4eQPhT2wWnSFL+wABfXSE9d9vFHyhQF
         zA9J/mL/SDCEC9kZtSUiJd3L9VnkLcxuC0TRATp2sXdijC4kbMOx3CtWsgH/GhRm6jg9
         JhYQ==
X-Gm-Message-State: AJcUukfqTXX11TvFeFjNwFdPGIu4tt0vfahWjddaL1WbLIgrJbscsKWW
        v4Ci0XyAZLdhbFhn/pa3y957MYplkQEBVUFOlIc=
X-Google-Smtp-Source: ALg8bN6QJQavh/ZLKnLycstV1k9NYVto1p3B1xeD1fzPMAxdwM0MVKLZIrTjvNQBmehVrFvZEAbMlGBYjt+LMMldogQ=
X-Received: by 2002:a67:d119:: with SMTP id u25mr3340440vsi.63.1546515806231;
 Thu, 03 Jan 2019 03:43:26 -0800 (PST)
MIME-Version: 1.0
References: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org> <1546442319-20461-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546442319-20461-3-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Jan 2019 12:43:13 +0100
Message-ID: <CAMuHMdUT3B2JLkijM5Ofd3TUYa8TZJaj1NWaEJvU_19B-naF-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: generate uapi header and syscall table header files
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

Thanks for your patch!

On Wed, Jan 2, 2019 at 4:19 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> Subject: m68k: generate uapi header and syscall table header files
>
> Unified system call table generation script must be run to
> generate unistd_32.h and syscall_table.h files. This patch
> will have changes which will invokes the script.
>
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> m68k/Makefile and the generated files against the removed
> files must be identical.
>
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/syscalltable.S file.

This doesn't really describe what this patch is doing.
This patch switches m68k over to use the common scripts for
system call header file generation.

> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/m68k/kernel/syscalls/Makefile      | 11 ++++++++--
>  arch/m68k/kernel/syscalls/syscallhdr.sh | 36 ---------------------------------
>  arch/m68k/kernel/syscalls/syscalltbl.sh | 32 -----------------------------
>  3 files changed, 9 insertions(+), 70 deletions(-)
>  delete mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
>  delete mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
>
> diff --git a/arch/m68k/kernel/syscalls/Makefile b/arch/m68k/kernel/syscalls/Makefile
> index 659faef..75c7421 100644
> --- a/arch/m68k/kernel/syscalls/Makefile
> +++ b/arch/m68k/kernel/syscalls/Makefile
> @@ -6,8 +6,9 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')       \
>           $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
>
>  syscall := $(srctree)/$(src)/syscall.tbl
> -syshdr := $(srctree)/$(src)/syscallhdr.sh
> -systbl := $(srctree)/$(src)/syscalltbl.sh
> +syshdr := $(srctree)/scripts/syscallhdr.sh
> +sysnr := $(srctree)/scripts/syscallnr.sh

What's the purpose of adding sysnr?

> +systbl := $(srctree)/scripts/syscalltbl.sh
>
>  quiet_cmd_syshdr = SYSHDR  $@
>        cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'       \
> @@ -15,6 +16,12 @@ quiet_cmd_syshdr = SYSHDR  $@
>                    '$(syshdr_pfx_$(basetarget))'                \
>                    '$(syshdr_offset_$(basetarget))'
>
> +quiet_cmd_sysnr = SYSNR  $@
> +      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'         \
> +                 '$(sysnr_abis_$(basetarget))'                 \
> +                 '$(sysnr_pfx_$(basetarget))'                  \
> +                 '$(sysnr_offset_$(basetarget))'
> +

What's the purpose of adding this build rule, which is unused?

The patch works fine though.

I assume the common build rules will be moved to a common place later?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
