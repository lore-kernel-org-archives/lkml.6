Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeC0J6E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:58:04 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:59769 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeC0J6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:58:01 -0400
Subject: Re: [PATCH v6 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder driver
To: Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, <architt@codeaurora.org>,
        <Laurent.pinchart@ideasonboard.com>, <airlied@linux.ie>,
        <horms@verge.net.au>, <magnus.damm@gmail.com>, <geert@linux-m68k.org>,
        <niklas.soderlund@ragnatech.se>, <sergei.shtylyov@cogentembedded.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org>
 <1521213399-31947-3-git-send-email-jacopo+renesas@jmondi.org>
 <CGME20180327062437epcas5p3389cb070d15669febeb6f504cff2cf6f@epcas5p3.samsung.com>
 <30381869-9bc8-b6aa-a37a-598d9c8f280d@mentor.com>
 <df124c8f-7c71-7941-9969-977dd19c7d1b@samsung.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <cac21cde-d3ac-884e-2896-8aebd9df0cb0@mentor.com>
Date: Tue, 27 Mar 2018 12:57:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <df124c8f-7c71-7941-9969-977dd19c7d1b@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On 03/27/2018 10:28 AM, Andrzej Hajda wrote:
> On 27.03.2018 08:24, Vladimir Zapolskiy wrote:
>> Hi Jacopo,
>>
>> On 03/16/2018 05:16 PM, Jacopo Mondi wrote:
>>> Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
>>> output converter.
>>>
>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>> ---
>>>  drivers/gpu/drm/bridge/Kconfig        |   6 +
>>>  drivers/gpu/drm/bridge/Makefile       |   1 +
>>>  drivers/gpu/drm/bridge/thc63lvd1024.c | 255 ++++++++++++++++++++++++++++++++++
>>>  3 files changed, 262 insertions(+)
>>>  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
>>>
>>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>>> index 3b99d5a..5815a20 100644
>>> --- a/drivers/gpu/drm/bridge/Kconfig
>>> +++ b/drivers/gpu/drm/bridge/Kconfig
>>> @@ -92,6 +92,12 @@ config DRM_SII9234
>>>  	  It is an I2C driver, that detects connection of MHL bridge
>>>  	  and starts encapsulation of HDMI signal.
>>>  
>>> +config DRM_THINE_THC63LVD1024
>>> +	tristate "Thine THC63LVD1024 LVDS decoder bridge"
>>> +	depends on OF
>>> +	---help---
>>> +	  Thine THC63LVD1024 LVDS/parallel converter driver.
>>> +
>>>  config DRM_TOSHIBA_TC358767
>>>  	tristate "Toshiba TC358767 eDP bridge"
>>>  	depends on OF
>>> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
>>> index 373eb28..fd90b16 100644
>>> --- a/drivers/gpu/drm/bridge/Makefile
>>> +++ b/drivers/gpu/drm/bridge/Makefile
>>> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
>>>  obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
>>>  obj-$(CONFIG_DRM_SII902X) += sii902x.o
>>>  obj-$(CONFIG_DRM_SII9234) += sii9234.o
>>> +obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>>>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
>>>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
>>>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
>>> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
>>> new file mode 100644
>>> index 0000000..02a54c2
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
>>> @@ -0,0 +1,255 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * THC63LVD1024 LVDS to parallel data DRM bridge driver.
>>> + *
>>> + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
>>> + */
>>> +
>>> +#include <drm/drmP.h>
>>> +#include <drm/drm_bridge.h>
>>> +#include <drm/drm_panel.h>
>>> +
>>> +#include <linux/gpio/consumer.h>
>>> +#include <linux/of_graph.h>
>>> +#include <linux/regulator/consumer.h>
>>> +
>>> +enum {
>>> +	THC63_LVDS_IN0,
>>> +	THC63_LVDS_IN1,
>>> +	THC63_DIGITAL_OUT0,
>>> +	THC63_DIGITAL_OUT1,
>>> +};
>>> +
>>> +static const char * const thc63_reg_names[] = {
>>> +	"vcc", "lvcc", "pvcc", "cvcc",
>>> +};
>>> +
>>> +struct thc63_dev {
>>> +	struct device *dev;
>>> +
>>> +	struct regulator *vccs[ARRAY_SIZE(thc63_reg_names)];
>>> +
>>> +	struct gpio_desc *pdwn;
>>> +	struct gpio_desc *oe;
>>> +
>>> +	struct drm_bridge bridge;
>>> +	struct drm_bridge *next;
>>> +};
>>> +
>>> +static inline struct thc63_dev *to_thc63(struct drm_bridge *bridge)
>>> +{
>>> +	return container_of(bridge, struct thc63_dev, bridge);
>>> +}
>>> +
>>> +static int thc63_attach(struct drm_bridge *bridge)
>>> +{
>>> +	struct thc63_dev *thc63 = to_thc63(bridge);
>>> +
>>> +	return drm_bridge_attach(bridge->encoder, thc63->next, bridge);
>>> +}
>>> +
>>> +static void thc63_enable(struct drm_bridge *bridge)
>>> +{
>>> +	struct thc63_dev *thc63 = to_thc63(bridge);
>>> +	struct regulator *vcc;
>>> +	int i;
>> unsigned int i;
> 
> Why? You are introducing silly bug this way, see few lines below.

You see that the comment was too terse to describe the context in full.
Thank you for exposing a flaw.

>>
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
>>> +		vcc = thc63->vccs[i];
>>> +		if (!vcc)
>>> +			continue;
>>> +
>>> +		if (regulator_enable(vcc))
>>> +			goto error_vcc_enable;
>>> +	}
>>> +
>>> +	if (thc63->pdwn)
>>> +		gpiod_set_value(thc63->pdwn, 0);
>>> +
>>> +	if (thc63->oe)
>>> +		gpiod_set_value(thc63->oe, 1);
>>> +
>>> +	return;
>>> +
>>> +error_vcc_enable:
>>> +	dev_err(thc63->dev, "Failed to enable regulator %s\n",
>>> +		thc63_reg_names[i]);
>>> +
>>> +	for (i = i - 1; i >= 0; i--) {
> 
> Here, the loop will not end if you define i unsigned.
> 
> I know one can change the loop, to make it working with unsigned. But
> this clearly shows that using unsigned is more risky.
> What are advantages of unsigned vs int in this case. Are there some
> guidelines/discussions about it?
> 

The reason is pretty simple, like Geert said it might be a personal reason,
but a code pattern 

	int i;
	...
	for (i = 0; i < ARRAY_SIZE(...); i++)

is my own red rag, because I've seen the pattern so many times, and every
time here a compiler produces a W=12 (or -Wsign-compare) warning like
the next one:

drivers/gpu/drm/bridge/thc63lvd1024.c:182:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++, reg++) {
                ^

Usually a conversion from 'int i' to 'unsigned int i' is trivial, and lowering
of a noise level in compiler's output is seen as beneficial, because it gives
more chances to people to capture a real problem.

--
With best wishes,
Vladimir
