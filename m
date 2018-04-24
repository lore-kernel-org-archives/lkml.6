Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeDXXmH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 19:42:07 -0400
Received: from hermes.aosc.io ([199.195.250.187]:45738 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbeDXXmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 19:42:05 -0400
Date: Wed, 25 Apr 2018 07:41:35 +0800
In-Reply-To: <20180424170733.GD22073@sirena.org.uk>
References: <20180423144657.63264-1-icenowy@aosc.io> <20180423144657.63264-3-icenowy@aosc.io> <20180424170733.GD22073@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 2/3] regulator: add support for SY8106A regulator
To: linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>
CC: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi@googlegroups.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <C0C1F042-221A-420F-A8C1-5FADCFC687F1@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年4月25日 GMT+08:00 上午1:07:33, Mark Brown <broonie@kernel.org> 写到:
>On Mon, Apr 23, 2018 at 10:46:56PM +0800, Icenowy Zheng wrote:
>
>> --- /dev/null
>> +++ b/drivers/regulator/sy8106a-regulator.c
>> @@ -0,0 +1,176 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * sy8106a-regulator.c - Regulator device driver for SY8106A
>
>Just make the entire thing a C++ comment so it looks consistent and
>joined up.

SPDX identifier is special -- it should be in a seperated
comment block.

>
>> +static int sy8106a_set_voltage_sel(struct regulator_dev *rdev,
>unsigned int sel)
>> +{
>> +	/* We use our set_voltage_sel in order to avoid unnecessary I2C
>> +	 * chatter, because the regulator_get_voltage_sel_regmap using
>> +	 * apply_bit would perform 4 unnecessary transfers instead of one,
>> +	 * increasing the chance of error.
>> +	 */
>> +	return regmap_write(rdev->regmap, rdev->desc->vsel_reg,
>> +			    sel | SY8106A_GO_BIT);
>
>Why would it do these extra transfers?  Is this just the fact that you
>didn't set up a register cache (though the r/m/w cycle should only add
>the read)?  We could put some logic in the core regmap code to detect
>that an _update_bits() call is going to write to the whole register,
>though it'd be even easier to just let this register be cached.
>
>Generally if we can usefully optimize things we should do it at the
>framework level.

Oh maybe the comment needs to be changed, but it's
needed to enable it to change voltage, as it might be
not enabled at boot.

>
>> +	if (reg & SY8106A_GO_BIT)
>> +		return reg & rdev->desc->vsel_mask;
>> +	else
>> +		return (chip->fixed_voltage - rdev->desc->min_uV) /
>> +		       rdev->desc->uV_step;
>
>You could use the standard get_voltage_sel() if you provide a mapping
>operation that set everything with _GO_BIT set to return the fixed
>voltage.  Though looking at this it seems that the fixed voltage will
>always be one that could be set via the register anyway so I'm
>wondering
>if the easiest thing here isn't to just have the driver turn off
>_GO_BIT

Do you mean "turn on" here?

>during probe() and not worry about the special case at runtime.
