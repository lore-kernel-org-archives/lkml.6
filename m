Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E76C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C820720672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xttV+pTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C820720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391206AbeKVWX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:23:59 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:55272 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeKVWX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:23:59 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAMBidVM003087;
        Thu, 22 Nov 2018 20:44:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAMBidVM003087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542887080;
        bh=d5fkNbI2IFoPK74SC+vtCIb7pBYjeXmACVQU9qlx44Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xttV+pTn/hH5rdm3ONgEtRjfW/npBY6c82YlpYcyFg0JAMDdgganbN+54bOQXbMwS
         Gh5TZzG6+z21n7Ou98MawKwsJU73bf0ltUhYknVpyWfuErNXedHY22C2DvEzHvmF16
         4T7h+GyYfEtw0z4uqkW3BLEw5LwNQaXagVhKUtB1fSeNMS1UmztqOQc5ZTSs0IJ0c4
         mQPThpALIQ6ffBOIe3cZFB/DeJvNxPlS+r/8+uLYuqSVBUIWK3+GvJnnFtTMpoCfJb
         t73VgHsv7Yj7W8tYA/azMj+GAOn0jpD/IwLsj6FRwej7AtkfUJojnhAINBiBey8wpl
         jq16eWNI682dA==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id z3so5175377vsf.7;
        Thu, 22 Nov 2018 03:44:39 -0800 (PST)
X-Gm-Message-State: AA+aEWbwKElq3uNtqvv3fOl+Dp5rauihDArjFIKWDx5apJwMeKegKFNp
        FbA6yK4f1CvUQuL85m/EXAdZ9ovTHyLwEBgUo7s=
X-Google-Smtp-Source: AJdET5dAzwAWilYjCFgnZ32hNbRFg7ZonVmKyvMGXsaxXkHzc4PdCWc1sV74f/OmRKr8TOnBk8aSK3tOv2x+s95/TSA=
X-Received: by 2002:a67:485:: with SMTP id 127mr4719964vse.54.1542887078380;
 Thu, 22 Nov 2018 03:44:38 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1811211311410.18372@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1811211311410.18372@viisi.sifive.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 22 Nov 2018 20:44:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfRvBXpdHAjXKZ-x0AJnSiOE612N=cGxHO=jF9BJeCXw@mail.gmail.com>
Message-ID: <CAK7LNASfRvBXpdHAjXKZ-x0AJnSiOE612N=cGxHO=jF9BJeCXw@mail.gmail.com>
Subject: Re: [PATCH] modpost: skip ELF local symbols during section mismatch check
To:     paul.walmsley@sifive.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, jimw@sifive.com,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>, Paul Walmsley <paul@pwsan.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 4:11 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
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
> This was verified by compiling the kernel with -fno-section-anchors
> and observing that the ".LANCHOR1" ELF local symbol disappeared, and
> modpost no longer warned about the section mismatch.  The serial
> driver code idiom triggering the warning is standard Linux serial
> driver practice that has a specific whitelist inclusion in modpost.c.
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
> This third version of the patch implements a suggestion from Masahiro
> Yamada <yamada.masahiro@socionext.com> to restructure the code as an
> additional pattern matching step inside secref_whitelist(), and
> further improves the patch description.
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

Applied with Sam's Ack.

Thanks!


>   scripts/mod/modpost.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 0d998c54564d..90bb04b4e166 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1163,6 +1163,14 @@ static const struct sectioncheck *section_mismatch(
>    *   fromsec = text section
>    *   refsymname = *.constprop.*
>    *
> + * Pattern 6:
> + *   Hide section mismatch warnings for ELF local symbols.  The goal
> + *   is to eliminate false positive modpost warnings caused by
> + *   compiler-generated ELF local symbol names such as ".LANCHOR1".
> + *   Autogenerated symbol names bypass modpost's "Pattern 2"
> + *   whitelisting, which relies on pattern-matching against symbol
> + *   names to work.  (One situation where gcc can autogenerate ELF
> + *   local symbols is when "-fsection-anchors" is used.)
>    **/
>   static int secref_whitelist(const struct sectioncheck *mismatch,
>                             const char *fromsec, const char *fromsym,
> @@ -1201,6 +1209,10 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
>             match(fromsym, optim_symbols))
>                 return 0;
>
> +       /* Check for pattern 6 */
> +       if (strstarts(fromsym, ".L"))
> +               return 0;
> +
>         return 1;
>   }
>
> --
> 2.19.1
>
>


-- 
Best Regards
Masahiro Yamada
