Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBE9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FEA217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="eGDrthbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeL2Mta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:49:30 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57458 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeL2MtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 07:49:25 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 0E1685C03A3;
        Sat, 29 Dec 2018 13:49:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546087764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDa0ox/a1r/Xo9WAoQ6E54h/Id7DcOHbf7mAU3MfjNY=;
        b=eGDrthbFS+drBwAaGSJ2ZCbMQwIayoq6gvyJxtaDfDLtGc2kNi3w7ndrDuacSvlVUVw3LI
        c1c9vdJyIobX3bu8xsfAiNWALNXfGirMx8peGaovZ6nDQTEvPBqLU9URUiVQvd4x54vc27
        FAC0qAUalG0MTf5dpZHLhaNxqUgTtWw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 29 Dec 2018 13:49:23 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/2] ARM: Remove '-p' from LDFLAGS
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
References: <20181205014213.943-1-natechancellor@gmail.com>
Message-ID: <d1b55b04ad9f7fe85394aa2036c4ae23@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.2018 02:42, Nathan Chancellor wrote:
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

There is another -p in arch/arm/boot/bootp/Makefile.

With that fixed:

Reviewed-by: Stefan Agner <stefan@agner.ch>

I guess you can send a v2 with this patch only, which then can make it
in. Patch 2 seems to get fixed by adding --pic-veneer support in lld.

--
Stefan

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
> diff --git a/arch/arm/boot/compressed/Makefile
> b/arch/arm/boot/compressed/Makefile
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
