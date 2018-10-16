Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23151C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA13B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DV8lF0x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA13B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJPVCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:02:22 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39504 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPVCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:02:22 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DFDD61A81;
        Tue, 16 Oct 2018 15:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539695514;
        bh=WhpwMLDcD+2DL28YK/oI4T0/BRuG4A3tzuGsy4ldtX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DV8lF0x+lMfDyxfzS6KCigWxbT8kp/Lq/R/Byy7w+QmrSOmqg6nmPkijNVTVsniyo
         U3YS7/7O05EhAPXc4gQH5Cw0Y0E1htjTWKOYQQJ1WS8BYgPVwYEp6lO6dplgr0ppUc
         XD9qcusjv/sX9St9vCIoicMmosH3Hb6/a7oYt9dQ=
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
Date:   Tue, 16 Oct 2018 16:12:02 +0300
Message-ID: <6392366.NPbusjoGUK@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <369ef3ac-6f68-c450-713f-762b1c5cd5c9@mentor.com>
References: <20181008211205.2900-1-vz@mleia.com> <3599186.afdMBtdL0k@avalon> <369ef3ac-6f68-c450-713f-762b1c5cd5c9@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Saturday, 13 October 2018 18:10:25 EEST Vladimir Zapolskiy wrote:
> On 10/12/2018 04:01 PM, Laurent Pinchart wrote:
> > On Friday, 12 October 2018 14:47:52 EEST Kieran Bingham wrote:
> >> On 12/10/18 11:58, Vladimir Zapolskiy wrote:
> [snip]
> 
> >> Essentially they are multi purpose buses - which do not yet have a home.
> >> We have used media as a home because of our use case.
> >> 
> >> The use case whether they transfer frames from a camera or to a display
> >> are of course closely related, but ultimately covered by two separate
> >> subsystems at the pixel level (DRM vs V4L, or other for other data)
> >> 
> >> Perhaps as they are buses - on a level with USB or I2C (except they can
> >> of course carry I2C or Serial as well as 'bi-directional video' etc ),
> >> they are looking for their own subsystem.
> >> 
> >> Except I don't think we don't want to add a new subsystem for just one
> >> (or two) devices...
> > 
> > I'm not sure a new subsystem is needed. As you've noted there's an overlap
> > between drivers/media/ and drivers/gpu/drm/ in terms of supported
> > hardware. We even have a devices supported by two drivers, one in drivers/
> > media/ and one in drivers/gpu/drm/ (I'm thinking about the adv7511 in
> > particular). This is a well known issue, and so far nothing has been done
> > in mainline to try and solve it.
> 
> I agree that there's an overlap between drivers/media/ and drivers/gpu/drm/,
> formally a hypothetical (sic!) DS90Ux9xx video bridge cell driver should be
> added into both subsystems also, and the actual driver of two should be
> selected in runtime. I call such a driver 'hypothetical', because in fact I
> don't have it, and I'm not so sure that its existence is justified, but
> that's only because DS90Ux9xx video bridge functionality is _transparent_,
> it does not have any controls literally, but it is a pure luck eventually.

I don't think that's entirely correct, there's at least the video bus width 
(18-bit/24-bit) that needs to be selected. You currently do so through a 
pinctrl property, but that's not right.

> So, as I've stated in my cover letter, I can misuse yours 'lvds-encoder'
> driver only for the purpose of establishing a mediated link between
> an LVDS controller and a panel over a serializer-deserializer pair.
> 
> > Trying to find another home in drivers/mfd/ to escape from the problem
> > isn't a good solution in my opinion. The best option from a Linux point
> > of view would be to unify V4L2 and DRM/KMS when it comes to bridge
> > support, but that's a long way down the road (I won't complain if you
> > want to give it a go though> 
> > :-)).
> 
> I return you a wider smile :)
> 
> > As your use cases are display, focused, I would propose to start with
> > drivers/gpu/drm/bridge/, and leave the problem of camera support for first
> > person who will have such a use case.
> 
> Frankly speaking I would like to start from copy-pasting your 'lvds-encoder'
> driver into an 'absolutely-transparent-video-bridge' driver with no LVDS or
> 'encoder' specifics, adding just a new compatible may suffice, if the
> driver is renamed/redefined.
> 
> PS, I remember I owe you a reference OF snippet of data path to a panel.

-- 
Regards,

Laurent Pinchart



