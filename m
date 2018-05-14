Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeENKXd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:23:33 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35780 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeENKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:23:29 -0400
X-Google-Smtp-Source: AB8JxZpUbcDeGUDYbKs5P8CdgNNV8v5GAeX2mIbzBVscLIRXOMOTwvKmGhYHhGILlyx5w6Qsji3OJA==
Date: Mon, 14 May 2018 12:23:26 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: renesas: draak: Describe HDMI input
Message-ID: <20180514102326.GG30519@bigcity.dyn.berto.se>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526032802-14376-4-git-send-email-jacopo+renesas@jmondi.org>
 <20180513125755.GQ18974@bigcity.dyn.berto.se>
 <20180514073520.GA5956@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180514073520.GA5956@w540>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 2018-05-14 09:39:34 +0200, Jacopo Mondi wrote:
> Hi Niklas,
> 
> On Sun, May 13, 2018 at 02:57:55PM +0200, Niklas Söderlund wrote:
> > Hi Jacopo,
> >
> > Thanks for your patch.
> >
> > On 2018-05-11 12:00:02 +0200, Jacopo Mondi wrote:
> > > Describe HDMI input connected to VIN4 interface for R-Car D3 Draak
> > > development board.
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > > ---
> > >  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 68 ++++++++++++++++++++++++++
> > >  1 file changed, 68 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > > index d03f194..e0ce462 100644
> > > --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > > +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > > @@ -59,6 +59,17 @@
> > >  		};
> > >  	};
> > >
> > > +	hdmi-in {
> > > +		compatible = "hdmi-connector";
> > > +		type = "a";
> > > +
> > > +		port {
> > > +			hdmi_con_in: endpoint {
> > > +				remote-endpoint = <&adv7612_in>;
> > > +			};
> > > +		};
> > > +	};
> > > +
> > >  	memory@48000000 {
> > >  		device_type = "memory";
> > >  		/* first 128MB is reserved for secure area. */
> > > @@ -142,6 +153,11 @@
> > >  		groups = "usb0";
> > >  		function = "usb0";
> > >  	};
> > > +
> > > +	vin4_pins: vin4 {
> > > +		groups = "vin4_data24", "vin4_sync", "vin4_clk", "vin4_clkenb";
> > > +		function = "vin4";
> > > +	};
> > >  };
> > >
> > >  &i2c0 {
> > > @@ -154,6 +170,35 @@
> > >  		reg = <0x50>;
> > >  		pagesize = <8>;
> > >  	};
> > > +
> > > +	hdmi-decoder@4c {
> > > +		compatible = "adi,adv7612";
> > > +		reg = <0x4c>;
> > > +		default-input = <0>;
> > > +
> > > +		ports {
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +
> > > +			port@0 {
> > > +				reg = <0>;
> > > +				adv7612_in: endpoint {
> > > +					remote-endpoint = <&hdmi_con_in>;
> > > +				};
> > > +			};
> > > +
> > > +			port@2 {
> > > +				reg = <2>;
> > > +				adv7612_out: endpoint {
> > > +					pclk-sample = <0>;
> > > +					hsync-active = <0>;
> > > +					vsync-active = <0>;
> >
> > This differs from the Gen2 DT bindings which is a very similar hardware
> > setup using the same components. Defining these properties will make the
> > bus marked as V4L2_MBUS_PARALLEL instead of V4L2_MBUS_BT656.
> 
> And that's what we want....
> 
> >
> > This will change how the hardware is configured for capture if the media
> > bus is in a UYVY format, see VNMC_INF register in rvin_setup(). Maybe
> > this it not an issue here but still I'm curious to why this differ
> > between Gen2 and Gen3 :-)
> 
> Actually this won't impact the VIN configuration as this is the
> 'remote endpoint' from VIN perspective and the properties used to
> configure the interface are the ones in the 'local endpoint'.

You are right, sorry for the confusion and thanks for educating me :-)

> 
> >
> > > +
> > > +					remote-endpoint = <&vin4_in>;
> > > +				};
> > > +			};
> > > +		};
> > > +	};
> > >  };
> > >
> > >  &i2c1 {
> > > @@ -246,3 +291,26 @@
> > >  	timeout-sec = <60>;
> > >  	status = "okay";
> > >  };
> > > +
> > > +&vin4 {
> > > +	pinctrl-0 = <&vin4_pins>;
> > > +	pinctrl-names = "default";
> > > +
> > > +	status = "okay";
> > > +
> > > +	ports {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		port@0 {
> > > +			reg = <0>;
> > > +
> > > +			vin4_in: endpoint {
> > > +				hsync-active = <0>;
> > > +				vsync-active = <0>;
> >
> > Comparing this to the Gen2 bindings some properties are missing,
> >
> > bus-width = <24>;
> > pclk-sample = <1>;
> > data-active = <1>;
> 
> The VIN driver does not parse them, so there is no value in having
> them there, if not confusing people as it happened to me reading the
> Gen2 DT.

I have no objection removing them. Trying to understand why the 
description differed from Gen2.

> 
> >
> > This is not a big deal as the VIN driver don't use these properties so
> > no functional change should come of this but still a difference.
> 
> Exactly.
> 
> On a side note. I have not seen a way to configure the pixel clock
> sampling level in the interface datasheet. The register used to
> configure synchronism signals polarities is VnDMR2, and there I read
> we can configure HSYNC/VSYNC and CLOCKENB (which is data enable, not
> pixel clock) polarities. Is it configured through some other
> register?

I have not seen such a register no.

> >
> > Over all I'm happy with this change but before I add my tag I would like
> > to understand why it differs from the Gen2 configuration for the adv7612
> > properties.
> >
> > Also on a side not it is possible with hardware switches on the board
> > switch the VIN4 source to a completely different pipeline CVBS connector
> > -> adv7180 -> VIN4. But I think it's best we keep the HDMI as default as
> > this seems to be how the boards are shipped. But maybe mentioning this
> > in the commit message would not hurt if you end-up resending the patch.
> 
> Oh I see. SW-49 to SW-52 enables the HDMI input, SW53-SW54 CVBS one.
> And actually, reading the 'initial setting of slide switches' in the
> Draak board manual, it turns out that the board default configuration
> is with CVBS input selected... What should we do here? reflect
> defaults in the DT, or prioritize HDMI?

I feel this is a question for Laurent. My feeling for how we handled 
this in other cases is to go with the board default settings. I'm 
however sure there are exceptions to the rule. So maybe we should go 
with the most useful (what ever that is) configuration?

> 
> Thanks
>    j
> 
> >
> > > +
> > > +				remote-endpoint = <&adv7612_out>;
> > > +			};
> > > +		};
> > > +	};
> > > +};
> > > --
> > > 2.7.4
> > >
> >
> > --
> > Regards,
> > Niklas Söderlund



-- 
Regards,
Niklas Söderlund
