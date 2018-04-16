Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbeDPItG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:49:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42626 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753655AbeDPItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:49:03 -0400
X-Google-Smtp-Source: AIpwx49DNzcQo3+p09/ssmJzgr4Em/h4bi59KU0VcZScqP7/iPsmANbE66EE++Ee0+xjbFawqz6yOw==
Subject: Re: [dragonboard] [PATCH 1/1] dts: qcom: db820c: Add gpio-line-names
 property
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linus.walleij@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, bjorn.andersson@linaro.org,
        will.deacon@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dragonboard@lists.96boards.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180414031811.11351-1-manivannan.sadhasivam@linaro.org>
 <20180414031811.11351-2-manivannan.sadhasivam@linaro.org>
From: Todor Tomov <todor.tomov@linaro.org>
Message-ID: <9acdd412-9b6d-ec63-c5ca-c5fa8d98d489@linaro.org>
Date: Mon, 16 Apr 2018 11:48:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180414031811.11351-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

Thank you for the patch.

On 14.04.2018 06:18, Manivannan Sadhasivam wrote:
> Add gpio-line-names property for Dragonboard820c based on APQ8096 SoC.
> There are 4 gpio-controllers present on this board, including the
> APQ8096 SoC, PM8994 (GPIO and MPP) and PMI8994 (GPIO).
> 
> Lines names are derived from 96Boards CE Specification 1.0, Appendix
> "Expansion Connector Signal Description". Line names for PMI8994 MPP
> pins are not added due to the absence of the gpio-controller support.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 240 +++++++++++++++++++++++++++
>  1 file changed, 240 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index 1c8f1b86472d..1c1deef031c6 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -19,6 +19,34 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
>  
> +/*
> + * GPIO name legend: proper name = the GPIO line is used as GPIO
> + *         NC      = not connected (pin out but not routed from the chip to
> + *                   anything the board)
> + *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
> + *         LSEC    = Low Speed External Connector
> + *         HSEC    = High Speed External Connector
> + *         P HSEC  = Primary High Speed External Connector
> + *         S HSEC  = Secondary High Speed External Connector
> + *         J14     = Camera Connector
> + *         TP      = Test Points
> + *
> + * Line names are taken from the schematic "DragonBoard 820c",
> + * drawing no: LM25-P2751-1
> + *
> + * For the lines routed to the external connectors the
> + * lines are named after the 96Boards CE Specification 1.0,
> + * Appendix "Expansion Connector Signal Description".
> + *
> + * When the 96Board naming of a line and the schematic name of
> + * the same line are in conflict, the 96Board specification
> + * takes precedence, which means that the external UART on the
> + * LSEC is named UART0 while the schematic and SoC names this
> + * UART3. This is only for the informational lines i.e. "[FOO]",

It seems to me that this can lead to some confusion for cases when
some schematic names have 96board names and others don't. (An
example below.) However I don't really see any better way to do
it. I'm wondering whether adding the schematic name in
the comment (for gpios which are named with 96board names)
can help a little. What do you think? Or any other idea?

> + * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
> + * ones actually used for GPIO.
> + */
> +
>  / {
>  	aliases {
>  		serial0 = &blsp2_uart1;
> @@ -90,6 +118,218 @@
>  			status = "okay";
>  		};
>  
> +		pinctrl@1010000 {
> +			gpio-line-names =
> +				"[SPI0_DOUT]", /* GPIO_0, LSEC pin 14 */
> +				"[SPI0_DIN]", /* GPIO_1, LSEC pin 10 */
> +				"[SPI0_CS]", /* GPIO_2, LSEC pin 12 */
> +				"[SPI0_SCLK]", /* GPIO_3, LSEC pin 8 */
> +				"[UART1_TxD]", /* GPIO_4, LSEC pin 11 */
> +				"[UART1_RxD]", /* GPIO_5, LSEC pin 13 */
> +				"[I2C1_SDA]", /* GPIO_6, LSEC pin 21 */
> +				"[I2C1_SCL]", /* GPIO_7, LSEC pin 19 */
> +				"GPIO-H", /* GPIO_8, LSEC pin 30 */
> +				"TP93", /* GPIO_9 */
> +				"GPIO-G", /* GPIO_10, LSEC pin 29 */
> +				"[MDP_VSYNC_S]", /* GPIO_11, P HSEC pin 55 */
> +				"NC", /* GPIO_12 */
> +				"[CSI0_MCLK]", /* GPIO_13, P HSEC pin 15 */
> +				"[CAM_MCLK1]", /* GPIO_14, J14 pin 11 */
> +				"[CSI1_MCLK]", /* GPIO_15, P HSEC pin 17 */

This could be a little misleading.
96Board name / schametic name:
CSI0_MCLK / CAM_MCLK0
--------- / CAM_MCLK1
CSI1_MCLK / CAM_MCLK2

<snip>

-- 
Best regards,
Todor Tomov
