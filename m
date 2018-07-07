Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A817C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0492254B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0492254B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbeGGDiF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:38:05 -0400
Received: from hermes.aosc.io ([199.195.250.187]:45329 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932635AbeGGDiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:38:03 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 25E4964376;
        Sat,  7 Jul 2018 03:37:58 +0000 (UTC)
Date:   Sat, 07 Jul 2018 11:37:52 +0800
In-Reply-To: <CAGb2v67=FeGJ6PJLsru5ScXdTyLdCczQ7BNRmOnh-+4g7iCFqg@mail.gmail.com>
References: <20180706153805.25842-1-icenowy@aosc.io> <20180706153805.25842-9-icenowy@aosc.io> <CAGb2v67=FeGJ6PJLsru5ScXdTyLdCczQ7BNRmOnh-+4g7iCFqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH v2 8/9] arm64: allwinner: dts: h6: add USB3 device nodes
To:     Chen-Yu Tsai <wens@csie.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <76682488-74B8-4CEE-ACD5-29C667C438AE@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月7日 GMT+08:00 上午11:35:22, Chen-Yu Tsai <wens@csie.org> 写到:
>On Fri, Jul 6, 2018 at 11:38 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> Allwinner H6 SoC features USB3 functionality, with a DWC3 controller
>and
>> a custom PHY.
>>
>> Add device tree nodes for them.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v2:
>> - Rebased on top of the USB2 support patch.
>> - Dropped the dwc3-of-simple device.
>>
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 24
>++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> index 62fc0f5e10ba..6738e97ee37f 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> @@ -229,6 +229,30 @@
>>                         status = "disabled";
>>                 };
>>
>> +               dwc3: dwc3 {
>> +                       compatible = "snps,dwc3";
>> +                       reg = <0x5200000 0x10000>;
>> +                       interrupts = <GIC_SPI 26
>IRQ_TYPE_LEVEL_HIGH>;
>> +                       /* The only clock is shared. */
>> +                       clocks = <&ccu CLK_BUS_XHCI>,
>> +                                <&ccu CLK_BUS_XHCI>,
>> +                                <&ccu CLK_BUS_XHCI>;
>> +                       clock-names = "ref", "bus_early", "suspend";
>
>The diagram in the user manual also shows the low speed 32k oscillator
>being fed into DWC3. Maybe someone with more knowledge of what the IP
>block expects can give us a clue about which one of these it is.

If possible, I think it's suspend clock.

I have checked RK3399 clk tree and USB3 ref is just a gate
on 24M osc, and bus clock is surely CLK_BUS_XHCI.

>
>ChenYu
>
>> +                       resets = <&ccu RST_BUS_XHCI>;
>> +                       /*
>> +                        * The datasheet of the chip doesn't declare
>the
>> +                        * peripheral function, and there's no boards
>known
>> +                        * to have a USB Type-B port routed to the
>port.
>> +                        * In addition, no one has tested the
>peripheral
>> +                        * function yet.
>> +                        * So set the dr_mode to "host" in the DTSI
>file.
>> +                        */
>> +                       dr_mode = "host";
>> +                       phys = <&usb3phy>;
>> +                       phy-names = "usb3-phy";
>> +                       status = "disabled";
>> +               };
>> +
>>                 usb3phy: phy@5210000 {
>>                         compatible = "allwinner,sun50i-h6-usb3-phy";
>>                         reg = <0x5210000 0x10000>;
>> --
>> 2.17.1
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
