Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6E5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF22A2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mKyYOEYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393449AbfBOXE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:04:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35061 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfBOXE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 18:04:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id j5so1022426pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 15:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=WSBuT6eeQ81XnwL/J514wr3YHctzw6fgCGrNbp9Fw8A=;
        b=mKyYOEYGysQ02rbg9zTJCtGpUtqEmkPOBZPDfD/TrrCiQCUqOML0i9OeDGPOCFylT1
         OcAiRI3yycSycviATxmGVwMUimOv/ocvFmRul4CLBI/zKFhmYZcaF+jB/qkgVg9vZZ8C
         qvXdYWK0Pqq27NpTkPleQeIdDqlOSMwRpw0aGiBnIRA1J4Vie5bsd56LOtCYD8cHG440
         Cj0Ots+heHC+GawwpE0apoZvkzcM1UuMEXt9weNZips6tymmPS7kkDJ/uHfKmcA8g0GF
         hijgO/LinXsP9lJKVh+2XbYlJw/uAx3PNd6mzhHLnFndDBglc8muo7Lx3RD6tR4yCEUw
         Havw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WSBuT6eeQ81XnwL/J514wr3YHctzw6fgCGrNbp9Fw8A=;
        b=Wgf6ntzZtFhIW0WZvNsyJB39KN/5AQbgJ+/tI9j4ZINI4MrigL/3nzzT21FyJfjCE3
         teCLKjAZHwFPg3gVisn804492QnkKdD5A8vjXLqhvUDxI4H2I4X3rpKkJZ4U2F/cMqGX
         523gfz10rEtM4iXbHuLVlOQvq5D/JDwFUygjaMuWHTaPbNqaoDYQm5EklZQczUJ7YiDy
         9BhXwdQbR4uLF1fxy8pfnkf8BK9taMhkK697z2zwiArxhWzr3DpYVqQ9glccZwh/dZwk
         IH+ExtfepD144jDJaQI1NEyRe5o7S2sPm99ij5nsMYWbyTruMxUXqcsro01vKSXKbVr9
         VU9g==
X-Gm-Message-State: AHQUAuYehv36kS15AWA6Ef1Jc5mt+olt9Fx8KfjGClbm0qg3rJEtMXCr
        b8HzoCFEfNv1V9PbQbZmmuJbng==
X-Google-Smtp-Source: AHgI3IagsKX80wDJARjGhBna3390K6ophwXiS8XXMlS6DB6Rt8jQvSgdgN49nfZHBdxod4PUAX/drQ==
X-Received: by 2002:a63:a:: with SMTP id 10mr7557891pga.121.1550271897540;
        Fri, 15 Feb 2019 15:04:57 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:100f:5904:cb2b:8631])
        by smtp.googlemail.com with ESMTPSA id 64sm8799726pff.101.2019.02.15.15.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 15:04:56 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: Add SEI Robotics SEI510 Board
In-Reply-To: <20190212140259.9537-3-narmstrong@baylibre.com>
References: <20190212140259.9537-1-narmstrong@baylibre.com> <20190212140259.9537-3-narmstrong@baylibre.com>
Date:   Fri, 15 Feb 2019 15:04:55 -0800
Message-ID: <7hy36girfs.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The SEI Robotics SEI510 Board is based on the Amlogic G12A S905X2
> and has the following features :
> - Amlogic G12A S905X2 SoC
> - 10/100 Ethernet
> - USB2 + USB3 ports
> - Micro SDCard Port
> - Audio + CVBS AV Jack port
> - HDMI 2.1 + CEC Port
> - ADC Touch Button
> - Far-Field Microphone Array + Mono HP
> - IR Sensor
> - IR Emmiter LED Array
> - RGB Led
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[...]

> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 0821fed4c074..2709f7ede908 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb

nit: not sorted alphabetically.  I'll move it bofore u200 when applying.

Thanks for the new board support!

Kevin
