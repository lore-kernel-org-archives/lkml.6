Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392D4C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0063E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0iHMzeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfAUWf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:35:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55462 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfAUWf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=smPZs7xn99Pdyb/sQAe3MKY+5MEjJn4rUA+V9wxHRIM=; b=T0iHMzeu7IxhpuDGNuNtlbsvDa
        bpVUu1XCvVgC3o+aLcUjuQcwp7n1m0vafb0nFmQBuTou3nR+RcgTHpZZcWSendy4Rk/1flV33x0xN
        VqWroYPd2KGY8PfbsKhSZpdf8ZrKUf+HnuQzc0AK7ZR/rZLsGv1OE8ZUixdSoHVMQg8do5TvTHYIy
        +eV9RAhXhjuDWccJW0BY0EggEWgYilXq8WkTcjgTPggkQFnKpwc6Lw/OfhwFv4G+wDZQCi1ucJkz7
        uJvxVUaGlZxfIo1UJi7MESUlcr/xvZOE6OgNHGZdIncu+JTLtItUGBlNbADgYcKpI5fKYsjsLap31
        KkHud5Xg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gliAc-0006HE-6P; Mon, 21 Jan 2019 22:35:54 +0000
Subject: Re: [PATCH] mfd: Fix I2C_DESIGNWARE_PLATFORM dependencies
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        linux-i2c@vger.kernel.org, Stable <stable@vger.kernel.org>
References: <20190121141128.5283-1-jarkko.nikula@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <05a36e0c-3b26-c3dd-9f9e-c3e152b0a2a3@infradead.org>
Date:   Mon, 21 Jan 2019 14:35:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190121141128.5283-1-jarkko.nikula@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 6:11 AM, Jarkko Nikula wrote:
> INTEL_SOC_PMIC, INTEL_SOC_PMIC_CHTWC and MFD_TPS68470 select the
> I2C_DESIGNWARE_PLATFORM without its dependencies making it possible to see
> warning and build error like below:
> 
> WARNING: unmet direct dependencies detected for I2C_DESIGNWARE_PLATFORM
>   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ACPI [=y] && COMMON_CLK [=n] || !ACPI [=y])
>   Selected by [y]:
>   - MFD_TPS68470 [=y] && HAS_IOMEM [=y] && ACPI [=y] && I2C [=y]=y
> 
> /usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_resume':
> i2c-designware-platdrv.c:(.text+0x62): undefined reference to `i2c_dw_prepare_clk'
> /usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_suspend':
> i2c-designware-platdrv.c:(.text+0x9a): undefined reference to `i2c_dw_prepare_clk'
> /usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_probe':
> i2c-designware-platdrv.c:(.text+0x41c): undefined reference to `i2c_dw_prepare_clk'
> /usr/bin/ld: i2c-designware-platdrv.c:(.text+0x438): undefined reference to `i2c_dw_read_comp_param'
> /usr/bin/ld: i2c-designware-platdrv.c:(.text+0x545): undefined reference to `i2c_dw_probe'
> /usr/bin/ld: i2c-designware-platdrv.c:(.text+0x727): undefined reference to `i2c_dw_probe_slave'
> 
> Fix this by making above options to depend on I2C_DESIGNWARE_PLATFORM
> being built-in. I2C_DESIGNWARE_PLATFORM is a visible symbol with
> dependencies so in general the select should be avoided.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: acebcff9eda8 ("mfd: intel_soc_pmic: Select designware i2c-bus driver")
> Fixes: de85d79f4aab ("mfd: Add Cherry Trail Whiskey Cove PMIC driver")
> Fixes: 9bbf6a15ce19 ("mfd: Add support for TPS68470 device")
> Cc: Stable <stable@vger.kernel.org> # v4.14+
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/mfd/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f461460a2aeb..6a84a8ecd4a9 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -519,10 +519,10 @@ config INTEL_SOC_PMIC
>  	bool "Support for Crystal Cove PMIC"
>  	depends on ACPI && HAS_IOMEM && I2C=y && GPIOLIB && COMMON_CLK
>  	depends on X86 || COMPILE_TEST
> +	depends on I2C_DESIGNWARE_PLATFORM=y
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
> -	select I2C_DESIGNWARE_PLATFORM
>  	help
>  	  Select this option to enable support for Crystal Cove PMIC
>  	  on some Intel SoC systems. The PMIC provides ADC, GPIO,
> @@ -548,10 +548,10 @@ config INTEL_SOC_PMIC_CHTWC
>  	bool "Support for Intel Cherry Trail Whiskey Cove PMIC"
>  	depends on ACPI && HAS_IOMEM && I2C=y && COMMON_CLK
>  	depends on X86 || COMPILE_TEST
> +	depends on I2C_DESIGNWARE_PLATFORM=y
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
> -	select I2C_DESIGNWARE_PLATFORM
>  	help
>  	  Select this option to enable support for the Intel Cherry Trail
>  	  Whiskey Cove PMIC found on some Intel Cherry Trail systems.
> @@ -1420,9 +1420,9 @@ config MFD_TPS65217
>  config MFD_TPS68470
>  	bool "TI TPS68470 Power Management / LED chips"
>  	depends on ACPI && I2C=y
> +	depends on I2C_DESIGNWARE_PLATFORM=y
>  	select MFD_CORE
>  	select REGMAP_I2C
> -	select I2C_DESIGNWARE_PLATFORM
>  	help
>  	  If you say yes here you get support for the TPS68470 series of
>  	  Power Management / LED chips.
> 


-- 
~Randy
