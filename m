Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeFAQg3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752360AbeFAQg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:36:27 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527574066-27237-1-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
References: <1527574066-27237-1-git-send-email-anischal@codeaurora.org>
Message-ID: <152787098620.144038.15158473245010154723@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: qcom: Enable clocks which needs to be always on for
 SDM845
Date: Fri, 01 Jun 2018 09:36:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51Gcgso015859

Quoting Amit Nischal (2018-05-28 23:07:46)
> There are certain clocks which needs to be always enabled for system
> operation. Remove support for such clocks from the clock driver and
> enable them explicitly gcc driver probe. Also fix the target name in
> kernel configuration description for SDM845 gcc driver.

This is why we have CLK_IS_CRITICAL.

> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index fc3edd1..79e9144 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -231,7 +231,7 @@ config SDM_GCC_845
>         select QCOM_GDSC
>         depends on COMMON_CLK_QCOM
>         help
> -         Support for the global clock controller on msm8998 devices.
> +         Support for the global clock controller on SDM845 devices.
>           Say Y if you want to use peripheral devices such as UART, SPI,
>           I2C, USB, UFS, SDDC, PCIe, etc.
> 

This can be its own patch.

> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index e78e6f5..b40aafc 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -3433,9 +3327,16 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
>         regmap_update_bits(regmap, 0x09ffc, 0x3, 0x3);
>         regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
> 
> -       /* Enable CPUSS clocks */
> -       regmap_update_bits(regmap, 0x48190, BIT(0), 0x1);
> -       regmap_update_bits(regmap, 0x52004, BIT(22), 0x1);
> +       /* Enable clocks which are required to be always ON */
> +       regmap_update_bits(regmap, 0xb004, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0xb008, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0xb00c, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0xb028, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0xb02c, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0xb030, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0x48190, BIT(0), BIT(0));
> +       regmap_update_bits(regmap, 0x52004, BIT(22), BIT(22));
> +       regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));

Let's do CLK_IS_CRITICAL flag instead. That has the added benefit of
checking to make sure the halt bit toggles correctly so the clks are
verified to be enabled.

> 
>         return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
>  }
> diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
> index aca6126..6330c3f 100644
> --- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
> +++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
> @@ -13,185 +13,178 @@
>  #define GCC_AGGRE_USB3_PRIM_AXI_CLK                            3
>  #define GCC_AGGRE_USB3_SEC_AXI_CLK                             4
>  #define GCC_BOOT_ROM_AHB_CLK                                   5
> -#define GCC_CAMERA_AHB_CLK                                     6

Don't do this. Things should only be added to here, not removed or
reshuffled.

> -#define GCC_CAMERA_AXI_CLK                                     7
> -#define GCC_CAMERA_XO_CLK                                      8
> -#define GCC_CE1_AHB_CLK                                                9
