Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70DCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA642171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJXGxgjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfABUDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:03:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34901 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfABUDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:03:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so15628629pfi.2;
        Wed, 02 Jan 2019 12:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUHhFYEAJcz/B5YgT6uq7e3ReZ0ZC/LmMbEEon6Yjxw=;
        b=tJXGxgjZIoj5EBPagnjv5RVY2B+iHThnDBWzCv0nIUdBi6aSTXvvAntLAJWQdC3OJX
         TWQxvSqRQU+tkGMhWCSNCWTf6ma/2Bk2SKqhLJmD+HlR7ybwhwXHXLViJuTMch0WQOMZ
         Vz+kR/W6Es4Wn6z4kbSnERfap15ezYx8nDhuL7SLE+etH+qdMyenDh0in09k8YG/oFiK
         0ibbJQIWXmnak0ZDn97vgkrrkTKziFKkCOy+LwE1a8Q8mevPoBp39yQbVRcx+VvxHF9p
         9so1jkFKIB9nw57g1UMUxd9kyOdyNazSCoCUb8EdmEDWrYGTx/q8Xprqa1vZjxtRfUYK
         yMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUHhFYEAJcz/B5YgT6uq7e3ReZ0ZC/LmMbEEon6Yjxw=;
        b=DT4L/SJmPVNZkV7rMIkBH4ccUHANz3/RmY9G6tf7ppV2xFqkcRbDKA031R3nVechGe
         PuYYbTE9XwkvtQRu5ot231R+5r9yfJj4bJM86Ivy3N6PbznV/h0DGNEefYn+XbwchIwL
         mIRifYrMiMDHj8ZpuQvNqNSQiCGyjX4T5PvdlafAvSpKXIV7EObWJtna9JEPy+z1HrAR
         2OXxI4DwzCDJqTa0A6XfxSBndE+P3qG+Tf2f06dmIU2onz8NCFc8NV7g9XUP4XFhRBGE
         gEE4F2QTtypxP/gR8KIo6Hb4TANvQUWTOheDvO89ruLFAgl8XvUWm0S8VDVQiG2jqK5z
         rb+A==
X-Gm-Message-State: AA+aEWb9urNfT/6rPF5OpBg47v/zHMhRLUVPA5nl3gE01HzIi2pmi4Wb
        ufOEB/yjwZdrBv0c17BwV/E=
X-Google-Smtp-Source: AFSGD/WTH7uLV+FWrIbRxMO3pDBB7SWsVNUz3wrZ2sdc65wBH21Aqs3EeQnlF8scErjBtOllG9ZPhQ==
X-Received: by 2002:a62:1c86:: with SMTP id c128mr47571763pfc.54.1546459390749;
        Wed, 02 Jan 2019 12:03:10 -0800 (PST)
Received: from localhost.localdomain ([207.86.76.174])
        by smtp.gmail.com with ESMTPSA id r6sm83612419pgk.91.2019.01.02.12.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 12:03:09 -0800 (PST)
Date:   Wed, 2 Jan 2019 12:03:08 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH v5 2/3] thermal: broadcom: Add Stingray thermal driver
Message-ID: <20190102200306.GB2024@localhost.localdomain>
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
 <1539702680-3746-3-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539702680-3746-3-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 08:41:19PM +0530, Srinath Mannam wrote:
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> Stingray SoC has six temperature sensor and those are
> configured, controlled and accessed to read temperature
> and update in DDR memory using m0 firmware.
> All six sensors has been given 4 bytes of memory in DDR
> to write temperature in millivolts.
> 
> This thermal driver read temperature values from DDR
> because no direct access to sensors.
> Like this all temparature sensors are monitored and
> trips at critical temperature.
> 
> If driver can't handle thermal runaways because of
> any unknown reason, then firmware in m0 Processor
> will handle.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
> ---
>  drivers/thermal/Kconfig               |   3 +-
>  drivers/thermal/broadcom/Kconfig      |   9 +++
>  drivers/thermal/broadcom/Makefile     |   1 +
>  drivers/thermal/broadcom/sr-thermal.c | 138 ++++++++++++++++++++++++++++++++++
>  4 files changed, 150 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 0e69edc..5f9f070 100644
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
> index 0000000..f45e12e
> --- /dev/null
> +++ b/drivers/thermal/broadcom/sr-thermal.c
> @@ -0,0 +1,138 @@
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
> +/*
> + * In stingray thermal IO memory,
> + * Total Number of available TMONs MASK is at offset 0
> + * temperature registers BASE is at 4 byte offset.
> + * Each TMON temperature register size is 4.
> + */
> +#define SR_TMON_TEMP_BASE(id)   ((id) * 0x4)
> +
> +#define SR_TMON_MAX_LIST        6
> +
> +struct sr_tmon {
> +	struct thermal_zone_device *tz;
> +	unsigned int crit_temp;
> +	unsigned int tmon_id;
> +	struct sr_thermal *priv;
> +};
> +
> +struct sr_thermal {
> +	void __iomem *regs;
> +	unsigned int max_crit_temp;
> +	struct sr_tmon tmon[SR_TMON_MAX_LIST];
> +};
> +
> +static int sr_get_temp(void *data, int *temp)
> +{
> +	struct sr_tmon *tmon = data;
> +	struct sr_thermal *sr_thermal = tmon->priv;
> +
> +	*temp = readl(sr_thermal->regs + SR_TMON_TEMP_BASE(tmon->tmon_id));
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops sr_tz_ops = {
> +	.get_temp = sr_get_temp,
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
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sr_thermal->regs = (void __iomem *)devm_memremap(&pdev->dev, res->start,
> +							 resource_size(res),
> +							 MEMREMAP_WB);
> +	if (IS_ERR(sr_thermal->regs)) {
> +		dev_err(dev, "failed to get io address\n");
> +		return PTR_ERR(sr_thermal->regs);
> +	}
> +
> +	ret = device_property_read_u32(dev, "brcm,tmon-mask", &sr_tmon_list);
> +	if (ret)
> +		return ret;
> +
> +	tmon = sr_thermal->tmon;
> +	for (i = 0; i < SR_TMON_MAX_LIST; i++, tmon++) {
> +
> +		if (!(sr_tmon_list & BIT(i)))
> +			continue;
> +
> +		/* Flush temperature registers */
> +		writel(0, sr_thermal->regs + SR_TMON_TEMP_BASE(i));
> +		tmon->tmon_id = i;
> +		tmon->priv = sr_thermal;
> +		tmon->tz = devm_thermal_zone_of_sensor_register(dev, i, tmon,
> +								&sr_tz_ops);
> +		if (IS_ERR(tmon->tz))
> +			return PTR_ERR(tmon->tz);
> +
> +		dev_info(dev, "thermal sensor %d registered\n", i);
> 

Does this really need to be dev_info() level? Usually just pollutes boot
message logs..

+	}
> +	platform_set_drvdata(pdev, sr_thermal);
> +
> +	return 0;
> +}
> +
> +static int sr_thermal_remove(struct platform_device *pdev)
> +{
> +	struct sr_thermal *sr_thermal = platform_get_drvdata(pdev);
> +	unsigned int i;
> +	struct sr_tmon *tmon;
> +
> +	tmon = sr_thermal->tmon;
> +	for (i = 0; i < SR_TMON_MAX_LIST; i++, tmon++)
> +		if (tmon->tz)
> +			devm_thermal_zone_of_sensor_unregister(&pdev->dev,
> +							       tmon->tz);

Why did you need to explicitly call devm_.*unregister()?

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
> -- 
> 2.7.4
> 
