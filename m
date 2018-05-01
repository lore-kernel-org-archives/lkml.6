Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756115AbeEAOhT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:37:19 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45114 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756008AbeEAOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:37:17 -0400
X-Google-Smtp-Source: AB8JxZo8e3MrgK+5KMQE+hGrKw1rLx1qY4kA7SdbAaBRXo5Tnn/eUbC2RnVLwQ7VP12eFeEWzgzskw==
Date: Tue, 1 May 2018 09:37:15 -0500
From: Rob Herring <robh@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] clk: meson: axg: document bindings for the audio
 clock controller
Message-ID: <20180501143715.GA20023@rob-hp-laptop>
References: <20180425163304.10852-1-jbrunet@baylibre.com>
 <20180425163304.10852-7-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425163304.10852-7-jbrunet@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 06:33:03PM +0200, Jerome Brunet wrote:
> Add documentation for the device tree bindings of the audio clock
> controller of the A113 based SoCs
> 

The preferred subject prefix for bindings is 'dt/bindings: clock: ...'

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/clock/amlogic,axg-audio-clkc.txt      | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> new file mode 100644
> index 000000000000..1b989ceda567
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> @@ -0,0 +1,56 @@
> +* Amlogic AXG Audio Clock Controllers
> +
> +The Amlogic AXG audio clock controller generates and supplies clock to the
> +other elements of the audio subsystem, such as fifos, i2s, spdif and pdm
> +devices.
> +
> +Required Properties:
> +
> +- compatible	: should be "amlogic,axg-audio-clkc" for the A113X and A113D
> +- reg		: physical base address of the clock controller and length of
> +		  memory mapped region.
> +- clocks	: a list of phandle + clock-specifier pairs for the clocks listed
> +		  in clock-names.
> +- clock-names	: must contain the following:
> +		  * "pclk" - Main peripheral bus clock
> +		  may contain the following:
> +		  * "mst_in[0-7]" - 8 input plls to generate clock signals

Unless the sources don't exist, then you should always have the clocks. 
It should not be based on whether you are using them or not.

> +		  * "slv_sclk[0-9]" - 10 slave bit clocks provided by external
> +				      components.
> +		  * "slv_lrclk[0-9]" - 10 slave sample clocks provided by external
> +				       components.

I'm guessing these may come from pins that aren't connected, so being 
optional is fine.

> +- reset		: phandle of the internal reset line

resets

> +- #clock-cells	: should be 1.
> +
> +Each clock is assigned an identifier and client nodes can use this identifier
> +to specify the clock which they consume. All available clocks are defined as
> +preprocessor macros in the dt-bindings/clock/axg-audio-clkc.h header and can be
> +used in device tree sources.
> +
> +Example:
> +
> +clkc_audio: clock-controller {

Needs a unit address.

> +	compatible = "amlogic,axg-audio-clkc";
> +	reg = <0x0 0x0 0x0 0xb4>;
> +	#clock-cells = <1>;
> +
> +	clocks = <&clkc CLKID_AUDIO>,
> +		 <&clkc CLKID_MPLL0>,
> +		 <&clkc CLKID_MPLL1>,
> +		 <&clkc CLKID_MPLL2>,
> +		 <&clkc CLKID_MPLL3>,
> +		 <&clkc CLKID_HIFI_PLL>,
> +		 <&clkc CLKID_FCLK_DIV3>,
> +		 <&clkc CLKID_FCLK_DIV4>,
> +		 <&clkc CLKID_GP0_PLL>;
> +	clock-names = "pclk",
> +		      "mst_in0",
> +		      "mst_in1",
> +		      "mst_in2",
> +		      "mst_in3",
> +		      "mst_in4",
> +		      "mst_in5",
> +		      "mst_in6",
> +		      "mst_in7";
> +	resets = <&reset RESET_AUDIO>;
> +};
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
