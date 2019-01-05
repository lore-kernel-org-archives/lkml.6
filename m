Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF87C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C082085A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJ/XCvaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAEQej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:34:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35962 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfAEQei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:34:38 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so43584387qtn.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 08:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lFCcsjcIHNKsXtTsfi9t1v7WWsUtrFogl1Oy++xtw5c=;
        b=HJ/XCvaKr55MY9weQDtj3muQMBCdUVdcJ+kzQsfHfWTc1JWMa9OQJMzHP2IejUm89r
         YT7spI82z7pr1aPuQgjUQXl+VlExc7G09FEngOpNpTp6fAlO04D21z2eS2djuaU1JAYJ
         ZAdO20MvH1al37+mZTihgNOoFafXpJ4cGNT6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lFCcsjcIHNKsXtTsfi9t1v7WWsUtrFogl1Oy++xtw5c=;
        b=Trwi73CQIbzYtjwBmLD82y/AL2ldFZLVAnUVN5e9/LzNIotDoXMHAQnIfCgSUPwdgY
         mHA0MyqstKZJnBzSi05OluSgmri6gq89zisrEjWGCaiO6LtCJebxoymL5RtuhQouJ5rP
         bnqG2zWT90m0xhqoyBGefTAWot6OaiPaJswqaXxYuijjwkIPpQiX5BdWB1lu00GIlqAK
         gIlx442BuP58AwcJUTaSrY1/bJmHanQ7/lP9XJjmBw/b593qECPEKQAC49aPZACM9QUr
         BfzJi8/v+xlMN9+/fkwI4sT5zwYJCrigEpATPCjDPDEoVCMe3liS36XkM+ZUrXqtbF7K
         Vbnw==
X-Gm-Message-State: AJcUukcAETWd4F2qIYe60LJpa33Qcl2jo2s1SIpqe++Oe1AMa/KnmIap
        zTz0Ghj3SkRMTvfo3/eUIMZv0Q==
X-Google-Smtp-Source: ALg8bN4dTgCGTmW+w4hSsQUryTrtmZ+/UswVewMx1xrlkbBeO2AuCwMm+eIYUKNG2YtqaVe+uAoWaQ==
X-Received: by 2002:a0c:9144:: with SMTP id q62mr54119304qvq.87.1546706076964;
        Sat, 05 Jan 2019 08:34:36 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id w34sm33727521qtj.27.2019.01.05.08.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 08:34:35 -0800 (PST)
Date:   Sat, 5 Jan 2019 11:34:31 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2] ARM: Remove '-p' from LDFLAGS
In-Reply-To: <20181231181209.28695-1-natechancellor@gmail.com>
Message-ID: <nycvar.YSQ.7.76.1901051128160.1783@knanqh.ubzr>
References: <20181205014213.943-1-natechancellor@gmail.com> <20181231181209.28695-1-natechancellor@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2018, Nathan Chancellor wrote:

> This option is not supported by lld:
> 
>     ld.lld: error: unknown argument: -p
> 
> This has been a no-op in binutils since 2004 (see commit dea514f51da1 in
> that tree). Given that the lowest officially supported of binutils for
> the kernel is 2.20, which was released in 2009, nobody needs this flag
> around so just remove it. Commit 1a381d4a0a9a ("arm64: remove no-op -p
> linker flag") did the same for arm64.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Stefan Agner <stefan@agner.ch>

You may now submit your patch to RMK's patch system:
http://www.arm.linux.org.uk/developer/patches/


> ---
> 
> v1 -> v2:
> 
> * Collect tags
> 
> * Remove an additional occurence of '-p' in the bootp Makefile, thank
>   you to Stefan for pointing it out
> 
> * Drop patch 2/2, it will be fixed properly in lld: https://reviews.llvm.org/D55505
> 
>  arch/arm/Makefile                 | 2 +-
>  arch/arm/boot/bootp/Makefile      | 2 +-
>  arch/arm/boot/compressed/Makefile | 2 --
>  3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 0436002d5091..1d48c8ed5f89 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -10,7 +10,7 @@
>  #
>  # Copyright (C) 1995-2001 by Russell King
>  
> -LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
> +LDFLAGS_vmlinux	:= --no-undefined -X --pic-veneer
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux	+= --be8
>  KBUILD_LDFLAGS_MODULE	+= --be8
> diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
> index 83e1a076a5d6..981a8d03f064 100644
> --- a/arch/arm/boot/bootp/Makefile
> +++ b/arch/arm/boot/bootp/Makefile
> @@ -8,7 +8,7 @@
>  
>  GCOV_PROFILE	:= n
>  
> -LDFLAGS_bootp	:=-p --no-undefined -X \
> +LDFLAGS_bootp	:= --no-undefined -X \
>  		 --defsym initrd_phys=$(INITRD_PHYS) \
>  		 --defsym params_phys=$(PARAMS_PHYS) -T
>  AFLAGS_initrd.o :=-DINITRD=\"$(INITRD)\"
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 01bf2585a0fa..ecfa4ca320a7 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -132,8 +132,6 @@ endif
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux += --be8
>  endif
> -# ?
> -LDFLAGS_vmlinux += -p
>  # Report unresolved symbol references
>  LDFLAGS_vmlinux += --no-undefined
>  # Delete all temporary local symbols
> -- 
> 2.20.1
> 
> 
