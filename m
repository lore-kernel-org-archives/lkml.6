Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68624C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF042089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZZjJFw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF042089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeJPGWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:22:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42563 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeJPGWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:22:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id g20-v6so12903103qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=cVcNYPOptZ8S5aeyxa4Y7XGBHy8OiCAlXkPAzlQn51E=;
        b=eZZjJFw3h0lBoBoMJYDF6joFdf7HUu8uvxRUmbnyUN73SVuZylLFnpyVfXhh1pjsv+
         PEBlo0mTxvY13ZWxlb12ylpCTBvNniSxzKvBmF/wz6yrMhvnWd7hBwwexahXgxq/P96d
         4ZvwF7hb2bje3Xnub+9eH7UJb5M1Bt/EN/AL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=cVcNYPOptZ8S5aeyxa4Y7XGBHy8OiCAlXkPAzlQn51E=;
        b=p7NucoIRw4iyWz+PQaivZhJkj+4xiNPiM3xIAYd60IkEuD3wu7/TH/eAjEjHrrU/jz
         Ig9Z6/gg+Wd5Ob54P8vZqazJwnOthmYnyY2vzQaJ4VCvOpfCWwmgabSu+hlCExRDVIFs
         QGoV57nbLO/p0gbcXv7mz+ygY9uHb9CuAu59g1Hm+QyGP8Nrh+HS92okD41eCc2H6REU
         EK9+LIiSF1d3SlEjC5wd3xbmIGIUCuXExYxMHNhz/eiKVnkwQ5imfPEDmWJ69v7GPrc6
         do9aB9E3mJvPBlOVUKiE7YaNSU75IbtZY7I4uoyOBBRaa/vakjNhSIwNBXLuU4ihaFzk
         4z5g==
X-Gm-Message-State: ABuFfoh/69ReeikqWFc6nu8Fg3XV/mD3guwIFcDnln8pGVy42Ooa7auk
        GQUzBa5DF13ScuHobhgC99Ubjw==
X-Google-Smtp-Source: ACcGV62SFhssOr4qZK6UdsqQx3CasVffbkZAZGKc9ImharH3/XWVfsqh4vv9iA4ZN13N09FTv1vpcQ==
X-Received: by 2002:a37:4bd1:: with SMTP id y200-v6mr18409734qka.55.1539642935354;
        Mon, 15 Oct 2018 15:35:35 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id j57-v6sm8647737qtj.96.2018.10.15.15.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 15:35:34 -0700 (PDT)
Date:   Mon, 15 Oct 2018 18:35:33 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     linux@armlinux.org.uk, ulli.kroll@googlemail.com, joel@jms.id.au,
        arnd@arndb.de, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: copypage: do not use naked functions
In-Reply-To: <20181015222621.14673-1-stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1810151831040.1498@knanqh.ubzr>
References: <20181015222621.14673-1-stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Stefan Agner wrote:

> GCC documentation says naked functions should only use basic ASM
> syntax. The extended ASM or mixture of basic ASM and "C" code is
> not guaranteed. Currently it seems to work though.
> 
> Furthermore with Clang using parameters in extended asm in a
> naked function is not supported:
>   arch/arm/mm/copypage-v4wb.c:47:9: error: parameter references not
>   allowed in naked functions
>         : "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
>                ^
> 
> Use a regular function to be more portable. Also use volatile asm
> to avoid unsolicited optimizations.
> 
> Tested with qemu versatileab machine and versatile_defconfig and
> qemu mainstone machine using pxa_defconfig compiled with GCC 7.2.1
> and Clang 7.0.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/90
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/mm/copypage-fa.c       | 17 +++++++++++------
>  arch/arm/mm/copypage-feroceon.c | 17 +++++++++++------
>  arch/arm/mm/copypage-v4mc.c     | 14 +++++++++-----
>  arch/arm/mm/copypage-v4wb.c     | 17 +++++++++++------
>  arch/arm/mm/copypage-v4wt.c     | 17 +++++++++++------
>  arch/arm/mm/copypage-xsc3.c     | 17 +++++++++++------
>  arch/arm/mm/copypage-xscale.c   | 13 ++++++++-----
>  7 files changed, 72 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
> index ec6501308c60..33ccd396bf99 100644
> --- a/arch/arm/mm/copypage-fa.c
> +++ b/arch/arm/mm/copypage-fa.c
> @@ -17,11 +17,16 @@
>  /*
>   * Faraday optimised copy_user_page
>   */
> -static void __naked
> -fa_copy_user_page(void *kto, const void *kfrom)
> +static void fa_copy_user_page(void *kto, const void *kfrom)
>  {
> -	asm("\
> -	stmfd	sp!, {r4, lr}			@ 2\n\
> +	register void *r0 asm("r0") = kto;
> +	register const void *r1 asm("r1") = kfrom;
> +
> +	asm(
> +	__asmeq("%0", "r0")
> +	__asmeq("%1", "r1")
> +	"\
> +	stmfd	sp!, {r4}			@ 2\n\
>  	mov	r2, %2				@ 1\n\
>  1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
>  	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
> @@ -34,9 +39,9 @@ fa_copy_user_page(void *kto, const void *kfrom)
>  	subs	r2, r2, #1			@ 1\n\
>  	bne	1b				@ 1\n\
>  	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
> -	ldmfd	sp!, {r4, pc}			@ 3"
> +	ldmfd	sp!, {r4}			@ 3"
>  	:
> -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 32));
> +	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 32));

This is still wrong as you list r0 and r1 in the input operand list 
where they must remain constant but the code does modify them. You 
should list them in the output operand list with the "&" attribute. Also 
r2 should be listed in the clobbered list.


Nicolas
