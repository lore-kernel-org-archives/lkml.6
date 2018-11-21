Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D266C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9521521479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="azHCHf4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9521521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeKUQrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:47:46 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:23129 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKUQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:47:46 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wAL6EXX9026287;
        Wed, 21 Nov 2018 15:14:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wAL6EXX9026287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542780874;
        bh=mgpSrIsKXJH6ElVAIqePo1isY/4rmeh1rH2/vKCvkb4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=azHCHf4tK2JDvYq5k3tpoXrK7C9LtMDA3bsbP3q6wkREzn+0it7mDBSHE9K7hYxVb
         KWRU3tcYjBcTxZspW9IekYBUCxfTz0uYGERo0lEGpAX8hMyTmZJ2JtJaDnCKhIdCoa
         M727z4SJpszxyp7VBYwCPhMoaa8Uk16QMSOgENytUQOFBdJBLcxEmEI2qWaxiiAPxM
         N0Z4y4BxM6oOuwEBuTFOMs4rgG5b/7BXxzUO/gMN9uKSuErDcsxrqYjE04tVxBTR2/
         kHmaMN7CwhrUtfXg45xo8nQHpBJxyQWmyLzuBDjjwHTcIBeMl4bDhmUfeDmMpWqMS3
         y1cOLwl6P2/Ew==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id k10so1527345ual.6;
        Tue, 20 Nov 2018 22:14:33 -0800 (PST)
X-Gm-Message-State: AA+aEWY9iI2JinJSJaU1Y9kQcJor39CerbMS70VMzrYvdUJaPSD7xdEQ
        eVJbGT0QxOUD3hxPKKpCpM54ZPZVzortm4gl9Hw=
X-Google-Smtp-Source: AFSGD/VU+wvHS1lYoKm83fbye3uYhJV3Adq6YmLBvr0D5B7WEldGAkaCjbOD+bF+yNlZZlkHtmXfCFX/wJbGmSl1erU=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr2295859uam.89.1542780872554;
 Tue, 20 Nov 2018 22:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20181115005602.30746-1-paul.walmsley@sifive.com> <20181115005602.30746-3-paul.walmsley@sifive.com>
In-Reply-To: <20181115005602.30746-3-paul.walmsley@sifive.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 21 Nov 2018 15:13:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqpzJcxZBvZY1Bd2sVUwTLg7eD2mq61hDOw6Ek=akdfw@mail.gmail.com>
Message-ID: <CAK7LNAQqpzJcxZBvZY1Bd2sVUwTLg7eD2mq61hDOw6Ek=akdfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] modpost: skip ELF local symbols by default during
 section mismatch check
To:     paul.walmsley@sifive.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, jimw@sifive.com,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,


On Thu, Nov 15, 2018 at 9:57 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> During development of a serial console driver with a gcc 8.2.0
> toolchain for RISC-V, the following modpost warning appeared:
>
> ----
> WARNING: vmlinux.o(.data+0x19b10): Section mismatch in reference from the variable .LANCHOR1 to the function .init.text:sifive_serial_console_setup()
> The variable .LANCHOR1 references
> the function __init sifive_serial_console_setup()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> ----
>
> ".LANCHOR1" is an ELF local symbol, automatically created by gcc's section
> anchor generation code:
>
> https://gcc.gnu.org/onlinedocs/gccint/Anchored-Addresses.html
>
> https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/varasm.c;h=cd9591a45617464946dcf9a126dde277d9de9804;hb=9fb89fa845c1b2e0a18d85ada0b077c84508ab78#l7473
>
> This was verified by compiling the kernel with -fno-section-anchors.
> The serial driver code idiom triggering the warning is standard serial
> driver practice, and one that has a specific whitelist inclusion in
> modpost.c.
>
> I'm neither a modpost nor an ELF expert, but naively, it doesn't seem
> useful for modpost to report section mismatch warnings caused by ELF
> local symbols by default.  Local symbols have compiler-generated
> names, and thus bypass modpost's whitelisting algorithm, which relies
> on the presence of a non-autogenerated symbol name.  This increases
> the likelihood that false positive warnings will be generated (as in
> the above case).
>
> Thus, disable section mismatch reporting on ELF local symbols.  The
> rationale here is similar to that of commit 2e3a10a1551d ("ARM: avoid
> ARM binutils leaking ELF local symbols") and of similar code already
> present in modpost.c:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/mod/modpost.c?h=v4.19-rc4&id=7876320f88802b22d4e2daf7eb027dd14175a0f8#n1256
>
> This second version of the patch drops the option to keep section
> mismatch warnings for local sections, based on feedback from Sam
> Ravnborg <sam@ravnborg.org>; and clarifies that these warnings
> appear with gcc 8.2.0.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Jim Wilson <jimw@sifive.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  scripts/mod/modpost.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 85bd93c63180..0fb148171b78 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1253,6 +1253,17 @@ static inline int is_arm_mapping_symbol(const char *str)
>                && (str[2] == '\0' || str[2] == '.');
>  }
>
> +/*
> + * If a symbol name follows the convention for ELF-local symbols (i.e., the
> + * name begins with a ".L"), return true; otherwise false.  This is used to
> + * skip section mismatch reporting on ELF-local symbols, due to the risk of
> + * false positives.
> + */
> +static inline int is_local_symbol(const char *str)
> +{
> +       return str[0] == '.' && str[1] == 'L';
> +}
> +
>  /*
>   * If there's no name there, ignore it; likewise, ignore it if it's
>   * one of the magic symbols emitted used by current ARM tools.
> @@ -1535,6 +1546,9 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
>         if (strstarts(fromsym, "reference___initcall"))
>                 return;
>
> +       if (is_local_symbol(fromsym))
> +               return;
> +
>         tosec = sec_name(elf, get_secindex(elf, sym));
>         to = find_elf_symbol(elf, r->r_addend, sym);
>         tosym = sym_name(elf, to);
> --
> 2.19.1
>


I think this is almost good.
Just a nit.

Maybe, putting this check in secref_whitelist()
(with a comment "Pattern 6:")
could look more consistency.


Also, if you use strstart() helper,
you can remove is_local_symbol() function.


        /* Check for pattern 6 */
        if (strstarts(fromsym, ".L"))
                return 0;




-- 
Best Regards
Masahiro Yamada
