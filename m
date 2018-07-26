Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C9FC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2012206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbZ98P6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2012206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbeGZV3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbeGZV3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:29:38 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A9A7206B7;
        Thu, 26 Jul 2018 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532635871;
        bh=xVDgorF6YphNwRQR1sAXrpnIQzf0rzap9BMQ6xlBAqU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tbZ98P6h4gengKcrpKWsvDTrsZErgFmuQ9+6/ayZGScjDTPV2QSbqnAFb/jgz9qaC
         pfpKkT6k4ENyBzNWkH7g8w48T2RPI9UO7TaDTvAS/xgaWCujD2pEJzq0EgIi0sUkTh
         gkpGxuvb1m30jQXCxzZaOAMpAlpGZjFVVP4M8MpE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531719468-8458-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1531719468-8458-1-git-send-email-tdas@codeaurora.org>
 <1531719468-8458-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153263587085.48062.14881216441533347350@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/2] clk: qcom: Add support for RCG to register for DFS
Date:   Thu, 26 Jul 2018 13:11:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-15 22:37:47)
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index 52208d4..f8f1417 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -929,3 +938,167 @@ static void clk_rcg2_shared_disable(struct clk_hw *=
hw)
>         .set_rate_and_parent =3D clk_rcg2_shared_set_rate_and_parent,
>  };
>  EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
> +
> +/* Common APIs to be used for DFS based RCGR */
> +static unsigned long clk_rcg2_calculate_freq(struct clk_hw *hw,
> +               int level, struct freq_tbl *f)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       struct clk_hw *p;
> +       unsigned long prate =3D 0;
> +       u32 val, mask, cfg, m_off, n_off, offset, mode;
> +       int i, ret, num_parents;
> +
> +       offset =3D SE_PERF_DFSR(level);
> +       ret =3D regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + offset, &cf=
g);
> +       if (ret)
> +               return ret;
> +
> +       mask =3D BIT(rcg->hid_width) - 1;
> +       f->pre_div =3D cfg & mask ? (cfg & mask) : 1;
> +
> +       mode =3D cfg & CFG_MODE_MASK;
> +       mode >>=3D CFG_MODE_SHIFT;
> +
> +       cfg &=3D CFG_SRC_SEL_MASK;
> +       cfg >>=3D CFG_SRC_SEL_SHIFT;
> +
> +       num_parents =3D clk_hw_get_num_parents(hw);
> +       for (i =3D 0; i < num_parents; i++) {
> +               if (cfg =3D=3D rcg->parent_map[i].cfg) {
> +                       f->src =3D rcg->parent_map[i].src;
> +                       p =3D clk_hw_get_parent_by_index(&rcg->clkr.hw, i=
);
> +                       prate =3D clk_hw_get_rate(p);
> +               }
> +       }
> +
> +       if (!mode)
> +               goto done;

Please remove the goto and indent all the below code when we need to do
the mode check.

> +
> +       /* Calculate M & N values */
> +       m_off =3D SE_PERF_M_DFSR(level);
> +       n_off =3D SE_PERF_N_DFSR(level);
> +
> +       mask =3D BIT(rcg->mnd_width) - 1;
> +       ret =3D regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + m_off, &val=
);
> +       if (ret) {
> +               pr_err("Failed to read M offset register\n");
> +               return ret;
> +       }
> +       val &=3D mask;
> +       f->m =3D val;
> +
> +       ret =3D regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + n_off, &val=
);
> +       if (ret) {
> +               pr_err("Failed to read N offset register\n");
> +               return ret;
> +       }
> +       /* val ~(N-M) */
> +       val =3D ~val;
> +       val &=3D mask;
> +       val +=3D f->m;
> +       f->n =3D val;
> +done:
> +       return calc_rate(prate, f->m, f->n, mode, f->pre_div);
> +}
> +
> +static int clk_rcg2_dfs_populate_freq_table(struct clk_rcg2 *rcg)
> +{
> +       struct freq_tbl *freq_tbl;
> +       unsigned long calc_freq;
> +       int i;
> +
> +       freq_tbl =3D kcalloc(MAX_PERF_LEVEL, sizeof(*freq_tbl),
> +                               GFP_KERNEL);
> +       if (!freq_tbl)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < MAX_PERF_LEVEL; i++) {
> +               calc_freq =3D clk_rcg2_calculate_freq(&rcg->clkr.hw,
> +                                                       i, &freq_tbl[i]);
> +               if (calc_freq < 0) {
> +                       kfree(freq_tbl);
> +                       return calc_freq;
> +               }
> +
> +               freq_tbl[i].freq =3D calc_freq;
> +       }
> +       rcg->freq_tbl =3D freq_tbl;
> +
> +       return 0;
> +}
> +
> +static int clk_rcg2_dfs_determine_rate(struct clk_hw *hw,
> +                                  struct clk_rate_request *req)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       int ret;
> +
> +       if (!rcg->freq_tbl) {
> +               ret =3D clk_rcg2_dfs_populate_freq_table(rcg);
> +               if (ret) {
> +                       pr_err("Failed to update DFS tables for %s\n",
> +                                       clk_hw_get_name(hw));
> +                       return ret;
> +               }
> +       }
> +
> +       return clk_rcg2_shared_ops.determine_rate(hw, req);
> +}
> +
> +static const struct clk_ops clk_rcg2_dfs_ops =3D {
> +       .is_enabled =3D clk_rcg2_is_enabled,
> +       .get_parent =3D clk_rcg2_get_parent,
> +       .determine_rate =3D clk_rcg2_dfs_determine_rate,

It seems very risky to do this without being able to read the frequency
out of the hardware. Taking a peek at the DFS registers I see that there
is some sort of 'CURR_PERF_STATE' field in the DFSR register. Wouldn't
that correspond to the index in the table that the clk is currently
using? Why can't we mark these clks as CLK_GET_RATE_NOCACHE and then
read this field when we're using DFS?

In fact, I just tested this on my device and I see that changing the DFS
bit on the QUP register that controls the DFS used causes the DFSR
register in GCC to update the CURR_PERF_STATE field to match what is
chosen in the QUP. So there is definitely a way to implement
recalc_rate() for this clk. Please do so.

> +};
> +
> +static int clk_rcg2_enable_dfs(struct clk_rcg2 *rcg, struct regmap *regm=
ap)
> +{
> +       struct clk_init_data *init;
> +       u32 val;
> +       int ret;
> +
> +       ret =3D regmap_read(regmap, rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET,
> +                         &val);
> +       if (ret)
> +               return -EINVAL;
> +
> +       if (!(val & SE_CMD_DFS_EN))
> +               return 0;
> +
> +       init =3D kzalloc(sizeof(*init), GFP_KERNEL);
> +       if (!init)
> +               return -ENOMEM;
> +
> +       init->name =3D rcg->clkr.hw.init->name;
> +       init->flags =3D rcg->clkr.hw.init->flags;
> +       init->parent_names =3D rcg->clkr.hw.init->parent_names;
> +       init->num_parents =3D rcg->clkr.hw.init->num_parents;
> +       init->ops =3D &clk_rcg2_dfs_ops;
> +
> +       rcg->clkr.hw.init =3D init;
> +       rcg->freq_tbl =3D NULL;
> +
> +       pr_debug("DFS registered for clk %s\n", init->name);

Ok

> +
> +       return 0;
> +}
> +
> +int qcom_cc_register_rcg_dfs(struct regmap *regmap,
> +                           struct clk_rcg2 **rcgs, int num_clks)
> +{
> +       int i, ret =3D 0;
> +
> +       for (i =3D 0; i < num_clks; i++) {
> +               ret =3D clk_rcg2_enable_dfs(rcgs[i], regmap);
> +               if (ret) {
> +                       const char *name =3D rcgs[i]->clkr.hw.init->name;
> +
> +                       pr_err("DFS register failed for clk %s\n", name);
> +                       break;

Just return ret please.

> +               }
> +       }
> +
> +       return ret;

And return 0 here.

> +}
> +EXPORT_SYMBOL_GPL(qcom_cc_register_rcg_dfs);
