Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2C0A7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6D920020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6D920020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935634AbeFMM7s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:59:48 -0400
Received: from foss.arm.com ([217.140.101.70]:47232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935608AbeFMM7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:59:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3731529;
        Wed, 13 Jun 2018 05:59:43 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E55D43F25D;
        Wed, 13 Jun 2018 05:59:41 -0700 (PDT)
Subject: Re: [RFC PATCH] irqchip/gic-v3: Add quirk for msm8996 secured
 registers
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org, nicolas.dechesne@linaro.org
References: <20180613114340.32550-1-srinivas.kandagatla@linaro.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <2d866cd1-59a4-befb-b2de-b91f9e56804a@arm.com>
Date:   Wed, 13 Jun 2018 13:59:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613114340.32550-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/18 12:43, Srinivas Kandagatla wrote:
> Access to GICR_WAKER is restricted on msm8996 SoC. Its been more

Restricted by what? Firmware? Hypervisor? (most likely the later).

> than 2 years of wait for this to be fixed in firmware which is

This surely bodes very well in this day and age, where firmware update
are becoming just as important as updating your kernel and your
userspace to fix security problems. I'm impressed.

> not going anywhere. So add a quirk to not write to this register.
> With this quirk MSM8996 can atleast boot out of mainline,

at least

> which can help community to work with boards based on MSM8996.
> 
> Without this patch Qualcomm DB820c board reboots when GICR_WAKER
> is written to.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 76ea56d779a1..d1bb2c0cce02 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -47,6 +47,8 @@ struct redist_region {
>  	bool			single_redist;
>  };
>  
> +#define GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER	(1ULL << 0)

Drop the GICV3 prefix. What does IW means here? Please provide an
erratum number for this, and add a description to
Documentation/arm64/silicon-errata.txt.

> +
>  struct gic_chip_data {
>  	struct fwnode_handle	*fwnode;
>  	void __iomem		*dist_base;
> @@ -55,6 +57,7 @@ struct gic_chip_data {
>  	struct irq_domain	*domain;
>  	u64			redist_stride;
>  	u32			nr_redist_regions;
> +	u64			flags;
>  	bool			has_rss;
>  	unsigned int		irq_nr;
>  	struct partition_desc	*ppi_descs[16];
> @@ -139,6 +142,9 @@ static void gic_enable_redist(bool enable)
>  	u32 count = 1000000;	/* 1s! */
>  	u32 val;
>  
> +	if (gic_data.flags & GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER)
> +		return;
> +
>  	rbase = gic_data_rdist_rd_base();
>  
>  	val = readl_relaxed(rbase + GICR_WAKER);
> @@ -1064,6 +1070,31 @@ static const struct irq_domain_ops partition_domain_ops = {
>  	.select = gic_irq_domain_select,
>  };
>  
> +static bool __maybe_unused gicv3_enable_quirk_msm8996(void *data)

All the functions are prefixed with gic, not gicv3. The function name
should reflect the erratum number.

> +{
> +	struct gic_chip_data *d = data;
> +
> +	d->flags |= GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER;
> +
> +	return true;
> +}
> +
> +static const struct gic_quirk gicv3_quirks[] = {
> +	{
> +		.desc	= "GICV3: Qualcomm MSM8996 WAKER IW",

Please the erratum number in the message. It should read something like:

		"GICv3: Qualcomm erratum BIGNUMBERHERE"

> +		.iidr	= 0x00001070,	/* MSM8996 */
> +		.mask	= 0x0000ffff,

Please match the full GICD_IIDR register, not just the implementer and
the revision. Unless you expect all the QC systems to have the same
behaviour?

> +		.init	= gicv3_enable_quirk_msm8996,
> +	},
> +};
> +
> +static void gic_v3_enable_quirks(struct gic_chip_data *gic_data)

gic, not gic_v3.

> +{
> +	u32 iidr = readl_relaxed(gic_data->dist_base + GICD_IIDR);
> +
> +	gic_enable_quirks(iidr, gicv3_quirks, gic_data);
> +}
> +
>  static int __init gic_init_bases(void __iomem *dist_base,
>  				 struct redist_region *rdist_regs,
>  				 u32 nr_redist_regions,
> @@ -1126,6 +1157,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
>  		its_init(handle, &gic_data.rdists, gic_data.domain);
>  
> +	gic_v3_enable_quirks(&gic_data);
>  	gic_smp_init();
>  	gic_dist_init();
>  	gic_cpu_init();
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
