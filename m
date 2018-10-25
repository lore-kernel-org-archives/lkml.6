Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3989EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41AB2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyanDqMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41AB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJYTh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:37:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33128 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeJYTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:37:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so1683142wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C0BamnOmkIohfFzvdCg9JNSKhJZ2qbMi94Zn2XJWcVk=;
        b=PyanDqMezCBKvgu7IrfjLlAUdZZDPKCRHrPk/MtaCldP1OjOx7Pd+P3F8OQzfaHPMu
         y29x5a5f+baagDk9+HrSPEqYk5tAwIvFFnVBn7V5F+urvryfecUOrvbn7QRCq2Zllp6w
         5iy2hyesJJ7LwV1cd3tcUW0RFRJD7aFDSh048=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C0BamnOmkIohfFzvdCg9JNSKhJZ2qbMi94Zn2XJWcVk=;
        b=nJew4+pKYsd6foKkUGZhWswKGC/hmJkWOQmBCM1gIQvuFTdrLJlbQI6GQWCdDVXrlS
         zKYPqE4T1wIAG6VCfYDzN8iSBOd5kk4foE33QFFBVQRLSnzFexpIQbzr2f0KNWtQ37YD
         y+X8JPZsY1YL0E6YXZdm3Cvrj8ZQ6BjS/YT1M5sPEj8PfQvQNPdy14gZvxpgiSAjq7fI
         0VUCmtHRR14od5J6Eh/E3O9V2SXC1EmBHhN325N3irfvFRal8nJuAAtPlrArwRSUOzPQ
         1utw+t1nOK4dVuYWE2GD0MQ0kPOT6hwGxPv9JVL/V6v/JTADNeILRznW6R+q+G9QfJKI
         4RnQ==
X-Gm-Message-State: AGRZ1gKGxL5MxicY2uBAbu+OMwRNSCtSQZM7UBU7ZDJ5VNCWR/64xTJe
        WOLu2775Xq2YbxjySVhY0g2PMQ==
X-Google-Smtp-Source: AJdET5cUQsfPY3wejeW+oivvHCqJkheCVzzoORqdlSS88sEvsrVr4RuWOx6+0G9Uo9ejLKutur5S2w==
X-Received: by 2002:a1c:3e8d:: with SMTP id l135-v6mr1371220wma.13.1540465508470;
        Thu, 25 Oct 2018 04:05:08 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id m136-v6sm1003117wmb.4.2018.10.25.04.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 04:05:07 -0700 (PDT)
Date:   Thu, 25 Oct 2018 12:05:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan O'Donovan <dan@emutex.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        carlos.iglesias@emutex.com, Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v2 1/3] mfd: upboard: Add UP2 platform controller driver
Message-ID: <20181025110505.GA4870@dell>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-2-git-send-email-dan@emutex.com>
 <CAHp75VdkwfcPdSmB0dYBF_xwwXMqkrLOa1tL0xkOJ4DVcx8h8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdkwfcPdSmB0dYBF_xwwXMqkrLOa1tL0xkOJ4DVcx8h8g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Oct 2018, Andy Shevchenko wrote:

> On Fri, Oct 19, 2018 at 8:26 PM Dan O'Donovan <dan@emutex.com> wrote:
> >
> > From: Javier Arteaga <javier@emutex.com>
> >
> > UP Squared (UP2) is a x86 SBC from AAEON based on Intel Apollo Lake. It
> > features a MAX 10 FPGA that routes lines from both SoC and on-board
> > devices to two I/O headers:
> >
> >                                 +------------------------+
> >                                 | 40-pin RPi-like header |
> >                          +------|         (HAT)          |
> >                          |      +------------------------+
> >     +-------+    +--------+
> >     |       |    |        |     +------------------------+
> >     |  SoC  |----|  FPGA  |-----|  Custom UP2 pin header |
> >     |       |    |        |     |        (EXHAT)         |
> >     +-------+    +--------+     +------------------------+
> >                          |
> >                          +------* On-board devices: LED, VLS...
> >
> > This is intended to enable vendor-specific applications to customize I/O
> > header pinout, as well as include low-latency functionality. It also
> > performs voltage level translation between the SoC (1.8V) and HAT header
> > (3.3V).
> >
> > Out of the box, this block implements a platform controller with a
> > GPIO-bitbanged control interface. It's enumerated by ACPI and provides
> > registers to control:
> >
> > - Configuration of all FPGA-routed header lines. These can be driven
> >   SoC-to-header, header-to-SoC or set in high impedance.
> >
> > - On-board LEDs and enable lines for other platform devices.
> >
> > Add core support for this platform controller as a MFD device, exposing
> > these registers as a regmap.
> 
> Can we see a link to or an excerpt of ACPI table for this device?
> 
> > +#define set_clear(u, x) gpiod_set_value((u)->clear_gpio, (x))
> > +#define set_strobe(u, x) gpiod_set_value((u)->strobe_gpio, (x))
> > +#define set_datain(u, x) gpiod_set_value((u)->datain_gpio, (x))
> > +#define get_dataout(u) gpiod_get_value((u)->dataout_gpio)
> 
> I think these macros don't bring much value. (Up to you and Lee to decide)

I agree.

In fact I think they only serve to obfuscate instead of clarify.

[...]

> > +               set_strobe(ddata, 0);
> > +               set_strobe(ddata, 1);
> > +               *val |= get_dataout(ddata) << i;
> > +       }
> > +}
> 
> > +static int upboard_check_supported(struct device *dev, struct regmap *regmap)
> > +{
> > +       uint8_t manufacturer_id, build, major, minor, patch;
> > +       unsigned int platform_id, firmware_id;
> > +       int ret;
> 
> > +       manufacturer_id = platform_id & 0xff;
> 
> Redundant & 0xff part.

Maybe not required, but lets the reader know it's intended.

[...]

> > +       ret = upboard_init_gpio(dev);
> > +       if (ret) {
> > +               if (ret != -EPROBE_DEFER)
> > +                       dev_err(dev, "failed to init GPIOs: %d", ret);
> > +               return ret;
> > +       }
> 
> I don't know if probe_err() helper is going to be a part of v4.21
> (which this series targets), it would be good to use it.

Interesting.  What does it do?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
