Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6515ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0BE20831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARScVoWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0BE20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJYUOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:14:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42051 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeJYUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:14:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so4580595wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JvefQwpzz/XVjfAKaKrEc9qUYVbLEJG2GZ+Wcp+jAgg=;
        b=ARScVoWujR7rtkqy4YcNMPQ4cObHv5nQvByQOfuHEE/p/EL58MIjencKlx/F5e/UAz
         eesOo6fSeRxV11RzcDq0OmJMqPHv6tDNBDNiNowSzM5pNllFe+BYl6TcIhnxddPG7WDV
         e4LhyZm8VfVZJfVTg11+Gm2Eg0plb+nYl719U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JvefQwpzz/XVjfAKaKrEc9qUYVbLEJG2GZ+Wcp+jAgg=;
        b=VyHDN70Z21EzROC6PrDwJcuUAYkTW8qSgOV6mS2NRNCEwDAhIne6AzjxzFRuPjWC4q
         xQE/74fr/DHTaH3q78pfi2c69gxU1fyjgmbUsCiaHE5yOxUwt++u4A+YAc/HB7nI0GyC
         7X44+1FDLlt0j/CYwUg3jlMDVjs0ImqkwYmWEZItUZn0EHiH2xTofKZsn0bkXZ4HZVgO
         giQ9zD44otma9DXmwIjzdq+7uE2E1B+KLxuPuGPwuCU71OX4Y775LfC7w66K4EhU9XmF
         mPwt18edq5vz4DA48pNtAsVXq2/QPQhMdw2u5T+jUtaj+CIB/EAG6abRLbciV0azB4PF
         GfLw==
X-Gm-Message-State: AGRZ1gIEuYsoC9AMFGt8jb0dWe5QitT24cSWTe1mGWbbw/TQmaWiD/hA
        pi0uWwphZcvtc5HBZHMk01Fq2A==
X-Google-Smtp-Source: AJdET5e5527ybqw5mKaKX7n1bVuz0h6Y6JVwf95gVMKNOhY1gJuao24mN/HpdgGGVp2B7RzVIwP7Og==
X-Received: by 2002:adf:c748:: with SMTP id b8-v6mr1577841wrh.134.1540467728205;
        Thu, 25 Oct 2018 04:42:08 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id v30-v6sm7139449wra.67.2018.10.25.04.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 04:42:07 -0700 (PDT)
Date:   Thu, 25 Oct 2018 12:42:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        mturquette@baylibre.com, sboyd@kernel.org, broonie@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181025114205.GC4870@dell>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018, Richard Fitzgerald wrote:
> On 25/10/18 09:26, Charles Keepax wrote:
> > On Thu, Oct 25, 2018 at 08:44:59AM +0100, Lee Jones wrote:
> > > On Mon, 08 Oct 2018, Charles Keepax wrote:
> > > > From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > > > +static const struct reg_default lochnagar1_reg_defaults[] = {
> > > > +	{ LOCHNAGAR1_CDC_AIF1_SEL,    0x00 },
> > > > +	{ LOCHNAGAR1_CDC_AIF2_SEL,    0x00 },
> > ...
> > > > +	{ LOCHNAGAR1_LED1,            0x00 },
> > > > +	{ LOCHNAGAR1_LED2,            0x00 },
> > > > +	{ LOCHNAGAR1_I2C_CTRL,        0x01 },
> > > > +};
> > > 
> > > Why do you need to specify each register value?
> > 
> > The way regmap operates it needs to know the starting value of
> > each register. It will use this to initialise the cache and to
> > determine if writes need to actually update the hardware on
> > cache_syncs after devices have been powered back up.

That sounds crazy to me.  Some devices have thousands of registers.
At a line per register, that's thousands of lines of code/cruft.
Especially seeing as most (sane?) register layouts I've seen default
to zero.  Then default values can be changed at the leisure of the
s/w.

Even if it is absolutely critical that you have to supply these to
Regmap up-front, instead of on first use/read, why can't you just
supply the oddball non-zero ones?

> > > > +static const struct reg_sequence lochnagar1_patch[] = {
> > > > +	{ 0x40, 0x0083 },
> > > > +	{ 0x46, 0x0001 },
> > > > +	{ 0x47, 0x0018 },
> > > > +	{ 0x50, 0x0000 },
> > > > +};
> > > 
> > > I'm really not a fan of these so call 'patches'.
> > > 
> > > Can't you set the registers up proper way?
> > > 
> > 
> > I will see if we could move any out of here or define any of the
> > registers but as we have discussed before it is not always possible.
> > 
> 
> Also patches generally come out of hardware tuning/qualification/tools
> as this list of address,value. So it's easy for people to dump an update
> into the driver as a trivial copy-paste but more work if they have to
> reverse-engineer the patch list from hardware/datasheet into what each
> line "means" and then find the relevant lines of code to change. It's also
> much easier to answer the question "Have these hardware patches been
> applied to the driver?" if we have them in the original documented format.
> It just makes people's lives more difficult if they have to search around
> the code to try to find something that looks like the originally specified
> patch list. We don't use them just as a lazy way to setup some registers.

I understand why they normally exist (sometimes people are just lazy
too) (Mark: BTW chicken-bits sound delicious!).  They're just ugly
from an Open Source PoV.

> > > > +static bool lochnagar2_readable_register(struct device *dev, unsigned int reg)
> > > > +{
> > > > +	switch (reg) {
> > > > +	case LOCHNAGAR_SOFTWARE_RESET:
> > > > +	case LOCHNAGAR_FIRMWARE_ID1:
> > > > +	case LOCHNAGAR_FIRMWARE_ID2:
> > ...
> > > > +	case LOCHNAGAR2_MICVDD_CTRL2:
> > > > +	case LOCHNAGAR2_VDDCORE_CDC_CTRL1:
> > > > +	case LOCHNAGAR2_VDDCORE_CDC_CTRL2:
> > > > +	case LOCHNAGAR2_SOUNDCARD_AIF_CTRL:
> > > > +		return true;
> > > > +	default:
> > > > +		return false;
> > > > +	}
> > > > +}
> > > > +
> > > > +static bool lochnagar2_volatile_register(struct device *dev, unsigned int reg)
> > > > +{
> > > > +	switch (reg) {
> > > > +	case LOCHNAGAR2_GPIO_CHANNEL1:
> > > > +	case LOCHNAGAR2_GPIO_CHANNEL2:
> > > > +	case LOCHNAGAR2_GPIO_CHANNEL3:
> > ...
> > > > +	case LOCHNAGAR2_GPIO_CHANNEL13:
> > > > +	case LOCHNAGAR2_GPIO_CHANNEL14:
> > > > +	case LOCHNAGAR2_GPIO_CHANNEL15:
> > > > +	case LOCHNAGAR2_GPIO_CHANNEL16:
> > > > +	case LOCHNAGAR2_ANALOGUE_PATH_CTRL1:
> > > > +		return true;
> > > > +	default:
> > > > +		return false;
> > > > +	}
> > > > +}
> > > 
> > > This is getting silly now.  Can't you use ranges?
> > 
> > I can if you feel strongly about it? But it does make the drivers
> > much more error prone and significantly more annoying to work
> > with. I find it is really common to be checking that a register
> > is handled correctly through the regmap callbacks and it is nice
> > to just be able to grep for that. Obviously this won't work for
> > all devices/regmaps as well since many will not have consecutive
> > addresses on registers, for example having multi-byte registers
> > that are byte addressed.
> > 
> > How far would you like me to take this as well? Is it just the
> > numeric registers you want ranges for ie.
> > 
> > LOCHNAGAR2_GPIO_CHANNEL1...LOCHNAGAR_GPIO_CHANNEL16
> > 
> > Or is it all consecutive registers even if they are unrelated
> > (exmaple is probably not accurate as I haven't checked the
> > addresses):
> > 
> > LOCHNAGAR2_GPIO_CHANNEL1...LOCHNAGAR2_ANALOGURE_PATH_CTRL1
> > 
> > I don't mind the first at all but the second is getting really
> > horrible in my opinion.

My issue is that we have one end of the scale, where contributors are
submitting patches, trying to remove a line of code here, a line of
code there, then there are patches like this one which describe the
initial value, readable status, writable status and volatile status of
each and every register.

The API is obscene and needs a re-work IMHO.

I really hope we do not really have to list every register, but *if we
absolutely must*, let's do it once:

  REG_ADDRESS, WRV, INITIAL_VALUE

> > > > +static const struct reg_default lochnagar2_reg_defaults[] = {
> > > > +	{ LOCHNAGAR2_CDC_AIF1_CTRL,         0x0000 },
> > > > +	{ LOCHNAGAR2_CDC_AIF2_CTRL,         0x0000 },
> > > > +	{ LOCHNAGAR2_CDC_AIF3_CTRL,         0x0000 },
> > > > +	{ LOCHNAGAR2_DSP_AIF1_CTRL,         0x0000 },
> > ...
> > > > +	{ LOCHNAGAR2_MINICARD_RESETS,       0x0000 },
> > > > +	{ LOCHNAGAR2_ANALOGUE_PATH_CTRL2,   0x0000 },
> > > > +	{ LOCHNAGAR2_COMMS_CTRL4,           0x0001 },
> > > > +	{ LOCHNAGAR2_SPDIF_CTRL,            0x0008 },
> > > > +	{ LOCHNAGAR2_POWER_CTRL,            0x0001 },
> > > > +	{ LOCHNAGAR2_SOUNDCARD_AIF_CTRL,    0x0000 },
> > > > +};
> > > 
> > > OMG!  Vile, vile vile!
> > 
> > I really feel this isn't the driver you are objecting to as such
> > but the way regmap operates and also we seem to always have the same
> > discussions around regmap every time we push a driver.

Absolutely.  I didn't like it before.  I like it even less now.

> > Is there
> > any way me, you and Mark could hash this out and find out a way to
> > handle regmaps that is acceptable to you? I don't suppose you are
> > in Edinburgh at the moment for ELCE?

I'm not at ELCE I'm afraid.

> I suppose if Mark was willing to promote the regmap drivers to be a
> top-level subsystem that could contain the regmap definitions of devices
> then we could dump our regmap definitions in there, where Mark can review
> it as he's familiar with regmap and the chips and the reasons why things
> are done the way they are, rather than Lee having to stress about it every
> time we need to create an MFD device that uses regmap. Though that would
> make the initialization of an MFD rather awkward with the code required
> to init the MFD it not actually being in the MFD tree.

My issue isn't where all this bumph lives.

It's the fact that it's required (at least at this level) at all.

> > > > +	/* Wait for Lochnagar to boot */
> > > > +	ret = lochnagar_wait_for_boot(lochnagar->regmap, &val);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "Failed to read device ID: %d\n", ret);
> > > 
> > > Eh?
> > > 
> > > So you read the LOCHNAGAR_SOFTWARE_RESET register and out pops the
> > > device/revision IDs?  That's just random!
> > 
> > I shall let the hardware guys know you don't approve of their
> > life choices :-) and add some comments to the code.

Please do.  And tell them to stop drinking at lunch time. ;)

> > > > +	ret = devm_of_platform_populate(dev);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "Failed to populate child nodes: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > 
> > > Please do not mix OF and MFD device registration strategies.
> > > 
> > > Pick one and register all devices through your chosen method.
> > 
> > Hmmm we use this to do things like register some fixed regulators
> > and clocks that don't need any control but do need to be associated
> > with the device. I could do that through the MFD although it is in
> > direct conflict with the feedback on the clock patches I received
> > to move the fixed clocks into devicetree rather than registering
> > them manually (see v2 of the patch chain).

The I suggest moving everything to DT.

> > I will have a look see if I can find any ideas that will make
> > everyone happy but we might need to discuss with Mark and the
> > clock guys.
> > 
> > > > +	.probe_new = lochnagar_i2c_probe,
> > > 
> > > Hasn't this been replaced yet?
> > 
> > I will check, the patchset has been around internally for a while
> > so it is possible this is no longer needed.
> > 
> > > > +#ifndef CIRRUS_LOCHNAGAR_H
> > > > +#define CIRRUS_LOCHNAGAR_H
> > > > +
> > > > +#include "lochnagar1_regs.h"
> > > > +#include "lochnagar2_regs.h"
> > > 
> > > Why are you including these here?
> > > 
> > 
> > It is just a convenience so the drivers only need to include
> > lochnagar.h rather than including all three headers manually.

That's against convention.

If a source file needs a head, it should include it explicitly.

> > > > diff --git a/include/linux/mfd/lochnagar1_regs.h b/include/linux/mfd/lochnagar1_regs.h
> > > > diff --git a/include/linux/mfd/lochnagar2_regs.h b/include/linux/mfd/lochnagar2_regs.h
> > > 
> > > So Lochnagar 1 and 2 are completely different devices?
> > > 
> > > What do they do?
> > 
> > Completely different devices is a bit strong, they are different
> > versions of the same system. They have quite different register
> > maps but provide very similar functionality.
> 
> The register maps are different partly because some silicon
> used on the V1 is no longer manufactured and partly because some
> silicon added in V2 didn't fit into the older register map.

I just looked at the maps, which appeared to be vastly different.

> > All the other comments I will get fixed up for the next spin of
> > the patches.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
