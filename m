Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9596DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645C5217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QQOoYRO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfBHReW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:34:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42580 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfBHReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:34:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so723828pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qwxoUJaBAFteLzh6RJykpa7n9xuqchy/NUCDSUPEHd0=;
        b=QQOoYRO0gh/Za0bheg3uhgOx4qR0rqrkotYKU4qd009x+6hoZQnkywwwBggLmR2iSC
         skKmhAyJXEQbyeNMJHBKi9Ev4yUx6XCOSjk4dDHjAHVAwzOoVZtDURHwTMyr6FI02/5s
         HWIVoboziAbWqP/SkTdU+sx+6A0w+5uI82xg09NYeFEapnCh/fXJwC6D0QDn7HFhnM77
         Q4+05DWzAtWEazFQujJxQSRfay84jyp91cElONh2EOpiYaSmMs3imMCuoOqHxrXNOXXO
         Zu04oXBi+dASgwkxB79YGHv4dP1r2+SDuL08Y9mpuih2BiFtvhTK9J2/+ioBufJFD3MC
         uE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qwxoUJaBAFteLzh6RJykpa7n9xuqchy/NUCDSUPEHd0=;
        b=XiUhnylCjz1xtb+PGQUY08XUoTk8NglABxvR8zh+aXBrG73nOm6zQvjfniCxp1v71k
         qHIFRGjbVSOlW9B/qot2thtwo5TlxihrrhevctyIl30+Xo9vpE3Shw2u4J8TELaCNoEp
         ZuyS5HUOROmytj0zi/vaO4lm38VjbFR5KHfI2hRWXE4eDnPWa+B7kSfmdy9PgTyUkV5j
         m2R0G+X4Bz6qT+fLiHVVEYeqNrmGbN0STFGC0RNRXJK/xMbAU0B7WoCIrOiiqa1Bgkvb
         4KCUz3ETsEnZDFYUmV2yyNs+q1HFfWWi5qoVGCm2qFSSKKWW3F8wwfN5JFuvpM2sRyhb
         X+RQ==
X-Gm-Message-State: AHQUAubc2q7yXNnj8T4ufpr1FwaNze3O4/6KR9xi4k0gYH1I3HTdb/VL
        h/mgvvL62jptGl0vmzsc3nwydQ==
X-Google-Smtp-Source: AHgI3Ia+KJHRxHxAnitQc3735U9pQFBYqA33C04w+iRKO2nIjSJJOll1GjeJEp82TRDujMt58JZfWA==
X-Received: by 2002:aa7:81d0:: with SMTP id c16mr23146437pfn.153.1549647258994;
        Fri, 08 Feb 2019 09:34:18 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:551b:c3ab:6b62:8b9f])
        by smtp.googlemail.com with ESMTPSA id p2sm3311074pgc.94.2019.02.08.09.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 09:34:18 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] arm64: meson: enable g12a clock controller
In-Reply-To: <20190208101405.25699-2-jbrunet@baylibre.com>
References: <20190208101405.25699-1-jbrunet@baylibre.com> <20190208101405.25699-2-jbrunet@baylibre.com>
Date:   Fri, 08 Feb 2019 09:34:17 -0800
Message-ID: <7hlg2qfali.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Enable the g12a clock controller for ARCH_MESON
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/Kconfig.platforms | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 819e74ae9224..d0e0bd4af05d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -114,9 +114,11 @@ config ARCH_MESON
>  	select PINCTRL_MESON
>  	select COMMON_CLK_GXBB
>  	select COMMON_CLK_AXG
> +	select COMMON_CLK_G12A
>  	select MESON_IRQ_GPIO
>  	help
> -	  This enables support for the Amlogic S905 SoCs.
> +	  This enables support for the arm64 based Amlogic SoCs
> +	  such as the s905, S905X/D, S912, A113X/D or S905X/D2

Queued for v5.1.

nit: s/s905/S905/ to match the others.  I'll fix that up when applying
to my v5.1/soc branch.

Kevin
