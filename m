Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeDQTPX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:15:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDQTPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:15:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D04460264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [v2,2/2] regulator: add QCOM RPMh regulator driver
To: Matthias Kaehlcke <mka@chromium.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org, sboyd@kernel.org,
        dianders@chromium.org
References: <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <20180417182347.GD244487@google.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <2e45c0e5-7e79-3479-de18-9613e8eacf15@codeaurora.org>
Date: Tue, 17 Apr 2018 12:15:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180417182347.GD244487@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 11:23 AM, Matthias Kaehlcke wrote:
> On Fri, Apr 13, 2018 at 07:50:35PM -0700, David Collins wrote:
>> Add the QCOM RPMh regulator driver to manage PMIC regulators
>> which are controlled via RPMh on some Qualcomm Technologies, Inc.
>> SoCs.  RPMh is a hardware block which contains several
>> accelerators which are used to manage various hardware resources
>> that are shared between the processors of the SoC.  The final
>> hardware state of a regulator is determined within RPMh by
>> performing max aggregation of the requests made by all of the
>> processors.
>> [...]
>> +/**
>> + * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
>> + * @regulator_type:		RPMh accelerator type used to manage this
>> + *				regulator
>> + * @ops:			Pointer to regulator ops callback structure
>> + * @voltage_range:		The single range of voltages supported by this
>> + *				PMIC regulator type
>> + * @n_voltages:			The number of unique voltage set points defined
>> + *				by voltage_range
>> + * @pmic_mode_map:		Array indexed by regulator framework mode
>> + *				containing PMIC hardware modes.  Must be large
>> + *				enough to index all framework modes supported
>> + *				by this regulator hardware type.
>> + * @of_map_mode:		Maps an RPMH_REGULATOR_MODE_* mode value defined
>> + *				in device tree to a regulator framework mode
> 
> The name of the field is a bit misleading, this is a map of RPMh mode
> to regulator framework mode, the device tree just happens to be the
> place where this mapping is defined.

of_map_mode name is used here to match the struct regulator_desc field by
the same name that it is assigned to [1].  Do you think that the name
should be changed to something else?


>> +/**
>> + * struct rpmh_vreg - individual rpmh regulator data structure encapsulating a
>> + *		single regulator device
>> + * @rpmh_client:		Handle used for rpmh communications
> 
> nit: RPMh

I'll change this.


>> +struct rpmh_vreg {
>> +	struct rpmh_client		*rpmh_client;
>> +	u32				addr;
>> +	struct regulator_desc		rdesc;
>> +	const struct rpmh_vreg_hw_data	*hw_data;
>> +	enum rpmh_regulator_type	regulator_type;
> 
> This value is already available via rpmh_vreg->hw_data->regulator_type,
> why duplicate it? The field is assigned in rpmh_regulator_init_vreg()
> and only read once in the same function, there seems to be no need for
> it, not even to improve readability.

This is present to specifically allow for a future change to support
overriding the regulator_type value from device tree in order to force
RPMh resources to be handled via XOB instead of VRM in a board-specific
manner.  I included support of the property qcom,rpmh-resource-type in the
first version of this patch.  I removed this property from the second
version of the patch based upon review feedback since SDM845 does not
explicitly need it (though an upcoming chip will).

I'll remove regulator_type from struct rpmh_vreg.  It shouldn't be
particularly painful to add it back in when needed for XOB override support.


>> +static int rpmh_regulator_vrm_set_load(struct regulator_dev *rdev, int load_uA)
>> +{
>> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +	int i;
>> +
>> +	for (i = 0; i < vreg->drms_mode_count - 1; i++)
>> +		if (load_uA < vreg->drms_mode_max_uA[i])
> 
> Shouldn't this be '<='?
> 
> nit: IMO 'vreg->drms_mode_max_uA[i] >= load_uA' would be more readable.

I chose to use '<' here in order to maintain the non-inclusive limit
semantics of the downstream RPMh regulator driver.  E.g. with an LPM
threshold of 10000 uA, load_uA == 10000 would result in a request for HPM
instead of LPM.

I suppose that I can change this to '<=' to be more logically consistent.


>> +static const u32 pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
>> +	[REGULATOR_MODE_STANDBY] = 4,
>> +	[REGULATOR_MODE_IDLE]    = 5,
>> +	[REGULATOR_MODE_NORMAL]  = -EINVAL,
>> +	[REGULATOR_MODE_FAST]    = 7,
>> +};
> 
> Define constants for the modes on the PMIC4 side?

Are you suggesting something like this?

#define PMIC4_LDO_MODE_RETENTION	4
#define PMIC4_LDO_MODE_LPM		5
#define PMIC4_LDO_MODE_HPM		7

static const u32 pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
	[REGULATOR_MODE_STANDBY] = PMIC4_LDO_MODE_RETENTION,
	[REGULATOR_MODE_IDLE]    = PMIC4_LDO_MODE_LPM,
	[REGULATOR_MODE_NORMAL]  = -EINVAL,
	[REGULATOR_MODE_FAST]    = PMIC4_LDO_MODE_HPM,
};

#define PMIC4_SMPS_MODE_RETENTION	4
#define PMIC4_SMPS_MODE_PFM		5
#define PMIC4_SMPS_MODE_AUTO		6
#define PMIC4_SMPS_MODE_PWM		7

static const u32 pmic_mode_map_pmic4_smps[REGULATOR_MODE_STANDBY + 1] = {
	[REGULATOR_MODE_STANDBY] = PMIC4_SMPS_MODE_RETENTION,
	[REGULATOR_MODE_IDLE]    = PMIC4_SMPS_MODE_PFM,
	[REGULATOR_MODE_NORMAL]  = PMIC4_SMPS_MODE_AUTO,
	[REGULATOR_MODE_FAST]    = PMIC4_SMPS_MODE_PWM,
};

I considered using this approach, but it didn't seem like it increased
readability and did increase the line count.  Each of the constants would
only be used once.  Would you prefer this style (or something else)?

Thanks,
David

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/regulator/driver.h?h=v4.17-rc1#n370

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
