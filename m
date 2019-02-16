Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CB0222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iR/aDHC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394377AbfBPDDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 22:03:25 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:18784 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfBPDDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 22:03:25 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1G338iw016125;
        Sat, 16 Feb 2019 12:03:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1G338iw016125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550286189;
        bh=fK4CGg+clxECaweZnlz0HTCN4bokvBVCa/Z7kHhSm+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iR/aDHC34P24Nf3vit8zMqqwEIC7nRMLD3FKT33k+i8rHRdgct0hh/fnLrBislEhD
         QvYZCP0pJU9FfUFZoZdiVZBcQXeNX86Ur0TJW0OIMReqwsMWqAer3Xw9mc0l+eMQpR
         SbHHYUClaQgd7oSdifp4/kpb3LoixmOh8bakPZ/tHs+41FoTMSgRkPWOQ6GywkeRz2
         HTujEk3oUGRYlNbuEklJYs8G1bOGmGf4nrXazYILFRPI1Efg4C1dko2upyGGLbyfSW
         fw5vL/rI+jHq8izUcrTtawMgmZS0enXfFxPEyVwTQlxtgDeLthVfiJEPHpcHLJV71a
         Xm/2eXGTnEHYw==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id v26so4219313uap.4;
        Fri, 15 Feb 2019 19:03:09 -0800 (PST)
X-Gm-Message-State: AHQUAuYSAayFocbm8wvQ/MDnRfjjogEVVVY5gg8p5rHW17ZugSBT8joB
        JWlz0gcsdabLMY0rDmGCEGXPa1lbeQgm3yYe6Co=
X-Google-Smtp-Source: AHgI3IaZQ4hjRFbPO04+en6oI4Ucfte44Fis1n6tEqGrxQuZoK4C5n1KksVTwtbhNdvFFdICYUHsL4sl4W0eK+Kqwp0=
X-Received: by 2002:ab0:648c:: with SMTP id p12mr2445519uam.93.1550286188113;
 Fri, 15 Feb 2019 19:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com> <20190211193008.24101-2-ndesaulniers@google.com>
In-Reply-To: <20190211193008.24101-2-ndesaulniers@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 16 Feb 2019 12:02:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZSqAjw6AV49ZT6nyEu4zgDZwOYRq6W-JFVvfpF8Q8mA@mail.gmail.com>
Message-ID: <CAK7LNAQZSqAjw6AV49ZT6nyEu4zgDZwOYRq6W-JFVvfpF8Q8mA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Makefile: clang: choose GCC_TOOLCHAIN_DIR not on LD
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 5:42 AM <ndesaulniers@google.com> wrote:
>
> This causes an issue when trying to build with `make LD=ld.lld` if
> ld.lld and the rest of your cross tools aren't in the same directory
> (ex. /usr/local/bin) (as is the case for Android's build system), as the
> GCC_TOOLCHAIN_DIR then gets set based on `which $(LD)` which will point
> where LLVM tools are, not GCC/binutils tools are located.
>
> Instead, select the GCC_TOOLCHAIN_DIR based on another tool provided by
> binutils for which LLVM does not provide a substitute for, such as
> elfedit.
>
> Fixes commit 785f11aa595b ("kbuild: Add better clang cross build support")
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/341
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

This one looks correct to me.

Applied to linux-kbuild.



> Changes V1->V2:
> * add reviewed and tested tags.
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 86cf35d1d79d..d3b65e96d183 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -492,7 +492,7 @@ endif
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>  ifneq ($(CROSS_COMPILE),)
>  CLANG_FLAGS    := --target=$(notdir $(CROSS_COMPILE:%-=%))
> -GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> +GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
>  CLANG_FLAGS    += --prefix=$(GCC_TOOLCHAIN_DIR)
>  GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>  endif
> --
> 2.20.1.791.gb4d0f1c61a-goog
>


--
Best Regards
Masahiro Yamada
