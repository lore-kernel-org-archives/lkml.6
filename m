Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A88C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23B0205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="daViNYoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23B0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeK2Kgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:36:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36077 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeK2Kgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:36:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so28413plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pISjWUS76oypP1h3jeD3XGxLyhj9JCXmpApqVx3naOY=;
        b=daViNYoLBR9YKqL1z5q/pkOO74TZn9+pTOVLPlBvjY2UI8lGHJUsk37JFEVlAk+NPx
         QAYoumlccnBBjsnbRhOXLVxN+lcfdq+hY7Leuk0CWrv/62gpb0T0uUBHALBn4LmJu9om
         QHHdWcufo4zh3ODUwEmtJdMXBnmvzb01FzMho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pISjWUS76oypP1h3jeD3XGxLyhj9JCXmpApqVx3naOY=;
        b=pQH7AM1wHq2LQ+rUyV167JW/sDwf/9kVm+6iNMByqAQ08f3FXu9exwgLeKNmCCLmvl
         vwr3BPWmpFJw+OFA+bpHHVgN1n4pt78IdvCypK/EFfKFh6qhoPM4urGbUabfWVIgtpjd
         LY2JNubre0xVlIFhXfcJSFO3VKSSo66Yk7VKad0S4hm+gkfp2/jBReyrKwHu3CZQM3XH
         pd6clJSj0U5SlyqgH7ca+jYiF+o6I2tP1Tn1vFoh/TEFjhwOYlJVSjM+o9ov8DSRaIyX
         aRGsqMfrpYbdVHFZVqSjSm+XYcY1D9xndZca+5gfFNHhkYuQtquHHIi5KntHamzDhXMJ
         hR7w==
X-Gm-Message-State: AA+aEWaNKDk3CMGWxoJWEol/+dv9FIZAgorU8wfXcbS0EZlYeWk6olgA
        /BWMUDpkocDC6QTIN4kbM2DkvQ==
X-Google-Smtp-Source: AFSGD/W6ftA6vrN6eMlY0Zy5xWkCiMrLVoPFsK0PTWWnWUCbb1x/TiBO+S0dKZrdIzj9o/hdZZU6dw==
X-Received: by 2002:a17:902:b03:: with SMTP id 3mr29803523plq.91.1543448010254;
        Wed, 28 Nov 2018 15:33:30 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 64sm44713pff.101.2018.11.28.15.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 15:33:29 -0800 (PST)
Date:   Wed, 28 Nov 2018 15:33:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     marc.zyngier@arm.com, sudeep.holla@arm.com, tglx@linutronix.de,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, srini@kernel.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org
Subject: Re: [RFC PATCH v3 3/4] irqchip: gic-v3: Add quirk for msm8996
 secured registers
Message-ID: <20181128233327.GE24969@minitux>
References: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
 <20181112103340.24702-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112103340.24702-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12 Nov 02:33 PST 2018, Srinivas Kandagatla wrote:

> Access to GICR_WAKER is restricted on msm8996 SoC in Hypervisor.
> Its been more than 2+ years of wait for this to be fixed, which has
> no hopes to be fixed. This change was introduced for the "lead device"
> on msm8996 platform. It looks like all publicly available msm8996 and
> other qcom SoCs have this implementation.
> 
> So add a quirk to not access this register on msm8996.
> 
> With this quirk MSM8996 can at least boot out of mainline,
> which can help community to work with boards based on MSM8996 and other
> SoCs with have this restrictions. This Quirk is based on device tree
> compatible string.
> 
> Without this patch Qualcomm DB820c board reboots when GICR_WAKER
> is accessed.
> 

Hi Srinivas,

Given that the change request introducing this restriction looks quite
generic and that we've heard reports of other shipping platforms having
the same restriction, could we make this slightly more generic?

I.e. dropping the MSM8996 from the flag name and perhaps use a bool
property in devicetree to toggle the flag, instead of adding compatibles
as we figure out which Qualcomm platforms has this restriction.

Regards,
Bjorn

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 8f87f40c9460..4bd3bbe1b7ce 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -41,6 +41,8 @@
>  
>  #include "irq-gic-common.h"
>  
> +#define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
> +
>  struct redist_region {
>  	void __iomem		*redist_base;
>  	phys_addr_t		phys_base;
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
> +	if (gic_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
> +		return;
> +
>  	rbase = gic_data_rdist_rd_base();
>  
>  	val = readl_relaxed(rbase + GICR_WAKER);
> @@ -1067,6 +1073,23 @@ static const struct irq_domain_ops partition_domain_ops = {
>  	.select = gic_irq_domain_select,
>  };
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
> +		.compatible = "qcom,msm8996-gic-v3", /* MSM8996 */
> +		.init	= gic_enable_quirk_msm8996,
> +	},
> +};
> +
>  static int __init gic_init_bases(void __iomem *dist_base,
>  				 struct redist_region *rdist_regs,
>  				 u32 nr_redist_regions,
> @@ -1126,6 +1149,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  
>  	gic_update_vlpi_properties();
>  
> +	if (is_of_node(handle))
> +		gic_enable_of_quirks(to_of_node(handle), gic_quirks, &gic_data);
> +
>  	gic_smp_init();
>  	gic_dist_init();
>  	gic_cpu_init();
> -- 
> 2.19.1
> 
