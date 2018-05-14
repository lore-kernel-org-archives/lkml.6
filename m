Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeENOQv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:16:51 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37754 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbeENOQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:16:48 -0400
X-Google-Smtp-Source: AB8JxZrBG/eSPECm1oG8ONowNjQOOPYFPtc394kCaiRWAAkX3fNpFPDapu49bziCJ7kRIiTVgwWV1g==
Message-ID: <1526307405.2897.29.camel@baylibre.com>
Subject: Re: [PATCH 6/7] clk: meson: axg: document bindings for the audio
 clock controller
From: Jerome Brunet <jbrunet@baylibre.com>
To: Rob Herring <robh@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 16:16:45 +0200
In-Reply-To: <20180501143715.GA20023@rob-hp-laptop>
References: <20180425163304.10852-1-jbrunet@baylibre.com>
         <20180425163304.10852-7-jbrunet@baylibre.com>
         <20180501143715.GA20023@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-01 at 09:37 -0500, Rob Herring wrote:
> On Wed, Apr 25, 2018 at 06:33:03PM +0200, Jerome Brunet wrote:
> > Add documentation for the device tree bindings of the audio clock
> > controller of the A113 based SoCs
> > 
> 
> The preferred subject prefix for bindings is 'dt/bindings: clock: ...'

Noted, I suppose meant 'dt-bindings: clocks: ..." which seems to used half of
the times
The rest use 'clk: {platform}: ...'

> 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  .../bindings/clock/amlogic,axg-audio-clkc.txt      | 56 ++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> > new file mode 100644
> > index 000000000000..1b989ceda567
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> > @@ -0,0 +1,56 @@
> > +* Amlogic AXG Audio Clock Controllers
> > +
> > +The Amlogic AXG audio clock controller generates and supplies clock to the
> > +other elements of the audio subsystem, such as fifos, i2s, spdif and pdm
> > +devices.
> > +
> > +Required Properties:
> > +
> > +- compatible	: should be "amlogic,axg-audio-clkc" for the A113X and A113D
> > +- reg		: physical base address of the clock controller and length of
> > +		  memory mapped region.
> > +- clocks	: a list of phandle + clock-specifier pairs for the clocks listed
> > +		  in clock-names.
> > +- clock-names	: must contain the following:
> > +		  * "pclk" - Main peripheral bus clock
> > +		  may contain the following:
> > +		  * "mst_in[0-7]" - 8 input plls to generate clock signals
> 
> Unless the sources don't exist, then you should always have the clocks. 
> It should not be based on whether you are using them or not.

This is not really the point. The parent controller may or may not provide some
of the PLL. This was the case during the development of the controller when the
HIFI pll was not available simply because there was no driver for it.

Whatever the reason for an input clock to be missing, this clock controller may
continue to serve its purpose even if some input plls are not provided/available
which is why these are not "mandatory"

> 
> > +		  * "slv_sclk[0-9]" - 10 slave bit clocks provided by external
> > +				      components.
> > +		  * "slv_lrclk[0-9]" - 10 slave sample clocks provided by external
> > +				       components.
> 
> I'm guessing these may come from pins that aren't connected, so being 
> optional is fine.
> 
> > +- reset		: phandle of the internal reset line
> 
> resets
> 
> > +- #clock-cells	: should be 1.
> > +
> > +Each clock is assigned an identifier and client nodes can use this identifier
> > +to specify the clock which they consume. All available clocks are defined as
> > +preprocessor macros in the dt-bindings/clock/axg-audio-clkc.h header and can be
> > +used in device tree sources.
> > +
> > +Example:
> > +
> > +clkc_audio: clock-controller {
> 
> Needs a unit address.
> 
> > +	compatible = "amlogic,axg-audio-clkc";
> > +	reg = <0x0 0x0 0x0 0xb4>;
> > +	#clock-cells = <1>;
> > +
> > +	clocks = <&clkc CLKID_AUDIO>,
> > +		 <&clkc CLKID_MPLL0>,
> > +		 <&clkc CLKID_MPLL1>,
> > +		 <&clkc CLKID_MPLL2>,
> > +		 <&clkc CLKID_MPLL3>,
> > +		 <&clkc CLKID_HIFI_PLL>,
> > +		 <&clkc CLKID_FCLK_DIV3>,
> > +		 <&clkc CLKID_FCLK_DIV4>,
> > +		 <&clkc CLKID_GP0_PLL>;
> > +	clock-names = "pclk",
> > +		      "mst_in0",
> > +		      "mst_in1",
> > +		      "mst_in2",
> > +		      "mst_in3",
> > +		      "mst_in4",
> > +		      "mst_in5",
> > +		      "mst_in6",
> > +		      "mst_in7";
> > +	resets = <&reset RESET_AUDIO>;
> > +};
> > -- 
> > 2.14.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
