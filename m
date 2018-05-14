Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932971AbeENRDF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:03:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41604 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755228AbeENRDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:03:03 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Niklas =?ISO-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Cc: jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, horms@verge.net.au,
        geert@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: renesas: draak: Describe HDMI input
Date: Mon, 14 May 2018 20:03:18 +0300
Message-ID: <2432779.DoTkMjUeVb@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180514102326.GG30519@bigcity.dyn.berto.se>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org> <20180514073520.GA5956@w540> <20180514102326.GG30519@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EH3Bpu012218

Hi Niklas,

On Monday, 14 May 2018 13:23:26 EEST Niklas Söderlund wrote:
> On 2018-05-14 09:39:34 +0200, Jacopo Mondi wrote:
> > On Sun, May 13, 2018 at 02:57:55PM +0200, Niklas Söderlund wrote:
> >> On 2018-05-11 12:00:02 +0200, Jacopo Mondi wrote:
> >>> Describe HDMI input connected to VIN4 interface for R-Car D3 Draak
> >>> development board.
> >>> 
> >>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>> ---
> >>> 
> >>>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 68 +++++++++++++++++++
> >>>  1 file changed, 68 insertions(+)
> >>> 
> >>> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> >>> b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index
> >>> d03f194..e0ce462 100644
> >>> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> >>> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts

[snip]

> >>> +&vin4 {
> >>> +	pinctrl-0 = <&vin4_pins>;
> >>> +	pinctrl-names = "default";
> >>> +
> >>> +	status = "okay";
> >>> +
> >>> +	ports {
> >>> +		#address-cells = <1>;
> >>> +		#size-cells = <0>;
> >>> +
> >>> +		port@0 {
> >>> +			reg = <0>;
> >>> +
> >>> +			vin4_in: endpoint {
> >>> +				hsync-active = <0>;
> >>> +				vsync-active = <0>;
> >> 
> >> Comparing this to the Gen2 bindings some properties are missing,
> >> 
> >> bus-width = <24>;
> >> pclk-sample = <1>;
> >> data-active = <1>;
> > 
> > The VIN driver does not parse them, so there is no value in having
> > them there, if not confusing people as it happened to me reading the
> > Gen2 DT.
> 
> I have no objection removing them. Trying to understand why the
> description differed from Gen2.
> 
> >> This is not a big deal as the VIN driver don't use these properties so
> >> no functional change should come of this but still a difference.
> > 
> > Exactly.
> > 
> > On a side note. I have not seen a way to configure the pixel clock
> > sampling level in the interface datasheet. The register used to
> > configure synchronism signals polarities is VnDMR2, and there I read
> > we can configure HSYNC/VSYNC and CLOCKENB (which is data enable, not
> > pixel clock) polarities. Is it configured through some other
> > register?
> 
> I have not seen such a register no.
> 
> >> Over all I'm happy with this change but before I add my tag I would like
> >> to understand why it differs from the Gen2 configuration for the adv7612
> >> properties.
> >> 
> >> Also on a side not it is possible with hardware switches on the board
> >> switch the VIN4 source to a completely different pipeline CVBS connector
> >> -> adv7180 -> VIN4. But I think it's best we keep the HDMI as default as
> >> this seems to be how the boards are shipped. But maybe mentioning this
> >> in the commit message would not hurt if you end-up resending the patch.
> > 
> > Oh I see. SW-49 to SW-52 enables the HDMI input, SW53-SW54 CVBS one.
> > And actually, reading the 'initial setting of slide switches' in the
> > Draak board manual, it turns out that the board default configuration
> > is with CVBS input selected... What should we do here? reflect
> > defaults in the DT, or prioritize HDMI?
> 
> I feel this is a question for Laurent. My feeling for how we handled
> this in other cases is to go with the board default settings. I'm
> however sure there are exceptions to the rule. So maybe we should go
> with the most useful (what ever that is) configuration?

I think I'd go with CVBS as I don't think HDMI would be considered as the most 
useful configuration here. The Draak board is unlikely to be used by us as a 
reference platform to test HDMI capture, is it ?

This being said, you can instantiate the adv7612 and HDMI connector in DT, 
without connecting them to the VIN. That would make it easy to quickly change 
the configuration.

> >>> +
> >>> +				remote-endpoint = <&adv7612_out>;
> >>> +			};
> >>> +		};
> >>> +	};
> >>> +};

-- 
Regards,

Laurent Pinchart
