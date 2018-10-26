Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CC2C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66612082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6itqEGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66612082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeJZQg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:36:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45364 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeJZQg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:36:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id n5-v6so294099wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 01:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4RdiV/6FEJvjYTpccGmSQvpn2kcniDb2Jy7f+ytgCSk=;
        b=V6itqEGpz0PdbyOo7YA/TmnWPpRzD4jn2xGhoQPmTu292RgJWsDMJRK8W+jv+4jtCY
         r9rXLYhJYAKjxnLO+fafD6YXnt1735IJ5xgpLvuWETQSwVXlWJIrcLK58NCvPswBS3Nc
         qKjMTBF+rZq+f89GKc5j7taUihYRNmMv6ghtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4RdiV/6FEJvjYTpccGmSQvpn2kcniDb2Jy7f+ytgCSk=;
        b=gWYnYO+zNOWjD+CEQ0HeIfyq166w4cTbubIiRmHGt2CVlANylU39QmZq1qdlee4C/3
         ByhofAWs0BcNwk7ym8oDCjyr5i/bwwHI8EI88p/wVtIhZt3J0t30kXRcWaPX60r6Y1JS
         cyWsWA3PU8om9EsFuAkMlm4Jv0ziya0ye9vG4hEUzXcCuZTgMZiMldKspEUEMGHdUWtO
         lZwQRkIbsCaEp6Rgdn12IdIjZSD4xjYg72mfIAb/TF194JkMH4+c5cN0YmrydWJgsFKe
         YdsP0mXTJUCPryy2IrUgdCkssEzpF5lgr2lndMkJSMy9juzwYKxBUbm6KYMUGZ41Y0MN
         /59A==
X-Gm-Message-State: AGRZ1gJa8stHvNeFgDreu/jmJOo4cFFSqdLVNOPQo/e0+U7U+mrfwLkm
        ArQgKcluKy5C8mChq/h7OzoffA==
X-Google-Smtp-Source: AJdET5eUYcrHl+sQK2PYO7c+Z2tXeKf6Qsn1DxXgxvuMONvBqRzFy58pYbBCw6PIznrWhdbutPyQZw==
X-Received: by 2002:adf:ed8d:: with SMTP id c13-v6mr4614811wro.39.1540540855001;
        Fri, 26 Oct 2018 01:00:55 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id 199-v6sm2123976wme.39.2018.10.26.01.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 01:00:53 -0700 (PDT)
Date:   Fri, 26 Oct 2018 09:00:51 +0100
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
Message-ID: <20181026080051.GK4870@dell>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <33ea391c-aa6e-2709-6faf-4905e84229e4@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33ea391c-aa6e-2709-6faf-4905e84229e4@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018, Richard Fitzgerald wrote:

> On 25/10/18 12:42, Lee Jones wrote:
> > On Thu, 25 Oct 2018, Richard Fitzgerald wrote:
> > > On 25/10/18 09:26, Charles Keepax wrote:
> > > > On Thu, Oct 25, 2018 at 08:44:59AM +0100, Lee Jones wrote:
> > > > > On Mon, 08 Oct 2018, Charles Keepax wrote:
> > > > > > From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > > > > > +static const struct reg_default lochnagar1_reg_defaults[] = {
> > > > > > +	{ LOCHNAGAR1_CDC_AIF1_SEL,    0x00 },
> > > > > > +	{ LOCHNAGAR1_CDC_AIF2_SEL,    0x00 },
> > > > ...
> > > > > > +	{ LOCHNAGAR1_LED1,            0x00 },
> > > > > > +	{ LOCHNAGAR1_LED2,            0x00 },
> > > > > > +	{ LOCHNAGAR1_I2C_CTRL,        0x01 },
> > > > > > +};
> > > > > 
> > > > > Why do you need to specify each register value?
> > > > 
> > > > The way regmap operates it needs to know the starting value of
> > > > each register. It will use this to initialise the cache and to
> > > > determine if writes need to actually update the hardware on
> > > > cache_syncs after devices have been powered back up.
> > 
> > That sounds crazy to me.  Some devices have thousands of registers.
> 
> Largely the point. How long do you think it would take to populate the
> cache if you had to read thousands of registers over I2C? Boot time matters.
> Deferring it until it's touched can create various unpredictable and
> annoying behaviour later, for example if a lot of cache entries are
> written while the chip is asleep and the initial values weren't known
> then a suspend/resume cannot filter out writes that are setting the
> register to its default (which regmap does to avoid unnecessary bus traffic).
> So the resume could have a large amount of unnecessary overhead writing
> registers to a value they already have or reading the initial values of
> those registers.

One more register read when initially writing to a register and one
more when resuming doesn't sound like a vast amount of over-head.

> > At a line per register, that's thousands of lines of code/cruft.
> > Especially seeing as most (sane?) register layouts I've seen default
> > to zero.
> 
> Not a valid generalization. And it's not a question of sanity, the purpose
> of the register and the overhead to setup a use-case also matter.
> There are many reasons why the default of a register might not be zero.
> Take a look at drivers/mfd/wm5110-tables.c, a lot of the registers don't
> have a default of zero (and that's only the registers accessed by the driver.)
> It's particularly true of registers that affect things like voltage and
> current sources, zero might be a very inappropriate default - even dangerous.
> Also enable bits, if some things must power-up enabled and others don't, unless
> you want a chip that has a confusing mix of inverted and non-inverted enable
> bits. Another side to this is to reduce the number of writes to enable _typical_
> behaviour - if an IP block has say 100 registers and you have to write all of
> them to make it work that's a lot of overhead compared to them defaulting to
> typical values used 99.9% of the time and you only need to write one or two
> registers to use it.

Not sure what you think I was suggesting above.  If the default values
are actually non-zero that's fine - we'll either leave them as they
are (if they are never changed, in which case Regmap doesn't even need
to know about them), document only those (non-zero) ones or wait until
they are read for the first time, then populate the cache.

Setting up the cache manually also sounds like a vector for potential
failure.  At least if you were to cache dynamically on first write
(either on start-up or after sleep) then the actual value will be
cached, rather than what a piece of C code says it should be.

>   Then default values can be changed at the leisure of the
> > s/w.
> 
> Potentially with a lot of overhead, especially on those chips with thousands
> of registers to set to useful non-zero values before you can use it.
> 
> Lochnagar doesn't have that many registers but convention and consistency also
> comes into play. Regmap is used in a particular way and it helps people a lot
> if every driver using it follows the convention.

Precisely my point.  Lochnagar is a small device yet it's required to
submit hundreds of lines of Regmap tables.  Imagine what that would
look like for a large device.

> > Even if it is absolutely critical that you have to supply these to
> > Regmap up-front, instead of on first use/read, why can't you just
> > supply the oddball non-zero ones?
> 
> If you aren't happy with the regmap subsystem you could send some
> patches to change it to what you would be happy with (and patch the ~1300
> drivers that use it)

That may well happen.  This is the pre-patch discussion.

Apologies that it had to happen on your submission, but this is that
alerted me to the issue(s).

> Like any kernel subsystem it has an API that we have to obey to be able to
> use it.

Again, this isn't about Lochnagar.

> > > > > > +static const struct reg_sequence lochnagar1_patch[] = {
> > > > > > +	{ 0x40, 0x0083 },
> > > > > > +	{ 0x46, 0x0001 },
> > > > > > +	{ 0x47, 0x0018 },
> > > > > > +	{ 0x50, 0x0000 },
> > > > > > +};
> > > > > 
> > > > > I'm really not a fan of these so call 'patches'.
> > > > > 
> > > > > Can't you set the registers up proper way?
> > > > > 
> > > > 
> > > > I will see if we could move any out of here or define any of the
> > > > registers but as we have discussed before it is not always possible.
> > > > 
> > > 
> > > Also patches generally come out of hardware tuning/qualification/tools
> > > as this list of address,value. So it's easy for people to dump an update
> > > into the driver as a trivial copy-paste but more work if they have to
> > > reverse-engineer the patch list from hardware/datasheet into what each
> > > line "means" and then find the relevant lines of code to change. It's also
> > > much easier to answer the question "Have these hardware patches been
> > > applied to the driver?" if we have them in the original documented format.
> > > It just makes people's lives more difficult if they have to search around
> > > the code to try to find something that looks like the originally specified
> > > patch list. We don't use them just as a lazy way to setup some registers.
> > 
> > I understand why they normally exist (sometimes people are just lazy
> > too) (Mark: BTW chicken-bits sound delicious!).  They're just ugly
> > from an Open Source PoV.
> 
> In my opinion a lot of the source code in Linux is much uglier than
> these tables.

Right.  I usually comment on those (when I see them) too.

Besides, just because some people committing murder, doesn't mean
other people shouldn't go to jail for stealing a car.

> > > > > > +static bool lochnagar2_readable_register(struct device *dev, unsigned int reg)
> > > > > > +{
> > > > > > +	switch (reg) {
> > > > > > +	case LOCHNAGAR_SOFTWARE_RESET:
> > > > > > +	case LOCHNAGAR_FIRMWARE_ID1:
> > > > > > +	case LOCHNAGAR_FIRMWARE_ID2:
> > > > ...
> > > > > > +	case LOCHNAGAR2_MICVDD_CTRL2:
> > > > > > +	case LOCHNAGAR2_VDDCORE_CDC_CTRL1:
> > > > > > +	case LOCHNAGAR2_VDDCORE_CDC_CTRL2:
> > > > > > +	case LOCHNAGAR2_SOUNDCARD_AIF_CTRL:
> > > > > > +		return true;
> > > > > > +	default:
> > > > > > +		return false;
> > > > > > +	}
> > > > > > +}
> > > > > > +
> > > > > > +static bool lochnagar2_volatile_register(struct device *dev, unsigned int reg)
> > > > > > +{
> > > > > > +	switch (reg) {
> > > > > > +	case LOCHNAGAR2_GPIO_CHANNEL1:
> > > > > > +	case LOCHNAGAR2_GPIO_CHANNEL2:
> > > > > > +	case LOCHNAGAR2_GPIO_CHANNEL3:
> > > > ...
> > > > > > +	case LOCHNAGAR2_GPIO_CHANNEL13:
> > > > > > +	case LOCHNAGAR2_GPIO_CHANNEL14:
> > > > > > +	case LOCHNAGAR2_GPIO_CHANNEL15:
> > > > > > +	case LOCHNAGAR2_GPIO_CHANNEL16:
> > > > > > +	case LOCHNAGAR2_ANALOGUE_PATH_CTRL1:
> > > > > > +		return true;
> > > > > > +	default:
> > > > > > +		return false;
> > > > > > +	}
> > > > > > +}
> > > > > 
> > > > > This is getting silly now.  Can't you use ranges?
> > > > 
> > > > I can if you feel strongly about it? But it does make the drivers
> > > > much more error prone and significantly more annoying to work
> > > > with. I find it is really common to be checking that a register
> > > > is handled correctly through the regmap callbacks and it is nice
> > > > to just be able to grep for that. Obviously this won't work for
> > > > all devices/regmaps as well since many will not have consecutive
> > > > addresses on registers, for example having multi-byte registers
> > > > that are byte addressed.
> > > > 
> > > > How far would you like me to take this as well? Is it just the
> > > > numeric registers you want ranges for ie.
> > > > 
> > > > LOCHNAGAR2_GPIO_CHANNEL1...LOCHNAGAR_GPIO_CHANNEL16
> > > > 
> > > > Or is it all consecutive registers even if they are unrelated
> > > > (exmaple is probably not accurate as I haven't checked the
> > > > addresses):
> > > > 
> > > > LOCHNAGAR2_GPIO_CHANNEL1...LOCHNAGAR2_ANALOGURE_PATH_CTRL1
> > > > 
> > > > I don't mind the first at all but the second is getting really
> > > > horrible in my opinion.
> > 
> > My issue is that we have one end of the scale, where contributors are
> > submitting patches, trying to remove a line of code here, a line of
> > code there, then there are patches like this one which describe the
> > initial value, readable status, writable status and volatile status of
> > each and every register.
> 
> If we could add support for new devices by removing lines of code that
> would be cool :). Eventually Linux would support every piece of hardware
> and be zero lines of code.

I'm starting to think that you've missed the point. ;)

> > The API is obscene and needs a re-work IMHO.
> > 
> > I really hope we do not really have to list every register, but *if we
> > absolutely must*, let's do it once:
> > 
> >    REG_ADDRESS, WRV, INITIAL_VALUE
> 
> To re-iterate, regmap is a standard kernel subsystem. It's not owned by Cirrus,
> so it's not our responsibility if you don't like it. Mark Brown is the maintainer.

Sounds very much like you are saying, "it's not Cirrus' fault,
therefore it is not my problem"?  Which is a terrible attitude.

Remember that the Linux kernel is an open community.  Anyone should be
free to discuss any relevant issue.  If we decide to take this
off-line, which is likely, then so be it.  In the mean time, as a
contributor to this community project, it's absolutely your
responsibly to help discuss and potentially solve wider issues than
just your lines of code.

> Submit your patches to Mark and the owners of those ~1300 drivers to propose
> changes to regmap that you would be happy with.

Quoting myself from above:

  "That may well happen.  This is the pre-patch discussion.

  Apologies that it had to happen on your submission, but this is that
  alerted me to the issue(s)."

> > > > > > +static const struct reg_default lochnagar2_reg_defaults[] = {
> > > > > > +	{ LOCHNAGAR2_CDC_AIF1_CTRL,         0x0000 },
> > > > > > +	{ LOCHNAGAR2_CDC_AIF2_CTRL,         0x0000 },
> > > > > > +	{ LOCHNAGAR2_CDC_AIF3_CTRL,         0x0000 },
> > > > > > +	{ LOCHNAGAR2_DSP_AIF1_CTRL,         0x0000 },
> > > > ...
> > > > > > +	{ LOCHNAGAR2_MINICARD_RESETS,       0x0000 },
> > > > > > +	{ LOCHNAGAR2_ANALOGUE_PATH_CTRL2,   0x0000 },
> > > > > > +	{ LOCHNAGAR2_COMMS_CTRL4,           0x0001 },
> > > > > > +	{ LOCHNAGAR2_SPDIF_CTRL,            0x0008 },
> > > > > > +	{ LOCHNAGAR2_POWER_CTRL,            0x0001 },
> > > > > > +	{ LOCHNAGAR2_SOUNDCARD_AIF_CTRL,    0x0000 },
> > > > > > +};
> > > > > 
> > > > > OMG!  Vile, vile vile!
> > > > 
> > > > I really feel this isn't the driver you are objecting to as such
> > > > but the way regmap operates and also we seem to always have the same
> > > > discussions around regmap every time we push a driver.
> > 
> > Absolutely.  I didn't like it before.  I like it even less now.
> > 
> > > > Is there
> > > > any way me, you and Mark could hash this out and find out a way to
> > > > handle regmaps that is acceptable to you? I don't suppose you are
> > > > in Edinburgh at the moment for ELCE?
> > 
> > I'm not at ELCE I'm afraid.
> > 
> > > I suppose if Mark was willing to promote the regmap drivers to be a
> > > top-level subsystem that could contain the regmap definitions of devices
> > > then we could dump our regmap definitions in there, where Mark can review
> > > it as he's familiar with regmap and the chips and the reasons why things
> > > are done the way they are, rather than Lee having to stress about it every
> > > time we need to create an MFD device that uses regmap. Though that would
> > > make the initialization of an MFD rather awkward with the code required
> > > to init the MFD it not actually being in the MFD tree.
> > 
> > My issue isn't where all this bumph lives.
> > 
> > It's the fact that it's required (at least at this level) at all.
> > 
> 
> As above, if one subsystem owner doesn't like another subsystem then those
> subsystem owners should talk to each other and sort something out. It shouldn't
> block patches that are just trying to use the subsystem as it currently exists
> in the kernel.

Again, no one is blocking this patch.

This driver was submitted for review/discussion.  We are discussing.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
