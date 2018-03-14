Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeCNSRU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:17:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36186 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeCNSRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:17:15 -0400
X-Google-Smtp-Source: AG47ELs4NxLtskR8XiZxK6DnXgTdlXUBrVoSgBNmQJj6liY4cTKIJFzDFG6uY64+o2VCio3vpNe7jQ==
Subject: Re: [PATCH v3 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder driver
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, horms@verge.net.au, magnus.damm@gmail.com,
        geert@linux-m68k.org, niklas.soderlund@ragnatech.se,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1520951425-13843-1-git-send-email-jacopo+renesas@jmondi.org>
 <1520951425-13843-3-git-send-email-jacopo+renesas@jmondi.org>
 <a893a17c-367d-4f61-f835-4b6b420dc597@cogentembedded.com>
 <20180314180438.GD16424@w540>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <ee1d849a-2996-8813-384b-cc2c22dd78a8@cogentembedded.com>
Date: Wed, 14 Mar 2018 21:17:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180314180438.GD16424@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/2018 09:04 PM, jacopo mondi wrote:

>>> Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
>>> output decoder.
>>>
>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> [...]
>>> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
>>> new file mode 100644
>>> index 0000000..4b059c0
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
>>> @@ -0,0 +1,241 @@
[...]
>>> +static void thc63_enable(struct drm_bridge *bridge)
>>> +{
>>> +	struct thc63_dev *thc63 = to_thc63(bridge);
>>> +	struct regulator *vcc;
>>> +	unsigned int i;
>>> +	int ret;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
>>> +		vcc = thc63->vccs[i];
>>> +		if (vcc) {
>>> +			ret = regulator_enable(vcc);
>>> +			if (ret)
>>
>>    You hardly need this variable, could do a call right in this *if*.
>>
>> [...]
>>> +error_vcc_enable:
>>> +	dev_err(thc63->dev, "Failed to enable regulator %u\n", i);
>>> +}
>>> +
>>
>>    Why not do this instead of *goto* before?
> 
> Well, goto breaks the loop, if I only print out the error message, the
> enable sequence will go on and enable the other regulators.

> I can print out and break, but I don't see that much benefit

   Sorry, I meant that you should *return* there instead of *goto*.

> One thing I could do instead, is not only print out the error message,
> but disable the already enabled regulators if one fails to start.

   Yeah, probably...

[...]
>>> +static int thc63_gpio_init(struct thc63_dev *thc63)
>>> +{
>>> +	thc63->pwdn = devm_gpiod_get_optional(thc63->dev, "pwdn",
>>> +					      GPIOD_OUT_LOW);
>>> +	if (IS_ERR(thc63->pwdn)) {
>>> +		dev_err(thc63->dev, "Unable to get GPIO \"pwdn\"\n");
>>
>>    "pwdn-gpios" maybe?
>>
>>> +		return PTR_ERR(thc63->pwdn);
>>> +	}
>>> +
>>> +	thc63->oe = devm_gpiod_get_optional(thc63->dev, "oe", GPIOD_OUT_LOW);
>>> +	if (IS_ERR(thc63->oe)) {
>>> +		dev_err(thc63->dev, "Unable to get GPIO \"oe\"\n");
>>
>>    "oe-gpios" maybe?
> 
> Are you referring to the error message?

   Yes, seems more clear what to look for this way, IMHO...

[...]

MBR, Sergei
