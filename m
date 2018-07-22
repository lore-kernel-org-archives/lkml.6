Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74395C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37A420878
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="il/C7RN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37A420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeGVNdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 09:33:55 -0400
Received: from onstation.org ([52.200.56.107]:49966 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbeGVNdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 09:33:54 -0400
Received: from localhost (onstation.org [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 4E97A272F;
        Sun, 22 Jul 2018 12:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1532263040;
        bh=gg61OfYxHXRnZDJSZvHzGFQezsyt6AqgyTyIKoAGa/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=il/C7RN5Wtk3d9j5FmRDMW+GLwJE2eqh13uuY/pglNrEE/nXrA6CLyZUJJiERIYZo
         95LJnwZn7JZZQlLzPNRRNlFKky9hUL0+3OIG/u/aBjGs6Ljq98jGGjry1IA6dyKxEP
         gPMpsTaFf3/OeyMKZTh4tDGPyTlHjrKfUWAwAc9U=
Date:   Sun, 22 Jul 2018 12:37:20 +0000
From:   Brian Masney <masneyb@onstation.org>
To:     Jonathan Cameron <jic23@kernel.org>
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
Message-ID: <20180722123720.GB20029@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
 <20180717084158.23532-4-masneyb@onstation.org>
 <20180720173635.GA21241@rob-hp-laptop>
 <20180721183716.524632f1@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721183716.524632f1@archlinux>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 06:37:16PM +0100, Jonathan Cameron wrote:
> On Fri, 20 Jul 2018 11:36:35 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Tue, Jul 17, 2018 at 04:41:54AM -0400, Brian Masney wrote:
> > > This patch adds support for optionally reading the prox_diode and
> > > prox_power settings from device tree. This was tested using a LG
> > > Nexus 5 (hammerhead) which requires a different diode than the driver
> > > default for the IR LED.
> > > 
> > > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > > ---
> > > The next patch in the series removes the tsl2772 driver from the
> > > trivial-devices.txt file. I separated it out so that change can go
> > > through device tree.
> > > 
> > >  .../devicetree/bindings/iio/light/tsl2772.txt | 39 +++++++++++++++++++  
> > 
> > Please split DT bindings to separate patch.
> > 
> > >  drivers/iio/light/tsl2772.c                   | 16 ++++++++
> > >  include/dt-bindings/iio/amstaos,tsl2772.h     | 24 ++++++++++++
> > >  3 files changed, 79 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > >  create mode 100644 include/dt-bindings/iio/amstaos,tsl2772.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > > new file mode 100644
> > > index 000000000000..ab553d52b9fc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > > @@ -0,0 +1,39 @@
> > > +* AMS/TAOS ALS and proximity sensor
> > > +
> > > +Required properties:
> > > +
> > > +  - compatible: Should be one of
> > > +		"amstaos,tsl2571"
> > > +		"amstaos,tsl2671"
> > > +		"amstaos,tmd2671"
> > > +		"amstaos,tsl2771"
> > > +		"amstaos,tmd2771"
> > > +		"amstaos,tsl2572"
> > > +		"amstaos,tsl2672"
> > > +		"amstaos,tmd2672"
> > > +		"amstaos,tsl2772"
> > > +		"amstaos,tmd2772"
> > > +  - reg: the I2C address of the device
> > > +
> > > +Optional properties:
> > > +
> > > +  - amstaos,prox_diode - must be TSL2772_DIODE0, TSL2772_DIODE1, or
> > > +                         TSL2772_DIODE_BOTH.  
> > 
> > s/_/-/
> > 
> > > +  - amstaos,prox_power - must be TSL2772_100_mA, TSL2772_50_mA, TSL2772_25_mA,
> > > +                         or TSL2772_13_mA.  
> > 
> > I wonder if this should be common. Perhaps we should use the existing 
> > 'led-max-microamp' as this is setting the current for an IR LED.
> 
> Seems reasonable, then perhaps have two controls to turn on the diodes
> above.
> 
> > 
> > And while called 'power' this setting is current.
> 
> Also can we have real values?  I really don't like defines if they
> aren't absolutely necessary - particularly when there is a nice real
> unit to be used.

How about these options then?

amstaos,proximity-diode-0-enabled;
amstaos,proximity-diode-1-enabled;
led-max-microamp = <100000>;

Brian
