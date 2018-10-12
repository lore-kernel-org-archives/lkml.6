Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6665EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1874D2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WYyah4o3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1874D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJLTGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:06:51 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45278 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJLTGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:06:51 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 305061258;
        Fri, 12 Oct 2018 13:34:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539344088;
        bh=3C/u+Zpm2wTbtyyjls7bWYAk0HoTi2tU4gegRzAp5nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYyah4o3wra6uovymc+NZ6iGx7FceMyLPS/kfDEPX4CAUUXS6UL1zBSPvJkwZqCb4
         J9nfd/UWqnU/LDJM4J3ZgJH2Kvdnb/soKtCE+7YdWCIG6TUQnrra2HozFV5tnTCjGI
         Sgu7rxEjEvrNUTISSJ0zAJkkiqtLPFngM8QFE/Zw=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] mfd/pinctrl: add initial support of TI DS90Ux9xx ICs
Date:   Fri, 12 Oct 2018 14:34:53 +0300
Message-ID: <1799007.AefaWafTOB@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181008211205.2900-1-vz@mleia.com>
References: <20181008211205.2900-1-vz@mleia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

Thank you for the patches.

On Tuesday, 9 October 2018 00:11:58 EEST Vladimir Zapolskiy wrote:
> The published drivers describe the essential and generic parts of
> TI DS90Ux9xx series of ICs, which allow to transfer video, audio and
> control signals between FPD-Link III serializers and deserializers.
> 
> The placement of TI DS90Ux9xx I2C client driver was selected to be
> drivers/mfd as the most natural location of a true MFD driver,

Why does this have to be an MFD driver ? It's not uncommon for random devices 
to expose a few GPIOs or clocks to the outside world, to support their main 
feature (video transmission in this case). HDMI cables transport I2C on the 
DDC pins, and HDMI encoders usually have an I2C master controller to read 
EDID, and a GPIO pin to connect to the HPD signal. We don't model them as MFD 
drivers. You can register an I2C adapter and a GPIO controller from within any 
driver without a need to involve the MFD framework. I think it's completely 
overkill in this case.

> apparently drivers/media/i2c is for another type of device drivers,
> also DS90Ux9xx I2C bridge subcontroller driver is placed nearby,
> because drivers/i2c for it would be an inappropriate destination
> as well. Informally the TI DS90Ux9xx ICs serve a similar function
> to SMSC/Microchip MOST, and its drivers are in drivers/staging/most,
> the final destination is unknown to me. Please feel free to advise
> a better location for the published drivers, at the moment the core
> drivers are in drivers/mfd, but I select linux-media as a mailing list.
> 
> The published drivers instantly give a chance to test video bridge
> functionality to a TI DS90Ux9xx deserializer equipped display panel
> with the aide of Laurent's "lvds-encoder" driver by misusing it
> as a generic and transparent drm bridge with no particular LVDS
> specifics in it, for that it should be sufficient just to add the
> corresponding device node and input/output ports as children of
> a serializer connected to an application controller.
> 
> While the selected scheme of IC description by a list of subdevices,
> where each one described in its own device node, works pretty well,
> it might lead to unnecessary overcomplicated description of connections
> between subdevices on serializer and deserializer sides, i.e. for
> proper description of links/connections video serializer should
> be linked to video deserializer, audio serializer should be linked
> to audio deserializer and so on, however formally there is just one
> FPD-III Link connection between two ICs.

Could you please provide a complete DT example ? The series is titled "initial 
support", but it's hard to ascertain that it's taking the right direction 
without seeing where you want to go. In particular, I want to see how devices 
on both sides of the serializer and deserializer will be modeled.

> The series of patches is rebased on top of linux-next, and there are
> more changes in the queue to provide better support of TI DS90Ux9xx ICs.
> 
> The introduction to the ICs and drivers can be found in my presentation
> https://schd.ws/hosted_files/ossalsjp18/8a/vzapolskiy_als2018.pdf
> 
> Sandeep Jain (1):
>   dt-bindings: mfd: ds90ux9xx: add description of TI DS90Ux9xx ICs
> 
> Vladimir Zapolskiy (6):
>   dt-bindings: mfd: ds90ux9xx: add description of TI DS90Ux9xx I2C bridge
>   dt-bindings: pinctrl: ds90ux9xx: add description of TI DS90Ux9xx pinmux
>   mfd: ds90ux9xx: add TI DS90Ux9xx de-/serializer MFD driver
>   mfd: ds90ux9xx: add I2C bridge/alias and link connection driver
>   pinctrl: ds90ux9xx: add TI DS90Ux9xx pinmux and GPIO controller driver
>   MAINTAINERS: add entry for TI DS90Ux9xx FPD-Link III drivers
> 
>  .../bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt  |  61 ++
>  .../devicetree/bindings/mfd/ti,ds90ux9xx.txt  |  66 ++
>  .../bindings/pinctrl/ti,ds90ux9xx-pinctrl.txt |  83 ++
>  MAINTAINERS                                   |  10 +
>  drivers/mfd/Kconfig                           |  22 +
>  drivers/mfd/Makefile                          |   2 +
>  drivers/mfd/ds90ux9xx-core.c                  | 879 ++++++++++++++++
>  drivers/mfd/ds90ux9xx-i2c-bridge.c            | 764 ++++++++++++++
>  drivers/pinctrl/Kconfig                       |  11 +
>  drivers/pinctrl/Makefile                      |   1 +
>  drivers/pinctrl/pinctrl-ds90ux9xx.c           | 970 ++++++++++++++++++
>  include/linux/mfd/ds90ux9xx.h                 |  42 +
>  12 files changed, 2911 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/mfd/ti,ds90ux9xx-i2c-bridge.txt create
> mode 100644 Documentation/devicetree/bindings/mfd/ti,ds90ux9xx.txt create
> mode 100644
> Documentation/devicetree/bindings/pinctrl/ti,ds90ux9xx-pinctrl.txt create
> mode 100644 drivers/mfd/ds90ux9xx-core.c
>  create mode 100644 drivers/mfd/ds90ux9xx-i2c-bridge.c
>  create mode 100644 drivers/pinctrl/pinctrl-ds90ux9xx.c
>  create mode 100644 include/linux/mfd/ds90ux9xx.h

-- 
Regards,

Laurent Pinchart



