Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2BDC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0049F20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+SMHVmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0049F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbeGVSPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbeGVSPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:15:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D630320671;
        Sun, 22 Jul 2018 17:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532279874;
        bh=mekeYDPCusByTC/Or6DiLFI8dB2vXajEUbfN6rZl9PQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g+SMHVmOT/1oiqxsEaHZFp38pHMiKLpfJK85pfr1siuzZRaKMKSiBaH3X38S+COAQ
         e0ICn90NVZDBeUZfn7Uz499I9CamAjCoOIrWT4TotdWs4fudQIn5rY9L2JE2p89bDn
         s1WCI7d2W3V4h7XG6fM4VlqgI+F3+K6wH4u3eiBs=
Date:   Sun, 22 Jul 2018 18:17:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Rob Herring <robh@kernel.org>, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca,
        jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
        bshah@kde.org, ctatlor97@gmail.com, drew.paterson@ams.com
Subject: Re: [PATCH v2 3/7] iio: tsl2772: add support for reading power
 settings from device tree
Message-ID: <20180722181748.24bc47d8@archlinux>
In-Reply-To: <20180722123720.GB20029@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
        <20180717084158.23532-4-masneyb@onstation.org>
        <20180720173635.GA21241@rob-hp-laptop>
        <20180721183716.524632f1@archlinux>
        <20180722123720.GB20029@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jul 2018 12:37:20 +0000
Brian Masney <masneyb@onstation.org> wrote:

> On Sat, Jul 21, 2018 at 06:37:16PM +0100, Jonathan Cameron wrote:
> > On Fri, 20 Jul 2018 11:36:35 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >   
> > > On Tue, Jul 17, 2018 at 04:41:54AM -0400, Brian Masney wrote:  
> > > > This patch adds support for optionally reading the prox_diode and
> > > > prox_power settings from device tree. This was tested using a LG
> > > > Nexus 5 (hammerhead) which requires a different diode than the driver
> > > > default for the IR LED.
> > > > 
> > > > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > > > ---
> > > > The next patch in the series removes the tsl2772 driver from the
> > > > trivial-devices.txt file. I separated it out so that change can go
> > > > through device tree.
> > > > 
> > > >  .../devicetree/bindings/iio/light/tsl2772.txt | 39 +++++++++++++++++++    
> > > 
> > > Please split DT bindings to separate patch.
> > >   
> > > >  drivers/iio/light/tsl2772.c                   | 16 ++++++++
> > > >  include/dt-bindings/iio/amstaos,tsl2772.h     | 24 ++++++++++++
> > > >  3 files changed, 79 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > > >  create mode 100644 include/dt-bindings/iio/amstaos,tsl2772.h
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > > > new file mode 100644
> > > > index 000000000000..ab553d52b9fc
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > > > @@ -0,0 +1,39 @@
> > > > +* AMS/TAOS ALS and proximity sensor
> > > > +
> > > > +Required properties:
> > > > +
> > > > +  - compatible: Should be one of
> > > > +		"amstaos,tsl2571"
> > > > +		"amstaos,tsl2671"
> > > > +		"amstaos,tmd2671"
> > > > +		"amstaos,tsl2771"
> > > > +		"amstaos,tmd2771"
> > > > +		"amstaos,tsl2572"
> > > > +		"amstaos,tsl2672"
> > > > +		"amstaos,tmd2672"
> > > > +		"amstaos,tsl2772"
> > > > +		"amstaos,tmd2772"
> > > > +  - reg: the I2C address of the device
> > > > +
> > > > +Optional properties:
> > > > +
> > > > +  - amstaos,prox_diode - must be TSL2772_DIODE0, TSL2772_DIODE1, or
> > > > +                         TSL2772_DIODE_BOTH.    
> > > 
> > > s/_/-/
> > >   
> > > > +  - amstaos,prox_power - must be TSL2772_100_mA, TSL2772_50_mA, TSL2772_25_mA,
> > > > +                         or TSL2772_13_mA.    
> > > 
> > > I wonder if this should be common. Perhaps we should use the existing 
> > > 'led-max-microamp' as this is setting the current for an IR LED.  
> > 
> > Seems reasonable, then perhaps have two controls to turn on the diodes
> > above.
> >   
> > > 
> > > And while called 'power' this setting is current.  
> > 
> > Also can we have real values?  I really don't like defines if they
> > aren't absolutely necessary - particularly when there is a nice real
> > unit to be used.  
> 
> How about these options then?
> 
> amstaos,proximity-diode-0-enabled;
> amstaos,proximity-diode-1-enabled;
> led-max-microamp = <100000>;

Works for me.  Rob?

J
> 
> Brian

