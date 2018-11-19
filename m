Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AABC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E762086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyzKwE9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E762086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeKSLr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:47:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43309 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeKSLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:47:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so13732620plb.10;
        Sun, 18 Nov 2018 17:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Th0sIaHQRXi+knSorbWSUOCIbURNP6n2p9HUtwfuPcM=;
        b=ZyzKwE9z0DJb+LxoC5OL6LJ35bokZG3QVYs+g/qP4zhsu2WvYUoEpoHT5rY1MQi3og
         XnzXqODzpT3RajrenFg2QWjU4q3qlBBEngsoJvXfck8LrMUCd0ZioPbjp2S7M3c7JqU2
         EguYydO8MVmKcrUZEJ4+1/lsGF7xOfL1DUZ4DmRc6y+rzWq/WxrP7ZG2ZUUPv0QjLCcd
         zvhzHGj2fN/K+Q6o7BSZYAekpQF43e/+kGTNqk3cbbDbx7mEJv5fFLR6tFHB5fEQHZQ5
         DO+8mJJiMbze4oMVPtmohzQc/kAhsga/cAE0g1A3Xf13vpTZtC7InFgPTdJnxpOmyplB
         rKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Th0sIaHQRXi+knSorbWSUOCIbURNP6n2p9HUtwfuPcM=;
        b=tpGraF2dZzY03yKkhz/zCd05XcQu4yiHuirh6yvs9km5fcLoXBm3dli83pSYREydUs
         Fpd0m9kvibsjFRw/lHrzW+tmzzkQ2aZlUjkvNTl7P2VPJYuosMODy8+URPue3VqvleyG
         9lLBZjuS/7t7eoh7F6lgx2F3q0zVcv/3d7gFUTbiMwsD0I5UJnBhmA8/LB04fE9GgUMp
         obYJQ5IfTG5pvDkRksiN/5O9OQtX67QauX803RflotDo213YXmpZpWvZr4VeNaNQmeUt
         k7nKv80oX/DdQckFjakW0def/0rI2q0Y3Oj3b/775o8LU+zCfLjGd+Th+ItsSO/T0NH/
         NhPA==
X-Gm-Message-State: AGRZ1gJrL2mZdOFdAge267pb5BpLaIQeK4XZulxBQbUbuR+XUEUIr8Ab
        2SKUxgT3sDkKrL0UQhM7XDU=
X-Google-Smtp-Source: AJdET5d1ozdZHieYacRNHdV6dYWLHdZlSeDtSOUmvbR8ClTKoysolLgbvTqtpqaphly5jzeERkc5EQ==
X-Received: by 2002:a17:902:9698:: with SMTP id n24-v6mr20847486plp.9.1542590758611;
        Sun, 18 Nov 2018 17:25:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n65-v6sm44712138pfi.185.2018.11.18.17.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 17:25:57 -0800 (PST)
Date:   Sun, 18 Nov 2018 17:25:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Eckert <fe@dev.tdt.de>, jdelvare@suse.com,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hwmon: (adcxx) add devictree bindings
 documentation
Message-ID: <20181119012555.GA7856@roeck-us.net>
References: <20181115135013.30723-1-fe@dev.tdt.de>
 <20181115135013.30723-2-fe@dev.tdt.de>
 <20181117144040.GA8016@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117144040.GA8016@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 08:40:41AM -0600, Rob Herring wrote:
> On Thu, Nov 15, 2018 at 02:50:12PM +0100, Florian Eckert wrote:
> > Document the devicetree bindings for the adcxx.
> > 
> > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > ---
> >  Documentation/devicetree/bindings/hwmon/adcxx.txt | 24 +++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/adcxx.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/adcxx.txt b/Documentation/devicetree/bindings/hwmon/adcxx.txt
> > new file mode 100644
> > index 000000000000..a94a5fe21b6d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/adcxx.txt
> > @@ -0,0 +1,24 @@
> > +adcxx properties
> 
> Needs a better description of what this h/w is.
> 
> ADCs go in iio/adc/
> 
FWIW, the hwmon driver for this chip series would be a perfect candidate
for a conversion to an iio driver. The driver predates the existence of
iio.

Florian, any interest doing that ? It is quite likely that the chip isn't
used for hardware monitoring.

> > +
> > +Required properties:
> > +- compatible: Must be one of the following:
> > +	- "national,adcxx1s" for adcxx1s
> > +	- "national,adcxx2s" for adcxx2s
> > +	- "national,adcxx4s" for adcxx4s
> > +	- "national,adcxx8s" for adcxx8s
> 
> Don't use wildcards in compatible strings.
> 
Should we list all of them ?

ADC121S021 ADC121S051 ADC121S101
ADC101S021 ADC101S051 ADC101S101
ADC081S021 ADC081S051 ADC081S101

ADC121S625 ADC121S655 ADC121S705

ADC122S021 ADC122S051 ADC122S101
ADC102S021 ADC102S051 ADC102S101
ADC082S021 ADC082S051 ADC082S101

ADC122S625 ADC122S655 ADC122S706

ADC124S021 ADC124S051 ADC124S101
ADC104S021 ADC104S051 ADC104S101
ADC084S021 ADC084S051 ADC084S101

ADC128S022 ADC128S052 ADC128S102

I hope I didn't miss any.

Guenter

> > +- reg: SPI address for chip
> > +
> > +Optional properties:
> > +
> > +- vref-supply
> > +  The external reference in microvolt for this device is set to this value.
> > +  If it does not exists the reference will be set to 3300000uV (3.3V).
> > +
> > +Example:
> > +
> > +adc@6 {
> > +	compatible = "national,adcxx2s";
> > +	reg = <6 0>;
> 
> ? SPI addresses are a single cell.
> 
> > +	spi-max-frequency = <1000000>;
> > +	vref-supply = <&vref>;
> > +};
> > -- 
> > 2.11.0
> > 
