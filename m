Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D64BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB08320839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB08320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeHaRiS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:38:18 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:28950 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeHaRiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:38:17 -0400
Received: from [89.1.81.74] (helo=ipc1.ka-ro)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <LW@KARO-electronics.de>)
        id 1fvjVc-0001gl-DC; Fri, 31 Aug 2018 15:30:44 +0200
Date:   Fri, 31 Aug 2018 15:30:43 +0200
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Message-ID: <20180831153043.0b91fbce@ipc1.ka-ro>
In-Reply-To: <64b731c7-aa24-7738-0076-8520f6b9a495@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
        <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
        <20180831121809.GA22507@bogus>
        <20180831144548.26b1204d@ipc1.ka-ro>
        <64b731c7-aa24-7738-0076-8520f6b9a495@ysoft.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Vokáč <michal.vokac@ysoft.com> wrote:

> On 31.8.2018 14:45, Lothar Waßmann wrote:
> > Rob Herring <robh@kernel.org> wrote:
> >   
> >> On Tue, Aug 21, 2018 at 04:38:52PM +0200, Michal Vokáč wrote:  
> >>> Output of the PWM block of i.MX SoCs is always zero volts when the block
> >>> is disabled. This can caue issues when inverted PWM polarity is needed.
> >>> With inverted polarity a duty cycle = 0% corresponds to solid high level
> >>> on the output. If the PWM is dissabled its output instantly goes to solid
> >>> zero which corresponds to duty cycle = 100%.
> >>>
> >>> To have a trully inverted PWM output configure the PWM pad as a GPIO
> >>> with pull-up. Then switch the pad to PWM output whenever non-zero
> >>> duty cycle is needed.
> >>>
> >>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> >>> ---
> >>>   Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
> >>>   1 file changed, 44 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> >>> index c61bdf8..3b1bc4c 100644
> >>> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> >>> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> >>> @@ -14,6 +14,12 @@ See the clock consumer binding,
> >>>   	Documentation/devicetree/bindings/clock/clock-bindings.txt
> >>>   - interrupts: The interrupt for the pwm controller
> >>>   
> >>> +Optional properties:
> >>> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
> >>> +  pin to gpio function.  It allows control over the pin output level when the
> >>> +  PWM block is disabled. This is meant to be used if inverted polarity of the
> >>> +  PWM signal is required. See "Inverted PWM output" section bellow.
> >>> +
> >>>   Example:
> >>>   
> >>>   pwm1: pwm@53fb4000 {
> >>> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
> >>>   	clock-names = "ipg", "per";
> >>>   	interrupts = <61>;
> >>>   };
> >>> +
> >>> +Inverted PWM output
> >>> +-------------------
> >>> +
> >>> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
> >>> +output, the output level is always zero volts when the PWM block is disabled.
> >>> +The zero output level is actively driven by the output stage of the PWM block
> >>> +and can not be overridden by pull-up. It also does not matter what PWM polarity
> >>> +a PWM client (e.g. backlight) requested.
> >>> +
> >>> +To gain control of the PWM output level in disabled state two pinctrl states
> >>> +can be used. The "default" state and the "pwm" state. In the default state the
> >>> +PWM output is configured as a GPIO with pull-up. In the "pwm" state the output
> >>> +is configured as a PWM output. This setup assures that the PWM output is at
> >>> +the required level that corresponds to duty cycle = 0 when PWM is disabled.
> >>> +E.g. at boot.
> >>> +
> >>> +Example:
> >>> +
> >>> +&pwm1 {
> >>> +	pinctrl-names = "default", "pwm";
> >>> +	pinctrl-0 = <&pinctrl_backlight_gpio>;
> >>> +	pinctrl-1 = <&pinctrl_backlight_pwm>;
> >>> +}
> >>> +
> >>> +pinctrl_backlight_gpio: pwm1grp-gpio {
> >>> +	fsl,pins = <
> >>> +		/* GPIO with 22kOhm pull-up */
> >>> +		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008  
> >>
> >> There's a slight problem here if I remember the i.MX pin muxing. In GPIO
> >> mode, doesn't the GPIO block control the direction and level if an
> >> output. I guess as long as unused GPIOs are all initialized to inputs it
> >> will be okay.  
> 
> I am not sure if I understand you correctly. Did you mean: "..doesn't the
> GPIO block control the PULL-UP/DOWN and level if an output."? Yes, that is
> true. And as you said, all GPIOs are configured as inputs after reset.
> 
> > One could set the pad_ctl DSE value to 0, so that the pin cannot be
> > driven even if configured as output:
> > 		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF000  
> 
> Yes, it will make no harm to set the pin to high-Z if configured as
> output. Though I am not sure that this makes sense.
> 
If you want to rely on the function of the Pull resistors this is
exactly what you need.

> In case we choose the pull-up to keep the level high the pin needs to stay
> configured as input. And as the GPIO is reserved for us there is actually
> no one else who could re-configure it.
> 
U-Boot may have configured the PWM pin as output to enable the
backlight without brightness control.

> In case we choose to actively drive the pin instead of relying on the
> internal pull-up we need to use gpiod lib and configure the pin as output.
> In that case DSE must be set non-zero.
> 
That is my personal preference too.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
