Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE3ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5E320C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IoUhYm8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5E320C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeIRIhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:37:38 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:51684 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeIRIhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:37:38 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w8I36hT2012637;
        Tue, 18 Sep 2018 12:06:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w8I36hT2012637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537240004;
        bh=+mnSl0m0bDbdb7Ptk6Kg527ArnVUDSRmtXc979Uqjak=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=IoUhYm8Qdp4AcxE5E0+e8IEc6CuCLuC24o3UF+Dzg4NEF0FEo3hBdO6G4KGeYiRFs
         LYWiGgty2+oMuZUtGy8YEnNTwojH094JXTfa+17bf5kUnW0lto4oyK4a0GRw8SF14m
         Sy8sckQokHCnWUsLLLoUxyGvfPNkYNvYC0RrMbpiJUqQFvIJqfrVN7gVrEY3evnc9T
         byow+pNXOg0w1CU2rNl7GDGrCW5M7Mg065wbKNxmoEMo2yoVCFWX0dTFwa07+dyKJh
         d69eCzG20vtLLn76vhFl6TmAt42kczTfG8HlTpmP+2gvOHjKYOculDzVH+EO7OPssV
         BpOsDyik85nRg==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id y11-v6so146757vso.5;
        Mon, 17 Sep 2018 20:06:43 -0700 (PDT)
X-Gm-Message-State: APzg51A4FcHKRq4uWmlrE5a5Bcvs6Q7B3k/5vLQtKfohUI+EzQ7TPRK/
        G7zDF68FSMXScN/UzbFKfYglqPYfRK7wIq2n+Mo=
X-Google-Smtp-Source: ANB0VdZwYjRi95QnuwwH5KGfCzvZtICFj22fCKfZZqnc80ir6EfuvRjt1M1v914nqPweWjTrCW5gaoq7J/5FTSL6ols=
X-Received: by 2002:a67:4441:: with SMTP id r62-v6mr8635821vsa.38.1537240002354;
 Mon, 17 Sep 2018 20:06:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 20:06:01
 -0700 (PDT)
In-Reply-To: <20180918023157.23951-1-stefan@agner.ch>
References: <20180918023157.23951-1-stefan@agner.ch>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 18 Sep 2018 12:06:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASz4zabEdjO2AVscWbqGyjpEBE6Li7busC_sbYkuuJ7tQ@mail.gmail.com>
Message-ID: <CAK7LNASz4zabEdjO2AVscWbqGyjpEBE6Li7busC_sbYkuuJ7tQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: allow to use GCC toolchain not in Clang search path
To:     Stefan Agner <stefan@agner.ch>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

2018-09-18 11:31 GMT+09:00 Stefan Agner <stefan@agner.ch>:
> When using a GCC cross toolchain which is not in a compiled in
> Clang search path, Clang reverts to the system assembler and
> linker. This leads to assembler or linker errors, depending on
> which tool is first used for a given architecture.
>
> It seems that Clang is not searching $PATH for a matching
> assembler or linker.


The current code passes the absolute path of toolchains
to --gcc-toolchain option.
In my understanding, this is enough for Clang
to find the proper linker and the assembler.


Why is the --prefix option also needed ?


Am I missing something?



> Make sure that Clang picks up the correct assembler or linker by
> passing the cross compilers bin directory as search path.
>
> This allows to use Clang provided by distributions with GCC
> toolchains not in /usr/bin.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/78
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Nick, I removed your Reviewed-by since I had to change variable
> assignment slightly...
>
>  Makefile | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 4d5c883a98e5..d5de2db4b549 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -495,13 +495,15 @@ endif
>  ifeq ($(cc-name),clang)
>  ifneq ($(CROSS_COMPILE),)
>  CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
> -GCC_TOOLCHAIN  := $(realpath $(dir $(shell which $(LD)))/..)
> +GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> +CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
> +GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>  endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
> +KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> +KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
>  KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
>  endif
> --
> 2.19.0
>



-- 
Best Regards
Masahiro Yamada
