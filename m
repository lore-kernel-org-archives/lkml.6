Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3F6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7999C218A3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="pCtV7Woj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfAXI7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:59:50 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:57864 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfAXI7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:59:49 -0500
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id B89A6A07CC;
        Thu, 24 Jan 2019 09:59:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1548320387;
        bh=DqbpA9/WwPkNPKhrzx3w5CsdYGcF8mgxG3UgQf6TZBc=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=pCtV7Wojqe9vKHHYickzsHMk/Rwsq7qa6CvEJTHlZvi4DXetALBvWFPTsstjWCikw
         zoQrKGwoDpWHudTCdImZQ/SfAmH1n2LQcbpjHv7MSi5mAZCNGoLJWnNQM70W54X5H7
         gif06jaTUq4iPdSbqmbWj/KyhbuMe/IXnE9Mg0gU=
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in disabled
 state
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181212080154.kcfh57mulypwuscu@pengutronix.de>
 <52ed0614-d1f5-81cb-3b17-8eb137967872@ysoft.com>
 <20181212121255.yg6b4pw7qord7ebi@pengutronix.de>
Message-ID: <4b0356b7-bc7d-a026-ac90-3f0c5754ed29@ysoft.com>
Date:   Thu, 24 Jan 2019 09:59:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181212121255.yg6b4pw7qord7ebi@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.2018 13:12, Uwe Kleine-König wrote:
> On Wed, Dec 12, 2018 at 11:42:17AM +0000, Vokáč Michal wrote:
>> On 12.12.2018 09:01, Uwe Kleine-König wrote:
>>> On Thu, Dec 06, 2018 at 01:41:31PM +0000, Vokáč Michal wrote:
>>>> Normally the PWM output is held LOW when PWM is disabled. This can cause
>>>> problems when inverted PWM signal polarity is needed. With this behavior
>>>> the connected circuit is fed by 100% duty cycle instead of being shut-off.
>>>>
>>>> Allow users to define a "pwm" and a "gpio" pinctrl states. The pwm pinctrl
>>>> state is selected when PWM is enabled and the gpio pinctrl state is
>>>> selected when PWM is disabled. In the gpio state the new pwm-gpios GPIO is
>>>> configured as input and the internal pull-up resistor is used to pull the
>>>> output level high.
>>>>
>>>> If all the pinctrl states and the pwm-gpios GPIO are not correctly
>>>> specified in DT the PWM work as usual.
>>>>
>>>> As an example, with this patch a PWM controlled backlight with inversed
>>>> signal polarity can be used in full brightness range. Without this patch
>>>> the backlight can not be turned off as brightness = 0 disables the PWM
>>>> and that in turn set PWM output LOW, that is full brightness.
>>>>
>>>> Inverted output of the PWM with "default" and with "pwm"+"gpio" pinctrl:
>>>>
>>>> +--------------+------------+---------------+----------- +-------------+
>>>> | After reset  | Bootloader |   PWM probe   |     PWM    |     PWM     |
>>>> | 100k pull-up |            |               | enable 30% |   disable   |
>>>> +--------------+------------+---------------+------------+-------------+
>>>> | pinctrl      |    none    |    default    |   default  |   default   |
>>>> | out H   __________________                   __   __                 |
>>>> | out L                     \_________________/  \_/  \_/\____________ |
>>>> |                                           ^    ^    ^                |
>>>> +--------------+------------+---------------+------------+-------------+
>>>> | pinctrl      |    none    |      gpio     |     pwm    |     gpio    |
>>>> | out H   __________________________________   __   __   _____________ |
>>>> | out L                                     \_/  \_/  \_/              |
>>>> |                                           ^    ^    ^                |
>>>> +----------------------------------------------------------------------+
>>>>
>>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>>> ---
>>>> Changes in v3:
>>>>    - Commit message update.
>>>>    - Minor fix in code comment (Uwe)
>>>>    - Align function arguments to the opening parentheses. (Uwe)
>>>>    - Do not test devm_pinctrl_get for NULL. (Thierry)
>>>>    - Convert all messages to dev_dbg() (Thierry)
>>>>    - Do not actively drive the pin in gpio state. Configure it as input
>>>>      and rely solely on the internal pull-up. (Thierry)
>>>>
>>>> Changes in v2:
>>>>    - Utilize the "pwm" and "gpio" pinctrl states.
>>>>    - Use the pwm-gpios signal to drive the output in "gpio" pinctrl state.
>>>>    - Select the right pinctrl state in probe.
>>>>
>>>>    drivers/pwm/pwm-imx.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 77 insertions(+)
>>>>
>>
>> [ snip ]
>>
>>> On thing I noticed while looking at the rcar driver is: This doesn't
>>> wait for the current period to end. Is this supposed to happen? Also for
>>> the enable case the hardware is configured for the desired duty cycle
>>> and only then the pinctrl is switched to pwm. Both might result in a
>>> spike that is not desired.
>>
>> The behavior should not change from how imx-pwm was working before.
>> When PWM is disabled the output is immediately gated off (put into
>> the idle state) independently on the period. I measured this.
> 
> Oh really, I wasn't aware of that. This is another bug in the imx pwm
> then (I think).

I kind of expect that when hit a disable button the output is immediately
put into the idle state. To me it does not seem appropriate to wait the
whole period, or even just the active part of the period. If duty=100%
and period=4s (current maximum), in the worst case you would have to wait
4s until you stop the PWM. Quite a long time of driving something you
actually wanted to be shut off.

>> For the enable case you would certainly not get any additional spikes.
> 
> Yes, there is a possibility for a spike: If you configure for say 40%:
>                    _    _
> pwm output   : ___/ \__/ \__
> muxing       : GPIO| PWM_
> actual output: ____/\__/ \__

OK, you are right.

>> The worst thing that may happen is that the first period will be
>> slightly shorter depending on how long it takes to test the pinctrl
>> and switch the muxing. And this is unavoidable, it would happen even
>> if you wait for the start of a period. The test + muxing still takes
>> some time.
> 
> You could first configure for duty_cycle 0 and a short period, then mux
> to PWM and then configure the correct duty cycle. Ditto for disable.

I agree it can be solved for the enable case but I do not see the
point in doing so for the disable case. Can you elaborate on how it
could be useful?

This is what I came up with:

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 55666cc..f76a326 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -242,6 +284,15 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
                 else
                         period_cycles = 0;
  
+               cr = MX3_PWMCR_PRESCALER_SET(prescale) |
+                    MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
+                    FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
+                    MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
+
+               if (cstate.polarity == PWM_POLARITY_INVERSED)
+                       cr |= FIELD_PREP(MX3_PWMCR_POUTC,
+                                        MX3_PWMCR_POUTC_INVERTED);
+
                 /*
                  * Wait for a free FIFO slot if the PWM is already enabled, and
                  * flush the FIFO if the PWM was disabled and is about to be
@@ -255,22 +306,36 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
                                 return ret;
  
                         pwm_imx27_sw_reset(chip);
+                       if (imx->pinctrl) {
+                               /*
+                                * Smooth transition from disabled to enabled
+                                * state. Configure duty=0 and requested period
+                                * to assure that, later when the requested
+                                * duty is configured, the duty cycle of the
+                                * first period has correct length.
+                                */
+                               writel(0, imx->mmio_base + MX3_PWMSAR);
+                               writel(period_cycles, imx->mmio_base + MX3_PWMPR);
+                               writel(cr, imx->mmio_base + MX3_PWMCR);
+                               pinctrl_select_state(imx->pinctrl,
+                                                    imx->pinctrl_pins_pwm);
+                       }
                 }
  
                 writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
                 writel(period_cycles, imx->mmio_base + MX3_PWMPR);
-
-               cr = MX3_PWMCR_PRESCALER_SET(prescale) |
-                    MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
-                    FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
-                    MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
-
-               if (state->polarity == PWM_POLARITY_INVERSED)
-                       cr |= FIELD_PREP(MX3_PWMCR_POUTC,
-                                       MX3_PWMCR_POUTC_INVERTED);
-
                 writel(cr, imx->mmio_base + MX3_PWMCR);
         } else if (cstate.enabled) {
+               /*
+                * PWM block will be disabled. Normally its output will be set
+                * low no matter what output polarity is configured. Let's use
+                * pinctrl to switch the output pin to GPIO functon and keep
+                * the output at the same level as for duty-cycle = 0.
+                */
+               if (imx->pinctrl)
+                       pinctrl_select_state(imx->pinctrl,
+                                            imx->pinctrl_pins_gpio);
+
                 writel(0, imx->mmio_base + MX3_PWMCR);
  
                 pwm_imx27_clk_disable_unprepare(chip);
-- 
2.1.4

What do you think?

Best regards,
Michal

