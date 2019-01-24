Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD182C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BE421872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="28eZrKwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfAXE0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:26:22 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:48722 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfAXE0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:26:22 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x0O4QDuK001821;
        Thu, 24 Jan 2019 13:26:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x0O4QDuK001821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548303973;
        bh=vtcVE8Z0DcFhtYIv2q70OrhjLnzL3cU63BiAdv2vtus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=28eZrKwRGQnEMb0FrX27dx7ORhsPn8hREkWoA4+0AlE5N2dOt5HwU0JUdaW7RkX+A
         h8POLZyl32OGwP84dXPBbPT+c0zIXDzNy/E/V3DzyMyMC7U+V8Z/9Zu0/i/wL7nBML
         JTMBIyM3w0WLjDehuXXZpdiQ0OWnhHhEfdIBkalNpxqU4Sft5UvVkIcBc8Tlq6AoZ8
         d3kg4ZPYVkiA7e3nNmNtqQiLqYg3ieZzrp9N6oprFD7Tm9HsMjgCsfPaby0o/GevkT
         DbDa0vJYRmnIfrQ3cXpqiVaMNTFkfc2RV8R/o67KRsKKDlIGoKvDjF887pkWT3cTGB
         7MX/KdHd32hig==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id p9so1543968uaa.5;
        Wed, 23 Jan 2019 20:26:13 -0800 (PST)
X-Gm-Message-State: AJcUukdBsZCOWYEoliU2F/d0uYh7X4FZyxGBS57SA3lv7bBbtV5Y+Wt5
        X0RqXHIluIShcWJCVhBY8Y3Ig3Hfw5wXSROrw6Y=
X-Google-Smtp-Source: ALg8bN7bqry7k6yRSQuZQB/WM/6VSUVNsLZejfAKmSzPimzXI1NIaYcKWv3Q5SWv3DOQbmjQknPB9raulDm9WSu7Or4=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr2045370uap.6.1548303972479;
 Wed, 23 Jan 2019 20:26:12 -0800 (PST)
MIME-Version: 1.0
References: <1547799412-20120-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547799412-20120-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 24 Jan 2019 13:25:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATiQFTwyZsy-Hw1e8S=HBzT_tzjEkBwivQD+o=Cga1Yhw@mail.gmail.com>
Message-ID: <CAK7LNATiQFTwyZsy-Hw1e8S=HBzT_tzjEkBwivQD+o=Cga1Yhw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: descend to scripts/kconfig/ directly when
 syncconfig is needed
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:17 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The recursion of the top Makefile is inefficient.
> Just descend to scripts/kconfig/.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 9851a44..d5f0ac4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -631,7 +631,7 @@ $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
>  # include/generated/ and include/config/. Update them if .config is newer than
>  # include/config/auto.conf (which mirrors .config).
>  include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
> -       $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
> +       $(Q)$(MAKE) $(build)=scripts/kconfig syncconfig
>  else
>  # External modules and some install targets need include/generated/autoconf.h
>  # and include/config/auto.conf but do not care if they are up-to-date.
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
