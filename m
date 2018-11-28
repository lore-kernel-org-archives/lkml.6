Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ADCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCB020832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AkVyZoAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCB020832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeK1UFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:05:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36030 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeK1UFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:05:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id a18so1065448wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yLLvV0awuLMcFk5jBlViuTe6EadRbFI8xCh6hOecpPo=;
        b=AkVyZoApcK+Ep7O+PPXRR41XhcHq9XTXfXm7vZ+JZizTxxjA9AhRpAFGD2ZuXtxS5d
         hyn76Xl6qVdScfa7HpYZUlnI8EIpIM7xX0A2l0W2sHQnprI7gbpjJvnEzPjimYj9eFKH
         Ec33LKhJyZricpNRelA+63ykJEULlr1NK7eHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yLLvV0awuLMcFk5jBlViuTe6EadRbFI8xCh6hOecpPo=;
        b=n3c00aCnVjBXnrG8o7b0+0s2xrFKrG/vMGpLyUm4AGAznPMV4IOPxmRcY7D8PovF5I
         ZTwNGXnXptdUeNVIyI0moTd4r3mD2cbq3LDeHne95ShtqeeFbvfCF4Yd7wZBLBkDjbQs
         hCmhLWjdF/R1awxRumuYpclyBWUt01uqpQVkg/aZRUesTqjMDe/dPAEdjW4MDpnPkN5H
         INx6j0Dytfnpp625RE7h5CHICu61ucJ60DFiIKuBj8lG4p1n96QYQYTsOmxJvFOPoTI8
         pYZnnYIo7h2rz48yzCi8AsgKgB69MbkC44u9cNIHRaTIQ8s9D/fKuoatuFdwLOKHiS3Z
         z4Lg==
X-Gm-Message-State: AA+aEWYqCup0USsuRr+k9n2OdNMhHi3+9Gg0DZ7PEbwnE8Pagx90fr/E
        KBYEoecqbAvnoww+MBlb+bgDDQ==
X-Google-Smtp-Source: AFSGD/ULDgGbpkRfo30sT+BOSflY6InGgiR3U9Wq/KyPsW7ELakNmioj9KSF1FnCcj4pZ3wMlVm4qg==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr1917089wmd.15.1543395897837;
        Wed, 28 Nov 2018 01:04:57 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id t5sm1713829wmd.15.2018.11.28.01.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:04:56 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:04:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Freeman Liu <freeman.liu@spreadtrum.com>,
        linux-input@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: adc: add STMPE ADC driver using IIO framework
Message-ID: <20181128090454.GR4272@dell>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181123142411.8921-2-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123142411.8921-2-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018, Philippe Schenker wrote:

> From: Stefan Agner <stefan@agner.ch>
> 
> This adds an ADC driver for the STMPE device using the industrial
> input/output interface. The driver supports raw reading of values.
> The driver depends on the MFD STMPE driver. If the touchscreen
> block is enabled too, only four of the 8 ADC channels are available.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v3:
>  - Undo ADC-settings related code-deletions in stmpe-ts.c that the code is
>    backwards-compatible to older devicetrees.
> 
> Changes in v2:
>  - Code formatting
>  - Move code to setup ADC to MFD device, as it is used by both drivers
>    adc and touchscreen
>  - Removed unused includes
>  - Defined the macro STMPE_START_ONE_TEMP_CONV with other macros.
>  - Added new macro that defines the channel of the temperature sensor.
>    Took new name for STMPE_MAX_ADC->STMPE_ADC_LAST_NR and used it throughout
>    the code for better readability.
>  - Added mutex_unlock where missing.
> 
>  drivers/iio/adc/Kconfig              |   7 +
>  drivers/iio/adc/Makefile             |   1 +
>  drivers/iio/adc/stmpe-adc.c          | 326 +++++++++++++++++++++++++++
>  drivers/input/touchscreen/stmpe-ts.c |  36 +--

>  drivers/mfd/Kconfig                  |   3 +-
>  drivers/mfd/stmpe.c                  |  81 +++++++
>  include/linux/mfd/stmpe.h            |   9 +

The MFD changes should be contained in a separate patch.

I don't see anything which ties the changes together.

>  7 files changed, 437 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/iio/adc/stmpe-adc.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
