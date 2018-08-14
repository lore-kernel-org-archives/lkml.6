Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC2FC4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BE721742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VgU4ItX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BE721742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbeHNFeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 01:34:36 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:26071 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeHNFef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 01:34:35 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7E2nBUH005932;
        Tue, 14 Aug 2018 11:49:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7E2nBUH005932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534214952;
        bh=e156u1i9JbitJrH3jzZlLJLZ0c9fOvpxcBdoWsk68W4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VgU4ItX0R122xbeu3Aw7PrcJClRxe9lHlFW7W9guqmDqc2t86TGKT98QTdEHxx6vT
         MZZ3HM6lhyM/iz+SjhObxDUm2G/cAnM5Cqvb/RRkjZk8+PlVABRhBLuxxv4PQZWQTu
         EJkwtLgp27uC1oPnYpO13F75CR46Gjc3KqrVVd0d/qVDB5M8xsv4bx0P8GRMOSv7qp
         hiuDnZ5r5mA0dXMD5kaZKA81Gjorg2p/cZEwFlBg44RQaBQd6YWMARj4jlBeZpNf8E
         s7z2U25skU3J20OwTm5BynrWdMHqkLPe69e5EfYun9LYScjZTSurclnyqXE+INJWaA
         hZ+JEKg+VwbpA==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id q12-v6so11554911ual.2;
        Mon, 13 Aug 2018 19:49:12 -0700 (PDT)
X-Gm-Message-State: AOUpUlGdfZ94goBQoYPgeGe15TYVQzHy7FgplSlomAU5oGc/Bl5lp+0P
        P07MMHzjPqusCsU+NC2tM4gI1Tl1+T7Kqg5KgQk=
X-Google-Smtp-Source: AA+uWPxR7KzEG7RtAgyAoOIGSL/58VB29yW/xVttNqWnS1S3arFCBBl+6Wd4yU6VLZKFL+YpTtZ1UzV5ggyU1Curw1s=
X-Received: by 2002:a1f:5f44:: with SMTP id t65-v6mr12692010vkb.135.1534214951474;
 Mon, 13 Aug 2018 19:49:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 19:48:31
 -0700 (PDT)
In-Reply-To: <1533797226-6547-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533797226-6547-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 Aug 2018 11:48:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASRUBmk4Eux-x2qr1v53CYaEBvV7uDmaur84BoxotSXKA@mail.gmail.com>
Message-ID: <CAK7LNASRUBmk4Eux-x2qr1v53CYaEBvV7uDmaur84BoxotSXKA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix the rule of mainmenu_stmt symbol
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-09 15:47 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The rule of mainmenu_stmt does not have debug print of zconf_lineno(),
> but if it had, it would print a wrong line number for the same reason
> as commit b2d00d7c61c8 ("kconfig: fix line numbers for if-entries in
> menu tree").
>
> The mainmenu_stmt does not need to eat following empty lines because
> they are reduced to common_stmt.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild/kconfig.

>  scripts/kconfig/zconf.y | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
> index 4b68272..95a4fd3 100644
> --- a/scripts/kconfig/zconf.y
> +++ b/scripts/kconfig/zconf.y
> @@ -31,7 +31,7 @@ struct symbol *symbol_hash[SYMBOL_HASHSIZE];
>  static struct menu *current_menu, *current_entry;
>
>  %}
> -%expect 31
> +%expect 30
>
>  %union
>  {
> @@ -117,7 +117,7 @@ start: mainmenu_stmt stmt_list | stmt_list;
>
>  /* mainmenu entry */
>
> -mainmenu_stmt: T_MAINMENU prompt nl
> +mainmenu_stmt: T_MAINMENU prompt T_EOL
>  {
>         menu_add_prompt(P_MENU, $2, NULL);
>  };
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
