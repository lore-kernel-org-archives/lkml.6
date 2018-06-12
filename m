Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 34FD4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BE8208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8p1wy44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BE8208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeFLHRf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932416AbeFLHRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:17:32 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2803D208AE;
        Tue, 12 Jun 2018 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528787852;
        bh=TWC/2fZzzAlDfKOKU93CKjdLh04phVIIv2JQukOAZTk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=F8p1wy441jBMYdAu/2WJmtaAg/YSeqRJ+rqJ/VgOmAnS45qHZEcS8U8PTGQkFgBGW
         RMKnqeYE03zjxFwN5698SOUUktTDLF6kFbZMMgXS2rDS0jV8HPNkKvVoq7DQt6kEZT
         WFETc4LZ+8d0pLKPPI/XlO+idpJgXtEkJ6acd8G0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527245150-2726-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1527245150-2726-1-git-send-email-tdas@codeaurora.org>
 <1527245150-2726-2-git-send-email-tdas@codeaurora.org>
Message-ID: <152878785142.16708.816879308878293001@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1] clk: qcom: Add support for RCG to register for DFS
Date:   Tue, 12 Jun 2018 00:17:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-05-25 03:45:50)
> In the cases where a RCG requires a Dynamic Frequency switch support
> requires to register which would at runtime read the clock perf level
> registers to identify the frequencies supported and update the frequency
> table accordingly.

This sentence doesn't parse. Please rewrite it into multiple sentences
and explain what DFS is and why it's used and why we care to merge this
patch.

> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>

> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index b209a2f..b5e5424 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -138,6 +138,7 @@ struct clk_dyn_rcg {
>   * @parent_map: map from software's parent index to hardware's src_sel f=
ield
>   * @freq_tbl: frequency table
>   * @clkr: regmap clock handle
> + * @dfs_enable: corresponds to dfs mode enable

Please call this 'dfs_enabled'.

>   *

Also drop this extra newline here since you're in the area.

>   */
>  struct clk_rcg2 {
> @@ -160,5 +162,9 @@ struct clk_rcg2 {
>  extern const struct clk_ops clk_pixel_ops;
>  extern const struct clk_ops clk_gfx3d_ops;
>  extern const struct clk_ops clk_rcg2_shared_ops;
> +extern const struct clk_ops clk_rcg2_dfs_ops;
> +
> +extern int clk_rcg2_enable_dfs(struct clk_rcg2 *clk, struct device *dev);
> +extern int clk_rcg2_dfs_determine_rate_lazy(struct clk_rcg2 *clk);

This doesn't need to be exported?

> =

>  #endif
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index 52208d4..9112891 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -10,8 +10,10 @@
>  #include <linux/export.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
> +#include <linux/device.h>

Looks odd. Why not pass regmap instead?

> @@ -929,3 +939,265 @@ static void clk_rcg2_shared_disable(struct clk_hw *=
hw)
>         .set_rate_and_parent =3D clk_rcg2_shared_set_rate_and_parent,
>  };
>  EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
> +
> +/* Common APIs to be used for DFS based RCGR */
> +struct dfs_table {
> +       u8 src_index;
> +       unsigned long prate;
> +};
> +
> +static struct dfs_table *dfs_entry;

So all DFS are the same? Doesn't look right to have a static global for
this.

> +
> +static int clk_index_pre_div_and_mode(struct clk_hw *hw, u32 offset,

Please prefix with clk_rcg2_ on all these things.

> +               u32 *mode, u8 *pre_div)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       int i, num_parents, ret;
> +       u32 cfg, mask;
> +
> +       num_parents =3D clk_hw_get_num_parents(hw);
> +
> +       ret =3D regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + offset, &cf=
g);
> +       if (ret)
> +               goto err;
> +
> +       mask =3D BIT(rcg->hid_width) - 1;
> +       *pre_div =3D cfg & mask ? (cfg & mask) : 1;
> +
> +       *mode =3D cfg & CFG_MODE_MASK;
> +       *mode >>=3D CFG_MODE_SHIFT;
> +
> +       cfg &=3D CFG_SRC_SEL_MASK;
> +       cfg >>=3D CFG_SRC_SEL_SHIFT;
> +
> +       for (i =3D 0; i < num_parents; i++)
> +               if (cfg =3D=3D rcg->parent_map[i].cfg)
> +                       return i;
> +err:
> +       return 0;
> +}
> +
> +static int calculate_m_and_n(struct clk_hw *hw, u32 m_offset, u32 n_offs=
et,

Doesn't M and N always follow exactly same place? Why does this need to
be passed in here, just hardcode it?

> +               struct freq_tbl *f)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       u32 val, mask;
> +       int ret;
> +
> +       /* Calculate M & N values */
> +       mask =3D BIT(rcg->mnd_width) - 1;
> +       ret =3D  regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + m_offset, =
&val);
> +       if (ret) {
> +               pr_err("Failed to read M offset register\n");
> +               return ret;
> +       }
> +
> +       val &=3D mask;
> +       f->m  =3D val;

Weird space here.

> +
> +       ret =3D regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + n_offset, &=
val);
> +       if (ret) {
> +               pr_err("Failed to read N offset register\n");
> +               return ret;
> +       }
> +
> +       /* val ~(N-M) */
> +       val =3D ~val;
> +       val &=3D mask;
> +       val +=3D f->m;
> +       f->n =3D val;
> +
> +       return 0;
> +}
> +
> +int clk_rcg2_dfs_determine_rate_lazy(struct clk_rcg2 *rcg)

static?

> +{
> +       struct freq_tbl *dfs_freq_tbl;
> +       int i, j, index, ret =3D 0;
> +       unsigned long calc_freq, prate;
> +       u32 mode =3D 0;
> +
> +       if (rcg->dfs_enable) {
> +               pr_debug("DFS tables already populated\n");
> +               return 0;
> +       }
> +
> +       dfs_freq_tbl =3D kcalloc(MAX_PERF_LEVEL, sizeof(struct freq_tbl),

sizeof(*dfs_freq_tbl)

> +                               GFP_KERNEL);
> +       if (!dfs_freq_tbl)
> +               return -ENOMEM;
> +
> +       /* Populate the Perf Level frequencies */
> +       for (i =3D 0; i < MAX_PERF_LEVEL; i++) {
> +               /* Get parent index and mode */
> +               index =3D clk_index_pre_div_and_mode(&rcg->clkr.hw,
> +                                               SE_PERF_DFSR(i), &mode,
> +                                               &dfs_freq_tbl[i].pre_div);
> +               if (index < 0) {
> +                       pr_err("Failed to get parent index & mode %d\n", =
index);
> +                       kzfree(dfs_freq_tbl);
> +                       return index;
> +               }
> +
> +               /* Fill parent src */
> +               dfs_freq_tbl[i].src =3D rcg->parent_map[index].src;
> +               prate =3D dfs_entry[index].prate;
> +
> +               if (mode) {
> +                       ret =3D calculate_m_and_n(&rcg->clkr.hw,
> +                                               SE_PERF_M_DFSR(i),
> +                                               SE_PERF_N_DFSR(i),
> +                                               &dfs_freq_tbl[i]);

Please combine the prediv, mode, m, and n calculating code into one
function.

> +                       if (ret)
> +                               goto err;
> +               } else {
> +                       dfs_freq_tbl[i].m =3D 0;
> +                       dfs_freq_tbl[i].n =3D 0;

Is this even necessary? The whole table is kcalloc() so it's already
zero.

> +               }
> +
> +               /* calculate the final frequency */

Please remove worthless comments.

> +               calc_freq =3D calc_rate(prate, dfs_freq_tbl[i].m,
> +                                       dfs_freq_tbl[i].n, mode,
> +                                       dfs_freq_tbl[i].pre_div);
> +
> +               /* Check for duplicate frequencies */

Sure, but why? Does it mean end of table?

> +               for (j =3D 0; j  < i; j++) {
> +                       if (dfs_freq_tbl[j].freq =3D=3D calc_freq)
> +                               goto done;
> +               }
> +
> +               dfs_freq_tbl[i].freq =3D calc_freq;
> +       }
> +done:
> +       rcg->freq_tbl =3D dfs_freq_tbl;
> +err:

This label should go away and the goto site should just return ret.

> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(clk_rcg2_dfs_determine_rate_lazy);
> +
> +static int _freq_tbl_determine_dfs_rate(struct clk_hw *hw)

Call this something like clk_rcg2_dfs_populate_freqtable()? Reading the
function though it looks like it's populating some parent frequencies
and src to software index table? I don't think we want to be populating
that at runtime. That parent to software index should be static in
hardware so I'm sort of lost on that.

> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       struct clk_hw *phw;
> +       int i, num_parents;
> +
> +       num_parents =3D clk_hw_get_num_parents(hw);
> +
> +       dfs_entry =3D kcalloc(num_parents, sizeof(struct dfs_table), GFP_=
KERNEL);

sizeof(*dfs_entry)

> +       if (!dfs_entry)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < num_parents; i++) {
> +               dfs_entry[i].src_index =3D rcg->parent_map[i].src;
> +               if (rcg->parent_map[i].cfg =3D=3D 7)

Why is 7 magical and special? Means grounded or something?

> +                       break;
> +               phw =3D clk_hw_get_parent_by_index(&rcg->clkr.hw, i);
> +               if (!phw) {
> +                       kzfree(dfs_entry);

Why kzfree()?

> +                       return -EINVAL;
> +               }
> +               dfs_entry[i].prate =3D clk_hw_get_rate(phw);
> +       }
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
> +       if (!rcg->dfs_enable) {
> +               ret =3D _freq_tbl_determine_dfs_rate(hw);
> +               if (ret) {
> +                       pr_err("Failed to setup DFS frequency table\n");
> +                       return ret;
> +               }
> +
> +               ret =3D clk_rcg2_dfs_determine_rate_lazy(rcg);

Not sure we need to say 'lazy' in the name.

> +               if (ret) {
> +                       pr_err("Failed to update DFS tables\n");
> +                       return ret;
> +               }
> +       }
> +
> +       return clk_rcg2_shared_ops.determine_rate(hw, req);
> +}
> +
> +static int clk_rcg2_dfs_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +
> +       /* DFS hardware takes care of setting the parent */
> +       if (rcg->dfs_enable)

Why can't we read the hardware to see if DFS is there or not, and then
replace the clk_ops at boot time with the either the shared_ops or the
dfs "detecting" ones? That would make things a lot nicer so that we
don't have to look at these functions that swizzle between one or the
other every time they get called.

Due to the const on the clk_init pointer in clk_hw, you'll need to split
out the init structure into a named structure that you can modify at
runtime. Assign the default value to be the backup ops (shared?), and
then replace those ops with the dfs ops if the bit turns out to be set.
Then the dfs ops can be simple, except for the determine_rate callback.
And then dfs_enabled can be removed and we can set the freq_tbl pointer
to NULL on that clk_ops init swizzle and then populate the frequency
table if it's NULL in the determine rate op.

> +               return 0;
> +
> +       return clk_rcg2_shared_ops.set_parent(hw, index);
> +}
> +
> +static int clk_rcg2_dfs_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                   unsigned long prate)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +
> +       if (rcg->dfs_enable)
> +               return 0;
> +
> +       return clk_rcg2_shared_ops.set_rate(hw, rate, prate);
> +}
> +
> +static int clk_rcg2_dfs_set_rate_and_parent(struct clk_hw *hw,
> +                                   unsigned long rate,
> +                                   unsigned long prate, u8 index)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +
> +       if (rcg->dfs_enable)
> +               return 0;
> +
> +       return clk_rcg2_shared_ops.set_rate_and_parent(hw, rate, prate, i=
ndex);
> +}
> +
> +const struct clk_ops clk_rcg2_dfs_ops =3D {
> +       .is_enabled =3D clk_rcg2_is_enabled,
> +       .get_parent =3D clk_rcg2_get_parent,
> +       .set_parent =3D clk_rcg2_dfs_set_parent,
> +       .recalc_rate =3D clk_rcg2_recalc_rate,

Does recalc_rate even work when DFS is enabled? How do we know what the
rate actually is if DFS is enabled and a driver calls clk_set_rate()?
Does the hardware update the registers to indicate what frequency is
selected at the time?

> +       .determine_rate =3D clk_rcg2_dfs_determine_rate,
> +       .set_rate =3D clk_rcg2_dfs_set_rate,
> +       .set_rate_and_parent =3D clk_rcg2_dfs_set_rate_and_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_rcg2_dfs_ops);
> +
> +int clk_rcg2_enable_dfs(struct clk_rcg2 *rcg, struct device *dev)
> +{
> +       struct regmap *regmap;
> +       struct clk_rate_request req =3D { };
> +       u32 val;
> +       int ret;
> +
> +       regmap =3D dev_get_regmap(dev, NULL);
> +       if (!regmap)

Seems impossible! Of course, just pass the regmap and then it is 100%
impossible.

> +               return -EINVAL;
> +
> +       /* Check for DFS_EN */

Useless comment. Remove.

> +       ret =3D regmap_read(regmap, rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET,
> +                        &val);
> +       if (ret) {
> +               dev_err(dev, "Failed to read DFS enable register\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!(val & SE_CMD_DFS_EN))
> +               return ret;

Just return 0 please. It just happens to be 0 because it didn't fail
earlier, but 0 is more explicit about what's going on.

> +
> +       ret =3D __clk_determine_rate(&rcg->clkr.hw, &req);
> +       if (ret)
> +               return ret;

The whole point of lazy evaluation is to not do this and only calculate
the rate when we know the parent frequency. Right now, that won't work
because 'req' is empty and put on the stack. I'm not sure why this whole
function exists right now.

> +
> +       rcg->dfs_enable =3D true;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(clk_rcg2_enable_dfs);
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index b8064a3..0b656ed 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -288,4 +288,26 @@ int qcom_cc_probe(struct platform_device *pdev, cons=
t struct qcom_cc_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(qcom_cc_probe);
> =

> +int qcom_cc_register_rcg_dfs(struct platform_device *pdev,
> +                           struct clk_rcg2 **rcgs, int num_clks)
> +{
> +       struct clk_rcg2 *rcg;
> +       int i, ret =3D 0;
> +
> +       for (i =3D 0; i < num_clks; i++) {
> +               rcg =3D rcgs[i];
> +               ret =3D clk_rcg2_enable_dfs(rcg, &pdev->dev);
> +               if (ret) {
> +                       const char *name =3D (rcg->clkr.hw.init->name);

Useless parenthesis. Remove.

> +
> +                       dev_err(&pdev->dev,
> +                               "%s DFS frequencies update failed\n", nam=
e);
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_cc_register_rcg_dfs);

This whole thing should be in rcg.c, not common.c

> +
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 00196ee..71d1c27 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
>  #define PLL_LOCK_COUNT_MASK    0x3f
> @@ -69,4 +61,6 @@ extern int qcom_cc_really_probe(struct platform_device =
*pdev,
>  extern int qcom_cc_probe(struct platform_device *pdev,
>                          const struct qcom_cc_desc *desc);
> =

> +extern int qcom_cc_register_rcg_dfs(struct platform_device *pdev,
> +                                  struct clk_rcg2 **rcgs, int num_clks);

This should be exposed in clk-rcg.h instead of common.h

