Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CECC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5672624B85
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YpXIOrwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5672624B85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeF3OU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:20:26 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:47208 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeF3OUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:20:23 -0400
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w5UEKInQ001095;
        Sat, 30 Jun 2018 23:20:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w5UEKInQ001095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530368418;
        bh=1fH/lGVFozBRk+48c24m4GBnCALp0O91hhh6npjGhOA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YpXIOrwD7GRdLtLhpiCbYZzv9fOZlAcjy8JzUhR4Ls5w7gkwZmCEtv+G62JyQiuJE
         T9aP73vOPa6ACz70BmVmumJmhDIanJbbixCfIxvpoWEH5lLYd+tlaW+FtnCEAU1DcC
         QFowIz+Sey+4iXg1ukGVrvw30cHHj4is8JdfayytSIRhd9R+7bC30KEHVRaL5VZI39
         i1k8aPCy5DRySmhEk/SV/D8PMKMyvUIcLMetPGSS4hWjJSPh5iNWYno4cMnJSPTl+g
         0zPjCrHvcHubOENR9DAV+eGo3kjL7XfSlxU3ysvlIXrEOBKjWTpCx/bHY7xyaBV5u4
         MTCeEz6AS7kzg==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id l64-v6so6907839vkl.12;
        Sat, 30 Jun 2018 07:20:18 -0700 (PDT)
X-Gm-Message-State: APt69E1HA/5PYdadcHjqH5dKXh/VH9DKKJgRxjWVtTwkNPTjqbvKkZ1l
        3Tw2VVQD9XpE3kgCC6pF7BIUMaZN8aBPJ24kQ2Q=
X-Google-Smtp-Source: AAOMgpfKMtJ/D3Uj9eIC7tyjW48szB3Sy4hzyCFtMpFhWr0rLe3SWxpEZms9cXtRCq5VYt9qYgFWFXWMclWoGSpzugg=
X-Received: by 2002:a1f:b143:: with SMTP id a64-v6mr11098606vkf.65.1530368417413;
 Sat, 30 Jun 2018 07:20:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 07:19:36
 -0700 (PDT)
In-Reply-To: <c2541256-d3de-e0cf-077c-cdb590c3c152@infradead.org>
References: <c2541256-d3de-e0cf-077c-cdb590c3c152@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 30 Jun 2018 23:19:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS288qs50R=bL0R7mZfw0WhGsda409u6rbZ84PTNM98Rg@mail.gmail.com>
Message-ID: <CAK7LNAS288qs50R=bL0R7mZfw0WhGsda409u6rbZ84PTNM98Rg@mail.gmail.com>
Subject: Re: [PATCH v4] kconfig: check for pkg-config on make {menu,n,g,x}config
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-29 8:39 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Each of 'make {menu,n,g,x}config' uses (needs) pkg-config to make sure
> that other required files are present and to determine build flags
> settings, but none of these check that pkg-config itself is present.
> Add a check for all 4 of these targets and update
> Documentation/process/changes.rst to mention 'pkg-config'.
>
> Fixes kernel bugzilla #77511:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D77511
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bj=C3=B8rn Forsman <bjorn.forsman@gmail.com>
> ---

Applied to linux-kbuild/kconfig.   Thanks!


> v4: apply Masahiro's suggestions
>
> Strictly speaking, pkg-config is not required if someone is only
> using 'make {menu,n}config' since there are fallbacks for those
> two targets.
>
>  Documentation/process/changes.rst  |    8 ++++++++
>  scripts/kconfig/Makefile           |    1 +
>  scripts/kconfig/check-pkgconfig.sh |    8 ++++++++
>  3 files changed, 17 insertions(+)
>
> --- linux-next-20180628.orig/scripts/kconfig/Makefile
> +++ linux-next-20180628/scripts/kconfig/Makefile
> @@ -215,6 +215,7 @@ $(obj)/zconf.tab.o: $(obj)/zconf.lex.c
>
>  # check if necessary packages are available, and configure build flags
>  define filechk_conf_cfg
> +       $(CONFIG_SHELL) $(srctree)/scripts/kconfig/check-pkgconfig.sh; \
>         $(CONFIG_SHELL) $<
>  endef
>
> --- /dev/null
> +++ linux-next-20180628/scripts/kconfig/check-pkgconfig.sh
> @@ -0,0 +1,8 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Check for pkg-config presence
> +
> +if [ -z $(command -v pkg-config) ]; then
> +       echo "'make *config' requires 'pkg-config'. Please install it." 1=
>&2
> +       exit 1
> +fi
> --- linux-next-20180628.orig/Documentation/process/changes.rst
> +++ linux-next-20180628/Documentation/process/changes.rst
> @@ -81,6 +81,14 @@ The build system has, as of 4.13, switch
>  rather than incremental linking (`ld -r`) for built-in.a intermediate st=
eps.
>  This requires binutils 2.20 or newer.
>
> +pkg-config
> +----------
> +
> +The build system, as of 4.18, requires pkg-config to check for installed
> +kconfig tools and to determine flags settings for use in
> +'make {menu,n,g,x}config'.  Previously pkg-config was being used but not
> +verified or documented.
> +
>  Flex
>  ----
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best Regards
Masahiro Yamada
