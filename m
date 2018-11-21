Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E1DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F15214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMM4TgbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F15214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbeKVFnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbeKVFnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A683206BB;
        Wed, 21 Nov 2018 19:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827257;
        bh=64ADs1xhzE1G4KDKq+8Ze7BVKXcIBJbu7a+tA+x6Swg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=sMM4TgbBQa0ItcZPX+S4ZWb/hGldm5ZEmiYUcWF9udPFX0yLnzhHf3kCxe5mHTlfk
         4dWDg8TYrhhR2FUiwElG0PJooc9uDPw9h9MIzijiUVET8iqVEvL8DtG7zG54kscf3V
         TFJj2DzWeKipH2pinGsCeJS1o4g4+k+mypsJt3jU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1541814256-23254-3-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1541814256-23254-1-git-send-email-tdas@codeaurora.org>
 <1541814256-23254-3-git-send-email-tdas@codeaurora.org>
Message-ID: <154282725690.88331.797718066164707366@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 2/2] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Wed, 21 Nov 2018 11:07:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-09 17:44:16)
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index f133b7f..ba8ff99 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -3153,6 +3153,34 @@ enum {
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
> +                       .flags =3D CLK_IS_CRITICAL,
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
> +                       .flags =3D CLK_IS_CRITICAL,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
>  static struct gdsc pcie_0_gdsc =3D {
>         .gdscr =3D 0x6b004,
>         .pd =3D {
> @@ -3453,6 +3481,8 @@ enum {
>         [GCC_QSPI_CORE_CLK_SRC] =3D &gcc_qspi_core_clk_src.clkr,
>         [GCC_QSPI_CORE_CLK] =3D &gcc_qspi_core_clk.clkr,
>         [GCC_QSPI_CNOC_PERIPH_AHB_CLK] =3D &gcc_qspi_cnoc_periph_ahb_clk.=
clkr,
> +       [GCC_LPASS_Q6_AXI_CLK] =3D &gcc_lpass_q6_axi_clk.clkr,
> +       [GCC_LPASS_SWAY_CLK] =3D &gcc_lpass_sway_clk.clkr,

Sigh, more coordination with sdm845 mtp problems here due to the
clks being protected by firmware. I guess I can just merge this and the
mtp dts bits will land in Andy's tree during the same merge window? Or I
may need to take the dts bits for this into clk tree so that the broken
time is only between two commits.

>  };
> =

>  static const struct qcom_reset_map gcc_sdm845_resets[] =3D {
> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc=
-sdm845.c
> new file mode 100644
> index 0000000..2ef7f2a
> --- /dev/null
> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
> @@ -0,0 +1,192 @@
[...]
> +
> +static const struct of_device_id lpass_cc_sdm845_match_table[] =3D {
> +       { .compatible =3D "qcom,sdm845-lpasscc" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, lpass_cc_sdm845_match_table);

Move this down to the before the driver structure please.

> +
> +static int lpass_cc_sdm845_probe(struct platform_device *pdev)
> +{
> +       const struct qcom_cc_desc *desc;
> +       int ret;
> +
> +       lpass_regmap_config.name =3D "cc";
> +       desc =3D &lpass_cc_sdm845_desc;
> +
> +       ret =3D lpass_clocks_sdm845_probe(pdev, 0, desc);
> +       if (ret)
> +               return ret;
> +
> +       lpass_regmap_config.name =3D "qdsp6ss";
> +       desc =3D &lpass_qdsp6ss_sdm845_desc;
> +
> +       return lpass_clocks_sdm845_probe(pdev, 1, desc);
> +}
> +
> +static struct platform_driver lpass_cc_sdm845_driver =3D {
> +       .probe          =3D lpass_cc_sdm845_probe,
> +       .driver         =3D {
> +               .name   =3D "sdm845-lpasscc",
> +               .of_match_table =3D lpass_cc_sdm845_match_table,
> +       },
> +};
> +
> +static int __init lpass_cc_sdm845_init(void)
> +{
> +       return platform_driver_register(&lpass_cc_sdm845_driver);
> +}
> +subsys_initcall(lpass_cc_sdm845_init);
> +
> +static void __exit lpass_cc_sdm845_exit(void)
> +{
> +       platform_driver_unregister(&lpass_cc_sdm845_driver);
> +}
> +module_exit(lpass_cc_sdm845_exit);
> +
> +MODULE_LICENSE("GPL v2");

MODULE_DESCRIPTION?

