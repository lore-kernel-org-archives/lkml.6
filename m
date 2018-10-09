Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2FAC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D62213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUslgJAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D62213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJJEFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbeJJEFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:05:25 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33DE213A2;
        Tue,  9 Oct 2018 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539117999;
        bh=7L3W3D1LSExK7RCCuBflEjR+VfF3EG1spu2DjWVMb3Q=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=eUslgJAmu105cKIFRT7rjALqIJVlqU0fgrLDONpKHYcqXC4yTCDMTZ4j41iqmKPpR
         JnX2rGCk3KApDotLRPkDVFsiTkBR4Q2Bc7g0cmUKRR7ayh/80kuyZJkwuV9ZZLlIxY
         YAPhKJjPY2tjxbCFCYwZ9oTnY/P9JoNmNyObPymM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539093467-12123-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandanu@codeaurora.org, Taniya Das <tdas@codeaurora.org>
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
 <1539093467-12123-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153911799897.119890.15102407227774253910@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 1/2] clk: qcom: rcg2: Add support for display port clock ops
Date:   Tue, 09 Oct 2018 13:46:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-09 06:57:46)
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index 6e3bd19..ca6142f 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -10,6 +10,7 @@
>  #include <linux/export.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
> +#include <linux/rational.h>

Can you also select RATIONAL in the Kconfig language? Yes the clk
subsystem is already selecting it, but it's nice to be explicit in the
subdrivers.

>  #include <linux/regmap.h>
>  #include <linux/math64.h>
>  #include <linux/slab.h>
> @@ -1124,3 +1125,88 @@ int qcom_cc_register_rcg_dfs(struct regmap *regmap,
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(qcom_cc_register_rcg_dfs);
> +
> +static int clk_rcg2_dp_set_rate(struct clk_hw *hw, unsigned long rate,
> +                       unsigned long parent_rate)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       struct freq_tbl f =3D { 0 };
> +       unsigned long src_rate;
> +       unsigned long num, den;
> +       u32 mask =3D BIT(rcg->hid_width) - 1;
> +       u32 hid_div, cfg;
> +       int i, num_parents =3D clk_hw_get_num_parents(hw);
> +
> +       src_rate =3D clk_hw_get_rate(clk_hw_get_parent(hw));

What is this doing? We shouldn't need to check the parent clk for any
rate here when we're setting the rate.

> +       if (src_rate <=3D 0) {
> +               pr_err("Invalid RCG parent rate\n");
> +               return -EINVAL;
> +       }
> +
> +       rational_best_approximation(src_rate, rate,
> +                       (unsigned long)(1 << 16) - 1,

Use GENMASK?

> +                       (unsigned long)(1 << 16) - 1, &den, &num);

Same?

> +
> +       if (!num || !den) {
> +               pr_err("Invalid MN values derived for requested rate %lu\=
n",
> +                                                       rate);
> +               return -EINVAL;
> +       }
> +
> +       regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
> +       hid_div =3D cfg;
> +       cfg &=3D CFG_SRC_SEL_MASK;
> +       cfg >>=3D CFG_SRC_SEL_SHIFT;
> +
> +       for (i =3D 0; i < num_parents; i++)
> +               if (cfg =3D=3D rcg->parent_map[i].cfg) {
> +                       f.src =3D rcg->parent_map[i].src;
> +                       break;
> +       }
> +
> +       f.pre_div =3D hid_div;
> +       f.pre_div >>=3D CFG_SRC_DIV_SHIFT;
> +       f.pre_div &=3D mask;
> +
> +       if (num =3D=3D den) {
> +               f.m =3D 0;
> +               f.n =3D 0;
> +       } else {
> +               f.m =3D num;
> +               f.n =3D den;
> +       }
> +
> +       return clk_rcg2_configure(rcg, &f);
> +}
> +
> +static int clk_rcg2_dp_set_rate_and_parent(struct clk_hw *hw,
> +               unsigned long rate, unsigned long parent_rate, u8 index)
> +{
> +       return clk_rcg2_dp_set_rate(hw, rate, parent_rate);
> +}
> +
> +static int clk_rcg2_dp_determine_rate(struct clk_hw *hw,
> +                               struct clk_rate_request *req)
> +{
> +       if (!hw)
> +               return -EINVAL;
> +
> +       if (!clk_hw_get_parent(hw)) {
> +               pr_err("Missing the parent for the DP RCG\n");
> +               return -EINVAL;
> +       }

Let me Harry Potter this stuff. Expelliarmus!

> +
> +       req->best_parent_rate =3D clk_hw_get_rate(clk_hw_get_parent(hw));

Presumably we should ask the parent clk for the rate that is requested
here by calling determine rate up and see if the parent can do it. Sure,
this clk does nothing, so we don't really need any sort of op here then
and we can just flag the clk as CLK_SET_RATE_PARENT and let the core do
the rest.

> +       return 0;
> +}
> +
> +const struct clk_ops clk_dp_ops =3D {
> +       .is_enabled =3D clk_rcg2_is_enabled,
> +       .get_parent =3D clk_rcg2_get_parent,
> +       .set_parent =3D clk_rcg2_set_parent,
> +       .recalc_rate =3D clk_rcg2_recalc_rate,
> +       .set_rate =3D clk_rcg2_dp_set_rate,
> +       .set_rate_and_parent =3D clk_rcg2_dp_set_rate_and_parent,
> +       .determine_rate =3D clk_rcg2_dp_determine_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_dp_ops);
