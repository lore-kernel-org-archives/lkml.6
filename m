Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753A3C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4274520879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfAURJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:09:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39362 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfAURJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:09:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3979715AB;
        Mon, 21 Jan 2019 09:09:29 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF3153F614;
        Mon, 21 Jan 2019 09:09:27 -0800 (PST)
Subject: Re: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
To:     Sasha Levin <sashal@kernel.org>, ruizhao@microsoft.com
Cc:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@microsoft.com,
        will.deacon@arm.com, okaya@kernel.org
References: <20190118162324.17123-1-sashal@kernel.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <0866a996-49f7-1498-4653-20232bef2f46@arm.com>
Date:   Mon, 21 Jan 2019 17:09:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118162324.17123-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha, Rui,

On 18/01/2019 16:23, Sasha Levin wrote:
> From: Rui Zhao <ruizhao@microsoft.com>
> New driver supports DRAM error detection and correction on DMC520
> controller.

> Validated on actual hardware: DRAM errors showed up once the DDR core
> voltage was lowered down by 200+mV using test tool.

That's quite cool!


> ---
>  MAINTAINERS                |   6 +
>  drivers/edac/Kconfig       |   7 +
>  drivers/edac/Makefile      |   1 +
>  drivers/edac/dmc520_edac.c | 495 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 509 insertions(+)
>  create mode 100644 drivers/edac/dmc520_edac.c

Where do I find the dt-binding for this?

It would be good if we can make this generic, so it works on all platforms with
a DMC520, possibly along with other components. (e.g. the a15 L2 driver posted
recently).

This will mostly be getting the DT right, as we can refactor the code when a
second user comes along, but can't change the DT format.


The TRM describes 'a set of interrupts', which ones does the binding anticipate
are wired up for this? There are separate status bits for corrected and
uncorrected, and one pair for dram versus ram. (not sure what this corresponds
with).

Do we care about the link-error interrupt?


It looks you're platform has wired corrected and uncorrected dram up as separate
SPI, but not touched the ram interrupts. These are choices the soc designers
made, we need to capture this stuff in the binding.

A system may have multiple memory controllers, they may share the interrupts.

(It looks like you've folded these corners out by not using IRQF_SHARED: this
driver only works for independent interrupts, which can run concurrently, but
work fine because the only register they both touch is interrupt_clr, which is
write-only.)


For these pre-v8.2-RAS things the expectation is firmware handles all this
stuff. I'm surprised your platform hasn't made the memory-controller
'secure-only', so only platform-firmware can touch it.

I can't see how this could be used on v8/aarch64, it would imply there is no
firmware, which suggests this is a UP system. (or firmware trusts linux not to
mess it up!)

I'm guessing this is for 32bit, where on your platform linux is running in
'secure'. This is a significant platform policy, to make this generic we'd need
to find a way of describing it. i.e., other platforms may have a dmc520, the DT
may describe where it is, but linux can't touch it.
I believe that today this depends on the bootloader knowing which nodes to
remove when starting linux.

I think this policy-bit can be done by having a soc-family/vendor specific
driver that knows which of the edac components can be used on this platform.
The altera driver does something along these lines in altr_sdram_probe().
Obviously if we can have all the data come from DT that is better.


> diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
> new file mode 100644
> index 000000000000..5f14889074af
> --- /dev/null
> +++ b/drivers/edac/dmc520_edac.c
> @@ -0,0 +1,495 @@

> +/* Driver settings */
> +#define DMC520_EDAC_CHANS			1
> +#define DMC520_EDAC_ERR_GRAIN			1
> +#define DMC520_EDAC_INT_COUNT			2
> +#define DMC520_EDAC_BUS_WIDTH			8

Should these be in the DT?
If someone else has a dmc520 configured slightly differently, how can we get
both systems going, without having to change your system's DT?


> +static bool dmc520_is_ecc_enabled(struct dmc520_edac *edac)
> +{
> +	u32 reg_val = dmc520_read_reg(edac, REG_OFFSET_FEATURE_CONFIG);
> +
> +	return (FIELD_GET(REG_FIELD_DRAM_ECC_ENABLED, reg_val) != 0);
> +}

Ah, so there is firmware that sets this up and enables it ...


> +static int dmc520_edac_probe(struct platform_device *pdev)
> +{
> +	struct dmc520_edac *edac;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[2];
> +	int ret, irq;
> +	struct resource *res;
> +	void __iomem *reg_base;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(reg_base))
> +		return PTR_ERR(reg_base);
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = dmc520_get_rank_count(reg_base);
> +	layers[0].is_virt_csrow = true;
> +
> +	layers[1].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[1].size = DMC520_EDAC_CHANS;
> +	layers[1].is_virt_csrow = false;

If you can read the rank count, why hard code the bank?
(which is what I assume channels corresponds to ... although this has confused
me before [0]).


> +	platform_set_drvdata(pdev, mci);
> +
> +	mci->pdev = &pdev->dev;
> +	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;

> +	mci->scrub_cap = SCRUB_HW_SRC;
> +	mci->scrub_mode = SCRUB_NONE;

Is this saying the device supports error scrubbing, but its disabled?
Do we know that?

Can the user try and turn it on? (I can't find anything that reads this!)

It doesn't look like we can configured scrubbing if it wasn't done at boot.
3.3.245 scrub_control0_now of the TRM has "Cannot be written to and only updated
when in CONFIG or LOW-POWER states". I assume we can't put this thing back into
config mode when we're running.


[...]

> +	/* Check ECC CE/UE errors */
> +	dmc520_handle_ecc_errors(mci, true, false);
> +	dmc520_handle_ecc_errors(mci, false, false);

Do we know overflow=false?


> +	/* Enable interrupts */
> +	dmc520_write_reg(edac,
> +			 DRAM_ECC_INT_CE_MASK | DRAM_ECC_INT_UE_MASK,
> +			 REG_OFFSET_INTERRUPT_CONTROL);


What if they were enabled before? (e.g. enabled by firmware, the bootloader or
kdump). If they're already enabled, can we race with the interrupt handler on
another CPU and get double reporting of the error counter?


Thanks,

James

[0] https://lore.kernel.org/lkml/d4ee6d3a-b3ac-2986-40db-8423de7e960a@arm.com/
