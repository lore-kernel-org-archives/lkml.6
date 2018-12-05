Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEE8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA37020850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQXrHnki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA37020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeLEHhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:37:18 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37748 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeLEHhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:37:18 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so18796903iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkTrNYt7fjmOkBFR9cCizpTwwY6al+R2nNwW1id0OOI=;
        b=DQXrHnki7jtuYUyULs1gG8aYTelYlu9U2HKkn49V6Bi8ETw0H7u8VxBE7VWlGGW8V5
         1FvlSTAwGv97K+hYSKhPHMuJZjmnRNEUQEIZiK9RbJKgmxdg2E1ka/S99S18wxeqb7+p
         WZ2CoW1Bl1/FKjgNRNltVNRaNKzE1wnZnDxMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkTrNYt7fjmOkBFR9cCizpTwwY6al+R2nNwW1id0OOI=;
        b=ezJS3A1Pe3zG0d3OdzCguD03/VHNFJRJXtguJeLvntcf73jLj5jfnfQRQj+8tz62rN
         ScHHztfXkdur8s8k0wPk1VnRJuYqzXIa4ETV8iXBCdFJL0GhFlaoCdnTS9pv1lG0lrHh
         M+fT5A7cVEoie/nH8fRCTHgoiJCOPXUUgSPDoS6IvwdWcbznq6j3TjOWWicKYa99hmmb
         2g03+5w0fIX6JmVewV4sltxq5KgbE3QjvHLzvxHHgmEVKlsChfCQd9nCyvbx3S0X1p0+
         HyCSIDao43pfK98MJ4BMyj6Zln0f1zT9/5wpCsXzQibT6IXR6XqE7Mnlk3V4WOfb7h8N
         bCJA==
X-Gm-Message-State: AA+aEWaHIDlIUA71ivJSgQnD/Ky+lJqVswxRlBSt/f7PNEgd9gB+GFiP
        +cgffuxTbvVBxpFDKFlmj08wyHUWcKCZ9AHBtyyT2g==
X-Google-Smtp-Source: AFSGD/VCyKQfzSXzXgDR2De+wqxXCuOPT3UAT7e/DRrdAiCRdHADdSGVHQu9OfJGOSnlJ6B0ZcsNheQoEHkYmoDCh1I=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr15716842ith.158.1543995437578;
 Tue, 04 Dec 2018 23:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com> <20181205014213.943-2-natechancellor@gmail.com>
In-Reply-To: <20181205014213.943-2-natechancellor@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 5 Dec 2018 08:37:05 +0100
Message-ID: <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> This flag is not supported by lld:
>
>     ld.lld: error: unknown argument: --pic-veneer
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Hi Nate,

Does this mean ld.lld is guaranteed to produce position independent
veneers if you build kernels that are bigger than the typical range of
a relative branch?

> ---
>  arch/arm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index e2a0baf36766..4fab2aa29570 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -10,7 +10,7 @@
>  #
>  # Copyright (C) 1995-2001 by Russell King
>
> -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux        += --be8
>  KBUILD_LDFLAGS_MODULE  += --be8
> --
> 2.20.0.rc1
>
