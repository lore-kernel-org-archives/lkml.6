Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475B1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222EB2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfBFJ6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:58:14 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49963 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBFJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:58:14 -0500
X-Originating-IP: 109.213.164.40
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr [109.213.164.40])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 8074AC0009;
        Wed,  6 Feb 2019 09:58:11 +0000 (UTC)
Date:   Wed, 6 Feb 2019 10:58:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Oliver.Rohe@wago.com
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rs5c372: Fix reading from rtc when the oscillator
 got interrupted.
Message-ID: <20190206095810.GL24598@piout.net>
References: <1547212521-14871-1-git-send-email-oliver.rohe@wago.com>
 <20190205215552.GH24598@piout.net>
 <0b5372eb-a921-44e9-2bed-2f7582f64329@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b5372eb-a921-44e9-2bed-2f7582f64329@wago.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2019 06:33:39+0000, Oliver.Rohe@wago.com wrote:
> >> +	switch (rs5c->type) {
> >> +	case rtc_r2025sd:
> >> +	case rtc_r2221tl:
> >> +		if (ctrl2 & R2x2x_CTRL2_VDET)
> >> +			dev_warn(&client->dev, "rtc battery voltage drop below threshold detected.\n");
> > 
> > VDET doesn't mean anything specific regarding timekeeping so I wouldn't warn here.
> 
> VDET means in case the chip is powered by a battery, that is about to die sometime soon, it gives you heads up.

Yes but my statement stands true, this doesn't have any direct
implication regarding timekeeping.

There is the RTC_VL_READ ioctl to check voltage low. It is not weel
designed but this is what we have now.

> > 
> >> +		if (ctrl2 & R2x2x_CTRL2_PON)
> >> +			dev_warn(&client->dev, "rtc battery voltage drop to zero detected.\n");
> > 
> > You should return -EINVAL directly here
> 
> The PON implies the XSTP bit, so I only return from there, just to print all the warning messages, but I can return directly from here if you want.

As you said, PON implies XSTP so I'm not sure it is valuable to have both
warnings.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
