Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874FCC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4D9214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c02aZUvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4D9214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeJJDxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbeJJDxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:53:08 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77ABD214C4;
        Tue,  9 Oct 2018 20:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539117264;
        bh=geTX9f2Q1fw8JCj0sx4lXutNXjoTCgnePKZhWPFcrmE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=c02aZUvJnZPbR+2nyAtphQlD5yfP0v0PNTnMYWjUNEhWEGA5fzCtnrHGgnGnCo8m6
         TYAbONMMAvoREkYFgxb+YAmEb5ghKOg1PDEwSNEPERESPen/Qa06Stx+tTkFE719ga
         XWSCLUdIJaYKpgBBsboJO3Yw3BCOap9LavBq/OxI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539093467-12123-3-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandanu@codeaurora.org, Taniya Das <tdas@codeaurora.org>
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
 <1539093467-12123-3-git-send-email-tdas@codeaurora.org>
Message-ID: <153911726378.119890.5522594539667887860@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 2/2] clk: qcom : dispcc: Add support for display port clocks
Date:   Tue, 09 Oct 2018 13:34:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-09 06:57:47)
> diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-s=
dm845.c
> index 0cc4909..6d3136a 100644
> --- a/drivers/clk/qcom/dispcc-sdm845.c
> +++ b/drivers/clk/qcom/dispcc-sdm845.c
> @@ -128,6 +144,100 @@ enum {
>         },
>  };
> =

> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_aux_clk_src[] =3D {
> +       F(19200000, P_BI_TCXO, 1, 0, 0),
> +       { }
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dp_aux_clk_src =3D {
> +       .cmd_rcgr =3D 0x219c,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_2,
> +       .freq_tbl =3D ftbl_disp_cc_mdss_dp_aux_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "disp_cc_mdss_dp_aux_clk_src",
> +               .parent_names =3D disp_cc_parent_names_2,
> +               .num_parents =3D 2,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_rcg2_ops,
> +       },
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_crypto_clk_src[] =3D {
> +       F(108000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
> +       F(180000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
> +       F(360000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
> +       F(540000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
> +       { }
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dp_crypto_clk_src =3D {
> +       .cmd_rcgr =3D 0x2154,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_1,
> +       .freq_tbl =3D ftbl_disp_cc_mdss_dp_crypto_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "disp_cc_mdss_dp_crypto_clk_src",
> +               .parent_names =3D disp_cc_parent_names_1,
> +               .num_parents =3D 4,
> +               .flags =3D CLK_GET_RATE_NOCACHE,

Why?

> +               .ops =3D &clk_rcg2_ops,
> +       },
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_link_clk_src[] =3D {
> +       F(162000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> +       F(270000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> +       F(540000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> +       F(810000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),

Are these in kHz? They really look like it and that's bad. Why do we
need them at all? Just to make sure the display driver picks these exact
frequencies? It seems like we could just pass whatever number comes in
up to the parent and see what it can do.

> +       { }
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src =3D {
> +       .cmd_rcgr =3D 0x2138,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_1,
> +       .freq_tbl =3D ftbl_disp_cc_mdss_dp_link_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "disp_cc_mdss_dp_link_clk_src",
> +               .parent_names =3D disp_cc_parent_names_1,
> +               .num_parents =3D 4,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_rcg2_ops,
> +       },
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dp_pixel1_clk_src =3D {
> +       .cmd_rcgr =3D 0x2184,
> +       .mnd_width =3D 16,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_1,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "disp_cc_mdss_dp_pixel1_clk_src",
> +               .parent_names =3D disp_cc_parent_names_1,
> +               .num_parents =3D 4,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_dp_ops,
> +       },
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_dp_pixel_clk_src =3D {
> +       .cmd_rcgr =3D 0x216c,
> +       .mnd_width =3D 16,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_1,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "disp_cc_mdss_dp_pixel_clk_src",
> +               .parent_names =3D disp_cc_parent_names_1,
> +               .num_parents =3D 4,
> +               .flags =3D CLK_SET_RATE_PARENT,
> +               .ops =3D &clk_dp_ops,
> +       },
> +};
> +
>  static const struct freq_tbl ftbl_disp_cc_mdss_esc0_clk_src[] =3D {
>         F(19200000, P_BI_TCXO, 1, 0, 0),
>         { }
> @@ -391,6 +501,115 @@ enum {
>         },
>  };
> =

> +static struct clk_branch disp_cc_mdss_dp_aux_clk =3D {
> +       .halt_reg =3D 0x2054,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x2054,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "disp_cc_mdss_dp_aux_clk",
> +                       .parent_names =3D (const char *[]){
> +                               "disp_cc_mdss_dp_aux_clk_src",
> +                       },
> +                       .num_parents =3D 1,
> +                       .flags =3D CLK_SET_RATE_PARENT,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch disp_cc_mdss_dp_crypto_clk =3D {
> +       .halt_reg =3D 0x2048,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x2048,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "disp_cc_mdss_dp_crypto_clk",
> +                       .parent_names =3D (const char *[]){
> +                               "disp_cc_mdss_dp_crypto_clk_src",
> +                       },
> +                       .num_parents =3D 1,
> +                       .flags =3D CLK_SET_RATE_PARENT,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch disp_cc_mdss_dp_link_clk =3D {
> +       .halt_reg =3D 0x2040,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x2040,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "disp_cc_mdss_dp_link_clk",
> +                       .parent_names =3D (const char *[]){
> +                               "disp_cc_mdss_dp_link_clk_src",
> +                       },
> +                       .num_parents =3D 1,
> +                       .flags =3D CLK_SET_RATE_PARENT,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +/* reset state of disp_cc_mdss_dp_link_div_clk_src divider is 0x3 (div 4=
) */

Not sure what this comment is for. But it's interesting nonetheless.

> +static struct clk_branch disp_cc_mdss_dp_link_intf_clk =3D {
> +       .halt_reg =3D 0x2044,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x2044,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "disp_cc_mdss_dp_link_intf_clk",
> +                       .parent_names =3D (const char *[]){
> +                               "disp_cc_mdss_dp_link_clk_src",
> +                       },
> +                       .num_parents =3D 1,
> +                       .flags =3D CLK_GET_RATE_NOCACHE,

Why?

> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
