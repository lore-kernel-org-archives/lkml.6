Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBZPpR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:45:17 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:26047 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBZPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:45:15 -0500
Subject: Re: regression v4.16 on Nokia N900:/dev/input/event6 aka AV Jack
 support disappeared
To: Pavel Machek <pavel@ucw.cz>, <pali.rohar@gmail.com>, <sre@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>, <khilman@kernel.org>,
        <aaro.koskinen@iki.fi>, <ivo.g.dimitrov.75@gmail.com>,
        <patrikbachan@gmail.com>, <serge@hallyn.com>, <abcloriens@gmail.com>,
        <clayton@craftyguy.net>, <martijn@brixit.nl>,
        <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>
CC: <broonie@kernel.org>, <peter.ujfalusi@ti.com>,
        <alsa-devel@alsa-project.org>
References: <20180224214617.GA22619@amd>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <052b4de7-5734-925b-7e0d-edf7abeefcfc@ti.com>
Date: Mon, 26 Feb 2018 09:43:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180224214617.GA22619@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/2018 03:46 PM, Pavel Machek wrote:
> Hi!
> 
> In v4.16, AV jack support disappeared.
> 
> This one is suspect:
> 
> commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057
> Author: Andrew F. Davis <afd@ti.com>
> Date:   Wed Nov 29 11:13:59 2017 -0600
> 
>     ARM: dts: omap3-n900: Fix the audio CODEC's reset pin
> 
>     The correct DT property for specifying a GPIO used for reset
>         is "reset-gpios", fix this here.
> 
>     Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X
>     support")
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> How was it tested? It reverts polarity of reset pin, but
> sound/soc/codecs/tlv320aic3x.c treats those as aliases:
> 


The polarity was wrong before, the AIC3x devices are active low reset
and there is no logic inverters between the SoC and the reset line.
GPIO_ACTIVE_LOW is therefor the correct polarity.

This does not change the driver behavior as currently it uses the old
gpio_set_value() which does not respect the polarity as set in DT.

When this driver is converted to use gpiod_ style calls having the
polarity correct will be important, and right now the old style gpio
calls will cause this driver to fail to work if a board comes along that
does have some logic inversion on the reset line as GPIO_ACTIVE is ignored.

As Pavel points out I think your trouble is elsewhere.

Andrew


>  ret = of_get_named_gpio(np, "reset-gpios", 0);
>  if (ret >= 0) {
>     aic3x->gpio_reset = ret;
>  } else {
>  ret = of_get_named_gpio(np, "gpio-reset", 0);
>  if (ret > 0) {
>     dev_warn(&i2c->dev, "Using deprecated property \"gpio-r\eset\", please update your DT");
>     aic3x->gpio_reset = ret;
> 
> 
> 									Pavel
> 
