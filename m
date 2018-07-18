Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C7DECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E58D2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eBKPwBJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E58D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeGRXuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:50:07 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:39151 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGRXuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:50:06 -0400
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com [209.85.217.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w6IN9Y1l029385;
        Thu, 19 Jul 2018 08:09:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w6IN9Y1l029385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531955375;
        bh=lMQkwXcjyOPzc+LeuDE0/OkorVNoHpoif5vc08jtWaY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eBKPwBJizyTRM4GvWE8KW6Ks0X+Aca9iu4j2a/cNefuwko2rk/8P1GIiZAzFU+iRN
         4rHvuw50RB4dtX3JvNV5FVrCVGC5MogJi+HTMlQlrSWKLOoItTQ/8oYY5xU9U8HH2F
         vQGn1IIEDz2IaIlubbL3hxijv086RUd7BayXPE0i4cyIVLY0jMtwIYJiU1r2ucKfub
         +9i7M2ztTfqY3H0noe05+DYf7iNu8AZx/UpUbnVDK5E51vtCpllEtEq1JMcarqP8eq
         YcHACzVcsL32cTCTL3nhD1+1JKVrHuyXS03u8/WQwpXA8Fu6qcK4o2D/tshym4C67N
         2am9Tqae1fTYg==
X-Nifty-SrcIP: [209.85.217.177]
Received: by mail-ua0-f177.google.com with SMTP id x24-v6so3998610ual.10;
        Wed, 18 Jul 2018 16:09:34 -0700 (PDT)
X-Gm-Message-State: AOUpUlGWYAscyOGtOSQVHFqvvQq0leFTY5rTJul0Ac/VhLlJonJWaxvH
        5tW4znWOKFN3Su4Ki/xwLalnVdxkq09v1dlobRM=
X-Google-Smtp-Source: AAOMgpf4UfPazGb3y0eItg4O4eoImNIwQjg7R2LGNtaB4F8XXdQ2qK2cza3xadCknGRUAGB+kRjD4ZoVXBySizh6pQ8=
X-Received: by 2002:ab0:4705:: with SMTP id h5-v6mr5254991uac.140.1531955373612;
 Wed, 18 Jul 2018 16:09:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 16:08:53
 -0700 (PDT)
In-Reply-To: <20180713153033.20540-1-olof@lixom.net>
References: <20180713150701.GA3049@arm.com> <20180713153033.20540-1-olof@lixom.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 19 Jul 2018 08:08:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkL+8sFPiVsxaVF9ffyWFeezTzWFQCnJKTP1Y6-C0N8Q@mail.gmail.com>
Message-ID: <CAK7LNAQkL+8sFPiVsxaVF9ffyWFeezTzWFQCnJKTP1Y6-C0N8Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: build with baremetal linker target instead of
 Linux when available
To:     Olof Johansson <olof@lixom.net>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Paul Kocialkowski <contact@paulk.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-14 0:30 GMT+09:00 Olof Johansson <olof@lixom.net>:
> Not all toolchains have the baremetal elf targets, RedHat/Fedora ones
> in particular. So, probe for whether it's available and use the previous
> (linux) targets if it isn't.
>
> Reported-by: Laura Abbott <labbott@redhat.com>
> Cc: Paul Kocialkowski <contact@paulk.fr>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm64/Makefile    | 9 +++++----
>  scripts/Kbuild.include | 4 ++--
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index e7101b19d590..efe61a2e4b5e 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -60,15 +60,16 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS        += -mbig-endian
>  CHECKFLAGS     += -D__AARCH64EB__
>  AS             += -EB
> -# We must use the linux target here, since distributions don't tend to package
> -# the ELF linker scripts with binutils, and this results in a build failure.
> -LDFLAGS                += -EB -maarch64linuxb
> +# Prefer the baremetal ELF build target, but not all toolchains include
> +# it so fall back to the standard linux version if needed.
> +LDFLAGS                += -EB $(call ld-option, -maarch64elfb, -maarch64linuxb)
>  UTS_MACHINE    := aarch64_be
>  else
>  KBUILD_CPPFLAGS        += -mlittle-endian
>  CHECKFLAGS     += -D__AARCH64EL__
>  AS             += -EL
> -LDFLAGS                += -EL -maarch64linux # See comment above
> +# Same as above, prefer ELF but fall back to linux target if needed.
> +LDFLAGS                += -EL $(call ld-option, -maarch64elf, -maarch64linux)
>  UTS_MACHINE    := aarch64
>  endif
>
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index c8156d61678c..1e13f502b42f 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -163,8 +163,8 @@ cc-ldoption = $(call try-run,\
>         $(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
>
>  # ld-option
> -# Usage: LDFLAGS += $(call ld-option, -X)
> -ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
> +# Usage: LDFLAGS += $(call ld-option, -X, -Y)
> +ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2),$(3))
>
>  # ar-option
>  # Usage: KBUILD_ARFLAGS := $(call ar-option,D)


I guess this patch will go through the arm64 tree.

I am fine with the change of scripts/Kbuild.include

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

-- 
Best Regards
Masahiro Yamada
