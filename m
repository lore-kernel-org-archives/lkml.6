Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeBEGLN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:11:13 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35439 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753007AbeBEGJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:09:34 -0500
X-Google-Smtp-Source: AH8x224LEX7xqk9szc6PTVzSJIfMS3uy3fDOmKhJHANiZxYPKNXU5+5zn/lzH/b9gIJqu/QHRGWiZQ==
Date: Mon, 5 Feb 2018 00:09:32 -0600
From: Rob Herring <robh@kernel.org>
To: gabriel.fernandez@st.com
Cc: Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, gabriel.fernandez.st@gmail.com,
        olivier.bideau@st.com
Subject: Re: [PATCH 01/14] dt-bindings: Document STM32MP1 Reset Clock
 Controller (RCC) bindings
Message-ID: <20180205042238.64xjrrguls2drtrg@rob-hp-laptop>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
 <1517580222-23301-2-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517580222-23301-2-git-send-email-gabriel.fernandez@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 03:03:29PM +0100, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> The RCC block is responsible of the management of the clock and reset
> generation for the complete circuit.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/mfd/st,stm32-rcc.txt       | 85 ++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt b/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
> new file mode 100644
> index 0000000..28017a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
> @@ -0,0 +1,85 @@
> +STMicroelectronics STM32 Peripheral Reset Clock Controller
> +==========================================================
> +
> +The RCC IP is both a reset and a clock controller.
> +
> +Please also refer to reset.txt for common reset controller binding usage.
> +
> +Please also refer to clock-bindings.txt for common clock controller
> +binding usage.
> +
> +
> +Required properties:
> +- compatible: "simple-mfd", "syscon"


> +- reg: should be register base and length as documented in the datasheet
> +
> +- Sub-nodes:
> +  - compatible: "st,stm32mp1-rcc-clk"
> +	- #clock-cells: 1, device nodes should specify the clock in their
> +	  "clocks" property, containing a phandle to the clock device node,
> +	  an index specifying the clock to use.
> +
> +  - compatible: "st,stm32mp1-rcc-rst"
> +	- #reset-cells: Shall be 1
> +
> +Example:
> +	rcc: rcc@50000000 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0x50000000 0x1000>;
> +
> +		rcc_clk: rcc-clk@50000000 {
> +			#clock-cells = <1>;
> +			compatible = "st,stm32mp1-rcc-clk";
> +		};
> +
> +		rcc_rst: rcc-reset@50000000 {

You should not have the same unit-address twice.

IMO, this should just be:

	rcc: rcc@50000000 {
		compatible = "st-stm32mp1-rcc";
		reg = <0x50000000 0x1000>;
		#clock-cells = <1>;
		#reset-cells = <1>;
	};

There's no reason a node can't provide more than 1 function.


> +			#reset-cells = <1>;
> +			compatible = "st,stm32mp1-rcc-rst";
> +		};
> +	};
> +
> +Specifying clocks
> +=================
> +
> +All available clocks are defined as preprocessor macros in
> +dt-bindings/clock/stm32mp1-clks.h header and can be used in device
> +tree sources.
> +
> +Example:
> +
> +	/* Accessing DMA1 clock */
> +	... {
> +		clocks = <&rcc_clk DMA1>
> +	};
> +
> +	/* Accessing SPI6 kernel clock */
> +	... {
> +		clocks = <&rcc_clk SPI6_K>
> +	};

Other than the path to header, the clock binding explains all this. No 
need to duplicate here.

> +
> +Specifying softreset control of devices
> +=======================================
> +
> +Device nodes should specify the reset channel required in their "resets"
> +property, containing a phandle to the reset device node and an index specifying
> +which channel to use.
> +The index is the bit number within the RCC registers bank, starting from RCC
> +base address.
> +It is calculated as: index = register_offset / 4 * 32 + bit_offset.
> +Where bit_offset is the bit offset within the register.
> +
> +For example on STM32MP1, for LTDC reset:
> + ltdc = APB4_RSTSETR_offset / 4 * 32 + LTDC_bit_offset
> +      = 0x180 / 4 * 32 + 0 = 3072
> +
> +The list of valid indices for STM32MP1 is available in:
> +include/dt-bindings/reset-controller/stm32mp1-resets.h
> +
> +This file implements defines like:
> +#define LTDC_R	3072
> +
> +example:
> +
> +	ltdc {
> +		resets = <&rcc_rst LTDC_R>;
> +	};
> -- 
> 1.9.1
> 
