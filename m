Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD80C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EBC2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcjpE7Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EBC2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390398AbeKVJe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:34:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33266 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387670AbeKVJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:34:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so7516195plo.0;
        Wed, 21 Nov 2018 14:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EylomEtdWUd082R3jxytnlAYpt4BAW0GmgTIx2O+agI=;
        b=bcjpE7Ilr5Kx4GXH6xbVfThQu8ldFDH0a8W4YIkFdP83VFSuiRG7zQPu9GNCpC+kgs
         W0gKlIgQB65sAg1eOquWogyHzNiyWM6GHLBIxgpsPumjr5WDxkgr8vsZVb5cPfcrPSJ9
         CZZxtXk7/Rw8wCCw0lAyszxRjx7q/jucY2Tqz1c1bu/KhRqa5N39br+gfJJw4DQddFGj
         W3zTxWrniXBx4wliZLrzElW2GVfAVjydxx6k6kcAJI/Tlz4Iio+DYAmPCG4kFEPK+Jb8
         pNG4l1mQPXFt4broKXMgmlNpE4yKWahlIY4MXHufD1TqGajLfbfDl9VktwKQKg59CSex
         D99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EylomEtdWUd082R3jxytnlAYpt4BAW0GmgTIx2O+agI=;
        b=idrMZ8u7wZhbpx0fphRD+2nkLZF/NiUHF6glCjv8XmDzVaZ9rqidCFhKfGgeO68l4J
         bv0w4bB6Vu5uw0IkNfTsKJiWlF22tu4w7JUS52FW7k9mDsiC6tPkQ7PZmBArGKC6ciM2
         wXriGNth1D5XmALgNI6pF4FixFkmGZ2XjmEBTG30YtBcUoNht5Dp3MBYlJSSLzYhMp2V
         npPv7nnrwZi44UMF8ZzedSsbSzMahz7NDuAd8JRGUmKVtME8coZ1+bYVhY5eM4MUbGZv
         7I06m2hBF+bS8noxPCcDdyjh2GaEa+qSnrn3PUii12izIcBQBzIPDKNO1s4fJW4oR3vK
         TbEw==
X-Gm-Message-State: AGRZ1gIornM9fzFp3t0xo2X05A4YSy0vV9resNwfAdrQKFHH5/9mX+Wb
        1R6dhGWSRmjZcU5Y6ks8tkE=
X-Google-Smtp-Source: AFSGD/U6BaP6ExXH4AyoO1FxzRIlukmL1SaLyVQ9IEXqrSu1BTcEyFNZ0TltirmOsbsGBHapUWRjLw==
X-Received: by 2002:a63:fd53:: with SMTP id m19mr7844622pgj.340.1542841081100;
        Wed, 21 Nov 2018 14:58:01 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64sm21346794pff.101.2018.11.21.14.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 14:58:00 -0800 (PST)
Date:   Wed, 21 Nov 2018 14:57:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?B?QnL8bnMs?= Stefan <Stefan.Bruens@rwth-aachen.de>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC][PATCH] hwmon: (ina2xx) Improve current and power reading
 precision
Message-ID: <20181121225758.GA1421@roeck-us.net>
References: <20181121012629.5432-1-nicoleotsuka@gmail.com>
 <2863036.QIPGp1Eqjm@sbruens-linux.lcs.intern>
 <20181121194051.GA8902@Asurada-Nvidia.nvidia.com>
 <1717545.GXSegKtrMu@sbruens-linux.lcs.intern>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1717545.GXSegKtrMu@sbruens-linux.lcs.intern>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:16:09PM +0000, Brüns, Stefan wrote:
> On Mittwoch, 21. November 2018 20:40:52 CET Nicolin Chen wrote:
> > (Removing "m.purski@samsung.com" since it's not reachable any more)
> > 
> > Hi Stefan,
> > 
> > Thank you for the comments.
> > 
> > On Wed, Nov 21, 2018 at 04:13:01PM +0000, Brüns, Stefan wrote:
> > > > === Problem ===
> > > > Both methods simplify software routine by fixing one factor, which
> > > > sacrifices the precision of the hardware measurement results.
> > > > 
> > > > Using ina226 for example, with method A, the current scale was 1mA
> > > > and the power scale was 25mA.
> > > > 
> > > > With method B, calibration value is fixed at 2048 so the precision
> > > > is decided by shunt resistor value. It sounds reasonable since the
> > > > hardware engineers can use a larger shunt resistor when they need
> > > > higher resolution. However, they often concern power burning across
> > > > the resistor as well, so the resistor usually won't be so large: a
> > > > typical value 1000 micro-ohms, which results in a current scale at
> > > > 2.5 mA and a power sacle at 62.5 mW.
> > > 
> > > Power loss surely is a concern, but figures should be kept reasonable.
> > > 
> > > 1. You mention 1.8V bus voltage, and currents in the 30mA range. Using the
> > > 1mOhm current shunt:
> > > 
> > > U_S = R_S * I_S 1e-3 Ohm * 30e-3 A = 30e-6 V  (30uV)
> > > P_S = U_S * I_S = 30e-6V * 30e-3 A = 900e-9W = 0.9 uW
> > > 
> > > INA219 Power Supply (Datasheet)
> > > Min operating Voltage: 3V
> > > Quiescent Current: 0.7mA
> > > -> Min power: 2.1mW
> > > 
> > > So the INA219 alone uses 2.1mW, 1000 times more than the shunt.
> > 
> > Chip can enter power-down or one-shot mode. Though this upstream
> > driver doesn't have these two mode supports yet, I am working on
> > it so they'll be added.
> 
> The power-down current is 6uA, so even if you never leave power-down mode, you 
> are down to 18uW. But on top of that, you need power for the conversion, and 
> you need power for communication.
> 
> > > Another concern may be voltage drop over the shunt, but for this case you
> > > have a nominal voltage of 1.8V, so 30uV are 0.001%.
> > > 
> > > > When measuring a 1.8v voltage running a small current (e.g. 33 mA),
> > > > the power value (that's supposed to be 59.4 mW) becomes inaccurate
> > > > due to the larger scale (25mA for method A; 62.5 mA for method B).
> > 
> > Just found out that I have typos here: 25mW and 62.5mW.
> > 
> > > Another look into the datasheet reveals, even at full gain (PGA=1), the
> > > LSB is 40mV / 2^12 = 40mV / 4096 ~ 10uV. So when the current ADC reads
> > > out as 3*LSB, this anything between 25mA and 35mA. This is the best case
> > > figure.
> > Current read doesn't get affected a lot actually, since hwmon ABI
> > also reports current value in unit mA. However, the power read is
> > the matter here. With a 62.5mW power_lsb, power results are kinda
> > useless on my system.
> 
> The reported current does not matter here, actually. Internally, the ADC value 
> will have an uncertainty of 10mA (at PGA=1). At 1.8V, your uncertainty is 
> 18mW. And thats *only* the quantization noise. It wont get better than that.
> 
> Also note, you are apparently using the ina2xx hwmon driver - I strongly 
> advise against it, you should either use the ina2xx driver from the IIO 
> subsystem directly, or use the IIO driver via iio-hwmon.
> 
> 1. INA219 is not properly supported by the hwmon driver, see the changes in 
> the IIO driver.
> 2. The IIO driver has many more features:
>   - setting the PGA (INA219)
>   - setting the bus voltage range (INA219)
>   - selecting the conversion time (INA219/226)
> 

I agree. Not because of the functionality per se ("not properly supported, see
changes in IIO driver" is a bit vague given the number of changes there),
but you don't really use both ina3221 and ina219 as hwmon device. Afer all,
one-shot mode effectively turns off limit tracking.

Ultimately it would be nice if iio would support limits and alarms, and iio-hwmon
could read and report those. This would enable us to drop the iio-hwmon driver.

Guenter
