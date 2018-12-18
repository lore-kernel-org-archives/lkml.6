Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EAEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DAA21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeLRPqa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:46:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35543 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeLRPq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:46:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E6EF72072C; Tue, 18 Dec 2018 16:46:24 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id BBE2B206FF;
        Tue, 18 Dec 2018 16:46:24 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: ap806: add the cluster clock node in the syscon file
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
        <20181216094147.6468-2-gregory.clement@bootlin.com>
        <20181217225044.GA25148@bogus>
Date:   Tue, 18 Dec 2018 16:46:25 +0100
In-Reply-To: <20181217225044.GA25148@bogus> (Rob Herring's message of "Mon, 17
        Dec 2018 16:50:44 -0600")
Message-ID: <87efaehm7i.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
 
 On lun., déc. 17 2018, Rob Herring <robh@kernel.org> wrote:

> On Sun, Dec 16, 2018 at 10:41:42AM +0100, Gregory CLEMENT wrote:
>> Document the device tree binding for the cluster clock controllers found
>> in the Armada 7K/8K SoCs.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  .../arm/marvell/ap806-system-controller.txt   | 22 +++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
>> index 3fd21bb7cb37..8f281816a6b8 100644
>> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
>> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
>> @@ -136,3 +136,25 @@ ap_syscon1: system-controller@6f8000 {
>>  		#thermal-sensor-cells = <1>;
>>  	};
>>  };
>> +
>> +Cluster clocks:
>> +---------------
>> +
>> +Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
>> +cluster contain up to 2 CPUs running at the same frequency.
>> +
>> +Required properties:
>> +- compatible: must be  "marvell,ap806-cpu-clock";
>> +- #clock-cells : should be set to 1.
>> +- clocks : shall be the input parents clock phandle for the clock.
>> +
>> +ap_syscon1: system-controller@6f8000 {
>> +	compatible = "syscon", "simple-mfd";
>> +	reg = <0x6f8000 0x1000>;
>> +
>> +	cpu_clk: clock-cpu {
>
> There's not a register address range you can use even if Linux happens 
> to not need it (currently)?

We can add an optional reg property if you want, but the whole point of
this, is to be able to ensure the compatibility. Indeed, we have now
enough experience to know that the information we have from the
datasheet is incomplete. And when we start to deal with an IP calling
"system controller", then we can expect a mix between all the registers.

>
> There's already a clock node under this syscon? Are they really separate 
> sub-blocks?

Actually the other clock node (marvell,ap806-clock) is under the other
syscon: system controller 0 with gpio and pinctrl, whereas this one
(marvell,ap806-cpu-clock), is under system controller 1 with thermal.

Gregory

>
>> +		compatible = "marvell,ap806-cpu-clock";
>> +		clocks = <&ap_clk 0>, <&ap_clk 1>;
>> +		#clock-cells = <1>;
>> +	};
>> +};
>> -- 
>> 2.19.2
>> 

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
