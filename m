Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7D2C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA09F21708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="K6DHdvoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA09F21708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeHKLWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 07:22:46 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48944 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeHKLWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 07:22:45 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AD36E5C015D;
        Sat, 11 Aug 2018 10:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533977354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DDpqdcnLkDHBDSAZv8XG60tLf86pNGv3jUE/TNeGk0=;
        b=K6DHdvoeVNRSlqm41u0GBV+j7ug+OSfKJ2xN+2XcsMmJzHFgNHO64OMJbirC9AM90Oy/qu
        GdquIkbmvRqR1B53ODoMcGozius6YnwwAEmQufkuSvUQjo6+0PwG8hYBcrlberjgBIWITo
        GmySm4gOsAp/uxboju/NyP9o8WAFcXs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 11 Aug 2018 10:49:14 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Alistair Strachan <astrachan@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] efi/libstub: arm: support building with clang
In-Reply-To: <20180809164042.210675-1-astrachan@google.com>
References: <20180809164042.210675-1-astrachan@google.com>
Message-ID: <32f5ce9b26a386e81857afcd7d135bad@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2018 18:40, Alistair Strachan wrote:
> When building with CONFIG_EFI and CONFIG_EFI_STUB on ARM, the libstub
> Makefile would use -mno-single-pic-base without checking it was
> supported by the compiler. As the ARM (32-bit) clang backend does not
> support this flag, the build would fail.
> 
> This changes the Makefile to check the compiler's support for
> -mno-single-pic-base before using it, similar to c1c386681bd7 ("ARM:
> 8767/1: add support for building ARM kernel with clang").

Looks good to me:

Reviewed-by: Stefan Agner <stefan@agner.ch>

> 
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Alistair Strachan <astrachan@google.com>
> ---
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile
> b/drivers/firmware/efi/libstub/Makefile
> index a34e9290a699..91339d13f2a1 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
>  
>  cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
>  cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
> -				   -fno-builtin -fpic -mno-single-pic-base
> +				   -fno-builtin -fpic \
> +				   $(call cc-option,-mno-single-pic-base)
>  
>  cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
