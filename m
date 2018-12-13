Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901CFC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5768E2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/s7opV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5768E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeLMJW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:22:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38685 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeLMJWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:22:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so1581237wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bgqqR6CJkBdeUFkK/RQK0X0uJzxJluUBBR/puxA4ge0=;
        b=Y/s7opV3sD/wfz4FYv94a2QBPBd32r48SGL8SVskgiUsKqW7cGDLSujDVd/c2NUxTq
         RC/q/TPEJpFPIG0U6MmPc5/ZYWVWud/87k1WYylYadvNdtVTPR/P3KFwoLx5QEntBccU
         hM6yCJhkrJMyWnnHnU2S4Ins/s1jtG0jC1M88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bgqqR6CJkBdeUFkK/RQK0X0uJzxJluUBBR/puxA4ge0=;
        b=JDtm8u19K9K8eWISGP2pXJ0TnjuxFUNkEiG9K5MA0MR00HKZYJNh4fqe8hUTWB2lkA
         ynJ/BM/8U1zQkSUX7Or3jP9f42pC49Y76wBL0emj/95B7qpGdmpmLiBcP6ERabYireMZ
         uD7iH1cAXGYccIzJQ2JbHpZmQ5Iy5OBmOHp3Aetm2+N2r3C6ibAy+NgvbfCq7dPP0Fyg
         4knJ5HY6/SB9Kl9Hy705kWT39Pk8aoTyP6/ibT/fitz6ke+EaBNY9Nm18SswvQG0ABUF
         2Qn6spbFJWm6Hw7+XXEtvu3S12fbyzhyhk+lkHUAKqoBSk/O3s7qXhZYIexlhPoXsOtj
         FqOQ==
X-Gm-Message-State: AA+aEWZOj/EW/qurM/b50NUGrHpwcbXhNdr8klWHX/AN/aMSKERMxgfx
        9Ss0do/jiOqTIlRdcZYQthzj8w==
X-Google-Smtp-Source: AFSGD/Ve3MF5ZMj19IVquckJ2GS4bAde/O3MRZmotGmSenLuJgVRt5Ml+kvsV7lxdJOeyneY9nIS+Q==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr9836133wmf.117.1544692942352;
        Thu, 13 Dec 2018 01:22:22 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id k128sm1609608wmd.37.2018.12.13.01.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 01:22:21 -0800 (PST)
Date:   Thu, 13 Dec 2018 09:22:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, linux-rtc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Message-ID: <20181213092219.GM4497@dell>
References: <20181211190953.13626-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181211190953.13626-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Enric Balletbo i Serra wrote:

> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - Fix typo in Benson email address.
> 
>  MAINTAINERS | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a24129b0b043..bbe7180e2851 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3625,6 +3625,30 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
>  F:	drivers/platform/chrome/
>  
> +CHROMEOS EC SUBDRIVERS
> +M:	Benson Leung <bleung@chromium.org>
> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> +F:	Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> +F:	Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> +F:	Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
> +F:	Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> +F:	drivers/extcon/extcon-usbc-cros-ec.c
> +F:	drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +F:	drivers/iio/accel/cros_ec*
> +F:	drivers/iio/common/cros_ec_sensors/
> +F:	drivers/iio/light/cros_ec*
> +F:	drivers/iio/pressure/cros_ec*
> +F:	drivers/input/keyboard/cros_ec*
> +F:	drivers/power/supply/cros_usbpd-charger.c
> +F:	drivers/pwm/pwm-cros-ec.c
> +F:	drivers/rtc/rtc-cros-ec.c
> +F:	include/linux/iio/common/cros_ec_sensors_core.h


> +F:	Documentation/devicetree/bindings/mfd/cros-ec.txt
> +F:	drivers/mfd/cros_ec*
> +F:	include/linux/mfd/cros_ec*

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
