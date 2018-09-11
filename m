Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F38C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B53F2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B53F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeIKTNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:13:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44384 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeIKTNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:13:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1EE818A;
        Tue, 11 Sep 2018 07:14:23 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDB1E3F614;
        Tue, 11 Sep 2018 07:14:21 -0700 (PDT)
Subject: Re: [RFC PATCH v2] irqchip/gic-v3: Add quirk for msm8996 secured
 registers
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        Craig Tatlor <ctatlor97@gmail.com>
References: <20180904140538.16602-1-srinivas.kandagatla@linaro.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <69043397-9b99-27f6-82d7-69ba29a8ae22@arm.com>
Date:   Tue, 11 Sep 2018 15:14:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904140538.16602-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/18 15:05, Srinivas Kandagatla wrote:
> Access to GICR_WAKER is restricted on msm8996 SoC in Hypervisor.
> Its been more than 2 years of wait for this to be fixed, which has
> no hopes to be fixed. This change was introduced for the "lead device"
> on msm8996 platform. It looks like all publicly available msm8996
> devices have this implementation.
> 
> So add a quirk to not access this register on msm8996.
> 
> With this quirk MSM8996 can at least boot out of mainline,
> which can help community to work with boards based on MSM8996.
> 
> Without this patch Qualcomm DB820c board reboots when GICR_WAKER
> is accessed.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Hi Marc,
> 
> There is no errata associated with this quirk, so I could not add
> any entries into Documentation/arm64/silicon-errata.txt Or add
> any number to the quirk description.

Well, we still need something. Specially given that this seems to affect 
more than just the piece of HW you mention (see Craig's follow-up). This 
is quite important, given that the IIDR stuff doesn't seem to work at 
all (see below).

> 
> Changes since v1:
> - renamed gic_v3 references to gic
> - added full mask for iidr register match
> 
> thanks,
> srini
> 
>   drivers/irqchip/irq-gic-v3.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index d5912f1ec884..406d4a44c887 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -41,6 +41,8 @@
>   
>   #include "irq-gic-common.h"
>   
> +#define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
> +
>   struct redist_region {
>   	void __iomem		*redist_base;
>   	phys_addr_t		phys_base;
> @@ -55,6 +57,7 @@ struct gic_chip_data {
>   	struct irq_domain	*domain;
>   	u64			redist_stride;
>   	u32			nr_redist_regions;
> +	u64			flags;
>   	bool			has_rss;
>   	unsigned int		irq_nr;
>   	struct partition_desc	*ppi_descs[16];
> @@ -139,6 +142,9 @@ static void gic_enable_redist(bool enable)
>   	u32 count = 1000000;	/* 1s! */
>   	u32 val;
>   
> +	if (gic_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
> +		return;
> +
>   	rbase = gic_data_rdist_rd_base();
>   
>   	val = readl_relaxed(rbase + GICR_WAKER);
> @@ -1068,13 +1074,31 @@ static const struct irq_domain_ops partition_domain_ops = {
>   	.select = gic_irq_domain_select,
>   };
>   
> +static bool __maybe_unused gic_enable_quirk_msm8996(void *data)
> +{
> +	struct gic_chip_data *d = data;
> +
> +	d->flags |= FLAGS_WORKAROUND_GICR_WAKER_MSM8996;
> +
> +	return true;
> +}
> +
> +static const struct gic_quirk gic_quirks[] = {
> +	{
> +		.desc	= "GICv3: Qualcomm MSM8996 skip GICR_WAKER Read/Write",
> +		.iidr	= 0x00001070,	/* MSM8996 */

I just realized that this is the exact same ID as QDF2400, which is a 
perfectly functional platform. So on top of being fairly broken, the 
firmware also hijacks the ID of another implementation. I don't know if 
I should laugh or cry. Needless to say, I'm not going to willingly break 
a perfectly working platform.

> +		.mask	= 0xffffffff,
> +		.init	= gic_enable_quirk_msm8996,
> +	},
> +};
> +
>   static int __init gic_init_bases(void __iomem *dist_base,
>   				 struct redist_region *rdist_regs,
>   				 u32 nr_redist_regions,
>   				 u64 redist_stride,
>   				 struct fwnode_handle *handle)
>   {
> -	u32 typer;
> +	u32 typer, iidr;
>   	int gic_irqs;
>   	int err;
>   
> @@ -1130,6 +1154,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
>   	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
>   		its_init(handle, &gic_data.rdists, gic_data.domain);
>   
> +	iidr = readl_relaxed(dist_base + GICD_IIDR);
> +	gic_enable_quirks(iidr, gic_quirks, &gic_data);
> +
>   	gic_smp_init();
>   	gic_dist_init();
>   	gic_cpu_init();
> 

Given the above, I'm not taking this patch any time soon. Please 
consider alternative methods such as a different (non-)compatible string 
to flag affected implementations.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
