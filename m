Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A511AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F2322507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="m8Ruv+QU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F2322507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbeKMMP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:15:58 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:39035 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeKMMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:15:58 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAD2Jqll012992;
        Tue, 13 Nov 2018 11:19:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAD2Jqll012992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542075593;
        bh=40R36dISED+31cwp8IQEcXjDEXGOcXWQ2k/rwop9oI8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m8Ruv+QUG50HTG2JfnQQSM+LJUuiWYhxbIfersLqOFYRZc3/Mq8LfhlaoLAJ2UtFi
         FpjkqpmmMyfFykI05I56bngjxzX6QdGosvpSmeWwnTYWAdp9BoqegmuOOiEkrys+5m
         3muAIQb1RPwJaDYAzZT0ldi1BAGycVDo6PWBsHulp6xOH47AZ60uTduDVQdeJMRtPj
         JsTA4pqpE9/tquY19spo4UTdPKPZm/SJgLohqN8EoKsWBTB9pHOA5FsS5gLXunwBWK
         zAhiZ4RIyd6QeTWr6TjXPZd8NLRHDFFiqt/g9x8Ro+IZvmwL9pAK4vhHPvQ6p7sFhI
         3g1OnvhFLCVwQ==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id e16so2573039uam.12;
        Mon, 12 Nov 2018 18:19:53 -0800 (PST)
X-Gm-Message-State: AGRZ1gJGw6wM6YH2MRrgH1gka5l6V0IXWhD9vOaT6YgNBqJhwKyXuIK1
        Ev3Ec1UiFOLRxiLM9vq8OOmOwZmiTf3fLH6X4dw=
X-Google-Smtp-Source: AJdET5f4yGMin6SMjoszbZUM6rUU7oERQXbXFzrQoCJxF0sBhetdDLpeTuecxE14kGF3E3kjfmNTKTgYEX+X0ljmSos=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr1549002uam.89.1542075591890;
 Mon, 12 Nov 2018 18:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20181020131911.22443-1-paul.walmsley@sifive.com> <20181020131911.22443-3-paul.walmsley@sifive.com>
In-Reply-To: <20181020131911.22443-3-paul.walmsley@sifive.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 13 Nov 2018 11:19:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNARC2+BLFay_-CtaJXKCu3M0NZzxbeff1XandeH58BbUcg@mail.gmail.com>
Message-ID: <CAK7LNARC2+BLFay_-CtaJXKCu3M0NZzxbeff1XandeH58BbUcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] modpost: skip ELF local symbols by default during
 section mismatch check
To:     paul.walmsley@sifive.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, jimw@sifive.com,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Walmsley <paul@pwsan.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,


On Sat, Oct 20, 2018 at 10:21 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> During development of a serial console driver with a RISC-V toolchain,
> the following modpost warning appeared:
>
> ----
> WARNING: vmlinux.o(.data+0x19b10): Section mismatch in reference from the variable .LANCHOR1 to the function .init.text:sifive_serial_console_setup()
> The variable .LANCHOR1 references
> the function __init sifive_serial_console_setup()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> ----

Could you provide me a little more information to reproduce it?

I tried your dev/paulw/serial-v4.19-rc7,
but I could not get that warning.

I used risc64-linux-gcc (GCC 7.3, 8.1) from kernel.org





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
> Thus, disable section mismatch reporting on ELF local symbols by
> default.  The rationale here is similar to that of commit
> 2e3a10a1551d6ceea005e6a62ca58183b8976217 ("ARM: avoid ARM binutils
> leaking ELF local symbols") and of similar code already present in
> modpost.c:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/mod/modpost.c?h=v4.19-rc4&id=7876320f88802b22d4e2daf7eb027dd14175a0f8#n1256
>
> Since it might be useful for some static analysis runs to detect
> whether any new symbols have been added that result in any section
> mismatches, even from ELF local symbols, this change can be disabled
> (along with other tests that can often generate false positives) by
> passing the '-P' switch on the modpost command line.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Jim Wilson <jimw@sifive.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  scripts/mod/modpost.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 38fc1bd47926..2b8c960ece66 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1255,6 +1255,17 @@ static inline int is_arm_mapping_symbol(const char *str)
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
> @@ -1537,6 +1548,9 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
>         if (strstarts(fromsym, "reference___initcall"))
>                 return;
>
> +       if (!accept_falsepos_risk && is_local_symbol(fromsym))
> +               return;
> +
>         tosec = sec_name(elf, get_secindex(elf, sym));
>         to = find_elf_symbol(elf, r->r_addend, sym);
>         tosym = sym_name(elf, to);
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
