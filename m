Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B311C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09FB20856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ccP2f6n7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09FB20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbeGYBiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:38:51 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:57276 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388464AbeGYBiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:38:50 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w6P0TSC1031763;
        Wed, 25 Jul 2018 09:29:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w6P0TSC1031763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532478568;
        bh=IyWSAEC4uYbda6RbtCFJRuCH3suwgjXUcqEfTfMIOgw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ccP2f6n7gZb6JGaYv5AtQKYz2SqZ28Ndyf+DVK1IFLsrrQcOz5EjcV3Ykcm0ISXwO
         xKU0K3fdu9OiWAQdoc3velwR9/9ZZfEQ6ATiGzr5PW10xgDPW+KzUOK1qLsUr+qcAo
         mjiiQOfRdL8/flhNm5rJs7LEM5N4Vkxdlg9siTofcCRFeY+oYQgYbpUKeUzSmVfYvj
         7AUuH0tmpntcU5rLcn+LhjmxfJutCa4ygc7/wdll55nakGTvBM+J3gv02wQKZwLkCS
         sjOJi2yeWGgU0fzWk4WCMbEVdgunjdG1Y8JpdLLGFwvybpXgRS6R1+nydE+/tQJRb9
         iU9k3I6TXoDuA==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id q12-v6so3967595ual.2;
        Tue, 24 Jul 2018 17:29:28 -0700 (PDT)
X-Gm-Message-State: AOUpUlHcpE909TjzsYKP0zRil++4O2lgixg5KDNLgb7IlgTaNNQKlnna
        PB32uUVfE0O33I4NlayrJSbAOPM1IIZMEYdwtZU=
X-Google-Smtp-Source: AAOMgpdUQxR6uPMuVBHJ3P9EFnVI4Qoc1tgpWXQqxPGSwLzu4m4AYmlYH9Zx5ZdEqraZJNjN8QRoMbsm2iX2Zerm3F4=
X-Received: by 2002:ab0:290:: with SMTP id 16-v6mr12332414uah.144.1532478567327;
 Tue, 24 Jul 2018 17:29:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 17:28:46
 -0700 (PDT)
In-Reply-To: <20180712125013.14285-1-ville.syrjala@linux.intel.com>
References: <20180712125013.14285-1-ville.syrjala@linux.intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 25 Jul 2018 09:28:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQz1oU9=NHSbw+rOw7LLFP5PpwuvUcjEaVbN+y7uOD-xA@mail.gmail.com>
Message-ID: <CAK7LNAQz1oU9=NHSbw+rOw7LLFP5PpwuvUcjEaVbN+y7uOD-xA@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: Add "m or y" and "y or m" answers for oldconfig
To:     Ville Syrjala <ville.syrjala@linux.intel.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-12 21:50 GMT+09:00 Ville Syrjala <ville.syrjala@linux.intel.com>:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> Make it possible to answer "m or y" or "y or m" to
> oldconfig so that scripted kernel builds can easily
> enable new features not present in the existing .config.
>
> The particular use case I have in mind is continuous integration
> where you probably want to test build any new features. Currently
> you would have to either blindly try both 'y' and 'm' answers
> or parse the output to know which one will be accepted.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> ---
>  scripts/kconfig/conf.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 671ff5364497..8038f9a6b9f4 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -201,15 +201,33 @@ static int conf_sym(struct menu *menu)
>                         continue;
>                 case 'm':
>                 case 'M':
> -                       newval =3D mod;
> -                       if (!line[1])
> +                       if (!strcmp(line, "m or y") ||
> +                           !strcmp(line, "M or Y")) {
> +                               if (sym_tristate_within_range(sym, mod))
> +                                       newval =3D mod;
> +                               else
> +                                       newval =3D yes;
>                                 break;
> +                       } else {
> +                               newval =3D mod;
> +                               if (!line[1])
> +                                       break;
> +                       }
>                         continue;
>                 case 'y':
>                 case 'Y':
> -                       newval =3D yes;
> -                       if (!line[1] || !strcmp(&line[1], "es"))
> +                       if (!strcmp(line, "y or m") ||
> +                           !strcmp(line, "Y or M")) {
> +                               if (sym_tristate_within_range(sym, yes))
> +                                       newval =3D yes;
> +                               else
> +                                       newval =3D mod;
>                                 break;
> +                       } else {
> +                               newval =3D yes;
> +                               if (!line[1] || !strcmp(&line[1], "es"))
> +                                       break;
> +                       }
>                         continue;
>                 case 0:
>                         newval =3D oldval;




Hmm.

Instead of hard-coding specific patterns,
can you implement this in a more generic way?


For example, how about this?

Use '/' as a delimiter
so that user input will be "m/y", "y/m", "m/n", etc.

Split the input string into tokens by strtok() or something.
Iterate over the tokens until sym_set_tristate_value() succeeds.


Thanks.




> --
> 2.16.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best Regards
Masahiro Yamada
