Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E64C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A38724653
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxLGPBGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A38724653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933329AbeGDGXY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:23:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52234 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933048AbeGDGXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:23:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id w16-v6so4466758wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qJh9OZ3C9WfZxDIZZ2w7+ge7RAOGJOp+2kJdDFAztTI=;
        b=HxLGPBGfGqw2UmsAFoSiHbjJJ7RXacL9JY/E7n6tq0TelIkno0CsgofYuyILqsOgFK
         /30jyGlOrf3TZZNBDj/v4t/W3fis0YJN3wUoUAVEvLsSLbCwaNrxfC1xioA9Io04kJ9e
         F/tuDiGMTcuFbtT938GVEaQLHfXCljl3Qime4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qJh9OZ3C9WfZxDIZZ2w7+ge7RAOGJOp+2kJdDFAztTI=;
        b=Tep87EEjV7MiNV1SYk4EX0Zn5DIPXrxbI/dIVoVzVFQY2zqPZ/IQTO4eMsfNX9m38o
         MFcv9u5a1W40jtNRTw50UH/tASZBfQ1GSrXLvzQ/piXLDiiOpqW5rEncV76PM6F90mtX
         T9waGqxj4kIyl2rGN+9u+ah8Wm2kVq2Lh7PUL5JhjaII0zN0inmYsZgvfmuhg6tVPXm8
         mDXJfJqzLzzF00Bun6sL29bXT3RjoMLRz5Yv2m7LKQxBjaXBqyLE9nE2GW3NjB6FUcxc
         4bh7qIpH8wggnI5brFdy7QOVKFdUtATv36MrSJF5n26WwnBLihliPSw2kCWUNF3qQtcH
         C+0w==
X-Gm-Message-State: APt69E2xlyn7O2qiHYamatErUV5YBkRVjjKHS9RVjO5zoHnokzWhjmFp
        FQsYIifw92g3I4bDr0kDCdVhzQ==
X-Google-Smtp-Source: AAOMgpf62laKCSOJGpywTZ6z0xBy7iVRUDL5CmHHQQexyN0CFInS8X7WWvsB2Qc2agfPf9PSmpuqtA==
X-Received: by 2002:a1c:f46:: with SMTP id 67-v6mr590640wmp.122.1530685399033;
        Tue, 03 Jul 2018 23:23:19 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id f10-v6sm3963617wrc.93.2018.07.03.23.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 23:23:18 -0700 (PDT)
Date:   Wed, 4 Jul 2018 07:23:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v10 2/6] dt-bindings: add binding for atmel-usart in SPI
 mode
Message-ID: <20180704062316.GY20176@dell>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-3-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625172230.29686-3-radu.pirea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018, Radu Pirea wrote:

> This patch moves the bindings for serial from serial/atmel-usart.txt to
> mfd/atmel-usart.txt and adds bindings for USART in SPI mode.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I already Acked this in V4.

> ---
>  .../bindings/{serial => mfd}/atmel-usart.txt  | 25 +++++++++++++++++--
>  include/dt-bindings/mfd/at91-usart.h          | 17 +++++++++++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
