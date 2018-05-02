Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeEBLwS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:52:18 -0400
Received: from hermes.aosc.io ([199.195.250.187]:47659 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbeEBLwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:52:15 -0400
Date: Wed, 02 May 2018 19:51:37 +0800
In-Reply-To: <20180502114843.ou4qczp5eaigrdfo@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com> <20180430114058.5061-16-jagan@amarulasolutions.com> <20180502114843.ou4qczp5eaigrdfo@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 15/21] drm: sun4i: add support for HVCC regulator for DWC HDMI glue
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>
CC: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <2E519B6E-D1BA-4C6F-9105-446E564FBBB6@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年5月2日 GMT+08:00 下午7:48:43, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Mon, Apr 30, 2018 at 05:10:52PM +0530, Jagan Teki wrote:
>> From: Icenowy Zheng <icenowy@aosc.io>
>> 
>> Allwinner SoCs with DWC HDMI controller have a "HVCC" power pin for
>the
>> HDMI part, and on some boards it's connected to a dedicated regulator
>> rather than the main 3.3v.
>> 
>> Add support for optional HVCC regulator. For boards that doesn't use
>a
>> dedicated regulator to power it, the default dummy regulator is used.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 14 ++++++++++++++
>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |  2 ++
>>  2 files changed, 16 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>> index 9f40a44b456b..7c33faff7ad4 100644
>> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
>> @@ -73,6 +73,12 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
>struct device *master,
>>  	if (encoder->possible_crtcs == 0)
>>  		return -EPROBE_DEFER;
>>  
>> +	hdmi->vcc_hdmi = devm_regulator_get(dev, "hvcc");
>> +	if (IS_ERR(hdmi->vcc_hdmi)) {
>> +		dev_err(dev, "Could not get HDMI power supply\n");
>> +		return PTR_ERR(hdmi->vcc_hdmi);
>> +	}
>> +
>
>You're not making it optional here, unlike what your commit log
>says. Not that I'm fine with both, but we need to be consistent :)

If it's not set, regulator subsystem will generate a dummy
regulator as a spaceholder, except using the exclusive variant
of the function.

The word "optional" is from DT perspectove, as it's possible that
it's bound to some critical regulators.

>
>>  	hdmi->rst_ctrl = devm_reset_control_get(dev, "ctrl");
>>  	if (IS_ERR(hdmi->rst_ctrl)) {
>>  		dev_err(dev, "Could not get ctrl reset control\n");
>> @@ -91,6 +97,12 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
>struct device *master,
>>  		return ret;
>>  	}
>>  
>> +	ret = regulator_enable(hdmi->vcc_hdmi);
>> +	if (ret) {
>> +		dev_err(dev, "Cannot enable HDMI power supply\n");
>> +		goto err_disable_vcc;
>> +	}
>> +
>>  	ret = clk_prepare_enable(hdmi->clk_tmds);
>>  	if (ret) {
>>  		dev_err(dev, "Could not enable tmds clock\n");
>> @@ -143,6 +155,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
>struct device *master,
>>  	clk_disable_unprepare(hdmi->clk_tmds);
>>  err_assert_ctrl_reset:
>>  	reset_control_assert(hdmi->rst_ctrl);
>> +err_disable_vcc:
>> +	regulator_disable(hdmi->vcc_hdmi);
>
>
>The err_disable_vcc label will disable the regulator, but if there's
>an error in regulator_enable, it will disable it while it wasn't
>enabled in the first place, which is not really something we want to
>do.
>
>Maxime
