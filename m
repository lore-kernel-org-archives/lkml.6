Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755580AbeCSPC0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:02:26 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53206 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754923AbeCSPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:02:22 -0400
X-Google-Smtp-Source: AG47ELuf87s6V+6Ce5qm3OpxzdW93wcOdj+t3seUzdBReQVpsV9TuOMxgQPPWJnG93LMTotb1CJCFA==
Date: Mon, 19 Mar 2018 11:02:17 -0400
From: Matt Porter <mporter@konsulko.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: dts: hummingboard2: convert onboard audio to
 simple-audio-card
Message-ID: <20180319150217.legzgw6a63b7a3ky@bacon.ohporter.com>
References: <20180319135326.24357-1-mporter@konsulko.com>
 <20180319142350.GE2743@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319142350.GE2743@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 02:23:50PM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 19, 2018 at 09:53:26AM -0400, Matt Porter wrote:
> > The HB2 onboard audio currently makes use of the imx-audio-sgtl5000
> > binding. This binding does not support auxiliary audio devices such
> > as external amplifiers. The simple-audio-card binding does support
> > this property which allows systems incorporating the HB2 to easily
> > add an auxiliary device that's attached to the HB2 audio jack with
> > an overlay. Convert HB2 to use simple-audio-card for the onboard
> > audio to allow for this additional flexibility.
> 
> What is driving this change?

I have an HB2 that's incorporated in a platform that includes an
audio processor (tda7419) and external amplifier (tda7850) attached to
the HB2 headphone out. The tda7419 also handles two additional non-Linux
audio source inputs, FWIW. The tda7419 and tda7850 are supported as
ASoC component drivers. However, they must be added to a card as
auxiliary devices to be instantiated and have their controls exposed
to userspace. In addition, once added as an aux device, the tda7419
muxes and switches can participate in DAPM properly. Using
simple-audio-card enables this option, without giving up any of the
current functionality when using imx-audio-sgtl5000.

>Why only make this change for HB2 and not HB?

I was a little fixated on the HB2 platform that I'm working on. It's
equally applicable to HB so I can add the same change there.

-Matt

> > Signed-off-by: Matt Porter <mporter@konsulko.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 48 +++++++++++++++++++++++-----
> >  1 file changed, 40 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
> > index dffbc92e0023..587251ab76ec 100644
> > --- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
> > @@ -38,6 +38,7 @@
> >   *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >   *     OTHER DEALINGS IN THE SOFTWARE.
> >   */
> > +#include <dt-bindings/sound/fsl-imx-audmux.h>
> >  
> >  / {
> >  	chosen {
> > @@ -145,22 +146,52 @@
> >  		vin-supply = <&v_5v0>;
> >  	};
> >  
> > -	sound-sgtl5000 {
> > -		audio-codec = <&sgtl5000>;
> > -		audio-routing =
> > +	audio: sound-sgtl5000 {
> > +		compatible = "simple-audio-card";
> > +		simple-audio-card,name = "On-Board Codec";
> > +		simple-audio-card,format = "i2s";
> > +		simple-audio-card,bitclock-master = <&sound_codec>;
> > +		simple-audio-card,frame-master = <&sound_codec>;
> > +		simple-audio-card,widgets =
> > +			"Microphone", "Mic Jack",
> > +			"Headphone", "Headphone Jack";
> > +		simple-audio-card,routing =
> >  			"MIC_IN", "Mic Jack",
> >  			"Mic Jack", "Mic Bias",
> >  			"Headphone Jack", "HP_OUT";
> > -		compatible = "fsl,imx-audio-sgtl5000";
> > -		model = "On-board Codec";
> > -		mux-ext-port = <5>;
> > -		mux-int-port = <1>;
> > -		ssi-controller = <&ssi1>;
> > +
> > +		sound_cpu: simple-audio-card,cpu {
> > +			sound-dai = <&ssi1>;
> > +		};
> > +
> > +		sound_codec: simple-audio-card,codec {
> > +			sound-dai = <&sgtl5000>;
> > +		};
> >  	};
> >  };
> >  
> >  &audmux {
> >  	status = "okay";
> > +
> > +	ssi1 {
> > +		fsl,audmux-port = <0>;
> > +		fsl,port-config = <
> > +			(IMX_AUDMUX_V2_PTCR_SYN |
> > +			 IMX_AUDMUX_V2_PTCR_TFSEL(4) |
> > +			 IMX_AUDMUX_V2_PTCR_TCSEL(4) |
> > +			 IMX_AUDMUX_V2_PTCR_TFSDIR |
> > +			 IMX_AUDMUX_V2_PTCR_TCLKDIR)
> > +			 IMX_AUDMUX_V2_PDCR_RXDSEL(4)
> > +		>;
> > +	};
> > +
> > +	pins5 {
> > +		fsl,audmux-port = <4>;
> > +		fsl,port-config = <
> > +			IMX_AUDMUX_V2_PTCR_SYN
> > +			IMX_AUDMUX_V2_PDCR_RXDSEL(0)
> > +		>;
> > +	};
> >  };
> >  
> >  &ecspi2 {
> > @@ -193,6 +224,7 @@
> >  		compatible = "fsl,sgtl5000";
> >  		pinctrl-names = "default";
> >  		pinctrl-0 = <&pinctrl_hummingboard2_sgtl5000>;
> > +		#sound-dai-cells = <0>;
> >  		reg = <0x0a>;
> >  		VDDA-supply = <&v_3v2>;
> >  		VDDD-supply = <&vcc_1p8>;
> > -- 
> > 2.11.0
> > 
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
