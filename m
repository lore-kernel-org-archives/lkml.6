Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F80CECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6181B20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6181B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeJZG1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:27:04 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:41836 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeJZG1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:27:04 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52845 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gFnYT-0006AI-Q8; Thu, 25 Oct 2018 23:52:37 +0200
Subject: Re: [PATCH 0/3] drm: tinydrm driver for adafruit PiTFT 3.5"
 touchscreen
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20181024184313.2967-1-eric@anholt.net>
 <87h8harnv4.fsf@anholt.net>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <2e548bd7-81f3-5952-b5de-96c26c9f6b19@tronnes.org>
Date:   Thu, 25 Oct 2018 23:52:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87h8harnv4.fsf@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 25.10.2018 18.29, skrev Eric Anholt:
> Eric Anholt <eric@anholt.net> writes:
>
>> I was going to start working on making the vc4 driver work with
>> tinydrm panels, but it turned out tinydrm didn't have the panel I had
>> previously bought.  So, last night I ported the fbtft staging
>> driver over to DRM.
>>
>> It seems to work (with DT at
>> https://github.com/anholt/linux/commits/drm-misc-next-hx8357d) --
>> fbdev works great including rotated, and so does modetest.  However,
>> when X11 comes up at 16bpp, I get:
>>
>> https://photos.app.goo.gl/8tuhzPFFoDGamEfk8
>>
>> If I have tinydrm set a preferred bpp of 24, X looks great.  Noralf,
>> any ideas?
> Also, with these patches and the format modifier patch I just sent, mesa
> with vc4 is now working with this driver on this branch:
>
> https://gitlab.freedesktop.org/anholt/mesa/commits/kmsro

Ah, nice to see this happening!
Getting hw rendering was one of the advantages I saw DRM could provide
over fbdev on these displays. Little did I know how complicated graphics
was outside fbdev, so I was unable to realise this myself.

The current solution to get hw rendering is to have a userspace process
that continously copies the framebuffer:
https://github.com/tasanakorn/rpi-fbcp

It's used by some of the small DIY handheld game consoles that run
emulators which requires hw rendering.

> Now I wonder how we can improve performance of the SPI updates.

At what SPI speed are you running? The datasheet for most of these
display controllers list the max speed as 10MHz, but almost all of them
can go faster. Some are reported going as high as 70-80MHz. That's for
the pixel data transfer, not the commands. tinydrm/mipi-dbi.c sends
commands at 10MHz and pixels at full speed (mipi_dbi_spi_cmd_max_speed()).
Most panels I have run at 32MHz or 48MHz.

Almost all the time is spent in the SPI transfer, so every hz counts. On
the Pi there's byte swapping because the DMA capable SPI controller can't
do 16-bit (tinydrm_swab16()). If I remember correctly this has negligible
impact on performance.

The SPI controller/driver on the Pi has some restrictions on the speeds
to choose from because the divisor has to be a multiple of two
(bcm2835_spi_transfer_one()).

A full update on a 320x480 RGB565 panel is 262.5kB, so it's a lot to push
over SPI. A 2.8" 320x240 panel is more suitable for video fps, because of
the lower resolution.

I'll look at the patches during the weekend.

Noralf.


