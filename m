Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EB5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62362175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CZmIb4A4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62362175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbeKNJZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:25:40 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58339 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:25:40 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wADNOxRA011146;
        Wed, 14 Nov 2018 08:25:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wADNOxRA011146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542151500;
        bh=5/n47B9WoRQG5RqZHb6nYGRENCEo59FrzGhRZk/VOW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CZmIb4A4BHLNhnNfTrLINykuiME6cD+ludvir+rgX0RF/0xATVjTAkUCXseAdg5YP
         zWIqJnvMv1czTIyeQT+pWmhDep7NljR8RIPL7d7rCm19tCvLgw2OigxxMAAyufNKCF
         +TJiN7rpl6LEps7lSUWsA1ToD6IUgnELFLVxxrFy5kNQ1U54kXFGH0TsIyOzEnpIl+
         X6m9cvQFLDww7qODhlxdK9nUW6KbTfBf9ko3wiinA55/WabzxiPURh1MdgcA7BGsZ3
         y4FOB5Jo9pctcDQqHXnB+b+HKGbsSD5ffzHAzeUXv8fwRPq2wIt3LRMFkRBQMjdnj6
         dMOz1dsdFfBlA==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id d19so5028915uaq.11;
        Tue, 13 Nov 2018 15:24:59 -0800 (PST)
X-Gm-Message-State: AGRZ1gJpkMNTkeeSSST1OIiJY1CCEHUdt9UMF5ue8SONbGh8kkW1iFgu
        SSDUNOGHdCx8rLQI8imMHfa8QZ4hIzTFMM0HOyg=
X-Google-Smtp-Source: AJdET5cOsLE/d7TXgE73d738BdMt9jluxtAZHTvqLGIR9PCpvPYDnvxco98XfPNS0Mli0b6cDWnkVlh87xarU2ZWhgE=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr3456573uap.6.1542151498764;
 Tue, 13 Nov 2018 15:24:58 -0800 (PST)
MIME-Version: 1.0
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 14 Nov 2018 08:24:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVk788Za-2V58LjjiudiWDM=hjjS_ugVE2K7g9ir+3GQ@mail.gmail.com>
Message-ID: <CAK7LNASVk788Za-2V58LjjiudiWDM=hjjS_ugVE2K7g9ir+3GQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: add -no-integrated-as Clang option unconditionally
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
> We are still a way off the Clang's integrated assembler support for
> the kernel. Hence, -no-integrated-as is mandatory to build the kernel
> with Clang. If you had an ancient version of Clang that does not
> recognize this option, you would not be able to compile the kernel
> anyway.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>
> Changes in v2:
>   - New patch
>
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 93315eb..da11700 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -497,8 +497,8 @@ CLANG_GCC_TC        := --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
>  KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> -KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
> +KBUILD_CFLAGS += -no-integrated-as
> +KBUILD_AFLAGS += -no-integrated-as
>  endif
>
>  RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
