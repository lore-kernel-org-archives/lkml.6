Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE44C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6290421924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbfBOQOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:14:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56569 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfBOQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:14:35 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gug8E-0006hP-Jr; Fri, 15 Feb 2019 17:14:30 +0100
Message-ID: <1550247269.2546.58.camel@pengutronix.de>
Subject: Re: [PATCH v1 2/3] ARM: dts: stm32: enable Vivante GPU support on
 stm32mp157c-ed1 board
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     devicetree@vger.kernel.org, Philippe Cornu <philippe.cornu@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 15 Feb 2019 17:14:29 +0100
In-Reply-To: <1550246316-9747-3-git-send-email-pierre-yves.mordret@st.com>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
         <1550246316-9747-3-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 15.02.2019, 16:58 +0100 schrieb Pierre-Yves MORDRET:
> Enable Vivante GPU driver for stm32mp157c-ed1 board.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  arch/arm/boot/dts/stm32mp157c-ed1.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts
> b/arch/arm/boot/dts/stm32mp157c-ed1.dts
> index 98ef7a0..792f402 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
> @@ -20,6 +20,17 @@
>  		reg = <0xC0000000 0x40000000>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		gpu_reserved: gpu@f8000000 {
> +			reg = <0xf8000000 0x8000000>;
> +			no-map;
> +		};
> +	};
> +

I don't think you need this. The GPU driver uses very little contig dma
memory. Most of the GPU memory is ordinary paged memory, so setting
aside a private memory region of this size is a waste of memory. Most
likely you can just allow the GPU driver to use the system global CMA
region.

Regards,
Lucas


>  	aliases {
>  		serial0 = &uart4;
>  	};
> @@ -53,6 +64,11 @@
>  	status = "okay";
>  };
>  
> +&gpu {
> +	contiguous-area = <&gpu_reserved>;
> +	status = "okay";
> +};
> +
>  &i2c4 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c4_pins_a>;
