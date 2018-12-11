Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C0BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8292C2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8292C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeLKOft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:35:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51231 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbeLKOft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:35:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CF281207B0; Tue, 11 Dec 2018 15:35:46 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9EA0E206D8;
        Tue, 11 Dec 2018 15:35:46 +0100 (CET)
Date:   Tue, 11 Dec 2018 15:35:45 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Cyrille.Pitchen@microchip.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-mtd@lists.infradead.org, broonie@kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Message-ID: <20181211143545.GR8952@piout.net>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
 <20181210213553.GK8952@piout.net>
 <22730de3-55f0-df21-312a-560a02f02dc7@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22730de3-55f0-df21-312a-560a02f02dc7@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 12:32:40+0000, Tudor.Ambarus@microchip.com wrote:
> Hi, Alexandre,
> 
> On 12/10/2018 11:35 PM, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 10/12/2018 17:15:29+0000, Tudor.Ambarus@microchip.com wrote:
> >> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> >>
> >> This patch configures the QSPI0 controller pin muxing and declares
> >> a jedec,spi-nor memory.
> >>
> >> sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
> >> memory which advertises a maximum frequency of 80MHz for Quad IO
> >> Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
> >> the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.
> >>
> >> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> >> [tudor.ambarus@microchip.com:
> >> - drop partitions,
> >> - add spi-rx/tx-bus-width
> >> - change spi-max-frequency to match the 80MHz limit advertised by
> >>   MX25L25673G for Quad IO Fast Read,
> >> - reword commit message and subject.]
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++++++
> >>  1 file changed, 31 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> >> index 518e2b095ccf..171bc82cfbbf 100644
> >> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> >> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> >> @@ -108,6 +108,21 @@
> >>  		};
> >>  
> >>  		apb {
> >> +			qspi0: spi@f0020000 {
> >> +				pinctrl-names = "default";
> >> +				pinctrl-0 = <&pinctrl_qspi0_default>;
> >> +				/* status = "okay"; */ /* conflict with sdmmc1 */
> > 
> > Isn't that conflicting then because I think the default is okay.
> qspi0 is disabled in sama5d2.dtsi.
> 

Ok, then maybe that comment is not necessary at all.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
