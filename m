Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B16C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB152098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB152098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeJLXmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:42:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37827 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbeJLXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:42:10 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gAzzj-0004Vw-4k; Fri, 12 Oct 2018 18:08:55 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gAzzi-0002U6-EH; Fri, 12 Oct 2018 18:08:54 +0200
Date:   Fri, 12 Oct 2018 18:08:54 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Message-ID: <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Oct 12, 2018 at 03:04:48PM +0000, Vokáč Michal wrote:
> On 12.10.2018 10:57, Uwe Kleine-König wrote:
> > On Wed, Oct 10, 2018 at 09:33:26AM +0000, Vokáč Michal wrote:
> >> Normally the PWM output is held LOW when PWM is disabled. This can cause
> >> problems when inverted PWM signal polarity is needed. With this behavior
> >> the connected circuit is fed by 100% duty cycle instead of being shut-off.
> >>
> >> Allow users to define a "gpio" and a "pwm" pinctrl states. The pwm pinctrl
> >> state is then selected when PWM is enabled and the gpio pinctrl state is
> >> selected when PWM is disabled. Also add a new pwm-gpios GPIO that is used
> >> to drive the output in the gpio state.
> >>
> >> If all the pinctrl states and the pwm-gpios are not correctly specified
> >> in DT the logic will work as before.
> >>
> >> As an example, with this patch a PWM controlled backlight with inversed
> >> signal polarity can be used in full brightness range. Without this patch
> >> the backlight can not be turned off as brightness = 0 disables the PWM
> >> and that in turn set PWM output LOW, that is full brightness.
> >>
> >> Output of the PWM with "default" pinctrl and with "pwm"+"gpio" pinctrl:
> >>
> >> +--------------+------------+---------------+---------------------------+
> >> | After reset  | Bootloader | Linux pinctrl | User (sysfs, backlight..) |
> >> | 100k pull-up | (not used) |               |   enable    |   disable   |
> >> +--------------+------------+---------------+---------------------------+
> >>   ___________________________    default        _   _   _
> >>                              |_________________| |_| |_| |_|_____________
> >>
> >>                                 pwm + gpio
> >>   ___________________________________________   _   _   _   _____________
> >>                                              |_| |_| |_| |_|
> > 
> > I was made aware of this patch by Thierry while discussion about a patch
> > opportunity. I already pointed out some stuff I don't like about this
> > patch in the repective thread, but I repeat it here to have it at the
> > right place.
> 
> Thank you for taking time to comment on this one as well Uwe.
> 
> >> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> >> ---
> >> Changes in v2:
> >>   - Utilize the "pwm" and "gpio" pinctrl states.
> >>   - Use the pwm-gpios signal to drive the output in "gpio" pinctrl state.
> >>   - Select the right pinctrl state in probe.
> >>
> >>   drivers/pwm/pwm-imx.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 86 insertions(+)
> >>
> >> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> >> index 6cd3b72..3502123 100644
> >> --- a/drivers/pwm/pwm-imx.c
> >> +++ b/drivers/pwm/pwm-imx.c
> >> @@ -10,11 +10,13 @@
> >>   #include <linux/clk.h>
> >>   #include <linux/delay.h>
> >>   #include <linux/err.h>
> >> +#include <linux/gpio/consumer.h>
> >>   #include <linux/io.h>
> >>   #include <linux/kernel.h>
> >>   #include <linux/module.h>
> >>   #include <linux/of.h>
> >>   #include <linux/of_device.h>
> >> +#include <linux/pinctrl/consumer.h>
> >>   #include <linux/platform_device.h>
> >>   #include <linux/pwm.h>
> >>   #include <linux/slab.h>
> >> @@ -92,10 +94,45 @@ struct imx_chip {
> >>   	void __iomem	*mmio_base;
> >>   
> >>   	struct pwm_chip	chip;
> >> +
> >> +	struct pinctrl *pinctrl;
> >> +	struct pinctrl_state *pinctrl_pins_gpio;
> >> +	struct pinctrl_state *pinctrl_pins_pwm;
> >> +	struct gpio_desc *pwm_gpiod;
> > 
> > The pinctrl framework already knows about "init" and "default". These
> > should be enough. i.e. "init" configures as gpio and "default" als pwm.
> 
> That is totally new information for me. I've never seen any usage of
> "init" pinctrl state before. The total number of users is 6 (rockchip)
> so that explains a lot.
> 
> I think that it would not work though. The basic idea behind my
> solution is that the pinctrl driver does not know what is the correct
> pin configuration at probe whereas the pwm-imx driver does.
> 
> With the "init" and "default" states the pinctrl driver will always
> select the "default" if it find the pins in "init" state.
> 
> 	https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/core.c#L1469
> 
> But we want the pins to stay in the "init" GPIO state unless a client
> enables the PWM.

Note I don't know this very well either. What should work then is to
have "init" as GPIO and "active" as PWM. Well, though this breaks if you
intend to probe a running pwm without stopping it.
 
> >>   };
> >>   
> >> +
> >>   #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
> >>   
> >> +static int imx_pwm_init_pinctrl_info(struct imx_chip *imx_chip,
> >> +		struct platform_device *pdev)
> >> +{
> >> +	imx_chip->pinctrl = devm_pinctrl_get(&pdev->dev);
> >> +	if (!imx_chip->pinctrl || IS_ERR(imx_chip->pinctrl)) {
> >> +		dev_info(&pdev->dev, "can not get pinctrl\n");
> >> +		return PTR_ERR(imx_chip->pinctrl);
> >> +	}
> >> +
> >> +	imx_chip->pinctrl_pins_pwm = pinctrl_lookup_state(imx_chip->pinctrl,
> >> +			"pwm");
> >> +	imx_chip->pinctrl_pins_gpio = pinctrl_lookup_state(imx_chip->pinctrl,
> >> +			"gpio");
> >> +	imx_chip->pwm_gpiod = devm_gpiod_get_optional(&pdev->dev, "pwm",
> >> +			GPIOD_IN);
> >> +
> >> +	if (PTR_ERR(imx_chip->pwm_gpiod) == -EPROBE_DEFER) {
> > 
> > You must not use PTR_ERR on a value that might not contain an error
> > pointer.
> 
> OK, thank you for valuable info.
> So it seems like the I2C folks are in troubles as well:
> 
> 	https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2c-imx.c#L996

correct. I cannot find this documented though.

> >> +		 * pinctrl to switch the output pin to GPIO functon and keep
> >> +		 * the output at the same level as for duty-cycle = 0.
> > 
> > Is it obvious that using a GPIO is more efficient/better/worth the
> > complexity than just enabling the PWM with duty-cycle 0 and the right
> > polarity?
> 
> To me, it does more than just setting duty-cycle = 0. I think that the
> user expect to find the PWM chip in disabled state after this. So that
> when you read the HW registers you see the chip is disabled.

The PWM API user doesn't (have to) care how the lowlevel driver
implements the .disable() callback.

I personally would prefer to keep the driver simple (without pinctrl and
gpio stuff which also simplifies matters for dts authors) and spend that
little energy keeping the HW on.
 
> > There might be mechanisms in pincontrol that automatically mux the pin
> > if it's configured as gpio, I didn't follow the details though.
> > 
> > Also it should be possible to configure the GPIO as output immediatly.
> > If the pinmuxing is set to the PWM function this doesn't have a visible
> > side effect.
> 
> This could be the first time that we want to disable the PWM as you
> might start with PWM enabled from probe. And hence the GPIO is still
> configured as input.

I fail to follow your case. Do you mean the pwm is already running when
the driver probes? Then it is save to set the gpio to output as this has
no effect as long as the pin is muxed in its pwm function.

> >> +			pinctrl_select_state(imx->pinctrl,
> >> +					imx->pinctrl_pins_gpio);
> > 
> > Usually align function arguments to the opening (.
> 
> Oops, I will fix those. There is more than this one..
>   
> >> +		}
> >> +
> >>   		writel(0, imx->mmio_base + MX3_PWMCR);
> >>   
> >>   		clk_disable_unprepare(imx->clk_per);
> >> @@ -354,6 +415,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
> >>   	const struct of_device_id *of_id =
> >>   			of_match_device(imx_pwm_dt_ids, &pdev->dev);
> >>   	const struct imx_pwm_data *data;
> >> +	struct pwm_state cstate;
> >>   	struct imx_chip *imx;
> >>   	struct resource *r;
> >>   	int ret = 0;
> >> @@ -385,6 +447,10 @@ static int imx_pwm_probe(struct platform_device *pdev)
> >>   		imx->chip.of_pwm_n_cells = 3;
> >>   	}
> >>   
> >> +	ret = imx_pwm_init_pinctrl_info(imx, pdev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >>   	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>   	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
> >>   	if (IS_ERR(imx->mmio_base))
> >> @@ -394,6 +460,26 @@ static int imx_pwm_probe(struct platform_device *pdev)
> >>   	if (ret < 0)
> >>   		return ret;
> >>   
> >> +	if (imx->pinctrl) {
> >> +		/*
> >> +		 * Update cstate after pwmchip_add() call as the core might
> >> +		 * call the get_state() function to read the PWM registers
> >> +		 * to get the actual HW state.
> >> +		 */
> >> +		pwm_get_state(imx->chip.pwms, &cstate);
> >> +		if (cstate.enabled) {
> >> +			dev_dbg(&pdev->dev,
> >> +				"PWM entered probe in enabled state\n");
> >> +			pinctrl_select_state(imx->pinctrl,
> >> +					imx->pinctrl_pins_pwm);
> >> +		} else {
> >> +			gpiod_set_value_cansleep(imx->pwm_gpiod, 0);
> >> +			pinctrl_select_state(imx->pinctrl,
> >> +					imx->pinctrl_pins_gpio);
> >> +
> >> +		}
> >> +	}
> >> +
> >>   	platform_set_drvdata(pdev, imx);
> >>   	return 0;
> >>   }
> > 
> > There is nothing in this patch that would prevent this code to live in a
> > place where other drivers could reuse this. (But attention, there are
> > dragons: Thierry already replied on my topic that his view is different
> > in this aspect compared to other maintainers though. His POV is that as
> > long as there is only a single driver known that has a problem this
> > should be handled in driver specific code.)
> 
> When I tripped over that issue I also thought it is i.MX specific.
> It never came to my mind that something like that should be done in
> higher layer.
> 
> But I have to admit that my current understanding of the overall
> architecture is at such level that I will just do it how the maintainer
> wants me to do it. Given that the solution improves the situation and
> solves my original problem. And the pinctrl solution was already
> suggested by Fabio Estevam a year ago [1] so I went that way.
> 
> [1] https://patchwork.ozlabs.org/patch/839834/#1819865

In message 15 both Lothar and Fabio agree that they would prefer a
solution without messing with pin configs. But also note that they
discussed about suspend, too, not only pwm_disable().

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
