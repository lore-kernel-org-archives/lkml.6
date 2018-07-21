Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35A6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BC620863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIc3vpbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BC620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeGUSaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeGUSaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:30:52 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA65520858;
        Sat, 21 Jul 2018 17:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532194642;
        bh=Pa/kSQPJ5svel9JEXeHYuiyVgl25lqTs5UKm8VFU6Yg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kIc3vpbPh/O6AM6EWPz33suk1eh8eUWcnfgq5r03cz1H9AHeGBoR5PK3kcC8zqGag
         KGNgXswgr2INa0Mhg6edJsvQvSaydn4AAr4ivRR41W4UnpOC4ZPy7bD/sPEt8JNaiT
         srwmL7dsu7yNJkatz6RQP4bg44qKWTH0ekrUu168=
Date:   Sat, 21 Jul 2018 18:37:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca,
        jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
        bshah@kde.org, ctatlor97@gmail.com, drew.paterson@ams.com
Subject: Re: [PATCH v2 3/7] iio: tsl2772: add support for reading power
 settings from device tree
Message-ID: <20180721183716.524632f1@archlinux>
In-Reply-To: <20180720173635.GA21241@rob-hp-laptop>
References: <20180717084158.23532-1-masneyb@onstation.org>
        <20180717084158.23532-4-masneyb@onstation.org>
        <20180720173635.GA21241@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 11:36:35 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Jul 17, 2018 at 04:41:54AM -0400, Brian Masney wrote:
> > This patch adds support for optionally reading the prox_diode and
> > prox_power settings from device tree. This was tested using a LG
> > Nexus 5 (hammerhead) which requires a different diode than the driver
> > default for the IR LED.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> > The next patch in the series removes the tsl2772 driver from the
> > trivial-devices.txt file. I separated it out so that change can go
> > through device tree.
> > 
> >  .../devicetree/bindings/iio/light/tsl2772.txt | 39 +++++++++++++++++++  
> 
> Please split DT bindings to separate patch.
> 
> >  drivers/iio/light/tsl2772.c                   | 16 ++++++++
> >  include/dt-bindings/iio/amstaos,tsl2772.h     | 24 ++++++++++++
> >  3 files changed, 79 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
> >  create mode 100644 include/dt-bindings/iio/amstaos,tsl2772.h
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > new file mode 100644
> > index 000000000000..ab553d52b9fc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> > @@ -0,0 +1,39 @@
> > +* AMS/TAOS ALS and proximity sensor
> > +
> > +Required properties:
> > +
> > +  - compatible: Should be one of
> > +		"amstaos,tsl2571"
> > +		"amstaos,tsl2671"
> > +		"amstaos,tmd2671"
> > +		"amstaos,tsl2771"
> > +		"amstaos,tmd2771"
> > +		"amstaos,tsl2572"
> > +		"amstaos,tsl2672"
> > +		"amstaos,tmd2672"
> > +		"amstaos,tsl2772"
> > +		"amstaos,tmd2772"
> > +  - reg: the I2C address of the device
> > +
> > +Optional properties:
> > +
> > +  - amstaos,prox_diode - must be TSL2772_DIODE0, TSL2772_DIODE1, or
> > +                         TSL2772_DIODE_BOTH.  
> 
> s/_/-/
> 
> > +  - amstaos,prox_power - must be TSL2772_100_mA, TSL2772_50_mA, TSL2772_25_mA,
> > +                         or TSL2772_13_mA.  
> 
> I wonder if this should be common. Perhaps we should use the existing 
> 'led-max-microamp' as this is setting the current for an IR LED.

Seems reasonable, then perhaps have two controls to turn on the diodes
above.

> 
> And while called 'power' this setting is current.

Also can we have real values?  I really don't like defines if they
aren't absolutely necessary - particularly when there is a nice real
unit to be used.

> 
> > +  - interrupt-parent: should be the phandle for the interrupt controller  
> 
> Don't need to document this. It's implied by interrupts (and could be in 
> a parent node).
> 
> > +  - interrupts: the sole interrupt generated by the device
> > +
> > +  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> > +  node bindings.
> > +
> > +Example:
> > +
> > +#include <dt-bindings/iio/amstaos,tsl2772.h>
> > +
> > +tsl2772@39 {
> > +	compatible = "amstaos,tsl2772";
> > +	reg = <0x39>;
> > +	interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> > +	amstaos,prox_diode = <TSL2772_DIODE0>;
> > +};  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

