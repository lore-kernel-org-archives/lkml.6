Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E58C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEF9218FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeLZQQj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:16:39 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48908 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbeLZQQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:16:39 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4C634209ED; Wed, 26 Dec 2018 17:16:37 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 196362070E;
        Wed, 26 Dec 2018 17:16:37 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI area
References: <20181221164503.5128-1-xypron.glpk@gmx.de>
Date:   Wed, 26 Dec 2018 17:16:37 +0100
In-Reply-To: <20181221164503.5128-1-xypron.glpk@gmx.de> (Heinrich Schuchardt's
        message of "Fri, 21 Dec 2018 17:45:03 +0100")
Message-ID: <87h8f09sbe.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heinrich,
 
 On ven., déc. 21 2018, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
> attempt to access it from Linux leads to an immediate crash.
>
> So let's make the same memory reservation as the vendor kernel.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

We got a similar patch one month ago and Russell King pointed that it
didn't match waht he saw on his MACCHIATObin:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/612360.html

on mine under U-Boot I got:

Marvell>> md 0x4000000
04000000: 00000000 00000007 00000005 00000040    ............@...
04000010: 00000001 00001000 00000007 00000001    ................
04000020: 00000008 00000000 00000009 00000000    ................
04000030: 0000000a 00000000 ffffffff ffffffff    ................
04000040: ffffffff ffffffff ffffffff ffffffff    ................
04000050: ffffffff ffffffff ffffffff ffffffff    ................
04000060: ffffffff ffffffff ffffffff ffffffff    ................
04000070: ffffffff ffffffff ffffffff ffffffff    ................
04000080: ffffffff ffffffff ffffffff ffffffff    ................
04000090: ffffffff ffffffff ffffffff ffffffff    ................
040000a0: ffffffff ffffffff ffffffff ffffffff    ................
040000b0: ffffffff ffffffff ffffffff ffffffff    ................
040000c0: ffffffff ffffffff ffffffff ffffffff    ................
040000d0: ffffffff ffffffff ffffffff ffffffff    ................
040000e0: ffffffff ffffffff ffffffff ffffffff    ................
040000f0: ffffffff ffffffff ffffffff ffffffff    ................

In my case I have an old ATF, however this kind of setting should be
done by the bootloader.

I am interested by your claim about causing an immediate crash when
accessing this region. How did you trigger it?

Gregory


> ---
> v2
> 	Move the change from armada-8040-mcbin.dts to armada-ap806.dtsi.
> 	I only have a MACCHIATObin for testing but
> 	https://github.com/MarvellEmbeddedProcessors/linux-marvell
> 	has the reservation in that file.
> ---
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 7d94c1fa592a..f8dafef83db0 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -28,6 +28,17 @@
>  		method = "smc";
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		psci-area@4000000 {
> +			reg = <0x0 0x4000000 0x0 0x200000>;
> +			no-map;
> +		};
> +	};
> +
>  	ap806 {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> -- 
> 2.19.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
