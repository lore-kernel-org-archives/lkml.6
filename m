Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078CDC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A881920835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cvh9hGvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A881920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeJLUeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:34:17 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46412 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJLUeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:34:16 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 88DE51258;
        Fri, 12 Oct 2018 15:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539349312;
        bh=3tlewyIU92RqBPLzC7uVMHA+77jhewxLtlEndzeGgyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvh9hGvhsfkfsPTW+WJ1L6X8XjUACXiqBqdG2YyIv5O0cYFCMaVGbPjIikxFLMHB9
         oxSWV4yG4Wv2yIDHgohkcrP08RAQ+PRQaqjalBU8KRxM8NXVk2J6SAiBoZY/LHgB3m
         0Y7gMzAnFmPTUoQSkojnxZ5Oe361uOdI35DlTmzE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     kieran.bingham@ideasonboard.com, Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mfd: ds90ux9xx: add TI DS90Ux9xx de-/serializer MFD driver
Date:   Fri, 12 Oct 2018 16:01:56 +0300
Message-ID: <3599186.afdMBtdL0k@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <4a807a53-1592-a895-f140-54e7acc473b3@ideasonboard.com>
References: <20181008211205.2900-1-vz@mleia.com> <506c03d7-7986-44dd-3290-92d16a8106ad@mentor.com> <4a807a53-1592-a895-f140-54e7acc473b3@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vladimir,

On Friday, 12 October 2018 14:47:52 EEST Kieran Bingham wrote:
> On 12/10/18 11:58, Vladimir Zapolskiy wrote:
> > On 10/12/2018 12:20 PM, Kieran Bingham wrote:
> >> On 12/10/18 09:39, Lee Jones wrote:
> >>> On Fri, 12 Oct 2018, Vladimir Zapolskiy wrote:
> >>>> On 10/12/2018 09:03 AM, Lee Jones wrote:
> >>>>> On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:
> >>>>>> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>>>>> 
> >>>>>> The change adds I2C device driver for TI DS90Ux9xx de-/serializers,
> >>>>>> support of subdevice controllers is done in separate drivers, because
> >>>>>> not all IC functionality may be needed in particular situations, and
> >>>>>> this can be fine grained controlled in device tree.
> >>>>>> 
> >>>>>> The development of the driver was a collaborative work, the
> >>>>>> contribution done by Balasubramani Vivekanandan includes:
> >>>>>> * original implementation of the driver based on a reference driver,
> >>>>>> * regmap powered interrupt controller support on serializers,
> >>>>>> * support of implicitly or improperly specified in device tree ICs,
> >>>>>> * support of device properties and attributes: backward compatible
> >>>>>> 
> >>>>>>   mode, low frequency operation mode, spread spectrum clock
> >>>>>>   generator.
> >>>>>> 
> >>>>>> Contribution by Steve Longerbeam:
> >>>>>> * added ds90ux9xx_read_indirect() function,
> >>>>>> * moved number of links property and added ds90ux9xx_num_fpd_links(),
> >>>>>> * moved and updated ds90ux9xx_get_link_status() function to core
> >>>>>> driver,
> >>>>>> * added fpd_link_show device attribute.
> >>>>>> 
> >>>>>> Sandeep Jain added support of pixel clock edge configuration.
> >>>>>> 
> >>>>>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>>>>> ---
> >>>>>> 
> >>>>>>  drivers/mfd/Kconfig           |  14 +
> >>>>>>  drivers/mfd/Makefile          |   1 +
> >>>>>>  drivers/mfd/ds90ux9xx-core.c  | 879 ++++++++++++++++++++++++++++++++
> >>>>>>  include/linux/mfd/ds90ux9xx.h |  42 ++
> >>>>>>  4 files changed, 936 insertions(+)
> >>>>>>  create mode 100644 drivers/mfd/ds90ux9xx-core.c
> >>>>>>  create mode 100644 include/linux/mfd/ds90ux9xx.h
> >>>>>> 
> >>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >>>>>> index 8c5dfdce4326..a969fa123f64 100644
> >>>>>> --- a/drivers/mfd/Kconfig
> >>>>>> +++ b/drivers/mfd/Kconfig
> >>>>>> @@ -1280,6 +1280,20 @@ config MFD_DM355EVM_MSP
> >>>>>> 
> >>>>>>  	  boards.  MSP430 firmware manages resets and power sequencing,
> >>>>>>  	  inputs from buttons and the IR remote, LEDs, an RTC, and more.
> >>>>>> 
> >>>>>> +config MFD_DS90UX9XX
> >>>>>> +	tristate "TI DS90Ux9xx FPD-Link de-/serializer driver"
> >>>>>> +	depends on I2C && OF
> >>>>>> +	select MFD_CORE
> >>>>>> +	select REGMAP_I2C
> >>>>>> +	help
> >>>>>> +	  Say yes here to enable support for TI DS90UX9XX de-/serializer
> >>>>>> ICs.
> >>>>>> +
> >>>>>> +	  This driver provides basic support for setting up the
> >>>>>> de-/serializer
> >>>>>> +	  chips. Additional functionalities like connection handling to
> >>>>>> +	  remote de-/serializers, I2C bridging, pin multiplexing, GPIO
> >>>>>> +	  controller and so on are provided by separate drivers and should
> >>>>>> +	  enabled individually.
> >>>>> 
> >>>>> This is not an MFD driver.
> >>>> 
> >>>> Why do you think so? The representation of the ICs into device tree
> >>>> format of hardware description shows that this is a truly MFD driver
> >>>> with multiple IP subcomponents naturally mapped into MFD cells.
> >>> 
> >>> This driver does too much real work ('stuff') to be an MFD driver.
> >>> MFD drivers should not need to care of; links, gates, modes, pixels,
> >>> frequencies maps or properties.  Nor should they contain elaborate
> >>> sysfs structures to control the aforementioned 'stuff'.
> >>> 
> >>> Granted, there may be some code in there which could be appropriate
> >>> for an MFD driver.  However most of it needs moving out into a
> >>> function driver (or two).
> >>> 
> >>>> Basically it is possible to replace explicit of_platform_populate() by
> >>>> adding a "simple-mfd" compatible, if it is desired.
> >>>> 
> >>>>> After a 30 second Google of what this device actually does, perhaps
> >>>>> drivers/media might be a better fit?
> >>>> 
> >>>> I assume it would be quite unusual to add a driver with NO media
> >>>> functions and controls into drivers/media.
> >>> 
> >>> drivers/media may very well not be the correct place for this.  In my
> >>> 30 second Google, I saw that this device has a lot to do with cameras,
> >>> hence my media association.
> >>> 
> >>> If *all* else fails, there is always drivers/misc, but this should be
> >>> avoided if at all possible.
> >> 
> >> The device as a whole is FPD Link for camera devices I believe, but it
> > 
> > I still don't understand (I could be biased though) why there is such
> > a strong emphasis on cameras and media stuff in the discussion.
> > 
> > No, "the device as a whole is FPD Link for camera devices" is a wrong
> > statement. On hand I have a number of boards with
> > serializers/deserializers from the TI DS90Ux9xx IC series and sensors are
> > NOT connected to them.

I understand what is not connected to them, but could you tell us what is 
connected then ? :-)

> Yes - My apologies, this is a good point.
> 
> Especially as the clue is in the name "Flat Panel Display".
> I have been stuck with my GMSL hat on for too long.
> 
> Even GMSL is in the same boat. It's just that 'we' are using GMSL for
> cameras, but it can be used equally for displays and data.
> 
> These devices are serialiser-deserialiser pairs with power and control
> paths.

And data paths, that are designed to transport video (and audio in this case). 
The devices are thus media-focussed, although in a broader sense than drivers/
media/

> Essentially they are multi purpose buses - which do not yet have a home.
> We have used media as a home because of our use case.
> 
> The use case whether they transfer frames from a camera or to a display
> are of course closely related, but ultimately covered by two separate
> subsystems at the pixel level (DRM vs V4L, or other for other data)
> 
> Perhaps as they are buses - on a level with USB or I2C (except they can
> of course carry I2C or Serial as well as 'bi-directional video' etc ),
> they are looking for their own subsystem.
> 
> Except I don't think we don't want to add a new subsystem for just one
> (or two) devices...

I'm not sure a new subsystem is needed. As you've noted there's an overlap 
between drivers/media/ and drivers/gpu/drm/ in terms of supported hardware. We 
even have a devices supported by two drivers, one in drivers/media/ and one in 
drivers/gpu/drm/ (I'm thinking about the adv7511 in particular). This is a 
well known issue, and so far nothing has been done in mainline to try and 
solve it.

Trying to find another home in drivers/mfd/ to escape from the problem isn't a 
good solution in my opinion. The best option from a Linux point of view would 
be to unify V4L2 and DRM/KMS when it comes to bridge support, but that's a 
long way down the road (I won't complain if you want to give it a go though 
:-)). As your use cases are display, focused, I would propose to start with 
drivers/gpu/drm/bridge/, and leave the problem of camera support for first 
person who will have such a use case.

> >> certainly has different functions which are broken out in this
> >> implementation.
> > 
> > No, there is absolutely nothing broken out from the presented MFD drivers,
> > the drivers are completely integral and basically I don't expect any.
> > 
> > If you are concerned about media functionality, the correspondent MFD
> > *cell* drivers will be added into drivers/media, drivers/gpu/drm or
> > whatever is to be a proper place.
> > 
> >> I think it might be quite awkward having the i2c components in
> >> drivers/i2c and the media components in drivers/media/i2c, so what about
> >> creating drivers/media/i2c/fpd-link (or such) as a container?
> > 
> > I open drivers/media/i2c/Kconfig and all entries with no exception are
> > under from 'if VIDEO_V4L2'. The MFD drivers do NOT require on depend on
> > VIDEO_V4L2 or any other multimedia frameworks, nor the MFD drivers export
> > any multimedia controls.
> > 
> >> Our GMSL implementation is also a complex camera(s) device - but does
> >> not yet use the MFD framework, perhaps that's something to add to my
> >> todo list.

Nope, please don't :-) The GMSL (de)serializers are no MFD devices either.

> > Okay, but the TI DS90Ux9xx is NOT a camera device, and it is NOT a
> > multimedia device, but it is a pure MFD device so the argument is not
> > applicable.

For the reasons pointed out in the review of other patches, and also pointed 
out by Lee in his review of this patch, I disagree with that. This isn't an 
MFD device.

> >> We currently keep all of the complexity within the max9286.c driver, but
> >> I could foresee that being split further if more devices add to the
> >> complexity of managing the bus. At which point we might want an
> >> equivalent drivers/media/i2c/gmsl/ perhaps?
> >> 
> >>>> Laurent, can you please share your opinion?

Done :-)

I'd like to mention that I would prefer focusing on the DT bindings first, and 
then move to the driver side. In that area I would like to have a full example 
of a system using these chips, as the "initial support" is too limited for a 
proper review. This won't come as a surprise, but I will expect the OF graph 
bindings to be used to model data connections.

-- 
Regards,

Laurent Pinchart



