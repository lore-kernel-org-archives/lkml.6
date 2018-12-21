Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C6EC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C9121917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbeLUNuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:50:46 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33306 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbeLUNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:50:46 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBLDodgG028730;
        Fri, 21 Dec 2018 07:50:39 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2pcyw5vw2c-1;
        Fri, 21 Dec 2018 07:50:38 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 0EBD1611C8B7;
        Fri, 21 Dec 2018 07:54:30 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 21 Dec 2018
 13:50:37 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wBLDobOn031103; Fri,
 21 Dec 2018 13:50:37 GMT
Date:   Fri, 21 Dec 2018 13:50:37 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <broonie@kernel.org>, <lee.jones@linaro.org>,
        <linus.walleij@linaro.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v5 7/8] clk: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181221135037.GH16508@imbe.wolfsonmicro.main>
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
 <20181120141631.18949-7-ckeepax@opensource.cirrus.com>
 <154356443157.88331.15749597863624143993@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <154356443157.88331.15749597863624143993@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812210109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:53:51PM -0800, Stephen Boyd wrote:
> Quoting Charles Keepax (2018-11-20 06:16:30)

Apologies for the delay on this we have been very swamped at this
end lately.

> > diff --git a/drivers/clk/clk-lochnagar.c b/drivers/clk/clk-lochnagar.c
> > new file mode 100644
> > index 000000000000..8b2a78689715
> > --- /dev/null
> > +++ b/drivers/clk/clk-lochnagar.c
> > @@ -0,0 +1,360 @@
> [...]
> > +
> > +static int lochnagar_regmap_set_parent(struct clk_hw *hw, u8 index)
> > +{
> > +       struct lochnagar_clk *lclk = lochnagar_hw_to_lclk(hw);
> > +       struct lochnagar_clk_priv *priv = lclk->priv;
> > +       struct regmap *regmap = priv->regmap;
> > +       int ret;
> > +
> > +       /*
> > +        * Some clocks on Lochnagar can either generate a clock themselves
> > +        * or accept an external clock, these default to generating the clock
> > +        * themselves. If we set a parent however we should update the dir_mask
> > +        * to indicate to the hardware that this clock will now be receiving an
> > +        * external clock.
> 
> Hmm ok. So the plan is to configure parents in DT or from driver code if
> the configuration is to accept an external clk? I guess this works.
> 

Actually from further discussions on the hardware side it seems
this is handled automatically by the hardware so we no longer
need to set these direction bits. As such I will remove them in
the next spin.

> > +        */
> > +       if (lclk->dir_mask) {
> > +               ret = regmap_update_bits(regmap, lclk->cfg_reg,
> > +                                        lclk->dir_mask, lclk->dir_mask);
> > +               if (ret < 0) {
> > +                       dev_err(priv->dev, "Failed to set %s direction: %d\n",
> > +                               lclk->name, ret);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       ret = regmap_update_bits(regmap, lclk->src_reg, lclk->src_mask, index);
> > +       if (ret < 0)
> > +               dev_err(priv->dev, "Failed to reparent %s: %d\n",
> > +                       lclk->name, ret);
> > +
> > +       return ret;
> > +}
> > +
> > +static u8 lochnagar_regmap_get_parent(struct clk_hw *hw)
> > +{
> > +       struct lochnagar_clk *lclk = lochnagar_hw_to_lclk(hw);
> > +       struct lochnagar_clk_priv *priv = lclk->priv;
> > +       struct regmap *regmap = priv->regmap;
> > +       unsigned int val;
> > +       int ret;
> > +
> > +       ret = regmap_read(regmap, lclk->src_reg, &val);
> > +       if (ret < 0) {
> > +               dev_err(priv->dev, "Failed to read parent of %s: %d\n",
> > +                       lclk->name, ret);
> 
> The error messages in the above functions could be spammy. Just let
> drivers who fail when using these clks ops print errors and maybe
> downgrade these to debug? If you don't agree with this it's fine, I'll
> just hope to never see these prints change to debug in the future.
> 

Seems reasonable to me I will change them to debug prints.

> > +               return priv->nparents;
> > +       }
> > +
> > +       val &= lclk->src_mask;
> > +
> > +       return val;
> > +}
> > +
> > +static const struct clk_ops lochnagar_clk_regmap_ops = {
> > +       .prepare = lochnagar_regmap_prepare,
> > +       .unprepare = lochnagar_regmap_unprepare,
> > +       .set_parent = lochnagar_regmap_set_parent,
> > +       .get_parent = lochnagar_regmap_get_parent,
> 
> Is regmap important to have in the name of these functions and struct?
> I'd prefer it was just clk instead of regmap.
> 

Again no objection happy to rename.

> > +};
> > +
> > +static int lochnagar_init_parents(struct lochnagar_clk_priv *priv)
> > +{
> > +       struct device_node *np = priv->dev->of_node;
> > +       int i, j;
> > +
> > +       switch (priv->type) {
> > +       case LOCHNAGAR1:
> > +               memcpy(priv->lclks, lochnagar1_clks, sizeof(lochnagar1_clks));
> > +
> > +               priv->nparents = ARRAY_SIZE(lochnagar1_clk_parents);
> > +               priv->parents = devm_kmemdup(priv->dev, lochnagar1_clk_parents,
> > +                                            sizeof(lochnagar1_clk_parents),
> > +                                            GFP_KERNEL);
> > +               break;
> > +       case LOCHNAGAR2:
> > +               memcpy(priv->lclks, lochnagar2_clks, sizeof(lochnagar2_clks));
> > +
> > +               priv->nparents = ARRAY_SIZE(lochnagar2_clk_parents);
> > +               priv->parents = devm_kmemdup(priv->dev, lochnagar2_clk_parents,
> > +                                            sizeof(lochnagar2_clk_parents),
> > +                                            GFP_KERNEL);
> 
> Why do we need to kmemdup it? The clk framework already deep copies
> everything from clk_init structure.
> 

The copy is needed for the updates to the list down below.

> > +               break;
> > +       default:
> > +               dev_err(priv->dev, "Unknown Lochnagar type: %d\n", priv->type);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (!priv->parents)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < priv->nparents; i++) {
> > +               j = of_property_match_string(np, "clock-names",
> > +                                            priv->parents[i]);
> > +               if (j >= 0)
> > +                       priv->parents[i] = of_clk_get_parent_name(np, j);
> 
> Isn't this of_clk_parent_fill()? But there are holes or something?
> 

I guess rather than a fill, this is perhaps more of a name and
replace. I could make this a core function if you prefer? I think
there are a couple of other drivers that could also use it,
although might be worth doing that as a separate series rather
than holding this one up.

> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int lochnagar_init_clks(struct lochnagar_clk_priv *priv)
> > +{
> > +       struct clk_init_data clk_init = {
> > +               .ops = &lochnagar_clk_regmap_ops,
> > +               .parent_names = priv->parents,
> > +               .num_parents = priv->nparents,
> > +       };
> > +       struct lochnagar_clk *lclk;
> > +       int ret, i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(priv->lclks); i++) {
> 
> We already have an array of clks.
> 
> > +               lclk = &priv->lclks[i];
> > +
> > +               if (!lclk->name)
> > +                       continue;
> > +
> > +               clk_init.name = lclk->name;
> > +
> > +               lclk->priv = priv;
> > +               lclk->hw.init = &clk_init;
> > +
> > +               ret = devm_clk_hw_register(priv->dev, &lclk->hw);
> > +               if (ret) {
> > +                       dev_err(priv->dev, "Failed to register %s: %d\n",
> > +                               lclk->name, ret);
> > +                       return ret;
> > +               }
> > +
> > +               priv->clk_data->hws[i] = &lclk->hw;
> 
> But then we copy the pointers into here to use of_clk_hw_onecell_get().
> Can you just roll your own function to use your own array of clk
> structures? I know it's sort of sad, but it avoids a copy.
> 

Apologies for not doing it this way the first time, looks much
clearer that way round.

> > +       }
> > +
> > +       priv->clk_data->num = ARRAY_SIZE(priv->lclks);
> > +
> > +       ret = devm_of_clk_add_hw_provider(priv->dev, of_clk_hw_onecell_get,
> > +                                         priv->clk_data);
> > +       if (ret < 0) {
> > +               dev_err(priv->dev, "Failed to register provider: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> 
> Simplify this to
> 
> 	if (ret < 0)
> 		dev_err(...)
> 
> 	return ret;
> 

No problem.

> > +}
> > +
> > +static const struct of_device_id lochnagar_of_match[] = {
> > +       { .compatible = "cirrus,lochnagar1-clk", .data = (void *)LOCHNAGAR1 },
> > +       { .compatible = "cirrus,lochnagar2-clk", .data = (void *)LOCHNAGAR2 },
> > +       {},
> 
> Nitpick: Drop the comma, it's the sentinel so nothing should come after.
> 

Again no problem.

> > +};
> 
> Any MODULE_DEVICE_TABLE?
> 

Yes oversight there, will add that.

> > +static struct platform_driver lochnagar_clk_driver = {
> > +       .driver = {
> > +               .name = "lochnagar-clk",
> > +               .of_match_table = of_match_ptr(lochnagar_of_match),
> 
> I suspect of_match_ptr() makes the build complain about unused match
> table when CONFIG_OF=N. Can you try building it that way?
> 

The driver depends on the MFD which in turn depends on CONFIG_OF
so that shouldn't be a problem.

> > +       },
> > +
> 
> Nitpick: Why the extra newline?
> 

Happy to remove.

> > +       .probe = lochnagar_clk_probe,
> > +};
> > +module_platform_driver(lochnagar_clk_driver);
> > +
> > +MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
> > +MODULE_DESCRIPTION("Clock driver for Cirrus Logic Lochnagar Board");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:lochnagar-clk");
> 
> I think MODULE_ALIAS is not needed if it's this simple?
> 

Not actually sure on this one, to be honest its mostly cargo
culted from other drivers. I will investigate and see what I dig
up but if has any pointers I would greatly appreciate it.

Should be able to send another version very shortly.

Thanks,
Charles
