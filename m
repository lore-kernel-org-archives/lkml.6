Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeEaA6c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:58:32 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33866 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932475AbeEaA6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:58:30 -0400
X-Google-Smtp-Source: ADUXVKJP9DPznFy6QcZM0ySAXrOkhghMhbzQQnr/j0G85Q8t4Kg78fKcH6rrS2G0kbseJ/WFZG5jBQ==
Date: Wed, 30 May 2018 19:58:27 -0500
From: Rob Herring <robh@kernel.org>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        alsa-devel@alsa-project.org, nicolas.ferre@microchip.com,
        boris.brezillon@bootlin.com, alexandre.belloni@bootlin.com,
        broonie@kernel.org, Cristian.Birsan@microchip.com
Subject: Re: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S mux clock
Message-ID: <20180531005827.GA17203@rob-hp-laptop>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 03:34:22PM +0300, Codrin Ciubotariu wrote:
> The I2S mux clock can be used to select the I2S input clock. The
> available parents are the peripheral and the generated clocks.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  .../devicetree/bindings/clock/at91-clock.txt       | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
> index 51c259a..1c46b3c 100644
> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
> @@ -90,6 +90,8 @@ Required properties:
>  	"atmel,sama5d2-clk-audio-pll-pmc"
>  		at91 audio pll output on AUDIOPLLCLK that feeds the PMC
>  		and can be used by peripheral clock or generic clock
> +	"atmel,sama5d2-clk-i2s-mux":
> +		at91 I2S clock source selection

Is this boolean or takes some values. If latter, what are valid values?

>  
>  Required properties for SCKC node:
>  - reg : defines the IO memory reserved for the SCKC.
> @@ -507,3 +509,35 @@ For example:
>  			atmel,clk-output-range = <0 83000000>;
>  		};
>  	};
> +
> +Required properties for I2S mux clocks:
> +- #size-cells : shall be 0 (reg is used to encode I2S bus id).
> +- #address-cells : shall be 1 (reg is used to encode I2S bus id).
> +- name: device tree node describing a specific mux clock.
> +	* #clock-cells : from common clock binding; shall be set to 0.
> +	* clocks : shall be the mux clock parent phandles; shall be 2 phandles:
> +	  peripheral and generated clock; the first phandle shall belong to the
> +	  peripheral clock and the second one shall belong to the generated
> +	  clock; "clock-indices" property can be user to specify
> +	  the correct order.
> +	* reg: I2S bus id of the corresponding mux clock.
> +	  e.g. reg = <0>; for i2s0, reg = <1>; for i2s1
> +
> +For example:
> +	i2s_clkmux {

What is this a child of?

> +		compatible = "atmel,sama5d2-clk-i2s-mux";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

How do you address this block? My guess is you don't because it is just 
part of some other block and you are just creating this node to 
instantiate a driver. Just make the node for the actual h/w block a 
clock provider and define the clock ids (0 and 1).

> +
> +		i2s0muxck: i2s0_muxclk {
> +			clocks = <&i2s0_clk>, <&i2s0_gclk>;
> +			#clock-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		i2s1muxck: i2s1_muxclk {
> +			clocks = <&i2s1_clk>, <&i2s1_gclk>;
> +			#clock-cells = <0>;
> +			reg = <1>;
> +		};
> +	};
> -- 
> 2.7.4
> 
