Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD1FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA9420819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA9420819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbeKEWQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:16:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51052 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbeKEWQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:16:30 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cID7BvzdlixR; Mon,  5 Nov 2018 13:56:50 +0100 (CET)
Received: from zn.tnic (p200300EC2BC6CF00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:cf00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A94671EC01A8;
        Mon,  5 Nov 2018 13:56:50 +0100 (CET)
Date:   Mon, 5 Nov 2018 13:56:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Manish Narani <manish.narani@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, mchehab@kernel.org,
        amit.kucheria@linaro.org, sudeep.holla@arm.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
Message-ID: <20181105125644.GA7937@zn.tnic>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:37:00AM +0530, Manish Narani wrote:
> Add ddrc memory controller node in dts. The size mentioned in dts is
> 0x30000, because we need to access DDR_QOS INTR registers located at
> 0xFD090208 from this driver.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 29ce234..a81d3b16 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -355,6 +355,13 @@
>  			xlnx,bus-width = <64>;
>  		};
>  
> +		mc: memory-controller@fd070000 {
> +			compatible = "xlnx,zynqmp-ddrc-2.40a";
> +			reg = <0x0 0xfd070000 0x0 0x30000>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 112 4>;
> +		};
> +
>  		gem0: ethernet@ff0b0000 {
>  			compatible = "cdns,zynqmp-gem", "cdns,gem";
>  			status = "disabled";
> -- 

Ok, talking to Mark on IRC, he says those DT changes normally go through
the arm-soc tree.

And I'm fine with that except if we do that, then the EDAC changes
go through my tree and those drivers could end up temporarily broken
depending on the merge order and timing.

So should we perhaps make an arm-soc shared, immutable branch which you
guys export for me with those DT changes applied, which I can merge into
my tree and apply the EDAC changes ontop.

This is what we've been doing with the tip tree until now and it has
proven successful.

Thoughts?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
