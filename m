Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26E9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8137020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTyfYAYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8137020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbeGXPVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:21:19 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39335 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388386AbeGXPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:21:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id q12-v6so4217478qtp.6;
        Tue, 24 Jul 2018 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=M0wz1nHDyOwg1YcR9Z93Ir1MK1v4MNtmicbn9zJEH5Q=;
        b=jTyfYAYTTykAJQSu5h0XBeM//cxN0cdZiJD3oGfPgpAubTKJCx6ybITuSVgOVBzid4
         aRV+4a2pRARIz8SwEsjIkvGR1zRGi5qC0Ak5dfcqfCRoepgEt4NU+VoWXCQKp8W8m7Ju
         UDlaC58aviqx+HkKnEi25vv2cgB/+pRYQzs5+85Ec9HtmUYZ80z1PLD4qEm1jqAJFjTp
         jcnRQKdK30a8Mj/jghbiGf0L3E8+OyeHFOsUF0J55bH45avLTMwgkQMHLLCT8FKfLiOE
         l0Xybz5DSDRC29gy68ckXMKEy/t2WYuiZ11eEJ5eaanIqRc4HAsr3b3DNalDwLZlDpwc
         p4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=M0wz1nHDyOwg1YcR9Z93Ir1MK1v4MNtmicbn9zJEH5Q=;
        b=li40wJXS2fFeA1EBJvrnBh1KvlOIVDJVKL1apkrSLhuc9zuvA4tFFGsUv6GOFxDgwP
         QfA6EV4Ph25BCWgTk8GC2ifHBSn4H46zcRPV1Q5e73AVa7keOFTcO03FhkUVk9fdwFqH
         FLC+vC2GV53W6KIN6npzYrKDB1IeS88SSvwvKhy6erqNEQCZpAaPzlY/LHMHxmkYJ5xb
         ftwSS69TaJZ1sb5MLtUTZroQUDLJcnp8IHXCmyLsV2wdVg+/RSdFJ+luFFAUbSaBPWRA
         tIXK2Nr2lbdjelBsTufVMFnkKh6H+P8qASlQTrcX57HFl14TsmzHPEyc2/FzL9uittCt
         hmYA==
X-Gm-Message-State: AOUpUlFaUbHJXEXlMTbO8Wt2JI8ZVVFMKG3ECXs15/h4aNZXJK0qmvji
        aVfFYraIm5LmS1DDpPB67RQEsODfINsrZwuFFZ4=
X-Google-Smtp-Source: AAOMgpd5Wd5Usq9GzhKnRXuVMROXO9Ob72b+tan42ig75wnDaHDbslb+kDSQ6H8C2pWzURICpNLstdAdSTJlcB4R7ZM=
X-Received: by 2002:a0c:adf8:: with SMTP id x53-v6mr15348866qvc.19.1532441677162;
 Tue, 24 Jul 2018 07:14:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 07:14:36
 -0700 (PDT)
In-Reply-To: <20180720154132.2fwmwpiwtxa73ljf@ninjato>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se> <20180720154132.2fwmwpiwtxa73ljf@ninjato>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 16:14:36 +0200
X-Google-Sender-Auth: 92NLKo3K4O9M2EPsOuLbkC7P-w8
Message-ID: <CAK8P3a0+8a9LCyW2WX6gO2Pi3GJa_ofznC07LMHjWmxZ4HaX7Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 5:41 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> I don't have an actual example for I2C, maybe Wolfram does? But I can
>> invent a case. E.g. the speedy DMA-enabled master cannot generate
>> RESTART, which is a must for (re-)configuration, but not for passing
>> data to the device.
>
> DMA capable controllers may also not react adequate to the slave doing
> clock stretching (which is forbidden in I3C).
>
> Renesas R-Car Gen2 has two I2C IP cores. One can do DMA and automatic
> transfers to the PMIC, the other has I2C slave functionality. One cannot
> do I2C_SMBUS_QUICK, the other can. And some more kind of quirks.
> Sometimes you can mux the pins to GPIO, so you have a third option.
>
> This setup is the reason the demux driver exists.

Have you run into scenarios where you dynamically switch between
the two masters in order to do different things (on one slave, or
on multiple slaves), or could you always decide on one of them
at boot time with that particular chip?

>> Also consider some future HW that has several I3C blocks, but they
>> are not identical. There's one beefy kind and one slim kind (I'm sure
>> you can find HW with different flavors of I2C blocks). Even if the
>> HW designers intended for one type of block to be superior in every
>> aspect, they might have made a mistake? This HW also has a pinmux, so
>> the SW is free to route different I3C blocks to the actual I3C bus.
>
> So, basically this is what happened with R-Car. Now, I tend to think
> that I3C is much more complex and noone would put two I3C IP cores into
> on SoC. But it was not too long ago that I wouldn't believe someone put
> two different I2C IP cores into a SoC. Then again, it happened when I2C
> was around for 35 years...

I think an SoC design we will likely see is an i3c master multiplexed with
an i2c master to access one bus. The i2c master can then use clock
stretching and other things that may not work in the i3c master, and it
may be used in the absence of proper i3c drivers in the OS.

However, that case cannot be handled with the abstraction in the
proposed i3c framework, which can only deal with multiple i3c
standard compliant masters. I'm also not sure if it can be added
to the i2c-demux-pinctrl driver.

        Arnd
