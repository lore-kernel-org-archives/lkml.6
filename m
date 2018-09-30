Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3DFC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8962F2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CG2MfZMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8962F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeI3UUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:20:06 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:34007 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbeI3UUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:20:05 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w8UDkrPR016527;
        Sun, 30 Sep 2018 22:46:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w8UDkrPR016527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538315214;
        bh=gTJVAwHlwBmtWK0rm0gcu9pO9Vs9yxB/0rRyHoRQZ8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CG2MfZMtFR/31nwr8a3n79Al1JQU8TSRKxC/fWr0SYxz5yiw04G1PqI24tYv1xb5D
         zY+VM8QtxmnqNK+H5c2n9oq+rtQHZOzClYB+4Ktx6pkqa44R6gxorQKANdjYLbJPR8
         OliCZWmx1VM1QC6fjE/MQ6inb3qvuFjyUSwWn/0tjsSec01V6fXh1D5K/p4oR2+Jp8
         cYuNSd5nFyvRVJvhjPmg8nwYzFUDwak8OsU9ek1SvHnpou72/zR3WzMwc+eNfufep9
         QRbqeNKTX2UtrUIWSWATZL1JSHmxSTHCBJiSAyTqoSr8FzvIq6BAeXXNWRTTc6dFsI
         XU7+H2Xsh4Yhw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id w8-v6so6053534vsl.4;
        Sun, 30 Sep 2018 06:46:53 -0700 (PDT)
X-Gm-Message-State: ABuFfoghTUh0FJM9jMXMuoy0krpI5rbRGU53ABySbHPrLc7tqt3uGnmi
        /6DSufRHfJJS0YnTANxRhrclAZPQLZEfnirRrqs=
X-Google-Smtp-Source: ACcGV62NBhWVZZaMRoq7Jy4gElKIrRw+Nf9aLzpdLF5aQ26nBR4LzweK6DEUE8AVxveFhFH271AiEEWZjGqA5JAWOl8=
X-Received: by 2002:a67:e0cd:: with SMTP id m13-v6mr2394588vsl.181.1538315212865;
 Sun, 30 Sep 2018 06:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <1536906803-29741-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1536906803-29741-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 30 Sep 2018 22:46:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBFAc9SYaPn4-htcjbi9ZijPJrddFQuNSRfU96svBAbQ@mail.gmail.com>
Message-ID: <CAK7LNASBFAc9SYaPn4-htcjbi9ZijPJrddFQuNSRfU96svBAbQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add --include-dir flag only for out-of-tree build
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018=E5=B9=B49=E6=9C=8814=E6=97=A5(=E9=87=91) 15:33 Masahiro Yamada <yamada=
.masahiro@socionext.com>:
>
> The --include-dir flag is used to include check-in Makefiles from
> $(objtree) without $(srctree)/ prefix.  Obviously, this is unneeded
> for in-tree build.  Add the flag just before changing the working
> directory.
>
> This becomes effective after invoking sub-make.  Add a little bit
> comments about it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.



> Changes in v2:
>   - Add some more comments
>
>  Makefile | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f8c8e12..233b57d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -15,10 +15,9 @@ NAME =3D Merciless Moray
>  PHONY :=3D _all
>  _all:
>
> -# o Do not use make's built-in rules and variables
> -#   (this increases performance and avoids hard-to-debug behaviour);
> -# o Look for make include files relative to root of kernel src
> -MAKEFLAGS +=3D -rR --include-dir=3D$(CURDIR)
> +# Do not use make's built-in rules and variables
> +# (this increases performance and avoids hard-to-debug behaviour)
> +MAKEFLAGS +=3D -rR
>
>  # Avoid funny character set dependencies
>  unexport LC_ALL
> @@ -136,6 +135,13 @@ KBUILD_OUTPUT :=3D $(shell mkdir -p $(KBUILD_OUTPUT)=
 && cd $(KBUILD_OUTPUT) \
>  $(if $(KBUILD_OUTPUT),, \
>       $(error failed to create output directory "$(saved-output)"))
>
> +# Look for make include files relative to root of kernel src
> +#
> +# This does not become effective immediately because MAKEFLAGS is re-par=
sed
> +# once after the Makefile is read.  It is OK since we are going to invok=
e
> +# 'sub-make' below.
> +MAKEFLAGS +=3D --include-dir=3D$(CURDIR)
> +
>  PHONY +=3D $(MAKECMDGOALS) sub-make
>
>  $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: su=
b-make
> --
> 2.7.4
>


--=20
Best Regards
Masahiro Yamada
