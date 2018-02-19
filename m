Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeBSMgF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:36:05 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:41047 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbeBSMgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:36:03 -0500
X-Google-Smtp-Source: AH8x227QifOkoN2ZsePugOjwyJm6mY/Oru12TQGmMe2/wZM+aZhTItT0eqcXmDQZ82fnnUsUtE37dg==
Subject: Re: [PATCH v2 2/2] memory: tegra: Introduce memory client hot reset
 API
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518452709.git.digetx@gmail.com>
 <6eff4be25012d88595a9ef73d3d626e4707b032c.1518452709.git.digetx@gmail.com>
 <20180213112418.GB6764@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e061ce8f-fe3a-8697-3ec2-eed40e00ee8d@gmail.com>
Date: Mon, 19 Feb 2018 15:35:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213112418.GB6764@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2018 14:24, Thierry Reding wrote:
> On Mon, Feb 12, 2018 at 08:06:31PM +0300, Dmitry Osipenko wrote:
>> In order to reset busy HW properly, memory controller needs to be
>> involved, otherwise it possible to get corrupted memory if HW was reset
>> during DMA. Introduce memory client 'hot reset' API that will be used
>> for resetting busy HW. The primary users are memory clients related to
>> video (decoder/encoder/camera) and graphics (2d/3d).
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/mc.c       | 249 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/memory/tegra/tegra114.c |  25 ++++
>>  drivers/memory/tegra/tegra124.c |  32 ++++++
>>  drivers/memory/tegra/tegra20.c  |  23 ++++
>>  drivers/memory/tegra/tegra210.c |  27 +++++
>>  drivers/memory/tegra/tegra30.c  |  25 ++++
>>  include/soc/tegra/mc.h          |  77 +++++++++++++
>>  7 files changed, 458 insertions(+)
> 
> As discussed on IRC, I typed up a variant of this in an attempt to fix
> an unrelated bug report. The code is here:
> 
> 	https://github.com/thierryreding/linux/commit/e104e703cb75dfe742b2e051194a0af8ddefcd03
> 
> I think we can make this without adding a custom API. The reset control
> API should work just fine. The above version doesn't take into account
> some of Tegra20's quirks, but I think it should still work for Tegra20
> with just slightly different implementations for ->assert() and
> ->deassert().
> 
> A couple of more specific comments below.
> 
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index 187a9005351b..9838f588d64d 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -7,11 +7,13 @@
>>   */
>>  
>>  #include <linux/clk.h>
>> +#include <linux/delay.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/reset.h>
>>  #include <linux/slab.h>
>>  #include <linux/sort.h>
>>  
>> @@ -81,6 +83,172 @@ static const struct of_device_id tegra_mc_of_match[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
>>  
>> +static int terga_mc_flush_dma(struct tegra_mc *mc, unsigned int id)
>> +{
>> +	unsigned int hw_id = mc->soc->modules[id].hw_id;
>> +	u32 value, reg_poll = mc->soc->reg_client_flush_status;
>> +	int retries = 3;
>> +
>> +	value = mc_readl(mc, mc->soc->reg_client_ctrl);
>> +
>> +	if (mc->soc->tegra20)
>> +		value &= ~BIT(hw_id);
>> +	else
>> +		value |= BIT(hw_id);
>> +
>> +	/* block clients DMA requests */
>> +	mc_writel(mc, value, mc->soc->reg_client_ctrl);
>> +
>> +	/* wait for completion of the outstanding DMA requests */
>> +	if (mc->soc->tegra20) {
>> +		while (mc_readl(mc, reg_poll + hw_id * sizeof(u32)) != 0) {
>> +			if (!retries--)
>> +				return -EBUSY;
>> +
>> +			usleep_range(1000, 2000);
>> +		}
>> +	} else {
>> +		while ((mc_readl(mc, reg_poll) & BIT(hw_id)) == 0) {
>> +			if (!retries--)
>> +				return -EBUSY;
>> +
>> +			usleep_range(1000, 2000);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 
> I think this suffers from too much unification. The programming model is
> too different to stash this into a single function implementation and as
> a result this becomes very difficult to read. In my experience it's more
> readable to split this into separate implementations and pass around
> pointers to them.
> 
>> +
>> +static int terga_mc_unblock_dma(struct tegra_mc *mc, unsigned int id)
>> +{
>> +	unsigned int hw_id = mc->soc->modules[id].hw_id;
>> +	u32 value;
>> +
>> +	value = mc_readl(mc, mc->soc->reg_client_ctrl);
>> +
>> +	if (mc->soc->tegra20)
>> +		value |= BIT(hw_id);
>> +	else
>> +		value &= ~BIT(hw_id);
>> +
>> +	mc_writel(mc, value, mc->soc->reg_client_ctrl);
>> +
>> +	return 0;
>> +}
>> +
>> +static int terga_mc_hotreset_assert(struct tegra_mc *mc, unsigned int id)
>> +{
>> +	unsigned int hw_id = mc->soc->modules[id].hw_id;
>> +	u32 value;
>> +
>> +	if (mc->soc->tegra20) {
>> +		value = mc_readl(mc, mc->soc->reg_client_hotresetn);
>> +
>> +		mc_writel(mc, value & ~BIT(hw_id),
>> +			  mc->soc->reg_client_hotresetn);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int terga_mc_hotreset_deassert(struct tegra_mc *mc, unsigned int id)
>> +{
>> +	unsigned int hw_id = mc->soc->modules[id].hw_id;
>> +	u32 value;
>> +
>> +	if (mc->soc->tegra20) {
>> +		value = mc_readl(mc, mc->soc->reg_client_hotresetn);
>> +
>> +		mc_writel(mc, value | BIT(hw_id),
>> +			  mc->soc->reg_client_hotresetn);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> The same goes for these. I think we can do this much more easily by
> providing reset controller API ->assert() and ->deassert()
> implementations for Tegra20 and Tegra30+, and then register the reset
> controller device using the ops stored in the MC SoC structure.
> 
>> +static int tegra_mc_hot_reset_assert(struct tegra_mc *mc, unsigned int id,
>> +				     struct reset_control *rst)
>> +{
>> +	int err;
>> +
>> +	/*
>> +	 * Block clients DMA requests and wait for completion of the
>> +	 * outstanding requests.
>> +	 */
>> +	err = terga_mc_flush_dma(mc, id);
>> +	if (err) {
>> +		dev_err(mc->dev, "Failed to flush DMA: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	/* put in reset HW that corresponds to the memory client */
>> +	err = reset_control_assert(rst);
>> +	if (err) {
>> +		dev_err(mc->dev, "Failed to assert HW reset: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	/* clear the client requests sitting before arbitration */
>> +	err = terga_mc_hotreset_assert(mc, id);
>> +	if (err) {
>> +		dev_err(mc->dev, "Failed to hot reset client: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> This is very strictly according to the TRM, but I don't see a reason why
> you couldn't stash the DMA blocking and the hot reset into a ->assert()
> implementation...
> 
>> +
>> +static int tegra_mc_hot_reset_deassert(struct tegra_mc *mc, unsigned int id,
>> +				       struct reset_control *rst)
>> +{
>> +	int err;
>> +
>> +	/* take out client from hot reset */
>> +	err = terga_mc_hotreset_deassert(mc, id);
>> +	if (err) {
>> +		dev_err(mc->dev, "Failed to deassert hot reset: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	/* take out from reset corresponding clients HW */
>> +	err = reset_control_deassert(rst);
>> +	if (err) {
>> +		dev_err(mc->dev, "Failed to deassert HW reset: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	/* allow new DMA requests to proceed to arbitration */
>> +	err = terga_mc_unblock_dma(mc, id);
>> +	if (err) {
>> +		dev_err(mc->dev, "Failed to unblock client: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> ... and the hot reset deassertion and the DMA unblocking into a
> ->deassert() implementation.
> 
> I think the important part is that DMA is blocked and the requests are
> cleared before the module reset, and similarily that the hot reset is
> released and DMA is unblocked after the module reset.

Okay, let's try the way you're suggesting and see if anything breaks..

>> +
>> +static int tegra_mc_hot_reset(struct tegra_mc *mc, unsigned int id,
>> +			      struct reset_control *rst, unsigned long usecs)
>> +{
>> +	int err;
>> +
>> +	err = tegra_mc_hot_reset_assert(mc, id, rst);
>> +	if (err)
>> +		return err;
>> +
>> +	/* make sure that reset is propagated */
>> +	if (usecs < 15)
>> +		udelay(usecs);
>> +	else
>> +		usleep_range(usecs, usecs + 500);
>> +
>> +	err = tegra_mc_hot_reset_deassert(mc, id, rst);
>> +	if (err)
>> +		return err;
>> +
>> +	return 0;
>> +}
> 
> Do you really need this helper? It seems like a marginal gain in terms
> of boilerplate while obviously some (or maybe even most?) drivers can't
> use this because they need more explicit control over the sequence.
> 
> The only case where I could see this be useful is during some error
> recovery mechanism, in which case perhaps a runtime suspend/resume might
> be more useful.
> 
>> +
>>  static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
>>  {
>>  	unsigned long long tick;
>> @@ -416,6 +584,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>  		return -ENOMEM;
>>  
>>  	platform_set_drvdata(pdev, mc);
>> +	mutex_init(&mc->lock);
>>  	mc->soc = match->data;
>>  	mc->dev = &pdev->dev;
>>  
>> @@ -499,6 +668,86 @@ static struct platform_driver tegra_mc_driver = {
>>  	.probe = tegra_mc_probe,
>>  };
>>  
>> +static int tegra_mc_match(struct device *dev, void *data)
>> +{
>> +	return of_match_node(tegra_mc_of_match, dev->of_node) != NULL;
>> +}
>> +
>> +static struct tegra_mc *tegra_mc_find_device(void)
>> +{
>> +	struct device *dev;
>> +
>> +	dev = driver_find_device(&tegra_mc_driver.driver, NULL, NULL,
>> +				 tegra_mc_match);
>> +	if (!dev)
>> +		return NULL;
>> +
>> +	return dev_get_drvdata(dev);
>> +}
> 
> Another benefit of the reset controller API is that you don't have to
> look up the MC device like this. Instead you can just upcast the pointer
> to the reset controller device.
> 
>> +
>> +int tegra_memory_client_hot_reset(unsigned int id, struct reset_control *rst,
>> +				  unsigned long usecs)
>> +{
>> +	struct tegra_mc *mc;
>> +	int ret;
>> +
>> +	mc = tegra_mc_find_device();
>> +	if (!mc)
>> +		return -ENODEV;
>> +
>> +	if (id >= mc->soc->num_modules || !mc->soc->modules[id].valid)
>> +		return -EINVAL;
> 
> One of the problems with sparse arrays is that you need to explicitly
> mark each of the entries as valid. This is error prone and tedious in
> my opinion.
> 
>> +
>> +	mutex_lock(&mc->lock);
>> +	ret = tegra_mc_hot_reset(mc, id, rst, usecs);
>> +	mutex_unlock(&mc->lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tegra_memory_client_hot_reset);
>> +
>> +int tegra_memory_client_hot_reset_assert(unsigned int id,
>> +					 struct reset_control *rst)
>> +{
>> +	struct tegra_mc *mc;
>> +	int ret;
>> +
>> +	mc = tegra_mc_find_device();
>> +	if (!mc)
>> +		return -ENODEV;
>> +
>> +	if (id >= mc->soc->num_modules || !mc->soc->modules[id].valid)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&mc->lock);
>> +	ret = tegra_mc_hot_reset_assert(mc, id, rst);
>> +	mutex_unlock(&mc->lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tegra_memory_client_hot_reset_assert);
>> +
>> +int tegra_memory_client_hot_reset_deassert(unsigned int id,
>> +					   struct reset_control *rst)
>> +{
>> +	struct tegra_mc *mc;
>> +	int ret;
>> +
>> +	mc = tegra_mc_find_device();
>> +	if (!mc)
>> +		return -ENODEV;
>> +
>> +	if (id >= mc->soc->num_modules || !mc->soc->modules[id].valid)
>> +		return -EINVAL;
> 
> There's a lot of repetition in the code here. If you look at my
> prototype, I think this is simpler to deal with if you get a reference
> to the reset and then just use it. All of the special case handling is
> done in the lookup function, and then you get back NULL or a valid
> pointer that you can immediately use.
> 
>> +
>> +	mutex_lock(&mc->lock);
>> +	ret = tegra_mc_hot_reset_deassert(mc, id, rst);
>> +	mutex_unlock(&mc->lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tegra_memory_client_hot_reset_deassert);
>> +
>>  static int tegra_mc_init(void)
>>  {
>>  	return platform_driver_register(&tegra_mc_driver);
> [...]
>> diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
>> index 8b6360eabb8a..135012c74358 100644
>> --- a/drivers/memory/tegra/tegra124.c
>> +++ b/drivers/memory/tegra/tegra124.c
>> @@ -1012,6 +1012,30 @@ static const struct tegra_smmu_group_soc tegra124_groups[] = {
>>  	},
>>  };
>>  
>> +static const struct tegra_mc_module tegra124_mc_modules[] = {
>> +	[TEGRA_MEMORY_CLIENT_AFI]	= { .hw_id =  0, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_AVP]	= { .hw_id =  1, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_DC]	= { .hw_id =  2, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_DCB]	= { .hw_id =  3, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_HOST1X]	= { .hw_id =  6, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_HDA]	= { .hw_id =  7, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_ISP2]	= { .hw_id =  8, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_MPCORE]	= { .hw_id =  9, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_MPCORELP]	= { .hw_id = 10, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_MSENC]	= { .hw_id = 11, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_PPCS]	= { .hw_id = 14, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_SATA]	= { .hw_id = 15, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_VDE]	= { .hw_id = 16, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_VI]	= { .hw_id = 17, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_VIC]	= { .hw_id = 18, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_XUSB_HOST]	= { .hw_id = 19, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_XUSB_DEV]	= { .hw_id = 20, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_TSEC]	= { .hw_id = 22, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_SDMMC1]	= { .hw_id = 29, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_SDMMC2]	= { .hw_id = 30, .valid = true },
>> +	[TEGRA_MEMORY_CLIENT_SDMMC3]	= { .hw_id = 31, .valid = true },
>> +};
> 
> This list is incomplete. The same is true for any later generation.
> There are also quite a few holes in them. I think a better use of this
> space is to make the array compact and instead have more explicit
> information in the array.
> 
>> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
>> index 6cfc1dfa3a40..2d36db3ac659 100644
>> --- a/include/soc/tegra/mc.h
>> +++ b/include/soc/tegra/mc.h
>> @@ -9,11 +9,13 @@
>>  #ifndef __SOC_TEGRA_MC_H__
>>  #define __SOC_TEGRA_MC_H__
>>  
>> +#include <linux/mutex.h>
>>  #include <linux/types.h>
>>  
>>  struct clk;
>>  struct device;
>>  struct page;
>> +struct reset_control;
>>  
>>  struct tegra_smmu_enable {
>>  	unsigned int reg;
>> @@ -95,6 +97,11 @@ static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
>>  }
>>  #endif
>>  
>> +struct tegra_mc_module {
>> +	unsigned int hw_id;
>> +	bool valid;
>> +};
>> +
>>  struct tegra_mc_soc {
>>  	const struct tegra_mc_client *clients;
>>  	unsigned int num_clients;
>> @@ -110,6 +117,13 @@ struct tegra_mc_soc {
>>  	const struct tegra_smmu_soc *smmu;
>>  
>>  	bool tegra20;
>> +
>> +	const struct tegra_mc_module *modules;
>> +	unsigned int num_modules;
>> +
>> +	u32 reg_client_ctrl;
>> +	u32 reg_client_hotresetn;
>> +	u32 reg_client_flush_status;
> 
> That's not enough to cover all clients on Tegra124 and later. We need at
> least two registers. I'd also prefer to move away from the assumption
> that the ID is somehow linked to the bit position. The ID is in fact
> completely arbitrary and in this case only chosen to match the bit
> position.
> 
> This has multiple disadvantages, some of which I've already listed. One
> of them is that we inevitably make arrays sparse as the SoC evolves, so
> we need to work around this in code and data tables using a valid flag.
> Checking for validity also becomes non-trivial and we move part of that
> burden into drivers.
> 
> I think a much better and robust solution is to completely separate the
> ID from the hardware registers. This is implemented in my prototype on
> github. The ID is essentially only used as a way to identify the reset
> via device tree. The MC driver will use the ID to look up the reset in
> its per-SoC table and will only work with the reset object after that.
> The object itself contains all the information needed to program the
> registers.
> 
> Currently the tables in that implementation don't take into account the
> per-client "outstanding requests" registers, but they could be easily
> extended to do so.
> 
>>  };
>>  
>>  struct tegra_mc {
>> @@ -124,9 +138,72 @@ struct tegra_mc {
>>  
>>  	struct tegra_mc_timing *timings;
>>  	unsigned int num_timings;
>> +
>> +	struct mutex lock;
>>  };
>>  
>>  void tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
>>  unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
>>  
>> +#define TEGRA_MEMORY_CLIENT_AVP		0
>> +#define TEGRA_MEMORY_CLIENT_DC		1
>> +#define TEGRA_MEMORY_CLIENT_DCB		2
>> +#define TEGRA_MEMORY_CLIENT_EPP		3
>> +#define TEGRA_MEMORY_CLIENT_2D		4
>> +#define TEGRA_MEMORY_CLIENT_HOST1X	5
>> +#define TEGRA_MEMORY_CLIENT_ISP		6
>> +#define TEGRA_MEMORY_CLIENT_MPCORE	7
>> +#define TEGRA_MEMORY_CLIENT_MPCORELP	8
>> +#define TEGRA_MEMORY_CLIENT_MPEA	9
>> +#define TEGRA_MEMORY_CLIENT_MPEB	10
>> +#define TEGRA_MEMORY_CLIENT_MPEC	11
>> +#define TEGRA_MEMORY_CLIENT_3D		12
>> +#define TEGRA_MEMORY_CLIENT_3D1		13
>> +#define TEGRA_MEMORY_CLIENT_PPCS	14
>> +#define TEGRA_MEMORY_CLIENT_VDE		15
>> +#define TEGRA_MEMORY_CLIENT_VI		16
>> +#define TEGRA_MEMORY_CLIENT_AFI		17
>> +#define TEGRA_MEMORY_CLIENT_HDA		18
>> +#define TEGRA_MEMORY_CLIENT_SATA	19
>> +#define TEGRA_MEMORY_CLIENT_MSENC	20
>> +#define TEGRA_MEMORY_CLIENT_VIC		21
>> +#define TEGRA_MEMORY_CLIENT_XUSB_HOST	22
>> +#define TEGRA_MEMORY_CLIENT_XUSB_DEV	23
>> +#define TEGRA_MEMORY_CLIENT_TSEC	24
>> +#define TEGRA_MEMORY_CLIENT_SDMMC1	25
>> +#define TEGRA_MEMORY_CLIENT_SDMMC2	26
>> +#define TEGRA_MEMORY_CLIENT_SDMMC3	27
>> +#define TEGRA_MEMORY_CLIENT_MAX		TEGRA_MEMORY_CLIENT_SDMMC3
>> +
>> +#define TEGRA_MEMORY_CLIENT_3D0		TEGRA_MEMORY_CLIENT_3D
>> +#define TEGRA_MEMORY_CLIENT_MPE		TEGRA_MEMORY_CLIENT_MPEA
>> +#define TEGRA_MEMORY_CLIENT_NVENC	TEGRA_MEMORY_CLIENT_MSENC
>> +#define TEGRA_MEMORY_CLIENT_ISP2	TEGRA_MEMORY_CLIENT_ISP
>> +
>> +#ifdef CONFIG_ARCH_TEGRA
>> +int tegra_memory_client_hot_reset(unsigned int id, struct reset_control *rst,
>> +				  unsigned long usecs);
>> +int tegra_memory_client_hot_reset_assert(unsigned int id,
>> +					 struct reset_control *rst);
>> +int tegra_memory_client_hot_reset_deassert(unsigned int id,
>> +					   struct reset_control *rst);
>> +#else
> 
> I *really* don't want yet another custom API. We've had a number of
> these in the past and it's always been extremely painful to get rid of
> them. And we probably won't ever be able to completely get rid of the
> powergate API, which means additional headaches everytime we need to
> touch code in that area. I don't want to repeat that mistake.
