Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeBSCEu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:04:50 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35244 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeBSCEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:04:48 -0500
X-Google-Smtp-Source: AH8x2255XkqjwRKSZfERmtnRnN5wTkdayMyFydN/BDGNnx5nhyD5HoFeQsjVUP5ABWk78SSGIqTYSA==
Subject: Re: [PATCH v2 1/2] memory: tegra: Squash tegra20-mc into common
 tegra-mc driver
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1518452709.git.digetx@gmail.com>
 <148ce8c56ad764fc8133e0d97e43f9639cae15ff.1518452709.git.digetx@gmail.com>
 <20180213103039.GA6764@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3527fa63-596f-a83b-d868-1575484605d6@gmail.com>
Date: Mon, 19 Feb 2018 05:04:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213103039.GA6764@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2018 13:30, Thierry Reding wrote:
> On Mon, Feb 12, 2018 at 08:06:30PM +0300, Dmitry Osipenko wrote:
>> Tegra30+ has some minor differences in registers / bits layout compared
>> to Tegra20. Let's squash Tegra20 driver into the common tegra-mc driver
>> to reduce code a tad, this also will be useful for the upcoming Tegra's MC
>> reset API.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/Kconfig         |  10 --
>>  drivers/memory/Makefile        |   1 -
>>  drivers/memory/tegra/Makefile  |   1 +
>>  drivers/memory/tegra/mc.c      | 184 +++++++++++++++++++----------
>>  drivers/memory/tegra/mc.h      |  10 ++
>>  drivers/memory/tegra/tegra20.c |  72 ++++++++++++
>>  drivers/memory/tegra20-mc.c    | 254 -----------------------------------------
>>  include/soc/tegra/mc.h         |   4 +-
>>  8 files changed, 211 insertions(+), 325 deletions(-)
>>  create mode 100644 drivers/memory/tegra/tegra20.c
>>  delete mode 100644 drivers/memory/tegra20-mc.c
> 
> I generally like the idea of unifying the drivers, but I think this case
> is somewhat borderline because the changes don't come naturally. That is
> the parameterizations here seem overly heavy with a lot of special cases
> for Tegra20. To me that indicates that Tegra20 is conceptually too much
> apart from Tegra30 and later to make unification reasonable.
> 
> However, I'd still very much like to see them unified, so let's go
> through the remainder in more detail.
> 
>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
>> index 19a0e83f260d..8d731d6c3e54 100644
>> --- a/drivers/memory/Kconfig
>> +++ b/drivers/memory/Kconfig
>> @@ -104,16 +104,6 @@ config MVEBU_DEVBUS
>>  	  Armada 370 and Armada XP. This controller allows to handle flash
>>  	  devices such as NOR, NAND, SRAM, and FPGA.
>>  
>> -config TEGRA20_MC
>> -	bool "Tegra20 Memory Controller(MC) driver"
>> -	default y
>> -	depends on ARCH_TEGRA_2x_SOC
>> -	help
>> -	  This driver is for the Memory Controller(MC) module available
>> -	  in Tegra20 SoCs, mainly for a address translation fault
>> -	  analysis, especially for IOMMU/GART(Graphics Address
>> -	  Relocation Table) module.
>> -
>>  config FSL_CORENET_CF
>>  	tristate "Freescale CoreNet Error Reporting"
>>  	depends on FSL_SOC_BOOKE
>> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
>> index 66f55240830e..a01ab3e22f94 100644
>> --- a/drivers/memory/Makefile
>> +++ b/drivers/memory/Makefile
>> @@ -16,7 +16,6 @@ obj-$(CONFIG_OMAP_GPMC)		+= omap-gpmc.o
>>  obj-$(CONFIG_FSL_CORENET_CF)	+= fsl-corenet-cf.o
>>  obj-$(CONFIG_FSL_IFC)		+= fsl_ifc.o
>>  obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
>> -obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
>>  obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
>>  obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
>>  obj-$(CONFIG_DA8XX_DDRCTL)	+= da8xx-ddrctl.o
>> diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
>> index ce87a9470034..94ab16ba075b 100644
>> --- a/drivers/memory/tegra/Makefile
>> +++ b/drivers/memory/tegra/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  tegra-mc-y := mc.o
>>  
>> +tegra-mc-$(CONFIG_ARCH_TEGRA_2x_SOC)  += tegra20.o
>>  tegra-mc-$(CONFIG_ARCH_TEGRA_3x_SOC)  += tegra30.o
>>  tegra-mc-$(CONFIG_ARCH_TEGRA_114_SOC) += tegra114.o
>>  tegra-mc-$(CONFIG_ARCH_TEGRA_124_SOC) += tegra124.o
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index a4803ac192bb..187a9005351b 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -27,6 +27,7 @@
>>  #define  MC_INT_INVALID_SMMU_PAGE (1 << 10)
>>  #define  MC_INT_ARBITRATION_EMEM (1 << 9)
>>  #define  MC_INT_SECURITY_VIOLATION (1 << 8)
>> +#define  MC_INT_INVALID_GART_PAGE (1 << 7)
>>  #define  MC_INT_DECERR_EMEM (1 << 6)
>>  
>>  #define MC_INTMASK 0x004
>> @@ -53,7 +54,14 @@
>>  #define MC_EMEM_ADR_CFG 0x54
>>  #define MC_EMEM_ADR_CFG_EMEM_NUMDEV BIT(0)
>>  
>> +#define MC_GART_ERROR_REQ		0x30
>> +#define MC_DECERR_EMEM_OTHERS_STATUS	0x58
>> +#define MC_SECURITY_VIOLATION_STATUS	0x74
>> +
>>  static const struct of_device_id tegra_mc_of_match[] = {
>> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
>> +	{ .compatible = "nvidia,tegra20-mc", .data = &tegra20_mc_soc },
>> +#endif
>>  #ifdef CONFIG_ARCH_TEGRA_3x_SOC
>>  	{ .compatible = "nvidia,tegra30-mc", .data = &tegra30_mc_soc },
>>  #endif
>> @@ -79,6 +87,9 @@ static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
>>  	unsigned int i;
>>  	u32 value;
>>  
>> +	if (mc->soc->tegra20)
>> +		return 0;
> 
> Test for feature flags rather than chip generation. This could be
> swapped for:
> 
> 	if (mc->soc->supports_latency_allowance)
> 		return 0;

I'll try to do it other way in V2, without introducing any new flag at all.

>> +
>>  	/* compute the number of MC clock cycles per tick */
>>  	tick = mc->tick * clk_get_rate(mc->clk);
>>  	do_div(tick, NSEC_PER_SEC);
>> @@ -229,6 +240,7 @@ static int tegra_mc_setup_timings(struct tegra_mc *mc)
>>  static const char *const status_names[32] = {
>>  	[ 1] = "External interrupt",
>>  	[ 6] = "EMEM address decode error",
>> +	[ 7] = "GART page fault",
>>  	[ 8] = "Security violation",
>>  	[ 9] = "EMEM arbitration error",
>>  	[10] = "Page fault",
>> @@ -257,78 +269,124 @@ static irqreturn_t tegra_mc_irq(int irq, void *data)
>>  
>>  	for_each_set_bit(bit, &status, 32) {
>>  		const char *error = status_names[bit] ?: "unknown";
>> -		const char *client = "unknown", *desc;
>> -		const char *direction, *secure;
>> +		const char *client = "unknown", *desc = "";
>> +		const char *direction = "read", *secure = "";
>>  		phys_addr_t addr = 0;
>>  		unsigned int i;
>> -		char perm[7];
>> +		char perm[7] = { 0 };
>>  		u8 id, type;
>> -		u32 value;
>> +		u32 value, reg;
>>  
>> -		value = mc_readl(mc, MC_ERR_STATUS);
>> +		if (mc->soc->tegra20) {
>> +			switch (bit) {
>> +			case 6:
> 
> Can we have symbolic names for this (and other bits)?

Sure.

>> +				reg = MC_DECERR_EMEM_OTHERS_STATUS;
>> +				value = mc_readl(mc, reg);
>>  
>> -#ifdef CONFIG_PHYS_ADDR_T_64BIT
>> -		if (mc->soc->num_address_bits > 32) {
>> -			addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
>> -				MC_ERR_STATUS_ADR_HI_MASK);
>> -			addr <<= 32;
>> -		}
>> -#endif
>> +				id = value & mc->soc->client_id_mask;
>> +				desc = error_names[2];
>>  
>> -		if (value & MC_ERR_STATUS_RW)
>> -			direction = "write";
>> -		else
>> -			direction = "read";
>> +				if (value & BIT(31))
>> +					direction = "write";
>> +				break;
>>  
>> -		if (value & MC_ERR_STATUS_SECURITY)
>> -			secure = "secure ";
>> -		else
>> -			secure = "";
>> +			case 7:
>> +				reg = MC_GART_ERROR_REQ;
>> +				value = mc_readl(mc, reg);
>>  
>> -		id = value & mc->soc->client_id_mask;
>> +				id = (value >> 1) & mc->soc->client_id_mask;
>> +				desc = error_names[2];
>>  
>> -		for (i = 0; i < mc->soc->num_clients; i++) {
>> -			if (mc->soc->clients[i].id == id) {
>> -				client = mc->soc->clients[i].name;
>> +				if (value & BIT(0))
>> +					direction = "write";
>> +				break;
>> +
>> +			case 8:
>> +				reg = MC_SECURITY_VIOLATION_STATUS;
>> +				value = mc_readl(mc, reg);
>> +
>> +				id = value & mc->soc->client_id_mask;
>> +				type = (value & BIT(30)) ? 4 : 3;
>> +				desc = error_names[type];
>> +				secure = "secure ";
>> +
>> +				if (value & BIT(31))
>> +					direction = "write";
>> +				break;
>> +
>> +			default:
>> +				reg = 0;
>> +				direction = "";
> 
> This makes no sense to me. Why reset direction here if you already
> explicitly set direction to "read". Why not just leave it unset until
> you know exactly what it's going to be? Why do we even continue in a
> case where we know nothing of the error status?

I decided to re-do the "invalid" bits handling in other way and this "default"
case will be thrown away.

We continue because it's the point of handling _ALL_ bits here, including
erroneous. I don't understand what's the question because you made code that
way, I just added bits handling for T20.

>> +				id = mc->soc->num_clients;
>>  				break;
>>  			}
>> -		}
>>  
>> -		type = (value & MC_ERR_STATUS_TYPE_MASK) >>
>> -		       MC_ERR_STATUS_TYPE_SHIFT;
>> -		desc = error_names[type];
>> +			if (id < mc->soc->num_clients)
>> +				client = mc->soc->clients[id].name;
>>  
>> -		switch (value & MC_ERR_STATUS_TYPE_MASK) {
>> -		case MC_ERR_STATUS_TYPE_INVALID_SMMU_PAGE:
>> -			perm[0] = ' ';
>> -			perm[1] = '[';
>> +			if (reg)
>> +				addr = mc_readl(mc, reg + sizeof(u32));
>> +		} else {
>> +			value = mc_readl(mc, MC_ERR_STATUS);
>>  
>> -			if (value & MC_ERR_STATUS_READABLE)
>> -				perm[2] = 'R';
>> -			else
>> -				perm[2] = '-';
>> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
>> +			if (mc->soc->num_address_bits > 32) {
>> +				addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
>> +					MC_ERR_STATUS_ADR_HI_MASK);
>> +				addr <<= 32;
>> +			}
>> +#endif
>> +			if (value & MC_ERR_STATUS_RW)
>> +				direction = "write";
>>  
>> -			if (value & MC_ERR_STATUS_WRITABLE)
>> -				perm[3] = 'W';
>> -			else
>> -				perm[3] = '-';
>> +			if (value & MC_ERR_STATUS_SECURITY)
>> +				secure = "secure ";
>>  
>> -			if (value & MC_ERR_STATUS_NONSECURE)
>> -				perm[4] = '-';
>> -			else
>> -				perm[4] = 'S';
>> +			id = value & mc->soc->client_id_mask;
>>  
>> -			perm[5] = ']';
>> -			perm[6] = '\0';
>> -			break;
>> +			for (i = 0; i < mc->soc->num_clients; i++) {
>> +				if (mc->soc->clients[i].id == id) {
>> +					client = mc->soc->clients[i].name;
>> +					break;
>> +				}
>> +			}
>>  
>> -		default:
>> -			perm[0] = '\0';
>> -			break;
>> -		}
>> +			type = (value & MC_ERR_STATUS_TYPE_MASK) >>
>> +			       MC_ERR_STATUS_TYPE_SHIFT;
>> +			desc = error_names[type];
>> +
>> +			switch (value & MC_ERR_STATUS_TYPE_MASK) {
>> +			case MC_ERR_STATUS_TYPE_INVALID_SMMU_PAGE:
>> +				perm[0] = ' ';
>> +				perm[1] = '[';
>> +
>> +				if (value & MC_ERR_STATUS_READABLE)
>> +					perm[2] = 'R';
>> +				else
>> +					perm[2] = '-';
>> +
>> +				if (value & MC_ERR_STATUS_WRITABLE)
>> +					perm[3] = 'W';
>> +				else
>> +					perm[3] = '-';
>>  
>> -		value = mc_readl(mc, MC_ERR_ADR);
>> -		addr |= value;
>> +				if (value & MC_ERR_STATUS_NONSECURE)
>> +					perm[4] = '-';
>> +				else
>> +					perm[4] = 'S';
>> +
>> +				perm[5] = ']';
>> +				perm[6] = '\0';
>> +				break;
>> +
>> +			default:
>> +				perm[0] = '\0';
>> +				break;
>> +			}
>> +
>> +			value = mc_readl(mc, MC_ERR_ADR);
>> +			addr |= value;
>> +		}
>>  
>>  		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
>>  				    client, secure, direction, &addr, error,
> 
> I'd prefer if we completely separated the Tegra20 implementation of this
> handler from the Tegra30+ implementation. Both don't end up sharing very
> much in the end but this variant is very difficult to read, in my
> opinion.

I don't mind, although it is difficult to read because patch diff is formed that
way, maybe format-patch options could be tweaked to make it readable. The actual
code is "if (mc->soc->tegra20) {...} else {original code}".

Actually it is good that you asked to do it, because I've spotted couple issues
in this (and relative) code.

>> @@ -369,11 +427,18 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>  	if (IS_ERR(mc->regs))
>>  		return PTR_ERR(mc->regs);
>>  
>> -	mc->clk = devm_clk_get(&pdev->dev, "mc");
>> -	if (IS_ERR(mc->clk)) {
>> -		dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
>> -			PTR_ERR(mc->clk));
>> -		return PTR_ERR(mc->clk);
>> +	if (mc->soc->tegra20) {
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +		mc->regs2 = devm_ioremap_resource(&pdev->dev, res);
>> +		if (IS_ERR(mc->regs2))
>> +			return PTR_ERR(mc->regs2);
> 
> Ugh... this is really ugly. In retrospect we really should've left the
> memory-controller and iommu in the same device tree node. There's really
> no reason for them to be separate, other than perhaps the Linux driver
> model, which we could easily workaround by just instancing the IOMMU
> device from the memory controller driver. That way we could simply share
> the I/O mapping between both and avoid these games with two regions.

Probably MC should have been an MFD and GART its sub-device from the start.
Anyway I'll try to make this code a bit nicer.

>> +	} else {
>> +		mc->clk = devm_clk_get(&pdev->dev, "mc");
>> +		if (IS_ERR(mc->clk)) {
>> +			dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
>> +				PTR_ERR(mc->clk));
>> +			return PTR_ERR(mc->clk);
>> +		}
>>  	}
> 
> It's odd that we don't have an MC clock on Tegra2. I wonder if perhaps
> we just never implemented one, or it uses one which is always on by
> default. Cc Peter to see if he knows.
> 
>>  
>>  	err = tegra_mc_setup_latency_allowance(mc);
>> @@ -416,7 +481,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>  
>>  	value = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
>>  		MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
>> -		MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM;
>> +		MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM |
>> +		MC_INT_INVALID_GART_PAGE;
> 
> This should be conditionalized on a feature flag such as "has_gart". For
> most generations of Tegra this would probably work, but newer versions
> have become quite picky about these kinds of things, so in some cases an
> access to a reserved register or field can cause an exception.

I noticed that some of these flags also don't apply to T30/T40, so for now I
decided to add "intr_mask" per SoC instead of adding the "has_gart" flag.

>>  
>>  	mc_writel(mc, value, MC_INTMASK);
>>  
>> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
>> index ddb16676c3af..1642fbea5ce3 100644
>> --- a/drivers/memory/tegra/mc.h
>> +++ b/drivers/memory/tegra/mc.h
>> @@ -16,15 +16,25 @@
>>  
>>  static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
>>  {
>> +	if (mc->soc->tegra20 && offset >= 0x24)
>> +		return readl(mc->regs2 + offset - 0x3c);
> 
> Erm... this is weird. Shouldn't the check be offset >= 0x3c? Otherwise
> you could turn the offset into a very large number and access memory
> outside of the mapping. At least technically.

Either way it would be access outside of the mapping. Probably it should be
better if the mapping address is completely invalid, because there is a better
chance that it won't be unnoticed.

> Again, it'd be so much easier if MC and IOMMU were a single device as
> they are in actual hardware. I'm sure we could argue the case that the
> current DTS is buggy and that it's reasonable to break backwards-
> compatibility.
> 
>> +
>>  	return readl(mc->regs + offset);
>>  }
>>  
>>  static inline void mc_writel(struct tegra_mc *mc, u32 value,
>>  			     unsigned long offset)
>>  {
>> +	if (mc->soc->tegra20 && offset >= 0x24)
>> +		return writel(value, mc->regs2 + offset - 0x3c);
>> +
>>  	writel(value, mc->regs + offset);
>>  }
>>  
>> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
>> +extern const struct tegra_mc_soc tegra20_mc_soc;
>> +#endif
>> +
>>  #ifdef CONFIG_ARCH_TEGRA_3x_SOC
>>  extern const struct tegra_mc_soc tegra30_mc_soc;
>>  #endif
>> diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
>> new file mode 100644
>> index 000000000000..81a082bdba19
>> --- /dev/null
>> +++ b/drivers/memory/tegra/tegra20.c
>> @@ -0,0 +1,72 @@
>> +/*
>> + * Copyright (C) 2012 NVIDIA CORPORATION.  All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include "mc.h"
>> +
>> +static const struct tegra_mc_client tegra20_mc_clients[] = {
>> +	{ .name = "display0a" },
>> +	{ .name = "display0ab" },
>> +	{ .name = "display0b" },
>> +	{ .name = "display0bb" },
>> +	{ .name = "display0c" },
>> +	{ .name = "display0cb" },
>> +	{ .name = "display1b" },
>> +	{ .name = "display1bb" },
>> +	{ .name = "eppup" },
>> +	{ .name = "g2pr" },
>> +	{ .name = "g2sr" },
>> +	{ .name = "mpeunifbr" },
>> +	{ .name = "viruv" },
>> +	{ .name = "avpcarm7r" },
>> +	{ .name = "displayhc" },
>> +	{ .name = "displayhcb" },
>> +	{ .name = "fdcdrd" },
>> +	{ .name = "g2dr" },
>> +	{ .name = "host1xdmar" },
>> +	{ .name = "host1xr" },
>> +	{ .name = "idxsrd" },
>> +	{ .name = "mpcorer" },
>> +	{ .name = "mpe_ipred" },
>> +	{ .name = "mpeamemrd" },
>> +	{ .name = "mpecsrd" },
>> +	{ .name = "ppcsahbdmar" },
>> +	{ .name = "ppcsahbslvr" },
>> +	{ .name = "texsrd" },
>> +	{ .name = "vdebsevr" },
>> +	{ .name = "vdember" },
>> +	{ .name = "vdemcer" },
>> +	{ .name = "vdetper" },
>> +	{ .name = "eppu" },
>> +	{ .name = "eppv" },
>> +	{ .name = "eppy" },
>> +	{ .name = "mpeunifbw" },
>> +	{ .name = "viwsb" },
>> +	{ .name = "viwu" },
>> +	{ .name = "viwv" },
>> +	{ .name = "viwy" },
>> +	{ .name = "g2dw" },
>> +	{ .name = "avpcarm7w" },
>> +	{ .name = "fdcdwr" },
>> +	{ .name = "host1xw" },
>> +	{ .name = "ispw" },
>> +	{ .name = "mpcorew" },
>> +	{ .name = "mpecswr" },
>> +	{ .name = "ppcsahbdmaw" },
>> +	{ .name = "ppcsahbslvw" },
>> +	{ .name = "vdebsevw" },
>> +	{ .name = "vdembew" },
>> +	{ .name = "vdetpmw" },
>> +};
> 
> Can you please initialize the .id field for these? I know they aren't
> technically necessary because the Tegra20 code doesn't actually look up
> the client by ID (because the ID happens to match the array index), but
> I'd like this to be consistent across all generations.

Okay.
