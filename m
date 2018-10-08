Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5086C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02BE2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArUwT62F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02BE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeJHJxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 05:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeJHJxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 05:53:54 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5B320841;
        Mon,  8 Oct 2018 02:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538966669;
        bh=KTWOy3eFZuMXf5Aw1rOIrtjIawa0MLdNqV8ZrOg5nrg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ArUwT62FpTyKUlbguy9y+POPnt//Gohr2PKZwjIAYBHDarLR2G1xOtEBF6XHBK8Tg
         QMP1CX0YdGyE648vEbTPTDGnVlQXHOFaIzDBiOCThtrnZZKTLLy5YTe1VnLz6QuHtW
         C7xJmyS7VW0Zsx0gpjT41sO1wNy1d7JM8/UeFSaA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1538654546-31204-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1538654546-31204-1-git-send-email-tdas@codeaurora.org>
 <1538654546-31204-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153896666821.119890.13143150697797456341@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Sun, 07 Oct 2018 19:44:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-04 05:02:26)
> Add support for the lpass clock controller found on SDM845 based devices.
> This would allow lpass peripheral loader drivers to control the clocks to
> bring the subsystem out of reset.
> LPASS clocks present on the global clock controller would be registered
> with the clock framework based on the device tree flag. Also do not gate
> these clocks if they are left unused.

Why not gate them? This statement states what the code is doing, not why
it's doing it which is the more crucial information that should be
described in the commit text. Also, please add a comment about it to the
code next to the flag.

I am concerned that it doesn't make any sense though, so probably it
shouldn't be marked as CLK_IGNORE_UNUSED and it's papering over some
other larger bug that needs to be fixed.

> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index 08d593e..6379b8b 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -3169,6 +3169,32 @@ enum {
>         },
>  };
> =

> +static struct clk_branch gcc_lpass_q6_axi_clk =3D {
> +       .halt_reg =3D 0x47000,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x47000,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gcc_lpass_q6_axi_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch gcc_lpass_sway_clk =3D {
> +       .halt_reg =3D 0x47008,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x47008,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gcc_lpass_sway_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
>  static struct gdsc pcie_0_gdsc =3D {
>         .gdscr =3D 0x6b004,
>         .pd =3D {
> @@ -3469,6 +3495,8 @@ enum {
>         [GCC_QSPI_CORE_CLK_SRC] =3D &gcc_qspi_core_clk_src.clkr,
>         [GCC_QSPI_CORE_CLK] =3D &gcc_qspi_core_clk.clkr,
>         [GCC_QSPI_CNOC_PERIPH_AHB_CLK] =3D &gcc_qspi_cnoc_periph_ahb_clk.=
clkr,
> +       [GCC_LPASS_Q6_AXI_CLK] =3D NULL,
> +       [GCC_LPASS_SWAY_CLK] =3D NULL,
>  };
> =

>  static const struct qcom_reset_map gcc_sdm845_resets[] =3D {
> @@ -3583,6 +3611,13 @@ static int gcc_sdm845_probe(struct platform_device=
 *pdev)
>         if (ret)
>                 return ret;
> =

> +       if (!of_property_read_bool(pdev->dev.of_node, "qcom,lpass-protect=
ed")) {
> +               gcc_sdm845_clocks[GCC_LPASS_Q6_AXI_CLK] =3D
> +                       &gcc_lpass_q6_axi_clk.clkr;
> +               gcc_sdm845_clocks[GCC_LPASS_SWAY_CLK] =3D
> +                       &gcc_lpass_sway_clk.clkr;
> +       }
> +
>         return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
>  }
> =

> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc=
-sdm845.c
> new file mode 100644
> index 0000000..f7b9b0f
> --- /dev/null
> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/bitops.h>

Is this needed?

> +/* CLK_OFF would not toggle until LPASS is not out of reset */
> +static struct clk_branch lpass_qdsp6ss_xo_clk =3D {
> +       .halt_reg =3D 0x38,
> +       .halt_check =3D BRANCH_HALT_SKIP,
> +       .clkr =3D {
> +               .enable_reg =3D 0x38,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "lpass_qdsp6ss_xo_clk",
> +                       .flags =3D CLK_IGNORE_UNUSED,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +/* CLK_OFF would not toggle until LPASS is not out of reset */

Move this comment next to BRANCH_HALT_SKIP please so we know what it
relates to.

> +static struct clk_branch lpass_qdsp6ss_sleep_clk =3D {
> +       .halt_reg =3D 0x3c,
> +       .halt_check =3D BRANCH_HALT_SKIP,
> +       .clkr =3D {
> +               .enable_reg =3D 0x3c,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "lpass_qdsp6ss_sleep_clk",
> +                       .flags =3D CLK_IGNORE_UNUSED,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static int lpass_clocks_sdm845_probe(struct platform_device *pdev, int i=
ndex,
> +                                    const struct qcom_cc_desc *desc)
> +{
> +       struct regmap *regmap;
> +       struct resource *res;
> +       void __iomem *base;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, index);
> +       base =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       regmap =3D devm_regmap_init_mmio(&pdev->dev, base, desc->config);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);

If this happens again in the future we should move this into the
common.c file and let qcom_cc_probe_index() exist.

> +
> +       return qcom_cc_really_probe(pdev, desc, regmap);
> +}
> +
> +/* LPASS CC clock controller */

Please remove this comment. It's useless.

> +static const struct of_device_id lpass_cc_sdm845_match_table[] =3D {
> +       { .compatible =3D "qcom,sdm845-lpasscc" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, lpass_cc_sdm845_match_table);
> +
