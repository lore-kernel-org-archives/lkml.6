Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20171C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C168B208DE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2NFzFGZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C168B208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeHOGb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 02:31:56 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:51518 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeHOGb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 02:31:56 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7F3fHdc018431;
        Wed, 15 Aug 2018 12:41:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7F3fHdc018431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534304478;
        bh=avqrwTcE+ZeGr/N3g32vVwltHvDYjJ1oMCcL/eSJl8k=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=2NFzFGZNW/YS4ppA4sEdmLWGswyOkLR2nFz/I4BF9q3c0OESkJH3zO0u6CkK4o2Ef
         QCMjIMyglhaXpo6v+4yJPXpeFG10pTQz7+S2ZzuzHY4LPsPJv9XGQm8Lrvxnv6KFzZ
         M2wqEW6owFCBxQgO9Hz6V6U8Lo9n/ZSYIo6J5NWM7ifT8dBk8Ifr/FJ40Nbvl6vzPx
         kdOYq9l6gejAZTADJAE3yg0SAh85xt7ttcPXHdS/gSpb43OKLJ6QToPQmDqtMb9gD3
         +nvUCh2Jhn0j4S1+JWnlxhbI1Dvi5uNJfsonvFrSVGbCkZsGCL0ihQ4jss/ZSLco2Y
         0e7CmBUewdQIw==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id q12-v6so15563935ual.2;
        Tue, 14 Aug 2018 20:41:18 -0700 (PDT)
X-Gm-Message-State: AOUpUlFL4Ko0no+lpAQQB6lf6Qt+AxJqqD98DHAgqRJnCI0R5Pa5ZT9i
        QziWcxdBMqD3li7IgbqJAIKiLFO4Gf5+WoH5xrU=
X-Google-Smtp-Source: AA+uWPyG2D+p8aVmNU9bzNk5ppZA67Nh5oH7Lpm3iCaPCSWL8uv6ZftRF9IhZjRc3NE7ae3nl5ed4u1M9F2YIwCHCrk=
X-Received: by 2002:ab0:290:: with SMTP id 16-v6mr15653296uah.144.1534304477077;
 Tue, 14 Aug 2018 20:41:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 20:40:36
 -0700 (PDT)
In-Reply-To: <adc5b6e4-28c1-7fe2-b7b1-c6b1cd39f8ed@infradead.org>
References: <adc5b6e4-28c1-7fe2-b7b1-c6b1cd39f8ed@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 15 Aug 2018 12:40:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3nv2aJFvro4NmCyRNEBH_Kv=1cZaqt3PrQYGGatjnLg@mail.gmail.com>
Message-ID: <CAK7LNAT3nv2aJFvro4NmCyRNEBH_Kv=1cZaqt3PrQYGGatjnLg@mail.gmail.com>
Subject: Re: [PATCH] modpost: check strdup() return value
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yuexing Wang <wangyxlandq@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-15 5:50 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix missing error check for function strdup() in scripts/mod/modpost.c.
>
> Fixes kernel bugzilla #200319:
> https://bugzilla.kernel.org/show_bug.cgi?id=200319
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yuexing Wang <wangyxlandq@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>  scripts/mod/modpost.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
>
>


While you are here,
will you fix a little more?


line 1321:
            char *p = malloc(20);

line 1341:
            return strdup("");

line 2039:
            buf->p = realloc(buf->p, buf->size);



-- 
Best Regards
Masahiro Yamada
