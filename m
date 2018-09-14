Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543E0FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4B020861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBmP61EW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4B020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeINTfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:35:44 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39520 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeINTfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:35:44 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so8854494qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3W9wArRcCFL/r+t5VxuztDD9O2f5jmhyNk2LeEYvDQw=;
        b=JBmP61EWfb6ttvRw9NtsWX5RCNZ+H6JwG+ja4T9V0HqkwOqmN3muVGOtE8ngz+6gHk
         dZ2ja2DZRXcJ41mdNmypgED7E26uR+8673fbNvgQy0sv/C0DLcajHak9QO6TTUh7n8Aq
         elxOtnUDb0/ZMcfj/POhHecVT0SPOXU6GcYFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3W9wArRcCFL/r+t5VxuztDD9O2f5jmhyNk2LeEYvDQw=;
        b=E105BaE8rc36jAbzAcKTuKtYT0NLEGcpPuSqP/20CZF3c9BZTxVQ/9Q7ONNF3Bdui3
         92E7FCSX21htlt0XpFYEychDR8OI85/pzFqPOmHdnV0W2BbgFfZDU7mbZCyz4Jy04bch
         /VLXAO7zuRki1d5QOP2indotbdjLY9+TtutnuXcAhg4XYVFeKuD/7DInBEOxx6vtL8SK
         LRNMWc1tC2ewRVrXJDAPRqO702M/f0o0wkewvez0vO/Ui22D5aNuMxT3memeP1a2WyDm
         b1ojN+ywmnKcgskjQLDedX9Q+j5p0kW1CQMzUCLtgkModjgB36ae0U4ditAyqFaPikbp
         Iztw==
X-Gm-Message-State: APzg51AwRX/MowgHisS4RVDC2NE20Ohy1Wk2gzYsuX30sECbD3NFN2r5
        TkH/DmvXdiJNqGFKsms0oavjrA==
X-Google-Smtp-Source: ANB0Vdb3bqsR8Z1wkPF4cv4XaAlsQsqiEy/crzrCHjvW7P/arRgSD3UOQF7HwusFodG5XCJrPPRSMQ==
X-Received: by 2002:ac8:22f2:: with SMTP id g47-v6mr9263619qta.105.1536934859724;
        Fri, 14 Sep 2018 07:20:59 -0700 (PDT)
Received: from [192.168.2.120] (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.googlemail.com with ESMTPSA id k9-v6sm5863413qtk.2.2018.09.14.07.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:20:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 3/3] thermal: broadcom: Add Stingray thermal driver
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
References: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
 <1533819299-3401-4-git-send-email-srinath.mannam@broadcom.com>
Message-ID: <190f80d4-624b-a46a-c3a0-578a2dbb38b8@linaro.org>
Date:   Fri, 14 Sep 2018 16:20:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533819299-3401-4-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2018 14:54, Srinath Mannam wrote:
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> Adds stingray thermal driver to monitor six
> thermal zones temperature and trips at critical temperature.

Hi Pramod,

could you elaborate a bit more the description? As you are introducing a
new driver it would be nice to give the sensor details.

> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
> ---
>  drivers/thermal/Kconfig               |   3 +-
>  drivers/thermal/broadcom/Kconfig      |   9 ++
>  drivers/thermal/broadcom/Makefile     |   1 +
>  drivers/thermal/broadcom/sr-thermal.c | 216 ++++++++++++++++++++++++++++++++++
>  4 files changed, 228 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 8297988..26d39d4 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -416,7 +416,8 @@ config MTK_THERMAL
>  	  controller present in Mediatek SoCs
>  
>  menu "Broadcom thermal drivers"
> -depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
> +depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM_IPROC || \
> +		COMPILE_TEST
>  source "drivers/thermal/broadcom/Kconfig"
>  endmenu
>  
> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
> index c106a15..dc9a9bd 100644
> --- a/drivers/thermal/broadcom/Kconfig
> +++ b/drivers/thermal/broadcom/Kconfig
> @@ -22,3 +22,12 @@ config BCM_NS_THERMAL
>  	  BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
>  	  Management Unit) block with a thermal sensor that allows checking CPU
>  	  temperature.
> +
> +config BCM_SR_THERMAL
> +	tristate "Stingray thermal driver"
> +	depends on ARCH_BCM_IPROC || COMPILE_TEST
> +	default ARCH_BCM_IPROC
> +	help
> +	  Support for the Stingray family of SoCs. Its different blocks like
> +	  iHost, CRMU and NITRO has thermal sensor that allows checking its
> +	  temperature.
> diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
> index fae10ec..79df69e 100644
> --- a/drivers/thermal/broadcom/Makefile
> +++ b/drivers/thermal/broadcom/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_BCM2835_THERMAL)		+= bcm2835_thermal.o
>  obj-$(CONFIG_BRCMSTB_THERMAL)		+= brcmstb_thermal.o
>  obj-$(CONFIG_BCM_NS_THERMAL)		+= ns-thermal.o
> +obj-$(CONFIG_BCM_SR_THERMAL)		+= sr-thermal.o
> diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
> new file mode 100644
> index 0000000..909f80c
> --- /dev/null
> +++ b/drivers/thermal/broadcom/sr-thermal.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Broadcom
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#define TMON_CRIT_TEMP          105000 /* temp in millidegree C */

I suggest to move this in the DT?

> +#define SR_TMON_MAX_LIST        6
> +
> +/*
> + * In stingray thermal IO memory,
> + * Total Number of available TMONs MASK is at offset 0
> + * temperature registers BASE is at 4 byte offset.
> + * Each TMON temperature register size is 4.
> + */
> +#define SR_TMON_TEMP_BASE(id)   ((id) * 0x4)
> +
> +static const char * const sr_tmon_names[SR_TMON_MAX_LIST] = {

It will be more elegant to replace the macro SR_TMON_MAX_LIST by
ARRAY_SIZE(sr_tmon_names) and declare this array as:

static const char *const sr_tmon_name[] = {
	...
};

> +	"sr_tmon_ihost0",
> +	"sr_tmon_ihost1",
> +	"sr_tmon_ihost2",
> +	"sr_tmon_ihost3",
> +	"sr_tmon_crmu",
> +	"sr_tmon_nitro",
> +};
> +
> +struct sr_tmon {
> +	struct thermal_zone_device *tz;
> +	unsigned int crit_temp;
> +	unsigned int tmon_id;
> +	struct sr_thermal *priv;
> +};
> +
> +struct sr_thermal {
> +	struct device *dev;

This field is used for dev_dbg, may be it could be removed along with
the dev_dbg message?

> +	void __iomem *regs;
> +	struct sr_tmon tmon[SR_TMON_MAX_LIST];
> +};
> +
> +static int sr_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct sr_tmon *tmon = tz->devdata;
> +	struct sr_thermal *sr_thermal = tmon->priv;
> +
> +	*temp = readl(sr_thermal->regs + SR_TMON_TEMP_BASE(tmon->tmon_id));
> +
> +	return 0;
> +}
> +
> +static int sr_get_trip_type(struct thermal_zone_device *tz, int trip,
> +					enum thermal_trip_type *type)
> +{
> +	struct sr_tmon *tmon = tz->devdata;
> +	struct sr_thermal *sr_thermal = tmon->priv;
> +
> +	switch (trip) {
> +	case 0:
> +		*type = THERMAL_TRIP_CRITICAL;
> +		break;
> +	default:
> +		dev_dbg(sr_thermal->dev,
> +			"Driver does not support more than 1 trip point\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int sr_get_trip_temp(struct thermal_zone_device *tz, int trip, int *temp)
> +{
> +	struct sr_tmon *tmon = tz->devdata;
> +	struct sr_thermal *sr_thermal = tmon->priv;
> +
> +	switch (trip) {
> +	case 0:
> +		*temp = tmon->crit_temp;
> +		break;
> +	default:
> +		dev_dbg(sr_thermal->dev,
> +			"Driver does not support more than 1 trip point\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int sr_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
> +{
> +	struct sr_tmon *tmon = tz->devdata;
> +
> +	switch (trip) {
> +	case 0:
> +		/*
> +		 * Allow the user to change critical temperature
> +		 * as per their requirement, could be for debug
> +		 * purpose, even if it's more than the recommended
> +		 * critical temperature.
> +		 */

Couldn't the user harm the hardware with a too high value?

Why not define this value in the DT?

> +		tmon->crit_temp = temp;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

Is it possible to factor out these 3 functions above and remove the
'switch' in all of them ?

> +static struct thermal_zone_device_ops sr_thermal_ops = {
> +	.get_temp = sr_get_temp,
> +	.get_trip_type = sr_get_trip_type,
> +	.get_trip_temp = sr_get_trip_temp,
> +	.set_trip_temp = sr_set_trip_temp,
> +};
> +
> +static int sr_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sr_thermal *sr_thermal;
> +	struct sr_tmon *tmon;
> +	struct resource *res;
> +	uint32_t sr_tmon_list = 0;
> +	unsigned int i;
> +	int ret;
> +
> +	sr_thermal = devm_kzalloc(dev, sizeof(*sr_thermal), GFP_KERNEL);
> +	if (!sr_thermal)
> +		return -ENOMEM;
> +
> +	sr_thermal->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sr_thermal->regs = (void __iomem *)devm_memremap(&pdev->dev, res->start,
> +					 resource_size(res), MEMREMAP_WB);
> +	if (IS_ERR(sr_thermal->regs)) {
> +		dev_err(dev, "failed to get io address\n");
> +		return PTR_ERR(sr_thermal->regs);
> +	}
> +
> +	ret = device_property_read_u32(dev, "brcm,tmon-mask", &sr_tmon_list);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < SR_TMON_MAX_LIST; i++) {
> +
> +		if (!(sr_tmon_list & BIT(i)))
> +			continue;
> +
> +		/* Flush temperature registers */
> +		writel(0, sr_thermal->regs + SR_TMON_TEMP_BASE(i));
> +		tmon = &sr_thermal->tmon[i];

It is possible to initialize tmon to:

		tmon = &sr_thermal->tmon;

and then use the pointer increment:
		tmon++;


> +		tmon->crit_temp = TMON_CRIT_TEMP;
> +		tmon->tmon_id = i;
> +		tmon->priv = sr_thermal;
> +		tmon->tz = thermal_zone_device_register(sr_tmon_names[i],
> +				1, 1,
> +				tmon,
> +				&sr_thermal_ops,
> +				NULL, 1000, 1000);
> +		if (IS_ERR(tmon->tz))
> +			goto err_exit;
> +
> +		dev_info(dev, "%s: registered\n", sr_tmon_names[i]);
> +	}
> +	platform_set_drvdata(pdev, sr_thermal);
> +
> +	return 0;
> +
> +err_exit:
> +	while (--i >= 0) {
> +		if (sr_thermal->tmon[i].tz)
> +			thermal_zone_device_unregister(sr_thermal->tmon[i].tz);
> +	}
> +
> +	return PTR_ERR(tmon->tz);
> +}
> +
> +static int sr_thermal_remove(struct platform_device *pdev)
> +{
> +	struct sr_thermal *sr_thermal = platform_get_drvdata(pdev);
> +	unsigned int i;
> +
> +	for (i = 0; i < SR_TMON_MAX_LIST; i++)
> +		if (sr_thermal->tmon[i].tz)
> +			thermal_zone_device_unregister(sr_thermal->tmon[i].tz);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sr_thermal_of_match[] = {
> +	{ .compatible = "brcm,sr-thermal", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sr_thermal_of_match);
> +
> +static const struct acpi_device_id sr_thermal_acpi_ids[] = {
> +	{ .id = "BRCM0500" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, sr_thermal_acpi_ids);
> +
> +static struct platform_driver sr_thermal_driver = {
> +	.probe		= sr_thermal_probe,
> +	.remove		= sr_thermal_remove,
> +	.driver = {
> +		.name = "sr-thermal",
> +		.of_match_table = sr_thermal_of_match,
> +		.acpi_match_table = ACPI_PTR(sr_thermal_acpi_ids),
> +	},
> +};
> +module_platform_driver(sr_thermal_driver);
> +
> +MODULE_AUTHOR("Pramod Kumar <pramod.kumar@broadcom.com>");
> +MODULE_DESCRIPTION("Stingray thermal driver");
> +MODULE_LICENSE("GPL v2");
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

