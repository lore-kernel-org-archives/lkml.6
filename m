Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D0221477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="geVIXaHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D0221477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbeHPFdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:33:08 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:57353 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeHPFdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:33:08 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w7G2btxI018048;
        Thu, 16 Aug 2018 11:37:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w7G2btxI018048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534387076;
        bh=Krx9n8AGL0iTihVOqrt+6O4bMqXSTmOwr9n15SH2boE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=geVIXaHzkuZXemzJorleUNniyFVFi6Tz3SyPhGunxqhvc3UthRYof08AWa+8C0ZQW
         sO/1p25iTf1F5iPaY5z6RL8BDqaTO+vL0M3P2FvGEkKbYu5GmfxvBMsa60IkxmeJjW
         twVLxPtqszkM/QwjJmusq6UTGwj7LmOtKIICSfDEjiE03FTCnTZsfcvpv2hl53LC+V
         sgXQqFX7HRaEMfNWc7CikE+Kyozi3hnWqi24AntMYxXh183XA5X6c6efYoF2z9RFvi
         HtRfjz+Uc4M3m6TM3x8i+O0184aWueNVC8sWeQwsBO5qWbNjMh4GRVcoZ/w7RNdu2P
         EGWD5iEBBxLRA==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id w7-v6so2777565uan.9;
        Wed, 15 Aug 2018 19:37:56 -0700 (PDT)
X-Gm-Message-State: AOUpUlHS1dS3l29llVi44HJVgFoKWzRyLhKR0FkIXckZUEEJW7RI8wmk
        OANvOC7Q2xsJz/oi6tHJFZuDt6uZDK/CepvKFww=
X-Google-Smtp-Source: AA+uWPxCjWA+udgf99BIW8ak90yJop0tEAYsLzhoLo/Q9gN3UUqbOBLFl0U58E4g7oPRIoPdTGzl0kLLh8O5w5U1xrI=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr18503767uaf.199.1534387075175;
 Wed, 15 Aug 2018 19:37:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 19:37:14
 -0700 (PDT)
In-Reply-To: <eafb5a94-f140-27f2-bc91-c6b95a18c97d@infradead.org>
References: <eafb5a94-f140-27f2-bc91-c6b95a18c97d@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 16 Aug 2018 11:37:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWM0X3yeifD_3jsiP7yPb2G0B52fmsrBM=iqpaVSA9kA@mail.gmail.com>
Message-ID: <CAK7LNAQWM0X3yeifD_3jsiP7yPb2G0B52fmsrBM=iqpaVSA9kA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: modpost: check memory allocation results
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yuexing Wang <wangyxlandq@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-16 4:30 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix missing error check for memory allocation functions in
> scripts/mod/modpost.c.
>
> Fixes kernel bugzilla #200319:
> https://bugzilla.kernel.org/show_bug.cgi?id=200319
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yuexing Wang <wangyxlandq@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> v2: add checks in more places

Applied to linux-kbuild. Thanks!


>  scripts/mod/modpost.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- linux-next-20180814.orig/scripts/mod/modpost.c
> +++ linux-next-20180814/scripts/mod/modpost.c
> @@ -672,7 +672,7 @@ static void handle_modversions(struct mo
>                         if (ELF_ST_TYPE(sym->st_info) == STT_SPARC_REGISTER)
>                                 break;
>                         if (symname[0] == '.') {
> -                               char *munged = strdup(symname);
> +                               char *munged = NOFAIL(strdup(symname));
>                                 munged[0] = '_';
>                                 munged[1] = toupper(munged[1]);
>                                 symname = munged;
> @@ -1318,7 +1318,7 @@ static Elf_Sym *find_elf_symbol2(struct
>  static char *sec2annotation(const char *s)
>  {
>         if (match(s, init_exit_sections)) {
> -               char *p = malloc(20);
> +               char *p = NOFAIL(malloc(20));
>                 char *r = p;
>
>                 *p++ = '_';
> @@ -1338,7 +1338,7 @@ static char *sec2annotation(const char *
>                         strcat(p, " ");
>                 return r;
>         } else {
> -               return strdup("");
> +               return NOFAIL(strdup(""));
>         }
>  }
>
> @@ -2036,7 +2036,7 @@ void buf_write(struct buffer *buf, const
>  {
>         if (buf->size - buf->pos < len) {
>                 buf->size += len + SZ;
> -               buf->p = realloc(buf->p, buf->size);
> +               buf->p = NOFAIL(realloc(buf->p, buf->size));
>         }
>         strncpy(buf->p + buf->pos, s, len);
>         buf->pos += len;
>
>



-- 
Best Regards
Masahiro Yamada
