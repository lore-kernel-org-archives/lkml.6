Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46F3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFB921470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NyZ+FXWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFB921470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeJPV4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:56:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39758 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJPV4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:56:38 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 179831A81;
        Tue, 16 Oct 2018 16:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539698757;
        bh=KZ4/7leUtK2LkYf6fkX9idqpTgL+f1VB0hBU0EWPhk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyZ+FXWBM6Q2uEhF3qLxNNFtK3iYVTahC2btsDqaS+AtYttp5YSRXzn7XS6iCdcAI
         YIPinzAXfcr5Ea4LwcA97qN/PwLJP9JbfGXnLk7Dx027mnLqsJPJaGbjSRbhUtNtvh
         G7aY8gRuR4STk6Kivz0PP/v0vDoo7AbIHRHCrr2w=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mfd: ds90ux9xx: add I2C bridge/alias and link connection driver
Date:   Tue, 16 Oct 2018 17:06:06 +0300
Message-ID: <2291401.VxyBGcGQdW@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <0be75b0d-eb61-02e5-a086-be6a9d32841a@mleia.com>
References: <20181008211205.2900-1-vz@mleia.com> <1584081.CVFmJobd6K@avalon> <0be75b0d-eb61-02e5-a086-be6a9d32841a@mleia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Friday, 12 October 2018 17:36:39 EEST Vladimir Zapolskiy wrote:
> On 10/12/2018 04:12 PM, Laurent Pinchart wrote:
> > On Friday, 12 October 2018 10:32:32 EEST Vladimir Zapolskiy wrote:
> >> On 10/12/2018 09:04 AM, Lee Jones wrote:
> >>> On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:
> >>>> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>>> 
> >>>> The change adds TI DS90Ux9xx I2C bridge/alias subdevice driver and
> >>>> FPD Link connection handling mechanism.
> >>>> 
> >>>> Access to I2C devices connected to a remote de-/serializer is done in
> >>>> a transparent way, on established link detection event such devices
> >>>> are registered on an I2C bus, which serves a local de-/serializer IC.
> >>>> 
> >>>> The development of the driver was a collaborative work, the
> >>>> contribution done by Balasubramani Vivekanandan includes:
> >>>> * original simplistic implementation of the driver,
> >>>> * support of implicitly specified devices in device tree,
> >>>> * support of multiple FPD links for TI DS90Ux9xx,
> >>>> * other kind of valuable review comments, clean-ups and fixes.
> >>>> 
> >>>> Also Steve Longerbeam made the following changes:
> >>>> * clear address maps after linked device removal,
> >>>> * disable pass-through in disconnection,
> >>>> * qualify locked status with non-zero remote address.
> >>>> 
> >>>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>>> ---
> >>>> 
> >>>>  drivers/mfd/Kconfig                |   8 +
> >>>>  drivers/mfd/Makefile               |   1 +
> >>>>  drivers/mfd/ds90ux9xx-i2c-bridge.c | 764 +++++++++++++++++++++++++++++
> >>>>  3 files changed, 773 insertions(+)
> >>>>  create mode 100644 drivers/mfd/ds90ux9xx-i2c-bridge.c
> >>> 
> >>> Shouldn't this live in drivers/i2c?
> >> 
> >> no, the driver is not for an I2C controller of any kind, and the driver
> >> does not register itself in the I2C subsystem by calling
> >> i2c_add_adapter() or i2c_add_numbered_adapter() or i2c_mux_add_adapter()
> >> etc, this topic was discussed with Wolfram also.
> > 
> > (Who is now on CC)
> 
> Wolfram has copies of the drivers and discussion right from the beginning,
> hopefully he won't get two copies ;)
> 
> >> Formally the driver converts the managed IC into a multi-address I2C
> >> slave device, I understand that it does not sound like a well suited
> >> driver for MFD, but ds90ux9xx-core.c and ds90ux9xx-i2c-bridge.c drivers
> >> are quite tightly coupled.
> > 
> > As mentioned in other e-mails in this thread I don't think this should be
> > split out to a separate driver,> I would move the functionality to the
> > ds90ux9xx driver.
> 
> The proposal may have the grounds, but the I2C bridging functionality of ICs
> is quite detached from all other ones, thus it found its place in the cell
> driver per se.
> 
> > You may want to register an I2C mux, but as you have a single port, that
> > could be overkill. I haven't studied in details how to best support this
> > chip using the existing I2C subsystems APIs (which we may want to extend
> > if it needed), but I believe that (in your use cases) the deserializer
> > should be a child of the serializer, and modeled as an I2C device.
> 
> Formally in OF terms to define a link between devices by a phandle should
> be sufficient, panels are not the children of LVDS controllers under OF
> graph constraints in DT representation, the panels become secondary in
> runtime only, I'd like to reuse the concept. Also it adds a better sense of
> symmetry of deserializer <-> serializer connections relatively to a
> SoC/data source.

As I explained, DT models control buses through parent/child relationships. 
That's why I2C slaves are children of their I2C master. OF graph adds a second 
topology to describe data connections, which are orthogonal to the control bus 
relationship. In your case the device at the remote side of the link is 
controlled over the link, and that control flow goes from the SoC to the 
device on the local side of the link. That's why the remote device should be a 
child of the local device.

-- 
Regards,

Laurent Pinchart



