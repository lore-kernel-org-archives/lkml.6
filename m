Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeBSMoH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:44:07 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37815 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbeBSMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:44:04 -0500
X-Google-Smtp-Source: AH8x225i8ot0qlmg5xNILf1biTPR0xPqYk1k1Mlpf7JVpFNZCSeflIIU0RNliPea5XFLrYDgOp8I0g==
Subject: Re: [PATCH v2 2/2] memory: tegra: Introduce memory client hot reset
 API
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518452709.git.digetx@gmail.com>
 <6eff4be25012d88595a9ef73d3d626e4707b032c.1518452709.git.digetx@gmail.com>
 <20180213112418.GB6764@ulmo> <e061ce8f-fe3a-8697-3ec2-eed40e00ee8d@gmail.com>
Message-ID: <a489c730-999a-e1fd-c547-77cad46bbefb@gmail.com>
Date: Mon, 19 Feb 2018 15:44:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e061ce8f-fe3a-8697-3ec2-eed40e00ee8d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2018 15:35, Dmitry Osipenko wrote:
> On 13.02.2018 14:24, Thierry Reding wrote:
>> On Mon, Feb 12, 2018 at 08:06:31PM +0300, Dmitry Osipenko wrote:
>>> In order to reset busy HW properly, memory controller needs to be
>>> involved, otherwise it possible to get corrupted memory if HW was reset
>>> during DMA. Introduce memory client 'hot reset' API that will be used
>>> for resetting busy HW. The primary users are memory clients related to
>>> video (decoder/encoder/camera) and graphics (2d/3d).
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/memory/tegra/mc.c       | 249 ++++++++++++++++++++++++++++++++++++++++
>>>  drivers/memory/tegra/tegra114.c |  25 ++++
>>>  drivers/memory/tegra/tegra124.c |  32 ++++++
>>>  drivers/memory/tegra/tegra20.c  |  23 ++++
>>>  drivers/memory/tegra/tegra210.c |  27 +++++
>>>  drivers/memory/tegra/tegra30.c  |  25 ++++
>>>  include/soc/tegra/mc.h          |  77 +++++++++++++
>>>  7 files changed, 458 insertions(+)
>>
>> As discussed on IRC, I typed up a variant of this in an attempt to fix
>> an unrelated bug report. The code is here:
>>
>> 	https://github.com/thierryreding/linux/commit/e104e703cb75dfe742b2e051194a0af8ddefcd03
>>
>> I think we can make this without adding a custom API. The reset control
>> API should work just fine. The above version doesn't take into account
>> some of Tegra20's quirks, but I think it should still work for Tegra20
>> with just slightly different implementations for ->assert() and
>> ->deassert().
>>
>> A couple of more specific comments below.
>>
>>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>>> index 187a9005351b..9838f588d64d 100644
>>> --- a/drivers/memory/tegra/mc.c
>>> +++ b/drivers/memory/tegra/mc.c
>>> @@ -7,11 +7,13 @@
>>>   */
>>>  
>>>  #include <linux/clk.h>
>>> +#include <linux/delay.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/module.h>
>>>  #include <linux/of.h>
>>>  #include <linux/platform_device.h>
>>> +#include <linux/reset.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/sort.h>
>>>  
>>> @@ -81,6 +83,172 @@ static const struct of_device_id tegra_mc_of_match[] = {
>>>  };
>>>  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
>>>  
>>> +static int terga_mc_flush_dma(struct tegra_mc *mc, unsigned int id)
>>> +{
>>> +	unsigned int hw_id = mc->soc->modules[id].hw_id;
>>> +	u32 value, reg_poll = mc->soc->reg_client_flush_status;
>>> +	int retries = 3;
>>> +
>>> +	value = mc_readl(mc, mc->soc->reg_client_ctrl);
>>> +
>>> +	if (mc->soc->tegra20)
>>> +		value &= ~BIT(hw_id);
>>> +	else
>>> +		value |= BIT(hw_id);
>>> +
>>> +	/* block clients DMA requests */
>>> +	mc_writel(mc, value, mc->soc->reg_client_ctrl);
>>> +
>>> +	/* wait for completion of the outstanding DMA requests */
>>> +	if (mc->soc->tegra20) {
>>> +		while (mc_readl(mc, reg_poll + hw_id * sizeof(u32)) != 0) {
>>> +			if (!retries--)
>>> +				return -EBUSY;
>>> +
>>> +			usleep_range(1000, 2000);
>>> +		}
>>> +	} else {
>>> +		while ((mc_readl(mc, reg_poll) & BIT(hw_id)) == 0) {
>>> +			if (!retries--)
>>> +				return -EBUSY;
>>> +
>>> +			usleep_range(1000, 2000);
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> I think this suffers from too much unification. The programming model is
>> too different to stash this into a single function implementation and as
>> a result this becomes very difficult to read. In my experience it's more
>> readable to split this into separate implementations and pass around
>> pointers to them.
>>
>>> +
>>> +static int terga_mc_unblock_dma(struct tegra_mc *mc, unsigned int id)
>>> +{
>>> +	unsigned int hw_id = mc->soc->modules[id].hw_id;
>>> +	u32 value;
>>> +
>>> +	value = mc_readl(mc, mc->soc->reg_client_ctrl);
>>> +
>>> +	if (mc->soc->tegra20)
>>> +		value |= BIT(hw_id);
>>> +	else
>>> +		value &= ~BIT(hw_id);
>>> +
>>> +	mc_writel(mc, value, mc->soc->reg_client_ctrl);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int terga_mc_hotreset_assert(struct tegra_mc *mc, unsigned int id)
>>> +{
>>> +	unsigned int hw_id = mc->soc->modules[id].hw_id;
>>> +	u32 value;
>>> +
>>> +	if (mc->soc->tegra20) {
>>> +		value = mc_readl(mc, mc->soc->reg_client_hotresetn);
>>> +
>>> +		mc_writel(mc, value & ~BIT(hw_id),
>>> +			  mc->soc->reg_client_hotresetn);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int terga_mc_hotreset_deassert(struct tegra_mc *mc, unsigned int id)
>>> +{
>>> +	unsigned int hw_id = mc->soc->modules[id].hw_id;
>>> +	u32 value;
>>> +
>>> +	if (mc->soc->tegra20) {
>>> +		value = mc_readl(mc, mc->soc->reg_client_hotresetn);
>>> +
>>> +		mc_writel(mc, value | BIT(hw_id),
>>> +			  mc->soc->reg_client_hotresetn);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> The same goes for these. I think we can do this much more easily by
>> providing reset controller API ->assert() and ->deassert()
>> implementations for Tegra20 and Tegra30+, and then register the reset
>> controller device using the ops stored in the MC SoC structure.
>>
>>> +static int tegra_mc_hot_reset_assert(struct tegra_mc *mc, unsigned int id,
>>> +				     struct reset_control *rst)
>>> +{
>>> +	int err;
>>> +
>>> +	/*
>>> +	 * Block clients DMA requests and wait for completion of the
>>> +	 * outstanding requests.
>>> +	 */
>>> +	err = terga_mc_flush_dma(mc, id);
>>> +	if (err) {
>>> +		dev_err(mc->dev, "Failed to flush DMA: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	/* put in reset HW that corresponds to the memory client */
>>> +	err = reset_control_assert(rst);
>>> +	if (err) {
>>> +		dev_err(mc->dev, "Failed to assert HW reset: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	/* clear the client requests sitting before arbitration */
>>> +	err = terga_mc_hotreset_assert(mc, id);
>>> +	if (err) {
>>> +		dev_err(mc->dev, "Failed to hot reset client: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> This is very strictly according to the TRM, but I don't see a reason why
>> you couldn't stash the DMA blocking and the hot reset into a ->assert()
>> implementation...
>>
>>> +
>>> +static int tegra_mc_hot_reset_deassert(struct tegra_mc *mc, unsigned int id,
>>> +				       struct reset_control *rst)
>>> +{
>>> +	int err;
>>> +
>>> +	/* take out client from hot reset */
>>> +	err = terga_mc_hotreset_deassert(mc, id);
>>> +	if (err) {
>>> +		dev_err(mc->dev, "Failed to deassert hot reset: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	/* take out from reset corresponding clients HW */
>>> +	err = reset_control_deassert(rst);
>>> +	if (err) {
>>> +		dev_err(mc->dev, "Failed to deassert HW reset: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	/* allow new DMA requests to proceed to arbitration */
>>> +	err = terga_mc_unblock_dma(mc, id);
>>> +	if (err) {
>>> +		dev_err(mc->dev, "Failed to unblock client: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> ... and the hot reset deassertion and the DMA unblocking into a
>> ->deassert() implementation.
>>
>> I think the important part is that DMA is blocked and the requests are
>> cleared before the module reset, and similarily that the hot reset is
>> released and DMA is unblocked after the module reset.
> 
> Okay, let's try the way you're suggesting and see if anything breaks..

Although, it would be awesome if you could ask somebody who is familiar with the
actual HW implementation. I can imagine that HW is simplified and expecting SW
to take that into account, there could be hazards.
