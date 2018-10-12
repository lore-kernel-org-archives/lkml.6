Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B58C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841E52087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRNN6xNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841E52087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeJLQKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:10:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39695 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeJLQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:10:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id y144-v6so12030540wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AgWpzDDXUaZ6/qSSjDNWz4BAsSkxVzb6198yDH5/c2o=;
        b=PRNN6xNjgHm7bXt77VPO+HBWIwGsdEKRSx1mb4C8RqPN7oUJUZUEjiFfkkYdx4H4B7
         MOr8jkCgMAcp+DRcemUR+w7sU/nWaOOaYkc65/xmGg+xNhtvgee067p7aloBQIpXfNAI
         ETCw5B6oOkMvvn5kJAnZqqUjcsLwZChCC7Hxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AgWpzDDXUaZ6/qSSjDNWz4BAsSkxVzb6198yDH5/c2o=;
        b=fAKbRtAJ/OtQg9+TL4lhCg9/0SFBaiARmFXVrPB+hhYQTYfkQDanebjyBJcWV+FYNX
         rvlYbvXKTe29fsmKuXfF4Q4wXlLuJTVh/UxZZNPxtEApcldyT87GzqT0jVrZGXu7nTwB
         8vmNDaZZemzZw1wMwQRsKk1fEyk4d1YiOUPP3NS1FNB1IE4FoSHqK1AsvqbfMrV5LRvO
         /0aBIssfGOZi+EHeEtjYNisDYHNr8/LPkrOC0JHUcUKk96MevjXW0o79ASBpauo8wsn4
         i6rgMiSW+BI4M7Vr0HBf68oSJL/RzgJj6rkPsWFYbqq28SUZEx8QcENec6lHP7axgLZb
         0/DQ==
X-Gm-Message-State: ABuFfoiMx0Vr9+knyC+VjxM1AQwMnUY7dx9+N/PdYB7tUqekCHE685wC
        U4T5071Pb3xLpXDnmtg7qX5aaw==
X-Google-Smtp-Source: ACcGV6254v+/be0hL6eYpI7FEWq3a63KTTbzyAdojqAEmAYVppnN89KNh1+dXPvLXboXa4hFU7qPQA==
X-Received: by 2002:a1c:1d6:: with SMTP id 205-v6mr4550950wmb.0.1539333566963;
        Fri, 12 Oct 2018 01:39:26 -0700 (PDT)
Received: from dell ([2.27.167.33])
        by smtp.gmail.com with ESMTPSA id y3sm418201wrw.11.2018.10.12.01.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 01:39:26 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:39:24 +0100
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
Message-ID: <20181012083924.GW4939@dell>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-5-vz@mleia.com>
 <20181012060314.GU4939@dell>
 <63733d2e-f95e-8894-f2b0-0b551b5cfeeb@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63733d2e-f95e-8894-f2b0-0b551b5cfeeb@mentor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, Vladimir Zapolskiy wrote:
> On 10/12/2018 09:03 AM, Lee Jones wrote:
> > On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:
> > 
> >> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>
> >> The change adds I2C device driver for TI DS90Ux9xx de-/serializers,
> >> support of subdevice controllers is done in separate drivers, because
> >> not all IC functionality may be needed in particular situations, and
> >> this can be fine grained controlled in device tree.
> >>
> >> The development of the driver was a collaborative work, the
> >> contribution done by Balasubramani Vivekanandan includes:
> >> * original implementation of the driver based on a reference driver,
> >> * regmap powered interrupt controller support on serializers,
> >> * support of implicitly or improperly specified in device tree ICs,
> >> * support of device properties and attributes: backward compatible
> >>   mode, low frequency operation mode, spread spectrum clock generator.
> >>
> >> Contribution by Steve Longerbeam:
> >> * added ds90ux9xx_read_indirect() function,
> >> * moved number of links property and added ds90ux9xx_num_fpd_links(),
> >> * moved and updated ds90ux9xx_get_link_status() function to core driver,
> >> * added fpd_link_show device attribute.
> >>
> >> Sandeep Jain added support of pixel clock edge configuration.
> >>
> >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> ---
> >>  drivers/mfd/Kconfig           |  14 +
> >>  drivers/mfd/Makefile          |   1 +
> >>  drivers/mfd/ds90ux9xx-core.c  | 879 ++++++++++++++++++++++++++++++++++
> >>  include/linux/mfd/ds90ux9xx.h |  42 ++
> >>  4 files changed, 936 insertions(+)
> >>  create mode 100644 drivers/mfd/ds90ux9xx-core.c
> >>  create mode 100644 include/linux/mfd/ds90ux9xx.h
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index 8c5dfdce4326..a969fa123f64 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -1280,6 +1280,20 @@ config MFD_DM355EVM_MSP
> >>  	  boards.  MSP430 firmware manages resets and power sequencing,
> >>  	  inputs from buttons and the IR remote, LEDs, an RTC, and more.
> >>  
> >> +config MFD_DS90UX9XX
> >> +	tristate "TI DS90Ux9xx FPD-Link de-/serializer driver"
> >> +	depends on I2C && OF
> >> +	select MFD_CORE
> >> +	select REGMAP_I2C
> >> +	help
> >> +	  Say yes here to enable support for TI DS90UX9XX de-/serializer ICs.
> >> +
> >> +	  This driver provides basic support for setting up the de-/serializer
> >> +	  chips. Additional functionalities like connection handling to
> >> +	  remote de-/serializers, I2C bridging, pin multiplexing, GPIO
> >> +	  controller and so on are provided by separate drivers and should
> >> +	  enabled individually.
> > 
> > This is not an MFD driver.
> 
> Why do you think so? The representation of the ICs into device tree format
> of hardware description shows that this is a truly MFD driver with multiple
> IP subcomponents naturally mapped into MFD cells.

This driver does too much real work ('stuff') to be an MFD driver.
MFD drivers should not need to care of; links, gates, modes, pixels,
frequencies maps or properties.  Nor should they contain elaborate
sysfs structures to control the aforementioned 'stuff'.

Granted, there may be some code in there which could be appropriate
for an MFD driver.  However most of it needs moving out into a
function driver (or two).

> Basically it is possible to replace explicit of_platform_populate() by
> adding a "simple-mfd" compatible, if it is desired.
> 
> > After a 30 second Google of what this device actually does, perhaps
> > drivers/media might be a better fit?
> 
> I assume it would be quite unusual to add a driver with NO media functions
> and controls into drivers/media.

drivers/media may very well not be the correct place for this.  In my
30 second Google, I saw that this device has a lot to do with cameras,
hence my media association.

If *all* else fails, there is always drivers/misc, but this should be
avoided if at all possible.

> Laurent, can you please share your opinion?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
