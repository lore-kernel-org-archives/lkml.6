Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeB1Bwq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 20:52:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43280 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbeB1Bwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 20:52:44 -0500
Subject: Re: [linux-sunxi] [PATCH v2 1/4] dt-bindings: pwm: binding allwinner
 sun8i.
To: hao5781286@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com
References: <20180225135045.GA14508@arx-s1>
Cc: linux@armlinux.org.uk, wens@csie.org, Claudiu.Beznea@microchip.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <56645bca-9f4a-3191-72d8-32b60ebbc26e@arm.com>
Date: Wed, 28 Feb 2018 01:51:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180225135045.GA14508@arx-s1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/02/18 13:50, hao_zhang wrote:
> This patch adds allwinner sun8i pwm binding documents.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..e8c48be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,18 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +  - compatible: should be one of:
> +    - "allwinner,sun8i-r40-pwm"
> +  - reg: physical base address and length of the controller's registers
> +  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> +    the cells format.
> +  - clocks: From common clock binding, handle to the parent clock.

The manual tells me that there are two possible clock sources (24 MHz
OSC and APB1), with actually two bits for encoding the mux source,
allowing for two more potential clock sources.
So can we extend this description to provide up to four clocks, with a
clock-names property telling the driver how this maps to the mux value?
Either we use clock names matching the clocks mentioned in the manual:
	clocks = <&osc24M>, <&ccu CLK_APB1>;
	clock-names = "osc", "apb1";
or we encode the mux values in the clock-names:
	clock-names = "mux-0", "mux-1";
Don't know what's more widely used in those cases, the latter seems to
be more future-proof.
Each channel pair can be configured to use one of the two (or four)
clocks, so we can be more flexible with multiple clocks.


Also, can you please add an "interrupts" property here? You don't need
to use it in the driver right now, but since there are multiple
registers dealing with the interrupts we should have it in the binding.
If in need, we can then add support later.

> +
> +Example:
> +
> +pwm: pwm@1c23400 {
> +	     compatible = "allwinner,sun8i-pwm";

That should match what you wrote above: allwinner,sun8i-r40-pwm.
And I believe this is the right compatible name, since there are
numerous other sun8i SoCs with the sun4i PWM IP, so just sun8i-pwm would
be misleading and confusing.

> +	     reg = <0x01c23400 0x154>;
> +	     clocks = <&osc24M>;

This should then be amended to what I sketched above.

> +	     #pwm-cells = <3>;

And then here please add:
	     interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;

Cheers,
Andre
