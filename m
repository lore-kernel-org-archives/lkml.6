Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA5C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A220835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ihsb+e6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7A220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeJIRNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:13:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53847 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJIRNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:13:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id y11-v6so1197043wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VMCzdP22on589wsFehnS4fY/Istx26tCF06USFoNWKQ=;
        b=Ihsb+e6S82WDTvbz+8J4/aVyRGV4sRN87UxZVEq99jktZqEPHaLvwUlgn+xinzr0pg
         fpj2C1dbhfPo52lCNb2tTu92Fj6s5F65qM6h7Ag0cmIGsrpxcbxp16PQ7GJppNQpWBpj
         5qc4aW8GrzaQs2DRPj8jdbFbhbf3yxi2EkM54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VMCzdP22on589wsFehnS4fY/Istx26tCF06USFoNWKQ=;
        b=RwxGRnhqXnbqSWbSdal0wJryv6KET+fb+YF/IZLsJb601Vknej1/EaEpw+j4SJFjL8
         Mc8VwsVlbioSJVs16d83QgzFWYyUzP9p7H72+GXkrBqAbiEjx4zg5f1/B2jz+qyi3RuV
         Wgj1MMg7DSJFtSctMwDCkqrIT4Dczm4Bi/W7gW+BuJiZZNUbOtMIZ+mj9AR5sLjdBBZT
         trFZfnB51mstw+kKtXEXcKFDodXJuNRQlI+9FbxMEJgySuPS5W4iFtGittPtqbags7lY
         nk/GslbsZdMP1MLbppb6NiusS7Jn0Mp8p3+hWB2A/5/aEs3CL9fT1VanyDfpsaAHXfSk
         fCeg==
X-Gm-Message-State: ABuFfojEshFPe3Zm9HUTLcdLB9hmS5jjYCsZJrEv/imC7K/N7xg4Xsb2
        20PUX1Quzwo4U9svaR1vT/a2mg==
X-Google-Smtp-Source: ACcGV62M7NroAdNaY4ITCQdvdAqRF4YrXDShNIGKjdEMW/iSXLUM3ZAo08haTs6cpMaM2QpepjUVog==
X-Received: by 2002:a1c:7913:: with SMTP id l19-v6mr1306123wme.84.1539079043156;
        Tue, 09 Oct 2018 02:57:23 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id y7-v6sm11279890wmy.27.2018.10.09.02.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:57:22 -0700 (PDT)
Date:   Tue, 9 Oct 2018 02:57:20 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Aishwarya Pant <aishpant@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [RESEND v2 2/2] backlight: Remove ld9040 driver
Message-ID: <20181009095720.GJ4939@dell>
References: <20180927165541.11903-1-krzk@kernel.org>
 <20180927165541.11903-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927165541.11903-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, Krzysztof Kozlowski wrote:

> The driver for LD9040 AMOLED LCD panel was superseded with DRM driver
> panel-samsung-ld9040.c.  It does not support DeviceTree and respective
> possible user (Exynos4210 Universal C210) is DeviceTree-only and uses
> DRM version of driver.
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add Jingoo's and Daniel's acks.
> ---
>  drivers/video/backlight/Kconfig        |   8 -
>  drivers/video/backlight/Makefile       |   1 -
>  drivers/video/backlight/ld9040.c       | 811 -------------------------
>  drivers/video/backlight/ld9040_gamma.h | 202 ------
>  4 files changed, 1022 deletions(-)
>  delete mode 100644 drivers/video/backlight/ld9040.c
>  delete mode 100644 drivers/video/backlight/ld9040_gamma.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
