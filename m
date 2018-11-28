Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71511C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBCA2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqfG+/x4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBCA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeK2INk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:13:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbeK2INk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:13:40 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA312081B;
        Wed, 28 Nov 2018 21:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543439442;
        bh=hPz0MuQsL6ngE5d1VybNAPmLE5CinKVECbADTQlgvvE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=uqfG+/x4h39PvsF8MAWg1g8uzDz8bH7wqhE3YfVxvgojbxClj7ZE+V3RKP3o8Anwv
         3naVQTFKZB4Vr1LsnZxp5VWEOz2e3oLYJl1sndklHUd+4BcyiwrQeafjK/MdjACPOK
         q66MO43PA3zOC0Zo4TkyMUTdlwb0xh8E25v8md4E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542873221-13693-4-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1542873221-13693-1-git-send-email-tdas@codeaurora.org>
 <1542873221-13693-4-git-send-email-tdas@codeaurora.org>
Message-ID: <154343944180.88331.8662440760190505722@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v10 3/3] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Wed, 28 Nov 2018 13:10:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-21 23:53:41)
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

I have one single idea to avoid the integration nightmare with dts
needing another update for this on platforms where these can't be
touched. It's not perfect, but we can throw these clks and usage of the
clks behind an #ifdef CONFIG_SDM_LPASSCC_845 and then let the dts parts
match up with the clk driver parts in linux-next. After everything is
merged together, someone can turn on the knobs for LPASS clk controller
and make sure they have the right dts bits to mark them as protected.

