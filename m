Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAE9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E205520841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E205520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbeGaQLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:11:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40386 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732231AbeGaQLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:11:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A397A20799; Tue, 31 Jul 2018 16:30:58 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7107020731;
        Tue, 31 Jul 2018 16:30:58 +0200 (CEST)
Date:   Tue, 31 Jul 2018 16:30:59 +0200
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
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v2 1/6] i2c: designware: use generic table matching
Message-ID: <20180731143059.GV28585@piout.net>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
 <20180731134740.441-2-alexandre.belloni@bootlin.com>
 <44e52856371e4b5c102df8f2efebd527fd26b066.camel@linux.intel.com>
 <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2018 17:23:04+0300, Andy Shevchenko wrote:
> On Tue, 2018-07-31 at 17:02 +0300, Andy Shevchenko wrote:
> > On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
> > > Switch to device_get_match_data in probe to match the device
> > > specific
> > > data
> > > instead of using the acpi specific function.
> > > 
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Oops. See below.
> 
> > > -	id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> > > &pdev->dev);
> > > -	if (id && id->driver_data)
> > > -		dev->flags |= (u32)id->driver_data;
> 
> It seems you forgot to remove unused variable.
> 
> > > -
> > >  	if (acpi_bus_get_device(handle, &adev))
> > >  		return -ENODEV;
> > >  
> > > @@ -269,6 +265,8 @@ static int dw_i2c_plat_probe(struct
> > > platform_device *pdev)
> > >  	else
> > >  		i2c_parse_fw_timings(&pdev->dev, t, false);
> > >  
> > > +	dev->flags |= (u32)device_get_match_data(&pdev->dev);
> > > +
> 
> And since it would be changed anyway, can you actually move this line
> closet to  if (has_acpi_companion()) one ?
> 

I need that value to be set before calling of_configure though.

> > >  	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
> > >  	/*
> > >  	 * Some DSTDs use a non standard speed, round down to the
> > > lowest
> > 
> > 
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
