Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347C7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E412120B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E412120B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbeGKJt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:49:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2370 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeGKJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:49:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b45d1ed0000>; Wed, 11 Jul 2018 02:46:21 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 02:46:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Jul 2018 02:46:26 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 09:46:23 +0000
Subject: Re: [PATCH 6/6] soc/tegra: pmc: Implement pad configuration via
 pinctrl
To:     Aapo Vienamo <avienamo@nvidia.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1531226879-11802-1-git-send-email-avienamo@nvidia.com>
 <1531227295-12752-1-git-send-email-avienamo@nvidia.com>
 <d9a55862-39eb-5c67-1c24-83b8e2850c2a@nvidia.com>
 <20180711123818.0a62f93a@dhcp-10-21-25-168>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8a666c2b-09d3-9d25-a846-bdaccbfbefa9@nvidia.com>
Date:   Wed, 11 Jul 2018 10:46:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711123818.0a62f93a@dhcp-10-21-25-168>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/07/18 10:38, Aapo Vienamo wrote:
> On Wed, 11 Jul 2018 09:40:01 +0100
> Jon Hunter <jonathanh@nvidia.com> wrote:
> 
>> On 10/07/18 13:54, Aapo Vienamo wrote:
>>> Register a pinctrl device and implement get and set functions for
>>> PIN_CONFIG_LOW_POWER_MODE and PIN_CONFIG_POWER_SOURCE parameters.
>>>
>>> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
>>> ---
>>>  drivers/soc/tegra/pmc.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 190 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>> index b833334..8677391 100644
>>> --- a/drivers/soc/tegra/pmc.c
>>> +++ b/drivers/soc/tegra/pmc.c
>>> @@ -33,6 +33,9 @@
>>>  #include <linux/of_address.h>
>>>  #include <linux/of_clk.h>
>>>  #include <linux/of_platform.h>
>>> +#include <linux/pinctrl/pinctrl.h>
>>> +#include <linux/pinctrl/pinconf.h>
>>> +#include <linux/pinctrl/pinconf-generic.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/pm_domain.h>
>>>  #include <linux/reboot.h>
>>> @@ -45,6 +48,8 @@
>>>  #include <soc/tegra/fuse.h>
>>>  #include <soc/tegra/pmc.h>
>>>  
>>> +#include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>>> +
>>>  #define PMC_CNTRL			0x0
>>>  #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
>>>  #define  PMC_CNTRL_CPU_PWRREQ_OE	BIT(16) /* CPU pwr req enable */
>>> @@ -162,6 +167,9 @@ struct tegra_pmc_soc {
>>>  	const struct tegra_io_pad_soc *io_pads;
>>>  	unsigned int num_io_pads;
>>>  
>>> +	const struct pinctrl_pin_desc *pin_descs;
>>> +	unsigned int num_pin_descs;
>>> +
>>>  	const struct tegra_pmc_regs *regs;
>>>  	void (*init)(struct tegra_pmc *pmc);
>>>  	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
>>> @@ -220,6 +228,8 @@ struct tegra_pmc {
>>>  	DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
>>>  
>>>  	struct mutex powergates_lock;
>>> +
>>> +	struct pinctrl_dev *pctl_dev;
>>>  };
>>>  
>>>  static struct tegra_pmc *pmc = &(struct tegra_pmc) {
>>> @@ -1400,6 +1410,145 @@ static void tegra_pmc_init_tsense_reset(struct tegra_pmc *pmc)
>>>  	of_node_put(np);
>>>  }
>>>  
>>> +static int tegra_io_pad_pinctrl_get_groups_count(struct pinctrl_dev *pctl_dev)
>>> +{
>>> +	return pmc->soc->num_io_pads;
>>> +}
>>> +
>>> +static const char *tegra_io_pad_pinctrl_get_group_name(
>>> +		struct pinctrl_dev *pctl, unsigned int group)
>>> +{
>>> +	return pmc->soc->io_pads[group].name;
>>> +}
>>> +
>>> +static int tegra_io_pad_pinctrl_get_group_pins(struct pinctrl_dev *pctl_dev,
>>> +					       unsigned int group,
>>> +					       const unsigned int **pins,
>>> +					       unsigned int *num_pins)
>>> +{
>>> +	*pins = &pmc->soc->io_pads[group].id;
>>> +	*num_pins = 1;
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct pinctrl_ops tegra_io_pad_pinctrl_ops = {
>>> +	.get_groups_count = tegra_io_pad_pinctrl_get_groups_count,
>>> +	.get_group_name = tegra_io_pad_pinctrl_get_group_name,
>>> +	.get_group_pins = tegra_io_pad_pinctrl_get_group_pins,
>>> +	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
>>> +	.dt_free_map = pinconf_generic_dt_free_map,
>>> +};
>>> +
>>> +static int tegra_io_pad_pinconf_get(struct pinctrl_dev *pctl_dev,
>>> +				    unsigned int pin, unsigned long *config)
>>> +{
>>> +	const struct tegra_io_pad_soc *pad = tegra_io_pad_find(pmc, pin);
>>> +	enum pin_config_param param = pinconf_to_config_param(*config);
>>> +	int ret;
>>> +	u32 arg;
>>> +
>>> +	switch (param) {
>>> +	case PIN_CONFIG_POWER_SOURCE:
>>> +		ret = tegra_io_pad_get_voltage(pad->id);
>>> +		if (ret == TEGRA_IO_PAD_1800000UV)
>>> +			arg = TEGRA_IO_PAD_VOLTAGE_1V8;
>>> +		else if (ret == TEGRA_IO_PAD_3300000UV)
>>> +			arg = TEGRA_IO_PAD_VOLTAGE_3V3;  
>>
>> It looks like we have two definitions for the same thing here.
>> Can we get rid of one of these? 
> 
> They are indeed pretty much the same thing, however
> TEGRA_IO_PAD_1800000UV is part of the pmc.h api and
> TEGRA_IO_PAD_VOLTAGE_1V8 comes from the device tree binding abi headers.
> The key difference between them is that TEGRA_IO_PAD_VOLTAGE_1V8 is a
> macro and TEGRA_IO_PAD_1800000UV is an enum and it's used like this in
> the pmc api:
> 
> int tegra_io_pad_set_voltage(enum tegra_io_pad id,
>                              enum tegra_io_pad_voltage voltage);
> 
> where it's obvious that the function takes this enum as an argument. If
> the enum definitions were replaced with macros usable from the dts
> files, the enum from the function prototype would have to be changed to
> an int. This makes the api more ambiguous because other parts of the
> kernel have the convention where "int voltage" means voltage in
> microvolts.

Raises the question, do we need these legacy APIs? I don't see them being
used.

Cheers
Jon

-- 
nvpublic
