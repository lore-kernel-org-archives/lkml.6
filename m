Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5DFC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2712620672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2712620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeLMI4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:56:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44181 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbeLMI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:56:12 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXMmt-0002Zj-9Y; Thu, 13 Dec 2018 09:56:07 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXMmr-0003k6-DH; Thu, 13 Dec 2018 09:56:05 +0100
Date:   Thu, 13 Dec 2018 09:56:05 +0100
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
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v4 2/2] pwm: imx: Configure output to GPIO in
 disabled state
Message-ID: <20181213085605.j2e76y67srg5qfbc@pengutronix.de>
References: <1544616263-82642-1-git-send-email-michal.vokac@ysoft.com>
 <1544616263-82642-3-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544616263-82642-3-git-send-email-michal.vokac@ysoft.com>
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

On Wed, Dec 12, 2018 at 12:04:51PM +0000, Vokáč Michal wrote:
> Normally the PWM output is held LOW when PWM is disabled. This can cause
> problems when inverted PWM signal polarity is needed. With this behavior
> the connected circuit is fed by 100% duty cycle instead of being shut-off.
> 
> Allow users to define a "pwm" and a "gpio" pinctrl states. The pwm pinctrl
> state is selected when PWM is enabled and the gpio pinctrl state is
> selected when PWM is disabled. In the gpio state the new pwm-gpios GPIO is
> configured as input and the internal pull-up resistor is used to pull the
> output level high.
> 
> If all the pinctrl states and the pwm-gpios GPIO are not correctly
> specified in DT the PWM work as usual.
> 
> As an example, with this patch a PWM controlled backlight with inversed
> signal polarity can be used in full brightness range. Without this patch
> the backlight can not be turned off as brightness = 0 disables the PWM
> and that in turn set PWM output LOW, that is full brightness.
> 
> Inverted output of the PWM with "default" and with "pwm"+"gpio" pinctrl:
> 
> +--------------+------------+---------------+----------- +-------------+
> | After reset  | Bootloader |   PWM probe   |     PWM    |     PWM     |
> | 100k pull-up |            |               | enable 30% |   disable   |
> +--------------+------------+---------------+------------+-------------+
> | pinctrl      |    none    |    default    |   default  |   default   |
> | out H   __________________                   __   __                 |
> | out L                     \_________________/  \_/  \_/\____________ |
> |                                           ^    ^    ^                |
> +--------------+------------+---------------+------------+-------------+
> | pinctrl      |    none    |      gpio     |     pwm    |     gpio    |
> | out H   __________________________________   __   __   _____________ |
> | out L                                     \_/  \_/  \_/              |
> |                                           ^    ^    ^                |
> +----------------------------------------------------------------------+

Just for the record: My last concern against this patch set (that I sent
for v3) and v4 of the series criss-crossed. So the problem with the
peaks that could happen is still unaddressed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
