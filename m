Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E9CECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7852083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7852083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeJSNz3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:55:29 -0400
Received: from hermes.aosc.io ([199.195.250.187]:50122 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeJSNz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:55:29 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 36D5F15D401;
        Fri, 19 Oct 2018 05:50:49 +0000 (UTC)
Date:   Fri, 19 Oct 2018 13:50:43 +0800
In-Reply-To: <10486569.ZhsSaQbvn5@anarsoul-thinkpad>
References: <20181018073327.64942-1-icenowy@aosc.io> <20181018073327.64942-8-icenowy@aosc.io> <10486569.ZhsSaQbvn5@anarsoul-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 7/9] arm64: allwinner: a64: enable ANX6345 bridge on Pinebook
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-arm-kernel@lists.infradead.org
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <5B167CD3-734F-4AE0-81F5-51749C9AD09C@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年10月18日 GMT+08:00 下午11:17:35, Vasily Khoruzhick <anarsoul@gmail.com> 写到:
>Hi Icenowy,
>
>On Thursday, October 18, 2018 12:33:25 AM PDT Icenowy Zheng wrote:
>> Pinebook has an ANX6345 bridge connected to the RGB666 LCD output,
>and
>> the I2C controlling signals are connected to R_I2C bus.
>> 
>> Enable it in the device tree, and add a usable EDID from the panel's
>> datasheet (at least 14" Pinebook used a panel without EDID).
>
>There's no EDID in dts and 14" Pinebook uses a panel with EDID. Is it
>leftover 
>of old comment?

Yes, it is.

>
>Regards,
>Vasily
>
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 43
>+++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts index
>> 77fac84797e9..d7c14d0d61f9 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> @@ -66,6 +66,10 @@
>>  	};
>>  };
>> 
>> +&de {
>> +	status = "okay";
>> +};
>> +
>>  &ehci0 {
>>  	phys = <&usbphy 0>;
>>  	phy-names = "usb";
>> @@ -76,6 +80,10 @@
>>  	status = "okay";
>>  };
>> 
>> +&mixer0 {
>> +	status = "okay";
>> +};
>> +
>>  &mmc0 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&mmc0_pins>;
>> @@ -127,6 +135,27 @@
>>  	status = "okay";
>>  };
>> 
>> +&r_i2c {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&r_i2c_pins_a>;
>> +	status = "okay";
>> +
>> +	anx6345: anx6345@38 {
>> +		compatible = "analogix,anx6345";
>> +		reg = <0x38>;
>> +		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
>> +		panel-supply = <&reg_dc1sw>;
>> +		dvdd25-supply = <&reg_dldo2>;
>> +		dvdd12-supply = <&reg_fldo1>;
>> +
>> +		port {
>> +			anx6345_in: endpoint {
>> +				remote-endpoint = <&tcon0_out_anx6345>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>  &r_rsb {
>>  	status = "okay";
>> 
>> @@ -267,6 +296,20 @@
>>  	vcc-hdmi-supply = <&reg_dldo1>;
>>  };
>> 
>> +&tcon0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&lcd_rgb666_pins>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&tcon0_out {
>> +	tcon0_out_anx6345: endpoint@0 {
>> +		reg = <0>;
>> +		remote-endpoint = <&anx6345_in>;
>> +	};
>> +};
>> +
>>  &uart0 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&uart0_pb_pins>;
