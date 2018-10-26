Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BB1ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DC62082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DC62082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeJ0FgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:36:09 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:40943 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJ0FgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:36:09 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:56286 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gG9Ag-0001tc-Ka; Fri, 26 Oct 2018 22:57:30 +0200
Subject: Re: [PATCH 0/3] drm: tinydrm driver for adafruit PiTFT 3.5"
 touchscreen
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20181024184313.2967-1-eric@anholt.net>
 <87h8harnv4.fsf@anholt.net>
 <2e548bd7-81f3-5952-b5de-96c26c9f6b19@tronnes.org>
 <87o9bhphhv.fsf@anholt.net>
 <2b5b8650-1e44-ea86-7b38-3b6a7ae793cb@tronnes.org>
Message-ID: <1defaf31-d014-03ea-a61d-8f7970b95dc4@tronnes.org>
Date:   Fri, 26 Oct 2018 22:57:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2b5b8650-1e44-ea86-7b38-3b6a7ae793cb@tronnes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 26.10.2018 21.16, skrev Noralf Trønnes:
>
> Den 26.10.2018 04.30, skrev Eric Anholt:
>> Noralf Trønnes <noralf@tronnes.org> writes:
>>
>>> Den 25.10.2018 18.29, skrev Eric Anholt:
>>>> Eric Anholt <eric@anholt.net> writes:
>>>>
>>>>> I was going to start working on making the vc4 driver work with
>>>>> tinydrm panels, but it turned out tinydrm didn't have the panel I had
>>>>> previously bought.  So, last night I ported the fbtft staging
>>>>> driver over to DRM.
>>>>>
>>>>> It seems to work (with DT at
>>>>> https://github.com/anholt/linux/commits/drm-misc-next-hx8357d) --
>>>>> fbdev works great including rotated, and so does modetest.  However,
>>>>> when X11 comes up at 16bpp, I get:
>>>>>
>>>>> https://photos.app.goo.gl/8tuhzPFFoDGamEfk8
>>>>>
>>>>> If I have tinydrm set a preferred bpp of 24, X looks great.  Noralf,
>>>>> any ideas?
>>>> Also, with these patches and the format modifier patch I just sent, 
>>>> mesa
>>>> with vc4 is now working with this driver on this branch:
>>>>
>>>> https://gitlab.freedesktop.org/anholt/mesa/commits/kmsro
>>> Ah, nice to see this happening!
>>> Getting hw rendering was one of the advantages I saw DRM could provide
>>> over fbdev on these displays. Little did I know how complicated 
>>> graphics
>>> was outside fbdev, so I was unable to realise this myself.
>>>
>>> The current solution to get hw rendering is to have a userspace process
>>> that continously copies the framebuffer:
>>> https://github.com/tasanakorn/rpi-fbcp
>>>
>>> It's used by some of the small DIY handheld game consoles that run
>>> emulators which requires hw rendering.
>>>
>>>> Now I wonder how we can improve performance of the SPI updates.
>>> At what SPI speed are you running? The datasheet for most of these
>>> display controllers list the max speed as 10MHz, but almost all of them
>>> can go faster. Some are reported going as high as 70-80MHz. That's for
>>> the pixel data transfer, not the commands. tinydrm/mipi-dbi.c sends
>>> commands at 10MHz and pixels at full speed 
>>> (mipi_dbi_spi_cmd_max_speed()).
>>> Most panels I have run at 32MHz or 48MHz.
>> I copied the DT from the adafruit tree, which has it at 32mhz. System
>> performance seems to be limited by the copy and format conversion I
>> think -- in particular, I wonder if we shouldn't be doing our dirty
>> copies in our own workqueue.  I haven't managed to get any really good
>> profiling data yet, though.
>>
>> glxgears at 128x128 is nice and smooth, and at 480x320 it's 6fps.
>> That's not filling 32mhz of SPI.  On the other hand, I would have
>> expected the uncached reads for the 4-to-2 swapped conversion to be able
>> to go faster than 3.5mb/sec.  If it's the uncached reads, we could at
>> least use NEON for the copy to cached, and probably even do the whole
>> conversion in NEON with a bit more thought.
>>
>> Another option: use a vc4 RCL to do RGBA8888 to RGB565, since that will
>> be less pressure on the bus.  But then, I suppose I should just figure
>> out what's going on that makes X11 at RGBA8888 break, and fix that so we
>> don't even have to do that conversion.
>>
>> I keep hoping there's some way we could feed output from the DISPSLAVE
>> HVS register directly to the SPI master -- FIFO32 gets us close (two
>> 16-bit pixels packed next to each other, leftmost in the lower 2 bytes),
>> but the need for byte swapping (as opposed to R/B swapping) I think
>> makes it impossible.
>
> I just did some speed tests on a 320x240 display at 3 different speeds.
> I also tried with byteswapping disabled. Only full updates will benefit
> from passing the buffer straight through to SPI. This is because partial
> updates are copied to a transfer buffer anyways to minimize SPI transfer
> time. No need to transfer things that haven't changed and a memory copy
> is far cheaper than a SPI transfer.
>
> SPI at 48MHz:
>
> pi@pi2835:~$ od -An -vtu4 --endian=big 
> /sys/bus/spi/devices/spi0.0/of_node/spi-max-frequency
>    48000000
>
> pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
> 28:320x240@XR24 -v
> setting mode 320x240-0Hz@XR24 on connectors 28, crtc 30
> freq: 24.87Hz
> freq: 24.79Hz
>
> pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
> 28:320x240@RG16 -v
> setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
> freq: 26.33Hz
> freq: 26.30Hz
>
> disable byteswapping:
> pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
> 28:320x240@RG16 -v
> setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
> freq: 28.40Hz
> freq: 28.43Hz
>
>
> SPI at 64MHz (seems to work):
>
> pi@pi2835:~$ od -An -vtu4 --endian=big 
> /sys/bus/spi/devices/spi0.0/of_node/spi-max-frequency
>    64000000
>
> pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
> 28:320x240@XR24 -v
> setting mode 320x240-0Hz@XR24 on connectors 28, crtc 30
> freq: 32.74Hz
> freq: 32.69Hz
>
> pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
> 28:320x240@RG16 -v
> setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
> freq: 35.44Hz
> freq: 35.19Hz
>
> disabled byteswapping:
> pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
> 28:320x240@RG16 -v
> setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
> freq: 39.29Hz
> freq: 39.11Hz
>
>
> SPI at 128MHz (not at all as garbled as I expected):
>
> pi@pi2835:~$ od -An -vtu4 --endian=big 
> /sys/bus/spi/devices/spi0.0/of_node/spi-max-frequency
>   128000000
>
> pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
> 28:320x240@XR24 -v
> setting mode 320x240-0Hz@XR24 on connectors 28, crtc 30
> freq: 48.69Hz
> freq: 48.40Hz
>
> pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
> 28:320x240@RG16 -v
> setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
> freq: 53.61Hz
> freq: 54.45Hz
>
> disabled byteswapping:
> pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
> 28:320x240@RG16 -v
> setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
> freq: 63.16Hz
> freq: 64.19Hz
>
>
> This is how I disabled byteswapping for this test:
>
> diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c 
> b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> index cb3441e51d5f..fa5d81521485 100644
> --- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
> +++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> @@ -228,6 +228,8 @@ static int mipi_dbi_fb_dirty(struct 
> drm_framebuffer *fb,
>         DRM_DEBUG("Flushing [FB:%d] x1=%u, x2=%u, y1=%u, y2=%u\n", 
> fb->base.id,
>                   clip.x1, clip.x2, clip.y1, clip.y2);
>
> +       full = true;
> +       swap = false;
>         if (!mipi->dc || !full || swap ||
>             fb->format->format == DRM_FORMAT_XRGB8888) {
>                 tr = mipi->tx_buf;
>
>
>>> Almost all the time is spent in the SPI transfer, so every hz 
>>> counts. On
>>> the Pi there's byte swapping because the DMA capable SPI controller 
>>> can't
>>> do 16-bit (tinydrm_swab16()). If I remember correctly this has 
>>> negligible
>>> impact on performance.
>>>
>>> The SPI controller/driver on the Pi has some restrictions on the speeds
>>> to choose from because the divisor has to be a multiple of two
>>> (bcm2835_spi_transfer_one()).
>> That's weird.  My specs say CDIV must be a *power* of two, with lower
>> values rounded down.  I guess that means we might be running things
>> fast, not slow, though (and at 32mhz out of 250, we should be getting
>> the same CDIV).
>
> Yes, that's what the datasheet says.
> When fbtft was out-of-tree I distributed a custom kernel with fbtft and
> Martin Sperl's DMA capable spi-bcm2708. In that version I also allowed
> odd cdiv's with no ill effects reported:
> https://github.com/notro/spi-bcm2708/wiki#spi-clock-divider
> (see the link to the forum post for details)
> Maybe the hw just ignores odd cdiv's, I don't know.
>

I lifted the cdiv being odd limitation but it didn't give more speeds.
The test does demonstrate that it doesn't have to be a power of two though.

pi@pi2835:~$ od -An -vtu4 --endian=big 
/sys/bus/spi/devices/spi0.0/of_node/spi-max-frequency
    40000000
pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
28:320x240@RG16 -v
setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
freq: 26.32Hz
freq: 26.22Hz

pi@pi2835:~$ dmesg | grep cdiv
[   59.820514] bcm2835_spi_transfer_one: cdiv=7


pi@pi2835:~$ od -An -vtu4 --endian=big 
/sys/bus/spi/devices/spi0.0/of_node/spi-max-frequency
    48000000
pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
28:320x240@RG16 -v
setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
freq: 26.32Hz
freq: 26.28Hz

pi@pi2835:~$ dmesg | grep cdiv
[   59.250549] bcm2835_spi_transfer_one: cdiv=6


pi@pi2835:~$ od -An -vtu4 --endian=big 
/sys/bus/spi/devices/spi0.0/of_node/spi-max-frequency
    56000000
pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
28:320x240@RG16 -v
setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
freq: 35.33Hz
freq: 35.42Hz

pi@pi2835:~$ dmesg | grep cdiv
[   67.760747] bcm2835_spi_transfer_one: cdiv=5


pi@pi2835:~$ od -An -vtu4 --endian=big 
/sys/bus/spi/devices/spi0.0/of_node/spi-max-frequency
    64000000

pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
28:320x240@RG16 -v
setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
freq: 35.40Hz
freq: 35.35Hz

pi@pi2835:~$ dmesg | grep cdiv
[   76.061747] bcm2835_spi_transfer_one: cdiv=4


pi@pi2835:~$ od -An -vtu4 --endian=big 
/sys/bus/spi/devices/spi0.0/of_node/spi-max-frequency
    96000000

pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
28:320x240@RG16 -v
setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
freq: 54.46Hz
freq: 54.65Hz

pi@pi2835:~$ dmesg | grep cdiv
[  623.200407] bcm2835_spi_transfer_one: cdiv=3


pi@pi2835:~$ od -An -vtu4 --endian=big 
/sys/bus/spi/devices/spi0.0/of_node/spi-max-frequency
   128000000
pi@pi2835:~$ ./libdrm/tests/modetest/modetest -M mi0283qt -s 
28:320x240@RG16 -v
setting mode 320x240-0Hz@RG16 on connectors 28, crtc 30
freq: 54.43Hz
freq: 54.31Hz

pi@pi2835:~$ dmesg | grep cdiv
[   65.350713] bcm2835_spi_transfer_one: cdiv=2


I can add here that XRGB8888 was added to support things like plymouth
that only supports that one format. RGB565 is the native format supported
by the driver. These MIPI compatible controllers do support RGB888, but
there's no point in implementing it since it will increase the transfer
time by 50% due to the extra byte, so it's of little use.

Noralf.

