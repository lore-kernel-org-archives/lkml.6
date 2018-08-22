Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81094C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B862148C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B862148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeHVKDN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:03:13 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.109]:38011 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeHVKDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:03:13 -0400
X-Greylist: delayed 1509 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2018 06:03:12 EDT
Received: from [89.1.81.74] (helo=ipc1.ka-ro)
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <LW@KARO-electronics.de>)
        id 1fsMPc-0004hb-PO; Wed, 22 Aug 2018 08:14:36 +0200
Date:   Wed, 22 Aug 2018 08:14:36 +0200
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Message-ID: <20180822081436.13d8f55b@ipc1.ka-ro>
In-Reply-To: <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
        <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
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

> Output of the PWM block of i.MX SoCs is always zero volts when the block
> is disabled. This can caue issues when inverted PWM polarity is needed.
> With inverted polarity a duty cycle = 0% corresponds to solid high level
> on the output. If the PWM is dissabled its output instantly goes to solid
> zero which corresponds to duty cycle = 100%.
> 
> To have a trully inverted PWM output configure the PWM pad as a GPIO
> with pull-up. Then switch the pad to PWM output whenever non-zero
> duty cycle is needed.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> index c61bdf8..3b1bc4c 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> @@ -14,6 +14,12 @@ See the clock consumer binding,
>  	Documentation/devicetree/bindings/clock/clock-bindings.txt
>  - interrupts: The interrupt for the pwm controller
>  
> +Optional properties:
> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
> +  pin to gpio function.  It allows control over the pin output level when the
> +  PWM block is disabled. This is meant to be used if inverted polarity of the
> +  PWM signal is required. See "Inverted PWM output" section bellow.
> +
>  Example:
>  
>  pwm1: pwm@53fb4000 {
> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>  	clock-names = "ipg", "per";
>  	interrupts = <61>;
>  };
> +
> +Inverted PWM output
> +-------------------
> +
> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
> +output, the output level is always zero volts when the PWM block is disabled.
> +The zero output level is actively driven by the output stage of the PWM block
> +and can not be overridden by pull-up. It also does not matter what PWM polarity
> +a PWM client (e.g. backlight) requested.
> +
> +To gain control of the PWM output level in disabled state two pinctrl states
> +can be used. The "default" state and the "pwm" state. In the default state the
>
The "default" function of a PWM is to deliver a PWM signal. So it is
more sensible to me to have the PWM function as "default" and a "gpio"
function as alternative state.

> +PWM output is configured as a GPIO with pull-up. In the "pwm" state the output
> +is configured as a PWM output. This setup assures that the PWM output is at
> +the required level that corresponds to duty cycle = 0 when PWM is disabled.
> +E.g. at boot.
> +
> +Example:
> +
> +&pwm1 {
> +	pinctrl-names = "default", "pwm";
> +	pinctrl-0 = <&pinctrl_backlight_gpio>;
> +	pinctrl-1 = <&pinctrl_backlight_pwm>;
> +}
> +
> +pinctrl_backlight_gpio: pwm1grp-gpio {
> +	fsl,pins = <
> +		/* GPIO with 22kOhm pull-up */
> +		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008
> +	>;
> +};
> +
> +pinctrl_backlight_pwm: pwm1grp-pwm {
> +	fsl,pins = <
> +		/* PWM output */
> +		MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
> +	>;
> +};



-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
