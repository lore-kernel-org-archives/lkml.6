Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBDBC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0602F24C1E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0602F24C1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeFWOeJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 10:34:09 -0400
Received: from hermes.aosc.io ([199.195.250.187]:38060 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbeFWOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 10:34:08 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 8A07B631BF;
        Sat, 23 Jun 2018 14:33:55 +0000 (UTC)
Date:   Sat, 23 Jun 2018 22:18:21 +0800
In-Reply-To: <CAGRGNgUuEjmEcvJ3OUcQ9_6bPs9fDvKzUFm_NfCsYyjxVOVw3A@mail.gmail.com>
References: <20180622124540.56203-1-icenowy@aosc.io> <20180622124540.56203-4-icenowy@aosc.io> <CAGRGNgUuEjmEcvJ3OUcQ9_6bPs9fDvKzUFm_NfCsYyjxVOVw3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH v2 5/7] arm64: allwinner: a64: add necessary device tree nodes for DE2 CCU
To:     julian.calaby@gmail.com, Julian Calaby <julian.calaby@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, jagan@amarulasolutions.com,
        jernej.skrabec@siol.net, devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <3BDC9318-95A5-41BA-801E-6E0814249AFB@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年6月23日 GMT+08:00 下午10:06:27, Julian Calaby <julian.calaby@gmail.com> 写到:
>Hi Icenowy,
>
>On Fri, Jun 22, 2018 at 10:49 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>>
>> As we have all necessary parts to enable the DE2 CCU on the Allwinner
>> A64 SoC, add the needed device tree nodes, including the DE2 CCU
>itself
>> and the DE2 bus.
>>
>> The "mixer0-lcd0" simplefb device node is updated to use the DE2 CCU.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v2:
>> - Drop SRAM controller device tree node addition (as it's already
>added
>>   as part of syscon change.)
>> - Fix the clock reference in LCD SimpleFB.
>>
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 30
>+++++++++++++++----
>>  1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index ff2ddde1e117..318c4ba8ae9f 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -58,17 +60,12 @@
>>                 #size-cells = <1>;
>>                 ranges;
>>
>> -/*
>> - * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2
>CCU.
>> - * However there is no support for this clock on A64 yet, so we
>depend
>> - * on the upstream clocks here to keep them (and thus CLK_MIXER0)
>up.
>> - */
>>                 simplefb_lcd: framebuffer-lcd {
>>                         compatible = "allwinner,simple-framebuffer",
>>                                      "simple-framebuffer";
>>                         allwinner,pipeline = "mixer0-lcd0";
>>                         clocks = <&ccu CLK_TCON0>,
>> -                                <&ccu CLK_DE>, <&ccu CLK_BUS_DE>;
>> +                                <&display_clocks CLK_MIXER0>;
>
>Doesn't this technically break simplefb if this DT is used with a
>Linux that doesn't have the display clock driver?

1. DT doesn't care forware compatibility.

2. This is a fix for not accurate HW representation. In
fact I have sent the DT with simplefb using DE2 CCU before, but
when they're pending, someone who just wants the simplefb
sent the not temporary version.This must be fixed.

>
>Do we care about breaking that use-case?
>
>Thanks,
