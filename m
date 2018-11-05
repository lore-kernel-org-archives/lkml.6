Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9F2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819B820819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819B820819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbeKEWcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:32:10 -0500
Received: from shell.v3.sk ([90.176.6.54]:50896 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728973AbeKEWcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:32:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CECE3C5614;
        Mon,  5 Nov 2018 14:12:23 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w1VladxYosVk; Mon,  5 Nov 2018 14:12:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3ACFFC5618;
        Mon,  5 Nov 2018 14:12:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uTTofaeXatEN; Mon,  5 Nov 2018 14:12:19 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 76B04C5614;
        Mon,  5 Nov 2018 14:12:19 +0100 (CET)
Message-ID: <272b2d009e056f36bfb08206772eb40bcdff00b0.camel@v3.sk>
Subject: Re: [PATCH] [media] ov7670: make "xclk" clock optional
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Mon, 05 Nov 2018 14:12:18 +0100
In-Reply-To: <20181105105841.GJ20885@w540>
References: <20181004212903.364064-1-lkundrak@v3.sk>
         <20181105105841.GJ20885@w540>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 2018-11-05 at 11:58 +0100, jacopo mondi wrote:
> Hi Lubomir,
>    +Sakari in Cc
> 
> I just noticed this, and the patch is now in v4.20, but let me comment
> anyway on this.
> 
> On Thu, Oct 04, 2018 at 11:29:03PM +0200, Lubomir Rintel wrote:
> > When the "xclk" clock was added, it was made mandatory. This broke the
> > driver on an OLPC plaform which doesn't know such clock. Make it
> > optional.
> > 
> 
> I don't think this is correct. The sensor needs a clock to work.
>
> With this patch clock_speed which is used to calculate
> the framerate is defaulted to 30MHz, crippling all the calculations if
> that default value doesn't match what is actually installed on the
> board.

How come? I kept this:

+             info->clock_speed = clk_get_rate(info->clk) / 1000000;

> 
> If this patch breaks the OLPC, then might it be the DTS for said
> device needs to be fixed instead of working around the issue here?

No. Device tree is an ABI, and you can't just add mandatory properties.

There's no DTS for OLPC XO-1 either; it's an OpenFirmware machine.
You'd need to update all machines in the wild which is not realistic.

Alternatively, something else than DT could provide the clock. If this
gets in, then the OLPC would work even without the xclk patch:
https://lore.kernel.org/lkml/20181105073054.24407-12-lkundrak@v3.sk/

(I just got a kbuild failure message, so I'll surely be following up
with a v2.)

> Also, the DT bindings should be updated too if we decide this property
> can be omitted. At this point, with a follow-up patch.

Yes.

> 
> Thanks

Cheers
Lubo

>    j
> 
> > Tested on a OLPC XO-1 laptop.
> > 
> > Cc: stable@vger.kernel.org # 4.11+
> > Fixes: 0a024d634cee ("[media] ov7670: get xclk")
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/media/i2c/ov7670.c | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
> > index 31bf577b0bd3..64d1402882c8 100644
> > --- a/drivers/media/i2c/ov7670.c
> > +++ b/drivers/media/i2c/ov7670.c
> > @@ -1808,17 +1808,24 @@ static int ov7670_probe(struct i2c_client *client,
> >  			info->pclk_hb_disable = true;
> >  	}
> > 
> > -	info->clk = devm_clk_get(&client->dev, "xclk");
> > -	if (IS_ERR(info->clk))
> > -		return PTR_ERR(info->clk);
> > -	ret = clk_prepare_enable(info->clk);
> > -	if (ret)
> > -		return ret;
> > +	info->clk = devm_clk_get(&client->dev, "xclk"); /* optional */
> > +	if (IS_ERR(info->clk)) {
> > +		ret = PTR_ERR(info->clk);
> > +		if (ret == -ENOENT)
> > +			info->clk = NULL;
> > +		else
> > +			return ret;
> > +	}
> > +	if (info->clk) {
> > +		ret = clk_prepare_enable(info->clk);
> > +		if (ret)
> > +			return ret;
> > 
> > -	info->clock_speed = clk_get_rate(info->clk) / 1000000;
> > -	if (info->clock_speed < 10 || info->clock_speed > 48) {
> > -		ret = -EINVAL;
> > -		goto clk_disable;
> > +		info->clock_speed = clk_get_rate(info->clk) / 1000000;
> > +		if (info->clock_speed < 10 || info->clock_speed > 48) {
> > +			ret = -EINVAL;
> > +			goto clk_disable;
> > +		}
> >  	}
> > 
> >  	ret = ov7670_init_gpio(client, info);
> > --
> > 2.19.0
> > 

