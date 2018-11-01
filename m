Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04B9C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA4B20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA4B20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeKAUts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:49:48 -0400
Received: from foss.arm.com ([217.140.101.70]:55494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbeKAUts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:49:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D01A78;
        Thu,  1 Nov 2018 04:47:11 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A70E63F71D;
        Thu,  1 Nov 2018 04:47:09 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:47:07 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        andy@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH V5 7/8]  misc/pvpanic: add support to get pvpanic device
 info by FDT
Message-ID: <20181101114706.5mde3n7xwidlcugs@lakrids.cambridge.arm.com>
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
 <1541085002-42993-7-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541085002-42993-7-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:10:01PM +0800, Peng Hao wrote:
> By default, when ACPI tables and FDT coexist for ARM64,
> current kernel takes precedence over FDT to get device information.
> Virt machine in qemu provides both FDT and ACPI table. This patch
> increases the way to get information through FDT.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/misc/pvpanic.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index c0b787e..9d9f0d7 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -3,15 +3,18 @@
>   *  Pvpanic Device Support
>   *
>   *  Copyright (C) 2013 Fujitsu.
> - *
> + *  Copyright (C) 2018 ZTE.
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
>  #include <linux/types.h>
> -#include <linux/acpi.h>
>  
>  MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
>  MODULE_DESCRIPTION("pvpanic device driver");
> @@ -60,6 +63,32 @@
>  	.priority = 1, /* let this called before broken drm_fb_helper */
>  };
>  
> +static int pvpanic_mmio_probe(struct platform_device *pdev)
> +{
> +	struct resource *mem;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem)
> +		return -EINVAL;
> +
> +	base = devm_ioremap_resource(&pdev->dev, mem);
> +	if (base == NULL)
> +		return -EFAULT;
> +
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +				       &pvpanic_panic_nb);
> +
> +	return 0;
> +}
> +
> +static int pvpanic_mmio_remove(struct platform_device *pdev)
> +{
> +
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					 &pvpanic_panic_nb);
> +
> +	return 0;
> +}
>  
>  static acpi_status
>  pvpanic_walk_resources(struct acpi_resource *res, void *context)
> @@ -114,4 +143,35 @@ static int pvpanic_remove(struct acpi_device *device)
>  	return 0;
>  }
>  
> -module_acpi_driver(pvpanic_driver);
> +static const struct of_device_id pvpanic_mmio_match[] = {
> +	{ .compatible = "qemu,pvpanic-mmio", },
> +	{}
> +};
> +
> +static struct platform_driver pvpanic_mmio_driver = {
> +	.driver = {
> +		.name = "pvpanic-mmio",
> +		.of_match_table = pvpanic_mmio_match,
> +	},
> +	.probe = pvpanic_mmio_probe,
> +	.remove = pvpanic_mmio_remove,
> +};
> +
> +static int __init pvpanic_mmio_init(void)
> +{
> +	if (acpi_disabled)
> +		return platform_driver_register(&pvpanic_mmio_driver);
> +	else
> +		return acpi_bus_register_driver(&pvpanic_driver);
> +}
> +
> +static void __exit pvpanic_mmio_exit(void)
> +{
> +	if (acpi_disabled)
> +		platform_driver_unregister(&pvpanic_mmio_driver);
> +	else
> +		acpi_bus_unregister_driver(&pvpanic_driver);
> +}
> +
> +module_init(pvpanic_mmio_init);
> +module_exit(pvpanic_mmio_exit);
> -- 
> 1.8.3.1
> 
