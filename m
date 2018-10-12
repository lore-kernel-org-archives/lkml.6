Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF7C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8844620868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D7LRmkLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8844620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeJLUo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:44:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46914 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbeJLUo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:44:27 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 092411258;
        Fri, 12 Oct 2018 15:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539349920;
        bh=MvrOHrvP5z6ECzHGc7BPoFwcHlaVC97WaKHcyy/n6qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7LRmkLCY+0yUPIfdyNx/RS4IBf5FpiNraxxFzW8UD0mdsrULUlNdJvfj2+WqKbgs
         5gSZ2NIVvCcXpSVGBYQ1lAuCegBQ+iTE2c6Wm+BfeBNLS4loaYPFxz52tmhpZkFtDG
         kgKTh1PFkOqOMIJGY3Tr5N60COZIfwKwVQQrtnWE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsa@the-dreams.de
Subject: Re: [PATCH 5/7] mfd: ds90ux9xx: add I2C bridge/alias and link connection driver
Date:   Fri, 12 Oct 2018 16:12:04 +0300
Message-ID: <1584081.CVFmJobd6K@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <c8f01b88-c14f-867d-d796-7464b2e8ccfb@mentor.com>
References: <20181008211205.2900-1-vz@mleia.com> <20181012060455.GV4939@dell> <c8f01b88-c14f-867d-d796-7464b2e8ccfb@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

(CC'ing Wolfram)

On Friday, 12 October 2018 10:32:32 EEST Vladimir Zapolskiy wrote:
> On 10/12/2018 09:04 AM, Lee Jones wrote:
> > On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:
> >> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> 
> >> The change adds TI DS90Ux9xx I2C bridge/alias subdevice driver and
> >> FPD Link connection handling mechanism.
> >> 
> >> Access to I2C devices connected to a remote de-/serializer is done in
> >> a transparent way, on established link detection event such devices
> >> are registered on an I2C bus, which serves a local de-/serializer IC.
> >> 
> >> The development of the driver was a collaborative work, the
> >> contribution done by Balasubramani Vivekanandan includes:
> >> * original simplistic implementation of the driver,
> >> * support of implicitly specified devices in device tree,
> >> * support of multiple FPD links for TI DS90Ux9xx,
> >> * other kind of valuable review comments, clean-ups and fixes.
> >> 
> >> Also Steve Longerbeam made the following changes:
> >> * clear address maps after linked device removal,
> >> * disable pass-through in disconnection,
> >> * qualify locked status with non-zero remote address.
> >> 
> >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> ---
> >> 
> >>  drivers/mfd/Kconfig                |   8 +
> >>  drivers/mfd/Makefile               |   1 +
> >>  drivers/mfd/ds90ux9xx-i2c-bridge.c | 764 +++++++++++++++++++++++++++++
> >>  3 files changed, 773 insertions(+)
> >>  create mode 100644 drivers/mfd/ds90ux9xx-i2c-bridge.c
> > 
> > Shouldn't this live in drivers/i2c?
> 
> no, the driver is not for an I2C controller of any kind, and the driver does
> not register itself in the I2C subsystem by calling i2c_add_adapter() or
> i2c_add_numbered_adapter() or i2c_mux_add_adapter() etc, this topic was
> discussed with Wolfram also.

(Who is now on CC)

> Formally the driver converts the managed IC into a multi-address I2C
> slave device, I understand that it does not sound like a well suited driver
> for MFD, but ds90ux9xx-core.c and ds90ux9xx-i2c-bridge.c drivers are quite
> tightly coupled.

As mentioned in other e-mails in this thread I don't think this should be 
split out to a separate driver, I would move the functionality to the 
ds90ux9xx driver. You may want to register an I2C mux, but as you have a 
single port, that could be overkill. I haven't studied in details how to best 
support this chip using the existing I2C subsystems APIs (which we may want to 
extend if it needed), but I believe that (in your use cases) the deserializer 
should be a child of the serializer, and modeled as an I2C device.

-- 
Regards,

Laurent Pinchart



