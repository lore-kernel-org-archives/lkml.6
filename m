Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E5CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8672175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2Qwr/wfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8672175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbeKNJ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:26:31 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:59240 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeKNJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:26:30 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wADNPs1g012300;
        Wed, 14 Nov 2018 08:25:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wADNPs1g012300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542151555;
        bh=vZ9KOIiLmOGK0KOwUdWa8RFaKWmxD4apErxBOXls6LM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2Qwr/wfD0fptViNVqAnZly0XVwzNuIUtU04/fTQyefLn20f/nd+hxUhZP9SKaCYJL
         isQsLNyiOcUpFMs67Ai4huT4hH/kIWh1jJ6WTxruUv011RW4JXp/iTqm04XGhnG2fr
         UqNBtzxr7F94IjY/QeZOo+KX/Qkf8xkDT9I5puqulYHudzqCKgFInUU02fXVKmbkka
         J7UEE07b2mqx4LuWGKqzbYQKFM4X7KO2bswX1bAPTjyX+6ivJOeJDhk9ZljeoqUnNT
         x1Jh0J1JiascICrJO4XgVNxOWycvApYzCWWXJlx7KpFU5cN0MYxPxuv+9omIrhx/Ki
         Ub5YBukC2RQwg==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id p74so8440051vsc.0;
        Tue, 13 Nov 2018 15:25:54 -0800 (PST)
X-Gm-Message-State: AGRZ1gKBPvSl92VAJb1KMHkBtSIlS4WgKfZMPdyq3ydiMoihC7K6hYQw
        1QLf6isiM0qOY55b/I4O1wdiRYIznt1S2l7kzZg=
X-Google-Smtp-Source: AJdET5finwsM6Vv9wfmu3tpmY4chWDps3Yf9GacA5z9Q+Os8/Q5mkV5zHRQY7VhfDzvl5GePma/zyMKV2Lv4HsZ5Np8=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr3225348vsm.181.1542151553996;
 Tue, 13 Nov 2018 15:25:53 -0800 (PST)
MIME-Version: 1.0
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com> <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 14 Nov 2018 08:25:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUq-bJKsAWtX1bnRHsf+AhGCm_fVToy2Gpyc5BbW0K5g@mail.gmail.com>
Message-ID: <CAK7LNASUq-bJKsAWtX1bnRHsf+AhGCm_fVToy2Gpyc5BbW0K5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: consolidate Clang compiler flags
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Matthias Kaehlcke <mka@chromium.org>,
        Joel Stanley <joel@jms.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 12:06 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
> -no-integrated-as into a single variable CLANG_FLAGS so that it can be
> easily reused in other parts of Makefile.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.


> Changes in v2:
>  - Use := flavor instead of = because $(CLANG_FLAGS) is expanded soon anyway
>
>  Makefile | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index da11700..e173a73 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -487,18 +487,17 @@ endif
>
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>  ifneq ($(CROSS_COMPILE),)
> -CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
> +CLANG_FLAGS    := --target=$(notdir $(CROSS_COMPILE:%-=%))
>  GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> -CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
> +CLANG_FLAGS    += --prefix=$(GCC_TOOLCHAIN_DIR)
>  GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>  endif
>  ifneq ($(GCC_TOOLCHAIN),)
> -CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
> +CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_CFLAGS += -no-integrated-as
> -KBUILD_AFLAGS += -no-integrated-as
> +CLANG_FLAGS    += -no-integrated-as
> +KBUILD_CFLAGS  += $(CLANG_FLAGS)
> +KBUILD_AFLAGS  += $(CLANG_FLAGS)
>  endif
>
>  RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
