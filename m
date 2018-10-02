Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D60C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D739206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXEh1zhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D739206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbeJBUL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43731 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbeJBUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:58 -0400
Received: by mail-io1-f65.google.com with SMTP id y10-v6so2035672ioa.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Stpq7gf5dZa4IvtA63GCbc3JvnCU2/i30vDIRoeeleM=;
        b=UXEh1zhcpsZvnYP2LAh0tmzcakPFk9sMDJ5aLTwoNl+3X7JGRLlG+Ph+yO931ARafG
         Z0kgw1JLGbYMH5zNELYHrm9AynaLTKRWNO61/Q9CeVB+m8k7Ner3RvfoMzu9tv1ruoW5
         wg315AOr0udTkdAU7kKNSPwyk8lOXzsestBog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Stpq7gf5dZa4IvtA63GCbc3JvnCU2/i30vDIRoeeleM=;
        b=p2vt8/wZSmoJONnHgWF22d+BCcyp9v4RlW9yp4yALaOZlN+Z1GnY8rBoXLLwIB65gf
         RAvkAU1c2AlB/qwCRL7t43SA6FOWOH8XItPdOczLvzWZQufUHt9Lq79JVBlVlYI/Haf7
         Wa9EC+8GtujFvVRkcuSs81cj7z+U9AsYLu0ifJnV5y/dx9MMuMicu/r+OnGFS9M6jvMg
         HV9wrnE3B1/DqJ9l0OmkUycb/X4hfh69wA5Ynt8GHXOwh3O0fNUXFCYfFjuI40a1XFW8
         BEjle2rspNgVqDiGNmFgItIYDKeYJgpWpC17+4JeRDKjxxDtLKt0tKexh0WXtWo4RlxC
         DBVA==
X-Gm-Message-State: ABuFfojzfXUjuAQUWnxWisFj8W6S3ezrw7yVmFkgrFxZTL8dkpPF7fK0
        Ma+WS9uMjLGAJufY6Y5bbZIjKZesjSwzBDmptHVX9w==
X-Google-Smtp-Source: ACcGV63fQ5hdOwvRBEgkrC9TMmJHtoZXTiNZ8AdBEkYZQpSzoQmuZ9MleJaWKotMNak7JPzeLuXBapsEYrWQEpE5dQk=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr10258948iob.170.1538486916658;
 Tue, 02 Oct 2018 06:28:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 06:28:35 -0700 (PDT)
In-Reply-To: <20181002132026.14931-1-Jason@zx2c4.com>
References: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
 <20181002132026.14931-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Oct 2018 15:28:35 +0200
Message-ID: <CAKv+Gu_mwu+TFrbRPqDZ8i5csSqS26a534yzJ_wAQL_Y+W6F7w@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: use ARMv3M mode for RiscPC
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2018 at 15:20, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The purpose of CONFIG_CPU_32v3 is to avoid ldrh/strh on the RiscPC,
> which is pretty much an ARMv4 device, except its bus will choke on the
> half-words. The way to make the C compiler not output ldrh/strh is with
> -march=armv3, which doesn't support them in the ISA. However, this
> prevents certain cryptography code from working that uses instructions
> like umull. Fortunately there's also -march=armv3m that does support
> those, making it possible to continue assembling optimized cryptography
> routines for our beloved RiscPC.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index d1516f85f25d..7fd4bcaf0721 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -74,7 +74,7 @@ endif
>  arch-$(CONFIG_CPU_32v5)                =-D__LINUX_ARM_ARCH__=5 $(call cc-option,-march=armv5te,-march=armv4t)
>  arch-$(CONFIG_CPU_32v4T)       =-D__LINUX_ARM_ARCH__=4 -march=armv4t
>  arch-$(CONFIG_CPU_32v4)                =-D__LINUX_ARM_ARCH__=4 -march=armv4
> -arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
> +arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3m
>
>  # Evaluate arch cc-option calls now
>  arch-y := $(arch-y)
> --
> 2.19.0
>
