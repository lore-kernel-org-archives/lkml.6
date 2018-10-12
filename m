Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291D2C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D549720868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsQoIKI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D549720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeJLTPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:15:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbeJLTPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:15:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so13087137wrt.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OmikCrd9BvI0KAfudmKrn9gsVglSyuOuhdhDlsfpWRg=;
        b=IsQoIKI3+TYuYV/+P3+cIIVhIYMZX91rNvaOv2oSVflGHxO4bCWWOVMU3lCK3YnVz9
         ZmG8kLOEhbWKs0nh+loxbGGkMwl+zwqYRCgWCad5nlnSFVRZfKgZnmeIz8uiX93F8JUs
         8xmstre1yT7n/UohzsM26oNdRyCx9lG8eADHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OmikCrd9BvI0KAfudmKrn9gsVglSyuOuhdhDlsfpWRg=;
        b=XJYvumsYuLYZ0MLY10LEDRFERUHJFA+YS9RmZY5d5jeFtxBCVf+8NY0XbERzOHyMtY
         gbLnYJopqgiUAw0fPICsiL64KK72ytbgz1jDSuxdLU2Ui6fv23v2289u4scCCHQVSL+j
         +Jdzi+fYAxB0/cRDytqY5+5TxbVdMqAYMVq89+SLhJBhzbPZz4kbZFqfNCHjdLEbCSbt
         zBETJqm2rfX7lSfm/6AzdBC37yc63AuXeJX6/geUfEQPalp4h+Q20us7c895UJt+xO6V
         lHKR2plpmWTW/T0IqMs5sh7PywOHPTqw5USENWvvw7fRLkNRriNVOLTPoRH+biSHNX6N
         t4hw==
X-Gm-Message-State: ABuFfojm4MGjIZi8qzbNFn4+B3ZbEXF/Lxh1WMiB19F6YWD2DQUdSH3l
        +1ICwgstOjl9YBykQEByvHZzKw==
X-Google-Smtp-Source: ACcGV63ZGIgc91lFwSTPKQQ8WyjPnwRYcsmKDIi4W0G+jBjNrp9i56uCKyoZGrzvORiAGJps/jSzCw==
X-Received: by 2002:adf:f248:: with SMTP id b8-v6mr4660754wrp.184.1539344604867;
        Fri, 12 Oct 2018 04:43:24 -0700 (PDT)
Received: from dell ([2.27.167.33])
        by smtp.gmail.com with ESMTPSA id z12-v6sm723291wrv.46.2018.10.12.04.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:43:23 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:43:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mfd: ds90ux9xx: add TI DS90Ux9xx de-/serializer MFD
 driver
Message-ID: <20181012114321.GA4939@dell>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-5-vz@mleia.com>
 <20181012060314.GU4939@dell>
 <63733d2e-f95e-8894-f2b0-0b551b5cfeeb@mentor.com>
 <20181012083924.GW4939@dell>
 <3b22c550-0cba-60d7-a8ed-400265c8a9f6@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b22c550-0cba-60d7-a8ed-400265c8a9f6@mentor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, Vladimir Zapolskiy wrote:

> On 10/12/2018 11:39 AM, Lee Jones wrote:
> > On Fri, 12 Oct 2018, Vladimir Zapolskiy wrote:
> >> On 10/12/2018 09:03 AM, Lee Jones wrote:
> >>> On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:
> >>>
> >>>> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>>>
> >>>> The change adds I2C device driver for TI DS90Ux9xx de-/serializers,
> >>>> support of subdevice controllers is done in separate drivers, because
> >>>> not all IC functionality may be needed in particular situations, and
> >>>> this can be fine grained controlled in device tree.
> >>>>
> >>>> The development of the driver was a collaborative work, the
> >>>> contribution done by Balasubramani Vivekanandan includes:
> >>>> * original implementation of the driver based on a reference driver,
> >>>> * regmap powered interrupt controller support on serializers,
> >>>> * support of implicitly or improperly specified in device tree ICs,
> >>>> * support of device properties and attributes: backward compatible
> >>>>   mode, low frequency operation mode, spread spectrum clock generator.
> >>>>
> >>>> Contribution by Steve Longerbeam:
> >>>> * added ds90ux9xx_read_indirect() function,
> >>>> * moved number of links property and added ds90ux9xx_num_fpd_links(),
> >>>> * moved and updated ds90ux9xx_get_link_status() function to core driver,
> >>>> * added fpd_link_show device attribute.
> >>>>
> >>>> Sandeep Jain added support of pixel clock edge configuration.
> >>>>
> >>>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>>> ---
> >>>>  drivers/mfd/Kconfig           |  14 +
> >>>>  drivers/mfd/Makefile          |   1 +
> >>>>  drivers/mfd/ds90ux9xx-core.c  | 879 ++++++++++++++++++++++++++++++++++
> >>>>  include/linux/mfd/ds90ux9xx.h |  42 ++
> >>>>  4 files changed, 936 insertions(+)
> >>>>  create mode 100644 drivers/mfd/ds90ux9xx-core.c
> >>>>  create mode 100644 include/linux/mfd/ds90ux9xx.h
> >>>>
> >>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >>>> index 8c5dfdce4326..a969fa123f64 100644
> >>>> --- a/drivers/mfd/Kconfig
> >>>> +++ b/drivers/mfd/Kconfig
> >>>> @@ -1280,6 +1280,20 @@ config MFD_DM355EVM_MSP
> >>>>  	  boards.  MSP430 firmware manages resets and power sequencing,
> >>>>  	  inputs from buttons and the IR remote, LEDs, an RTC, and more.
> >>>>  
> >>>> +config MFD_DS90UX9XX
> >>>> +	tristate "TI DS90Ux9xx FPD-Link de-/serializer driver"
> >>>> +	depends on I2C && OF
> >>>> +	select MFD_CORE
> >>>> +	select REGMAP_I2C
> >>>> +	help
> >>>> +	  Say yes here to enable support for TI DS90UX9XX de-/serializer ICs.
> >>>> +
> >>>> +	  This driver provides basic support for setting up the de-/serializer
> >>>> +	  chips. Additional functionalities like connection handling to
> >>>> +	  remote de-/serializers, I2C bridging, pin multiplexing, GPIO
> >>>> +	  controller and so on are provided by separate drivers and should
> >>>> +	  enabled individually.
> >>>
> >>> This is not an MFD driver.
> >>
> >> Why do you think so? The representation of the ICs into device tree format
> >> of hardware description shows that this is a truly MFD driver with multiple
> >> IP subcomponents naturally mapped into MFD cells.
> > 
> > This driver does too much real work ('stuff') to be an MFD driver.
> > MFD drivers should not need to care of; links, gates, modes, pixels,
> > frequencies maps or properties.  Nor should they contain elaborate
> > sysfs structures to control the aforementioned 'stuff'.
> > 
> 
> What is the reason why device drivers for sort of multimedia ICs like
> WL1273, WM8994 and other numerous codecs are found in drivers/mfd?
> 
> If the same reason can not be applied to this DS90Ux9xx driver, why?
> 
> > Granted, there may be some code in there which could be appropriate
> > for an MFD driver.  However most of it needs moving out into a
> > function driver (or two).
> > 
> >> Basically it is possible to replace explicit of_platform_populate() by
> >> adding a "simple-mfd" compatible, if it is desired.
> >>
> >>> After a 30 second Google of what this device actually does, perhaps
> >>> drivers/media might be a better fit?
> >>
> >> I assume it would be quite unusual to add a driver with NO media functions
> >> and controls into drivers/media.
> > 
> > drivers/media may very well not be the correct place for this.  In my
> > 30 second Google, I saw that this device has a lot to do with cameras,
> > hence my media association.
> 
> Well, the argument is similar to the statement that Google says that
> camera sensors *can* be connected to NXP i.MX6 SoC, thus arch/arm/mach-imx
> contents should be placed into drivers/media
> 
> A few TI DS90Ux9xx *cell* drivers may be added to drivers/media, but it is
> out of the scope of the current series, which is completely integral per se,
> and actually the cover letter says that the series of drivers immediately
> allows to output video over DRM to panels, but the discussion is around
> sensors by some reason. But I hope it won't be seen as a misleading
> reason to consider to add the MFD driver into drivers/gpu/drm

This discussion isn't about not adding enough child devices.  It's
about there being too much functional work being done in an MFD
driver, where it doesn't belong.

> > If *all* else fails, there is always drivers/misc, but this should be
> > avoided if at all possible.
> 
> drivers/misc does not sound like a proper place for the MFD driver...

I'd agree with you if this were an MFD driver.

As I mentioned before, there may well be an argument for and MFD
driver to be part of this driver-set.  However it needs to be
significantly reduced with any functional code removed and placed
where it belongs.

> >> Laurent, can you please share your opinion?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
