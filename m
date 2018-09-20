Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087E4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A242147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="W5rnymiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A242147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbeIUBtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:49:43 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36144 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbeIUBtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:49:43 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 54E7F1C87;
        Thu, 20 Sep 2018 22:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537473873;
        bh=s+jmp33Efj6739p3hL3v2sTVLEWiI+uUKJmP9e6xEDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5rnymiYKOw1zK96MQMERSuZ3v7TMUm7lpuN3HOvnN1tFB7A4WWz9Fa3tNwEnMHvi
         Z9/GCZop5WrJpuwkeXFHjjcaAIF6oJcnIA7heWG7xVqjLb0IIb6X/c5vMtp6qYvlEl
         OWcIHGteoeKYTPEU6dsuP7Qr0BWY+8b3Un4rd9b0=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [PATCH v2 2/4] [media] ad5820: Add support for enable pin
Date:   Thu, 20 Sep 2018 23:04:46 +0300
Message-ID: <6867138.NTEK45P8Ux@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1887575.If169ivQRG@avalon>
References: <20180920161912.17063-2-ricardo.ribalda@gmail.com> <CAPybu_2mNE7Jmfm2n60Z9Hk_iO+-zLgtu4xn72pJUSXBitVg=g@mail.gmail.com> <1887575.If169ivQRG@avalon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20 September 2018 23:04:21 EEST Laurent Pinchart wrote:
> Hi Ricardo,
> 
> On Thursday, 20 September 2018 22:12:44 EEST Ricardo Ribalda Delgado wrote:
> > On Thu, Sep 20, 2018 at 9:08 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > On Thu 2018-09-20 21:06:16, Ricardo Ribalda Delgado wrote:
> > >> On Thu, Sep 20, 2018 at 8:54 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >>> On Thu 2018-09-20 20:45:52, Ricardo Ribalda Delgado wrote:
> > >>>> This patch adds support for a programmable enable pin. It can be
> > >>>> used in situations where the ANA-vcc is not configurable (dummy-
> > >>>> regulator), or just to have a more fine control of the power saving.
> > >>>> 
> > >>>> The use of the enable pin is optional.
> > >>>> 
> > >>>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > >>> 
> > >>> Do we really want to do that?
> > >>> 
> > >>> Would it make more sense to add gpio-regulator and connect ad5820 to
> > >>> it in such case?
> > >> 
> > >> My board (based on db820c)  has both:
> > >> 
> > >> ad5820: dac@0c {
> > >> 
> > >>    compatible = "adi,ad5820";
> > >>    reg = <0x0c>;
> > >>    
> > >>    VANA-supply = <&pm8994_l23>;
> > >>    enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
> > >> 
> > >> };
> > > 
> > > Well, I'm sure you could have gpio-based regulator powered from
> > > pm8994_l23, and outputting to ad5820.
> > > 
> > > Does ad5820 chip have a gpio input for enable?
> > 
> > xshutdown pin:
> > http://www.analog.com/media/en/technical-documentation/data-sheets/AD5821.
> > pd f
> > 
> > (AD5820,AD5821, and AD5823 are compatibles, or at least that is waht
> > the module manufacturer says :)
> 
> Is that the pin that msmgpio 26 is connected to on your board ?
> 
> I'd argue that the GPIO should be called xshutdown in that case, as DT
> usually uses the pin name, but there's precedent of using well-known names
> for pins with the same functionality. In any case you should update the DT
> bindings to document the new property, and clearly explain that it
> describes the GPIO connected to the xshutdown pin. Please CC the
> devicetree@vger.kernel.org mailing list on the bindings change (they
> usually like bindings changes to be split to a separate patch).

And now I've noticed patch 3/4 :-/ Please scratch this.

-- 
Regards,

Laurent Pinchart



