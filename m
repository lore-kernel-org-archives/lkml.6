Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5ABC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B41820883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B41820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbeGKOX5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:23:57 -0400
Received: from hermes.aosc.io ([199.195.250.187]:57372 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387834AbeGKOX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:23:57 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 1EE9864AC0;
        Wed, 11 Jul 2018 14:19:11 +0000 (UTC)
Date:   Wed, 11 Jul 2018 22:18:44 +0800
In-Reply-To: <CAGb2v65C=gQtkNUX4pV5wudWUPf3hLNnGuxgB48xq=d7nH9qxA@mail.gmail.com>
References: <20180711134450.43148-1-icenowy@aosc.io> <CAGb2v65C=gQtkNUX4pV5wudWUPf3hLNnGuxgB48xq=d7nH9qxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH 2/2] ARM: sun8i: h3: add SY8113B regulator on Banana Pi M2 Zero board
To:     wens@csie.org, Chen-Yu Tsai <wens@csie.org>
CC:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <9C53E8F0-C5F9-4730-AD72-1E6FA8793E4A@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月11日 GMT+08:00 下午10:15:41, Chen-Yu Tsai <wens@csie.org> 写到:
>Hi,
>
>On Wed, Jul 11, 2018 at 9:44 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> Banana Pi M2 Zero board has a SY8113B regulator, which is controlled
>via
>> GPIO and capable of outputing 1.1V when the PL1 GPIO is set to output
>0
>> or 1.1V when the PL6 GPIO is set to input or output 1, and the output
>is
>> the power supply of the ARM cores in H3 SoC.
>>
>> Add the device tree node of this regulator and set the cpu's
>cpu-supply
>> property to it.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 21
>+++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> index eb61dcf32797..abc8dc750f4b 100644
>> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> @@ -59,6 +59,23 @@
>>                 };
>>         };
>>
>> +       reg_vdd_cpux: vdd-cpux-regulator {
>> +               compatible = "regulator-gpio";
>> +               regulator-name = "vdd-cpux";
>> +               regulator-type = "voltage";
>> +               regulator-boot-on;
>> +               regulator-always-on;
>> +               regulator-min-microvolt = <1100000>;
>> +               regulator-max-microvolt = <1300000>;
>> +               regulator-ramp-delay = <50>; /* 4ms */
>> +
>> +               gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
>> +               enable-active-high;
>> +               gpios-states = <0x1>;
>> +               states = <1100000 0x0
>
>So looking at the schematics with the resistor values, this calculates
>to roughly 1.108475 (0.6 * (1 + 10 / 11.8)) ...
>
>> +                         1300000 0x1>;
>
>and this to 1.308475.

But I think it cannot reach such accuracy, because of the
error of component values and the error of the power voltage.

In addition, set it to a too accurate value may break the
common opp table.

>
>ChenYu
>
>> +       };
>> +
>>         wifi_pwrseq: wifi_pwrseq {
>>                 compatible = "mmc-pwrseq-simple";
>>                 pinctrl-names = "default";
>> @@ -66,6 +83,10 @@
>>         };
>>  };
>>
>> +&cpu0 {
>> +       cpu-supply = <&reg_vdd_cpux>;
>> +};
>> +
>>  &de {
>>         status = "okay";
>>  };
>> --
>> 2.17.1
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
