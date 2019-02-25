Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B9BC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6005D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfBYMNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:13:10 -0500
Received: from mx.socionext.com ([202.248.49.38]:8127 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfBYMNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:13:10 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Feb 2019 21:13:08 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id A25A66117D;
        Mon, 25 Feb 2019 21:13:08 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 25 Feb 2019 21:13:08 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 48B5F1A04E1;
        Mon, 25 Feb 2019 21:13:08 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 30B1B121B6C;
        Mon, 25 Feb 2019 21:13:08 +0900 (JST)
Subject: Re: [PATCH v2 08/15] clock: milbeaut: Add Milbeaut M10V clock
 controller
To:     Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1549628837-31574-1-git-send-email-sugaya.taichi@socionext.com>
 <155087986877.77512.2765555413921453918@swboyd.mtv.corp.google.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <7b7fbbd8-42cc-a4d3-ecfe-694716509476@socionext.com>
Date:   Mon, 25 Feb 2019 21:13:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <155087986877.77512.2765555413921453918@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comments.

On 2019/02/23 8:57, Stephen Boyd wrote:
> Quoting Sugaya Taichi (2019-02-08 04:27:17)
>> diff --git a/drivers/clk/clk-milbeaut.c b/drivers/clk/clk-milbeaut.c
>> new file mode 100644
>> index 0000000..f798939
>> --- /dev/null
>> +++ b/drivers/clk/clk-milbeaut.c
>> @@ -0,0 +1,626 @@
> [....]
>> +struct m10v_clk_div_fixed_data {
>> +       const char      *name;
>> +       const char      *parent_name;
>> +       u8              div;
>> +       u8              mult;
>> +       int             onecell_idx;
>> +};
>> +struct m10v_clk_mux_factors {
>> +       const char              *name;
>> +       const char * const      *parent_names;
>> +       u8                      num_parents;
>> +       u32                     offset;
>> +       u8                      shift;
>> +       u8                      mask;
>> +       u32                     *table;
>> +       unsigned long           mux_flags;
>> +       int                     onecell_idx;
>> +};
> 
> Please add newlines between struct definitions. It also wouldn't hurt to
> have kernel-doc on these.
> 

I got it.

>> +
>> +static const struct clk_div_table emmcclk_table[] = {
>> +       { .val = 0, .div = 8 },
>> +       { .val = 1, .div = 9 },
>> +       { .val = 2, .div = 10 },
>> +       { .val = 3, .div = 15 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table mclk400_table[] = {
>> +       { .val = 1, .div = 2 },
>> +       { .val = 3, .div = 4 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table mclk200_table[] = {
>> +       { .val = 3, .div = 4 },
>> +       { .val = 7, .div = 8 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table aclk400_table[] = {
>> +       { .val = 1, .div = 2 },
>> +       { .val = 3, .div = 4 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table aclk300_table[] = {
>> +       { .val = 0, .div = 2 },
>> +       { .val = 1, .div = 3 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table aclk_table[] = {
>> +       { .val = 3, .div = 4 },
>> +       { .val = 7, .div = 8 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table aclkexs_table[] = {
>> +       { .val = 3, .div = 4 },
>> +       { .val = 4, .div = 5 },
>> +       { .val = 5, .div = 6 },
>> +       { .val = 7, .div = 8 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table hclk_table[] = {
>> +       { .val = 7, .div = 8 },
>> +       { .val = 15, .div = 16 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table hclkbmh_table[] = {
>> +       { .val = 3, .div = 4 },
>> +       { .val = 7, .div = 8 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table pclk_table[] = {
>> +       { .val = 15, .div = 16 },
>> +       { .val = 31, .div = 32 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table rclk_table[] = {
>> +       { .val = 0, .div = 8 },
>> +       { .val = 1, .div = 16 },
>> +       { .val = 2, .div = 24 },
>> +       { .val = 3, .div = 32 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table uhs1clk0_table[] = {
>> +       { .val = 0, .div = 2 },
>> +       { .val = 1, .div = 3 },
>> +       { .val = 2, .div = 4 },
>> +       { .val = 3, .div = 8 },
>> +       { .val = 4, .div = 16 },
>> +       { .div = 0 },
>> +};
>> +static const struct clk_div_table uhs2clk_table[] = {
>> +       { .val = 0, .div = 9 },
>> +       { .val = 1, .div = 10 },
>> +       { .val = 2, .div = 11 },
>> +       { .val = 3, .div = 12 },
>> +       { .val = 4, .div = 13 },
>> +       { .val = 5, .div = 14 },
>> +       { .val = 6, .div = 16 },
>> +       { .val = 7, .div = 18 },
>> +       { .div = 0 },
>> +};
> 
> Same comment applies here. Newlines between tables please.
> 

OK.

>> +
>> +static u32 spi_mux_table[] = {0, 1, 2};
>> +static const char * const spi_mux_names[] = {
>> +       M10V_SPI_PARENT0, M10V_SPI_PARENT1, M10V_SPI_PARENT2
>> +};
>> +
>> +static u32 uhs1clk2_mux_table[] = {2, 3, 4, 8};
>> +static const char * const uhs1clk2_mux_names[] = {
>> +       M10V_UHS1CLK2_PARENT0, M10V_UHS1CLK2_PARENT1,
>> +       M10V_UHS1CLK2_PARENT2, M10V_PLL6DIV2
>> +};
>> +
>> +static u32 uhs1clk1_mux_table[] = {3, 4, 8};
>> +static const char * const uhs1clk1_mux_names[] = {
>> +       M10V_UHS1CLK1_PARENT0, M10V_UHS1CLK1_PARENT1, M10V_PLL6DIV2
>> +};
>> +
> [...]
>> +
>> +static const struct m10v_clk_mux_factors m10v_mux_factor_data[] = {
>> +       {"spi", spi_mux_names, ARRAY_SIZE(spi_mux_names),
>> +               CLKSEL(8), 3, 7, spi_mux_table, 0, M10V_SPICLK_ID},
>> +       {"uhs1clk2", uhs1clk2_mux_names, ARRAY_SIZE(uhs1clk2_mux_names),
>> +               CLKSEL(1), 13, 31, uhs1clk2_mux_table, 0, -1},
>> +       {"uhs1clk1", uhs1clk1_mux_names, ARRAY_SIZE(uhs1clk1_mux_names),
>> +               CLKSEL(1), 8, 31, uhs1clk1_mux_table, 0, -1},
>> +       {"nfclk", nfclk_mux_names, ARRAY_SIZE(nfclk_mux_names),
>> +               CLKSEL(1), 22, 127, nfclk_mux_table, 0, M10V_NFCLK_ID},
>> +};
>> +
>> +static u8 m10v_mux_get_parent(struct clk_hw *hw)
>> +{
>> +       struct clk_mux *mux = to_clk_mux(hw);
>> +       u32 val;
>> +
>> +       val = clk_readl(mux->reg) >> mux->shift;
> 
> Please don't use clk_readl() unless you absolutely need it.
> 

OK, I try to use "readl()" simply.

>> +       val &= mux->mask;
>> +
>> +       return clk_mux_val_to_index(hw, mux->table, mux->flags, val);
>> +}
>> +
> [...]
>> +static struct clk_hw *m10v_clk_hw_register_divider(struct device *dev,
>> +               const char *name, const char *parent_name, unsigned long flags,
>> +               void __iomem *reg, u8 shift, u8 width,
>> +               u8 clk_divider_flags, const struct clk_div_table *table,
>> +               spinlock_t *lock, void __iomem *write_valid_reg)
>> +{
>> +       struct m10v_clk_divider *div;
>> +       struct clk_hw *hw;
>> +       struct clk_init_data init;
>> +       int ret;
>> +
>> +       div = kzalloc(sizeof(*div), GFP_KERNEL);
>> +       if (!div)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.name = name;
>> +       if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
> 
> Is this used?
> 

Now there are no factors to use "CLK_DIVIDER_READ_ONLY".
I will drop this statement and ro_ops too.

>> +               init.ops = &m10v_clk_divider_ro_ops;
>> +       else
>> +               init.ops = &m10v_clk_divider_ops;
>> +       init.flags = flags;
>> +       init.parent_names = &parent_name;
>> +       init.num_parents = 1;
>> +
>> +       div->reg = reg;
>> +       div->shift = shift;
>> +       div->width = width;
>> +       div->flags = clk_divider_flags;
>> +       div->lock = lock;
>> +       div->hw.init = &init;
>> +       div->table = table;
>> +       div->write_valid_reg = write_valid_reg;
>> +
>> +       /* register the clock */
>> +       hw = &div->hw;
>> +       ret = clk_hw_register(dev, hw);
>> +       if (ret) {
>> +               kfree(div);
>> +               hw = ERR_PTR(ret);
>> +       }
>> +
>> +       return hw;
>> +}
>> +
>> +static int m10v_clk_probe(struct platform_device *pdev)
>> +{
> [...]
>> +       for (id = 0; id < ARRAY_SIZE(m10v_div_fixed_data); ++id) {
>> +               const struct m10v_clk_div_fixed_data *dfd =
>> +                               &m10v_div_fixed_data[id];
>> +               const char *pn = dfd->parent_name ?
>> +                               dfd->parent_name : parent_name;
>> +               hw = clk_hw_register_fixed_factor(NULL, dfd->name,
>> +                                       pn, 0, dfd->mult, dfd->div);
>> +               if (dfd->onecell_idx >= 0)
>> +                       m10v_clk_data->hws[dfd->onecell_idx] = hw;
>> +       }
>> +       for (id = 0; id < ARRAY_SIZE(m10v_mux_factor_data); ++id) {
>> +               const struct m10v_clk_mux_factors *mfd =
>> +                               &m10v_mux_factor_data[id];
>> +               hw = m10v_clk_hw_register_mux(NULL, mfd->name,
>> +                                       mfd->parent_names, mfd->num_parents,
>> +                                       CLK_SET_RATE_PARENT,
>> +                                       base + mfd->offset, mfd->shift,
>> +                                       mfd->mask, mfd->mux_flags, mfd->table,
>> +                                       &m10v_crglock);
>> +               if (mfd->onecell_idx >= 0)
>> +                       m10v_clk_data->hws[mfd->onecell_idx] = hw;
>> +       }
> 
> Similar style nitpick here. Add newlines between for loops. It may also
> make sense to make functions for each of those so that we don't need to
> put all the local variables interspersed throughout the function in each
> for loop.
> 

Yeah OK, I think these statements are bit of ugly too..
I try to make it easy to see.

>> +
>> +       for (id = 0; id < M10V_NUM_CLKS; id++) {
>> +               if (IS_ERR(m10v_clk_data->hws[id]))
>> +                       return PTR_ERR(m10v_clk_data->hws[id]);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id m10v_clk_dt_ids[] = {
>> +       { .compatible = "socionext,milbeaut-m10v-ccu", },
>> +       { },
> 
> Drop the , on the sentinel please. That way nothing can ever go after it
> without causing a compilation error.
> 

OK, drop it.

Thanks,
Sugaya Taichi

>> +};

