Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCCAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D5520850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7qC+Qh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D5520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbeLEQh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:37:29 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35736 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeLEQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:37:28 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so22966246qtc.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ATOrwfo64RSIZVwG3zT6reeU4TTRPGlCQUXTMYzUBeE=;
        b=P7qC+Qh0yJg8wvBxco5Tv0YnPh8gaxi2jwTZX26+jm2H4hFfqdTC8CO8/Gj3BTdRrC
         a+muoSpP0JG93iTepOwGP+4Q8UM8VwT5eXwCmy5ULl3R5RuthBTUtPmsyqTpm643miSt
         43DSn8ERc7IN2FYihZdjw/lrqoLZ929ohWDS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ATOrwfo64RSIZVwG3zT6reeU4TTRPGlCQUXTMYzUBeE=;
        b=PX38pVtKdMu6kIdRrNtZyfX3J1qmWGJDGYtCBPWZpZDaZV0gzQrl/59HQ6gUb7EfLk
         4h1TDFa7w+qOFQe9m+GQREhOiFXFZ5I5Mu4z3rqfHNLZ6dqoeZKVeMuI5Wu2UfIQN7H9
         AeM9SbLU+ZoPQBiGa7HCl3fWFE6cgR/OrPnph7AqosSM9w1sSFdIwWKCrB4ERkU5YUWX
         xma2BaY9mtnbFb+lJYwVR5br4cqZ17ixsU8LK6RL9oiZ+27mLISgIBppUN5RHNu4403K
         Sazppg5s8cFRiXH/7BssLAnWQYyNeJKr8fTvemb0PlB3UwelWNLP9CsrkSj8ivmHa1Eo
         inPw==
X-Gm-Message-State: AA+aEWZa/Ww9psGsKukNh/nBybubwYsKsdaqtSi3g74SquDcYN3lGrx7
        YsxYrM30rgPvV7638Qf1VvF/og==
X-Google-Smtp-Source: AFSGD/XB+dKMpQoMlgbpaelDKuiRR4aMMN6rE9htYWuRWE6JbgYo2k8sXSFFrXsIXB5V6QYc+qXizA==
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr24780663qvr.115.1544027847713;
        Wed, 05 Dec 2018 08:37:27 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id v57sm14146080qtv.80.2018.12.05.08.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:37:26 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:37:23 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/2] ARM: Remove '-p' from LDFLAGS
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
Message-ID: <nycvar.YSQ.7.76.1812051136470.3623@knanqh.ubzr>
References: <20181205014213.943-1-natechancellor@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Nathan Chancellor wrote:

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

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/Makefile                 | 2 +-
>  arch/arm/boot/compressed/Makefile | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 05a91d8b89f3..e2a0baf36766 100644
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
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 1f5a5ffe7fcf..dcd07bd24b85 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -131,8 +131,6 @@ endif
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux += --be8
>  endif
> -# ?
> -LDFLAGS_vmlinux += -p
>  # Report unresolved symbol references
>  LDFLAGS_vmlinux += --no-undefined
>  # Delete all temporary local symbols
> -- 
> 2.20.0.rc1
> 
> 
