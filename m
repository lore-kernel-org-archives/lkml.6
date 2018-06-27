Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C629C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0015C261DC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y7tb6jsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0015C261DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeF0KMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:12:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53012 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753406AbeF0KMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:12:33 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RABUN2033026;
        Wed, 27 Jun 2018 05:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530094290;
        bh=vBGbRqIfqdQLu1yU0Nn3bra1hOwBUucZBGENRyMmwZ4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=y7tb6jsEdfzpOqyyrtyTAufcoqFDnnytQBwzWIwY9OGQFQppxDkVq2yFea3eAye4A
         lx4LtTvns1VnoJ45tCT4Eltho81K+kOSSK98NoPcxhkPbTy5CNquFnEZBAWFcD4sOt
         gLwForMV1kYDQ5Tvl6yTsTJmY71pk9ZPD22GYwmI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RABUAR021068;
        Wed, 27 Jun 2018 05:11:30 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 05:11:30 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 05:11:30 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RABO9b026842;
        Wed, 27 Jun 2018 05:11:25 -0500
Subject: Re: [PATCH v2 06/13] ARM: davinci: omapl138-hawk: add aemif & nand
 support
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180626092537.6737-1-brgl@bgdev.pl>
 <20180626092537.6737-7-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <11b55553-435b-c363-9194-aebf47302198@ti.com>
Date:   Wed, 27 Jun 2018 15:41:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626092537.6737-7-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 June 2018 02:55 PM, Bartosz Golaszewski wrote:
>  arch/arm/mach-davinci/board-omapl138-hawk.c | 132 ++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index 466e87b24e9a..8d8e3165a45c 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -16,6 +16,11 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/platform_data/gpio-davinci.h>
> +#include <linux/platform_data/ti-aemif.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/mtd/partitions.h>

can you keep this (roughly) sorted by moving these above?

> +#include <linux/platform_data/mtd-davinci.h>
> +#include <linux/platform_data/mtd-davinci-aemif.h>
>  #include <linux/regulator/machine.h>
>  
>  #include <asm/mach-types.h>
> @@ -166,6 +171,129 @@ static __init void omapl138_hawk_mmc_init(void)
>  	gpiod_remove_lookup_table(&mmc_gpios_table);
>  }
>  

> +static struct platform_device omapl138_hawk_aemif_devices[] = {
> +	{
> +		.name		= "davinci_nand",
> +		.id		= 1,

This can be -1 now since you got "mtd: rawnand: davinci: stop using
pdev->id as chipselect" merged.

We cannot change for older platforms, but this is fresh support.

> +		.dev		= {
> +			.platform_data	= &omapl138_hawk_nandflash_data,
> +		},
> +		.resource	= omapl138_hawk_nandflash_resource,
> +		.num_resources	= ARRAY_SIZE(omapl138_hawk_nandflash_resource),
> +	}
> +};

Thanks,
Sekhar
