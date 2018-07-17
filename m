Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4695CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD86204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD86204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbeGQNNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:13:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38605 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731256AbeGQNNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:13:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4B0A9206F6; Tue, 17 Jul 2018 14:41:03 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1A547206F3;
        Tue, 17 Jul 2018 14:40:53 +0200 (CEST)
Date:   Tue, 17 Jul 2018 14:40:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/5] i2c: designware: add MSCC Ocelot support
Message-ID: <20180717124053.GB23935@piout.net>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
 <20180717114837.21839-4-alexandre.belloni@bootlin.com>
 <d64fc362be63bb8540447f7df2c232eedd696edb.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d64fc362be63bb8540447f7df2c232eedd696edb.camel@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2018 15:19:08+0300, Andy Shevchenko wrote:
> On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> > The Microsemi Ocelot I2C controller is a designware IP. It also has a
> > second set of registers to allow tweaking SDA hold time and spike
> > filtering.
> 
> Can you elaborate a bit?
> 
> Are they platform specific? Are they shadow registers? Are they
> something else? Datasheet link / excerpt would be also good to read.
>  
> >  Optional properties :
> > + - reg : for "mscc,ocelot-i2c", a second register set to configure
> > the SDA hold
> > +   time, named ICPU_CFG:TWI_DELAY in the datasheet.
> > +
> 
> Hmm... Is this registers unique to the SoC in question? Is address of
> them fixed or may be configured on RTL level?
> 
> If former is right, why do we need a separate property?
> 

Those are registers from the SoC, their position varies depending on
the SoC.

Even if the position was fixed, I'm pretty sure another register set is
needed. It is not a new property.

> >  
> > +#define MSCC_ICPU_CFG_TWI_DELAY		0x0
> > +#define MSCC_ICPU_CFG_TWI_DELAY_ENABLE	BIT(0)
> > +#define MSCC_ICPU_CFG_TWI_SPIKE_FILTER	0x4
> > +
> > +static int mscc_twi_set_sda_hold_time(struct dw_i2c_dev *dev)
> > +{
> > +	writel((dev->sda_hold_time << 1) |
> > MSCC_ICPU_CFG_TWI_DELAY_ENABLE,
> > +	       dev->base_ext + MSCC_ICPU_CFG_TWI_DELAY);
> > +
> > +	return 0;
> > +}
> 
> Hmm... And does how this make native DesignWare IP's registers obsolete?
> 

DW_IC_SDA_HOLD doesn't exist in this version of the IP. It is replaced
by this SoC specific register.

> 
> > +	if (of_device_is_compatible(pdev->dev.of_node, "mscc,ocelot-
> > i2c"))
> 
> Can't you just ask for this unconditionally? Why not?
> (It seems I might have known why not, but can we use named resource
> instead in case this is not so SoC specific)
> 

It is SoC specific.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
