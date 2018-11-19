Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D431EC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B5720871
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B5720871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeKSSzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:55:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46355 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeKSSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:55:37 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gOeyu-0004se-1x; Mon, 19 Nov 2018 09:32:32 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gOeys-0005gD-Gu; Mon, 19 Nov 2018 09:32:30 +0100
Date:   Mon, 19 Nov 2018 09:32:30 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Michal.Vokac@ysoft.com, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org,
        l.majewski@majess.pl,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Message-ID: <20181119083230.re3dtq4alnrojbnd@pengutronix.de>
References: <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <CACRpkdZAew3bUea=iR4t-a7SVSMf=-CTeWfeU215uT_jQ-o81A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZAew3bUea=iR4t-a7SVSMf=-CTeWfeU215uT_jQ-o81A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Mon, Nov 19, 2018 at 08:44:38AM +0100, Linus Walleij wrote:
> There is quite a discussion you folks have going on here. I tried to
> grasp it but I can't. I can try to answer the above question specifically.

To sumarize: When the pwm driver probes it is not yet clear if the idle
state of the output pin is high or low. Even when the pinctrl device has
an "init" and a "default" pinctrl, it is not yet fixed when its
"default" is configured.

The way Thierry wants to fix that is by disabling the output driver
until the pwm is in use und rely on a pull-up or pull-down in hardware.

The way I want to fix this is to only configure the pwm pin as part of
the consumer. This is late enough that the consumer already requested
and configured the pwm such that the idle level is known.
Thierry's and Lothar's claim was that putting the pin setup of the pwm
pin into the pwm consumer's pinctrl was forbidden. That's why I asked
you as pinctrl maintainer if there is a requirement that I don't know
of.

> So compared to things like that (that we still have to support
> forever) whatever you are doing here you're doing great as long
> as it is consumer controlled.
> 
> Whether that consumer is the previous driver thingie in the
> daisy-chain of consumers or the final end user consumer of
> the pin doesn't really matter to pin control, as long as it is a
> consumer. I would tend to say it is up to the subsystem,
> and the old IETF motto "rough consensus and running code".

So I understand that from the pinctrl side there is no hard requirement
that the PWM pin must be muxed as part of the pwm device. And if things
work better when the pin is only configured as part of its consumer this
is legitimate.

Thanks for your feedback.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
