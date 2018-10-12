Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2D4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6FC2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUxtikQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6FC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeJLTGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:06:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35630 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeJLTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:06:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so13074790wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MD8jO95YCTgIzOVzNXt8bi2JC1/tTEaPuYUsfgMZWIM=;
        b=UUxtikQzXEhIf4HJlhumR2JU5RHU3shP9OhiWq1CDjar+WMilNZIZFEbFJNVNeVC3k
         XfE60B8L0+f6juWT3BarPVuLonE3lKKAUYjqJOqtVCHsR9Mvir3JzEmIMrYbAiDpDZpY
         IZzFb3GkEXh2xGTGGGx2umKzp5e/IEBY1ciSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MD8jO95YCTgIzOVzNXt8bi2JC1/tTEaPuYUsfgMZWIM=;
        b=hw9ODIIcB8zD8Th8zliKz8tpt3tFqSrh91eybObGN0znVMpR7W1AdminE2hiUGrruZ
         Zjgfo2qc5BoRsoeBM5nEvOETCAKaMRBHpS7TwhFGxM8exIrkBKwcQVX3mxF4vXpPAlXi
         PApwwhwpMUZJ0Ww6bHunmJniPYO5eYTIpqTpvMOfEZivAfbsJSO3bmrApS5RHP9aSYdq
         Z7q4/q2pCVqIq3v9j5rQfhvlzcQXOtUDUED6K+hf2f0EZNcoN4JiJY5XVb4GjXn11MZM
         nBjSED8kc+thkF3qim9kuZf3AfgC4Qd63m7dQa9fBMDcrrlXB8dMQqFuKyIWusbgBRLF
         whAQ==
X-Gm-Message-State: ABuFfohnrP5HMOb3aNUexOb6yrlAcq5RIRdYk9dUl1uIw0molJJwf+Pk
        MMSswwBQGgeF0wqxeS65O2LHYQ==
X-Google-Smtp-Source: ACcGV63BHIuqx8x6ohezgGqwRkuAjjA6BcOWIcwF7OOETZoCTVYNbX/rvECHVPlf+bxJTMZpM65THA==
X-Received: by 2002:adf:9d26:: with SMTP id k38-v6mr5317752wre.18.1539344059213;
        Fri, 12 Oct 2018 04:34:19 -0700 (PDT)
Received: from dell ([2.27.167.33])
        by smtp.gmail.com with ESMTPSA id a11-v6sm758151wrp.3.2018.10.12.04.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:34:18 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:34:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     kieran.bingham@ideasonboard.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mfd: ds90ux9xx: add TI DS90Ux9xx de-/serializer MFD
 driver
Message-ID: <20181012113415.GZ4939@dell>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-5-vz@mleia.com>
 <20181012060314.GU4939@dell>
 <63733d2e-f95e-8894-f2b0-0b551b5cfeeb@mentor.com>
 <20181012083924.GW4939@dell>
 <eef99526-9232-8cd4-9a7c-c30114d58806@ideasonboard.com>
 <506c03d7-7986-44dd-3290-92d16a8106ad@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <506c03d7-7986-44dd-3290-92d16a8106ad@mentor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, Vladimir Zapolskiy wrote:
> On 10/12/2018 12:20 PM, Kieran Bingham wrote:
> > Hi Vladimir,
> > On 12/10/18 09:39, Lee Jones wrote:
> >> On Fri, 12 Oct 2018, Vladimir Zapolskiy wrote:
> >>> On 10/12/2018 09:03 AM, Lee Jones wrote:
> >>>> On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:
> >>>>
> >>>>> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>>>>
> >>>>> The change adds I2C device driver for TI DS90Ux9xx de-/serializers,
> >>>>> support of subdevice controllers is done in separate drivers, because
> >>>>> not all IC functionality may be needed in particular situations, and
> >>>>> this can be fine grained controlled in device tree.
> >>>>>
> >>>>> The development of the driver was a collaborative work, the
> >>>>> contribution done by Balasubramani Vivekanandan includes:
> >>>>> * original implementation of the driver based on a reference driver,
> >>>>> * regmap powered interrupt controller support on serializers,
> >>>>> * support of implicitly or improperly specified in device tree ICs,
> >>>>> * support of device properties and attributes: backward compatible
> >>>>>   mode, low frequency operation mode, spread spectrum clock generator.
> >>>>>
> >>>>> Contribution by Steve Longerbeam:
> >>>>> * added ds90ux9xx_read_indirect() function,
> >>>>> * moved number of links property and added ds90ux9xx_num_fpd_links(),
> >>>>> * moved and updated ds90ux9xx_get_link_status() function to core driver,
> >>>>> * added fpd_link_show device attribute.
> >>>>>
> >>>>> Sandeep Jain added support of pixel clock edge configuration.
> >>>>>
> >>>>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>>>> ---
> >>>>>  drivers/mfd/Kconfig           |  14 +
> >>>>>  drivers/mfd/Makefile          |   1 +
> >>>>>  drivers/mfd/ds90ux9xx-core.c  | 879 ++++++++++++++++++++++++++++++++++
> >>>>>  include/linux/mfd/ds90ux9xx.h |  42 ++
> >>>>>  4 files changed, 936 insertions(+)
> >>>>>  create mode 100644 drivers/mfd/ds90ux9xx-core.c
> >>>>>  create mode 100644 include/linux/mfd/ds90ux9xx.h
> >>>>>
> >>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >>>>> index 8c5dfdce4326..a969fa123f64 100644
> >>>>> --- a/drivers/mfd/Kconfig
> >>>>> +++ b/drivers/mfd/Kconfig
> >>>>> @@ -1280,6 +1280,20 @@ config MFD_DM355EVM_MSP
> >>>>>  	  boards.  MSP430 firmware manages resets and power sequencing,
> >>>>>  	  inputs from buttons and the IR remote, LEDs, an RTC, and more.
> >>>>>  
> >>>>> +config MFD_DS90UX9XX
> >>>>> +	tristate "TI DS90Ux9xx FPD-Link de-/serializer driver"
> >>>>> +	depends on I2C && OF
> >>>>> +	select MFD_CORE
> >>>>> +	select REGMAP_I2C
> >>>>> +	help
> >>>>> +	  Say yes here to enable support for TI DS90UX9XX de-/serializer ICs.
> >>>>> +
> >>>>> +	  This driver provides basic support for setting up the de-/serializer
> >>>>> +	  chips. Additional functionalities like connection handling to
> >>>>> +	  remote de-/serializers, I2C bridging, pin multiplexing, GPIO
> >>>>> +	  controller and so on are provided by separate drivers and should
> >>>>> +	  enabled individually.
> >>>>
> >>>> This is not an MFD driver.
> >>>
> >>> Why do you think so? The representation of the ICs into device tree format
> >>> of hardware description shows that this is a truly MFD driver with multiple
> >>> IP subcomponents naturally mapped into MFD cells.
> >>
> >> This driver does too much real work ('stuff') to be an MFD driver.
> >> MFD drivers should not need to care of; links, gates, modes, pixels,
> >> frequencies maps or properties.  Nor should they contain elaborate
> >> sysfs structures to control the aforementioned 'stuff'.
> >>
> >> Granted, there may be some code in there which could be appropriate
> >> for an MFD driver.  However most of it needs moving out into a
> >> function driver (or two).
> >>
> >>> Basically it is possible to replace explicit of_platform_populate() by
> >>> adding a "simple-mfd" compatible, if it is desired.
> >>>
> >>>> After a 30 second Google of what this device actually does, perhaps
> >>>> drivers/media might be a better fit?
> >>>
> >>> I assume it would be quite unusual to add a driver with NO media functions
> >>> and controls into drivers/media.
> >>
> >> drivers/media may very well not be the correct place for this.  In my
> >> 30 second Google, I saw that this device has a lot to do with cameras,
> >> hence my media association.
> >>
> >> If *all* else fails, there is always drivers/misc, but this should be
> >> avoided if at all possible.
> > 
> > The device as a whole is FPD Link for camera devices I believe, but it
> 
> I still don't understand (I could be biased though) why there is such
> a strong emphasis on cameras and media stuff in the discussion.
> 
> No, "the device as a whole is FPD Link for camera devices" is a wrong
> statement. On hand I have a number of boards with serializers/deserializers
> from the TI DS90Ux9xx IC series and sensors are NOT connected to them.
> 
> > certainly has different functions which are broken out in this
> > implementation.
> 
> No, there is absolutely nothing broken out from the presented MFD drivers,
> the drivers are completely integral and basically I don't expect any.
> 
> If you are concerned about media functionality, the correspondent MFD
> *cell* drivers will be added into drivers/media, drivers/gpu/drm or
> whatever is to be a proper place.
> 
> > I think it might be quite awkward having the i2c components in
> > drivers/i2c and the media components in drivers/media/i2c, so what about
> > creating drivers/media/i2c/fpd-link (or such) as a container?
> 
> I open drivers/media/i2c/Kconfig and all entries with no exception are
> under from 'if VIDEO_V4L2'. The MFD drivers do NOT require on depend on
> VIDEO_V4L2 or any other multimedia frameworks, nor the MFD drivers export
> any multimedia controls.
> 
> > Our GMSL implementation is also a complex camera(s) device - but does
> > not yet use the MFD framework, perhaps that's something to add to my
> > todo list.
> > 
> 
> Okay, but the TI DS90Ux9xx is NOT a camera device, and it is NOT a multimedia
> device, but it is a pure MFD device so the argument is not applicable.

You keep saying that "this is an MFD device" without any obvious
comprehension of what an MFD is.  Just saying that it is one
over-and-over does not make it so.

An MFD should be little more than parent to other functional devices.
Their role is to register children which in turn conduct operations
on the hardware in a useful way.  Some MFDs also house common functions
to save repetition of code in each of the child devices.  They do not
tend to offer any useful functionality (stuff) in their own right. 

As I already mentioned, you need to figure out what this device is
and move all of the functionality into the appropriate subsystem.
Since an MFD isn't a real thing/device (it's a Linuxy-shim which 
only serves to register sub-devices and (sometimes) provide a space
for common functionality to be located), drivers/mfd is not the
subsystem which you seek. 

> > We currently keep all of the complexity within the max9286.c driver, but
> > I could foresee that being split further if more devices add to the
> > complexity of managing the bus. At which point we might want an
> > equivalent drivers/media/i2c/gmsl/ perhaps?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
