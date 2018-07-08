Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECA8C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D475208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnij43QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D475208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933273AbeGHXyt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 19:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932942AbeGHXyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 19:54:47 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 552EE208D9;
        Sun,  8 Jul 2018 23:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531094086;
        bh=pG8Z3tHBQQb3w1YvlGIBX+w9LgJkkcMuAnBspQnBuJA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=dnij43QO6HpcpnypSxBRiYvLX2rs1ARq5Jp8n9G/yavde+7uje6VpBMXDYSPxT3jw
         46UVh03iutfSdlP8f4wY0bGMCEPtdNoGK8V5c7Dpc4ApT9HjFDm/s1/v0ouPoHMkL3
         P8B4aEh7X3wMt0YXcZrk9XlX1urw71gb0le/ddwk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1529763567-13131-4-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
 <1529763567-13131-4-git-send-email-tdas@codeaurora.org>
Message-ID: <153109408562.143105.15954380130353645468@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] clk: qcom: Add display clock controller driver for SDM845
Date:   Sun, 08 Jul 2018 16:54:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-06-23 07:19:27)
> diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-s=
dm845.c
> new file mode 100644
> index 0000000..af437e0
> --- /dev/null
> +++ b/drivers/clk/qcom/dispcc-sdm845.c
> @@ -0,0 +1,674 @@
> +// SPDX-License-Identifier: GPL-2.0
[...]
> +static struct clk_alpha_pll disp_cc_pll0 =3D {
> +       .offset =3D 0x0,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "disp_cc_pll0",
> +                       .parent_names =3D (const char *[]){ "bi_tcxo" },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_fabia_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_byte0_clk_src =3D {
> +       .cmd_rcgr =3D 0x20d0,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_0,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "disp_cc_mdss_byte0_clk_src",
> +               .parent_names =3D disp_cc_parent_names_0,
> +               .num_parents =3D 4,
> +               .flags =3D CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,

Why is there the no cache flag? Last time I asked I don't think I got
any answer, and there isn't a comment here so please at least add a
comment to the code so we don't forget.

> +               .ops =3D &clk_byte2_ops,
> +       },
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_byte1_clk_src =3D {
> +       .cmd_rcgr =3D 0x20ec,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_0,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "disp_cc_mdss_byte1_clk_src",
> +               .parent_names =3D disp_cc_parent_names_0,
> +               .num_parents =3D 4,
> +               .flags =3D CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> +               .ops =3D &clk_byte2_ops,
> +       },
> +};
> +
> +static const struct freq_tbl ftbl_disp_cc_mdss_esc0_clk_src[] =3D {
> +       F(19200000, P_BI_TCXO, 1, 0, 0),
> +       { }
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_esc0_clk_src =3D {
> +       .cmd_rcgr =3D 0x2108,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_0,
> +       .freq_tbl =3D ftbl_disp_cc_mdss_esc0_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "disp_cc_mdss_esc0_clk_src",
> +               .parent_names =3D disp_cc_parent_names_0,
> +               .num_parents =3D 4,
> +               .ops =3D &clk_rcg2_ops,
> +       },
> +};
> +
> +static struct clk_rcg2 disp_cc_mdss_esc1_clk_src =3D {
> +       .cmd_rcgr =3D 0x2120,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D disp_cc_parent_map_0,
> +       .freq_tbl =3D ftbl_disp_cc_mdss_esc0_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){
> +               .name =3D "disp_cc_mdss_esc1_clk_src",
> +               .parent_names =3D disp_cc_parent_names_0,
> +               .num_parents =3D 4,
> +               .ops =3D &clk_rcg2_ops,
> +       },
> +};
> +
[...]
> +
> +MODULE_LICENSE("GPL v2");

MODULE_DESCRIPTION?

