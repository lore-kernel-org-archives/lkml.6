Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7585C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FDF245CA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FDF245CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934333AbeFVQbw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:31:52 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:39111 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934061AbeFVQbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:31:51 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 28DE9C97D054A;
        Fri, 22 Jun 2018 17:31:47 +0100 (IST)
Received: from FRAEMA708-CHM.china.huawei.com (10.206.14.57) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.382.0; Fri, 22 Jun 2018 17:31:48 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.176]) by
 FRAEMA708-CHM.china.huawei.com ([169.254.8.193]) with mapi id 14.03.0382.000;
 Fri, 22 Jun 2018 18:31:41 +0200
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Lei Zhang <zhang.lei@jp.fujitsu.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 6/7] irqchip/gic-v3-its: Honor hypervisor enforced LPI
 range
Thread-Topic: [PATCH 6/7] irqchip/gic-v3-its: Honor hypervisor enforced LPI
 range
Thread-Index: AQHUCJ4hzL+MVAKZUUSRAob8n9It1KRseE1Q
Date:   Fri, 22 Jun 2018 16:31:40 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838706A1B@FRAEML521-MBX.china.huawei.com>
References: <20180620135234.32101-1-marc.zyngier@arm.com>
 <20180620135234.32101-7-marc.zyngier@arm.com>
In-Reply-To: <20180620135234.32101-7-marc.zyngier@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: 20 June 2018 14:53
> To: linux-kernel@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>; Ard Biesheuvel
> <ard.biesheuvel@linaro.org>; Shanker Donthineni
> <shankerd@codeaurora.org>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; MaJun <majun258@huawei.com>;
> Laurentiu Tudor <laurentiu.tudor@nxp.com>; Lei Zhang
> <zhang.lei@jp.fujitsu.com>
> Subject: [PATCH 6/7] irqchip/gic-v3-its: Honor hypervisor enforced LPI range
> 
> A recent extension to the GIC architecture allows a hypervisor to
> arbitrarily reduce the number of LPIs available to a guest, no
> matter what the GIC says about the valid range of IntIDs.
> 
> Let's factor in this information when computing the number of
> available LPIs

On our D05 board, this limits the lpis to 2 and results in MSI irq alloc fails:

[    0.000000] ITS: Using hypervisor restricted LPI range [2]
....
[   10.543889] ixgbe 000a:11:00.1: Failed to allocate MSI interrupt, falling back to legacy. Error: -12
 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 9 +++++++++
>  include/linux/irqchip/arm-gic-v3.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 8c7e8c235faf..903ca1c19553 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1525,8 +1525,17 @@ static int free_lpi_range(u32 base, u32 nr_lpis)
>  static int __init its_lpi_init(u32 id_bits)
>  {
>  	u32 lpis = (1UL << id_bits) - 8192;
> +	u32 numlpis;
>  	int err;
> 
> +	numlpis = 1UL << GICD_TYPER_NUM_LPIS(gic_rdists->gicd_typer);
> +
> +	if (numlpis > 1 && !WARN_ON(numlpis > lpis)) {
> +		lpis = numlpis;
> +		pr_info("ITS: Using hypervisor restricted LPI range [%u]\n",
> +			lpis);
> +	}

I don't have the GICv3 extension doc, but did you intent to check for,

 if (numlpis > 2 && !WARN_ON(numlpis > lpis)) {

as it looks like D05 returns 0 for bits 11-15 and that makes numlpis=2.

Please let me know.

Thanks,
Shameer

> +
>  	/*
>  	 * Initializing the allocator is just the same as freeing the
>  	 * full range of LPIs.
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-
> v3.h
> index 396cd99af02f..9d2ea3e907d0 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -73,6 +73,7 @@
>  #define GICD_TYPER_MBIS			(1U << 16)
> 
>  #define GICD_TYPER_ID_BITS(typer)	((((typer) >> 19) & 0x1f) + 1)
> +#define GICD_TYPER_NUM_LPIS(typer)	((((typer) >> 11) & 0x1f) + 1)
>  #define GICD_TYPER_IRQS(typer)		((((typer) & 0x1f) + 1) * 32)
> 
>  #define GICD_IROUTER_SPI_MODE_ONE	(0U << 31)
> --
> 2.17.1

