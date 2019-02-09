Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE4C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC34218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="io6gJ4n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfBIR22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:28:28 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:56176 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfBIR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:28:28 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7CA545C1E69;
        Sat,  9 Feb 2019 18:28:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1549733305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PW8zfQNBUwSdLd/R0RaFY9UOCwcevFz+HFnUPe87atQ=;
        b=io6gJ4n5U+HR4miJoeDVnMdccujW0ZscC2xbNXYvqtM5sASYiREoFppsdE8b2TgHYiBJyX
        TA0pGw87laYtP1Zyh2emQy5+3qDotXzn9DE3uo3j1ynkdr+MK4ajakqC3gmbrwTLdCmaWt
        U3bKBJ2px0PF10y8WxckJ5McF5oWvJY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 09 Feb 2019 18:28:25 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] ARM: use unified assembler in c files
In-Reply-To: <fed4850fb5d8a8ca874affa05d8d116d53e25b88.1549532513.git.stefan@agner.ch>
References: <cover.1549532513.git.stefan@agner.ch>
 <fed4850fb5d8a8ca874affa05d8d116d53e25b88.1549532513.git.stefan@agner.ch>
Message-ID: <db0e6b8f034f832c7e52fe3dd47073ad@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reviews so far.

During some more testing I stumbled upon another issue:

On 07.02.2019 10:48, Stefan Agner wrote:
> Use unified assembler syntax (UAL) in inline assembler. Divided
> syntax is considered depricated. This will also allow to build
> the kernel using LLVM's integrated assembler.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/mm/copypage-v4mc.c | 2 +-
>  arch/arm/mm/copypage-v4wb.c | 2 +-
>  arch/arm/mm/copypage-v4wt.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
> index b03202cddddb..b19c7ad1a6de 100644
> --- a/arch/arm/mm/copypage-v4mc.c
> +++ b/arch/arm/mm/copypage-v4mc.c
> @@ -56,7 +56,7 @@ static void mc_copy_user_page(void *from, void *to)
>  	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
>  	subs	%2, %2, #1			@ 1\n\
>  	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
> -	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
> +	ldmiane	%0!, {r2, r3, ip, lr}		@ 4\n\
>  	bne	1b				@ "
>  	: "+&r" (from), "+&r" (to), "=&r" (tmp)
>  	: "2" (PAGE_SIZE / 64)
> diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
> index cd3e165afeed..6e3c9b69dd25 100644
> --- a/arch/arm/mm/copypage-v4wb.c
> +++ b/arch/arm/mm/copypage-v4wb.c
> @@ -38,7 +38,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
>  	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
>  	subs	%2, %2, #1			@ 1\n\
>  	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
> -	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
> +	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
>  	bne	1b				@ 1\n\
>  	mcr	p15, 0, %1, c7, c10, 4		@ 1   drain WB"
>  	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
> diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
> index 8614572e1296..4a40fa1cbc2a 100644
> --- a/arch/arm/mm/copypage-v4wt.c
> +++ b/arch/arm/mm/copypage-v4wt.c
> @@ -34,7 +34,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
>  	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
>  	subs	%2, %2, #1			@ 1\n\
>  	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
> -	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
> +	ldmiane	%1!, {r3, r4, ip, lr}		@ 4\n\
>  	bne	1b				@ 1\n\
>  	mcr	p15, 0, %2, c7, c7, 0		@ flush ID cache"
>  	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)

When compiling with gcc, this leads to:

/tmp/ccrvA1wy.s: Assembler messages:
/tmp/ccrvA1wy.s:180: Error: bad instruction `ldmiane r0!,{r3,r4,ip,lr}'
make[1]: *** [scripts/Makefile.build:277: arch/arm/mm/copypage-v4wb.o]
Error 1
make: *** [Makefile:1042: arch/arm/mm] Error 2

Unfortunately, the gcc option -masm-syntax-unified which allows unified
syntax in inline assembly is broken (see also
https://lkml.org/lkml/2019/1/7/1320).

So this requires to sprinkle those inline assembly with ".syntax
unified" strings, similar to how I've done it in uaccess.h.

--
Stefan
