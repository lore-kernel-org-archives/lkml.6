Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548D2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E18B206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550879873;
	bh=QMD3bzMoTfdQ0t7bLG1BYt49fKANSP4oc82fWCBciDs=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=VH+Kj9SV3+28QOoiFpa9aHkUxYSf5tpUHI7HL8utS7o/IwYIA3BUAGtUzD/AqOQ1g
	 L3ONCrlBRGBpMsEDz3aFsbTLZ4CR0BozZLZzRqsvBilGbFlIAgEWpnIG7koU9hh7dn
	 Qpkfu5lkAy0jT0ZJJuOzclXlCkgMKjxkdv6t/UyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfBVX5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:57:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfBVX5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:57:51 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 965CE206A3;
        Fri, 22 Feb 2019 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550879869;
        bh=QMD3bzMoTfdQ0t7bLG1BYt49fKANSP4oc82fWCBciDs=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=XYIA5LB1Xu1xcWqcYUEOOa3UolTuBLokkjKQ/MfFQf+Tj3w94G2jk5X8qtRn1Kko9
         2TKkMh5LpAQGqqkmyLD+Rn08Yxc7oW5hSPoMsfhKCeJORXQZMBxYW3hR8hOIn1qO/7
         6vBN/241CQ0DeRxmv/fPYoIs6i6NfPmuhjom/v9w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 08/15] clock: milbeaut: Add Milbeaut M10V clock controller
Message-ID: <155087986877.77512.2765555413921453918@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1549628837-31574-1-git-send-email-sugaya.taichi@socionext.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1549628837-31574-1-git-send-email-sugaya.taichi@socionext.com>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Date:   Fri, 22 Feb 2019 15:57:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sugaya Taichi (2019-02-08 04:27:17)
> diff --git a/drivers/clk/clk-milbeaut.c b/drivers/clk/clk-milbeaut.c
> new file mode 100644
> index 0000000..f798939
> --- /dev/null
> +++ b/drivers/clk/clk-milbeaut.c
> @@ -0,0 +1,626 @@
[....]
> +struct m10v_clk_div_fixed_data {
> +       const char      *name;
> +       const char      *parent_name;
> +       u8              div;
> +       u8              mult;
> +       int             onecell_idx;
> +};
> +struct m10v_clk_mux_factors {
> +       const char              *name;
> +       const char * const      *parent_names;
> +       u8                      num_parents;
> +       u32                     offset;
> +       u8                      shift;
> +       u8                      mask;
> +       u32                     *table;
> +       unsigned long           mux_flags;
> +       int                     onecell_idx;
> +};

Please add newlines between struct definitions. It also wouldn't hurt to
have kernel-doc on these.

> +
> +static const struct clk_div_table emmcclk_table[] =3D {
> +       { .val =3D 0, .div =3D 8 },
> +       { .val =3D 1, .div =3D 9 },
> +       { .val =3D 2, .div =3D 10 },
> +       { .val =3D 3, .div =3D 15 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table mclk400_table[] =3D {
> +       { .val =3D 1, .div =3D 2 },
> +       { .val =3D 3, .div =3D 4 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table mclk200_table[] =3D {
> +       { .val =3D 3, .div =3D 4 },
> +       { .val =3D 7, .div =3D 8 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table aclk400_table[] =3D {
> +       { .val =3D 1, .div =3D 2 },
> +       { .val =3D 3, .div =3D 4 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table aclk300_table[] =3D {
> +       { .val =3D 0, .div =3D 2 },
> +       { .val =3D 1, .div =3D 3 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table aclk_table[] =3D {
> +       { .val =3D 3, .div =3D 4 },
> +       { .val =3D 7, .div =3D 8 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table aclkexs_table[] =3D {
> +       { .val =3D 3, .div =3D 4 },
> +       { .val =3D 4, .div =3D 5 },
> +       { .val =3D 5, .div =3D 6 },
> +       { .val =3D 7, .div =3D 8 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table hclk_table[] =3D {
> +       { .val =3D 7, .div =3D 8 },
> +       { .val =3D 15, .div =3D 16 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table hclkbmh_table[] =3D {
> +       { .val =3D 3, .div =3D 4 },
> +       { .val =3D 7, .div =3D 8 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table pclk_table[] =3D {
> +       { .val =3D 15, .div =3D 16 },
> +       { .val =3D 31, .div =3D 32 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table rclk_table[] =3D {
> +       { .val =3D 0, .div =3D 8 },
> +       { .val =3D 1, .div =3D 16 },
> +       { .val =3D 2, .div =3D 24 },
> +       { .val =3D 3, .div =3D 32 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table uhs1clk0_table[] =3D {
> +       { .val =3D 0, .div =3D 2 },
> +       { .val =3D 1, .div =3D 3 },
> +       { .val =3D 2, .div =3D 4 },
> +       { .val =3D 3, .div =3D 8 },
> +       { .val =3D 4, .div =3D 16 },
> +       { .div =3D 0 },
> +};
> +static const struct clk_div_table uhs2clk_table[] =3D {
> +       { .val =3D 0, .div =3D 9 },
> +       { .val =3D 1, .div =3D 10 },
> +       { .val =3D 2, .div =3D 11 },
> +       { .val =3D 3, .div =3D 12 },
> +       { .val =3D 4, .div =3D 13 },
> +       { .val =3D 5, .div =3D 14 },
> +       { .val =3D 6, .div =3D 16 },
> +       { .val =3D 7, .div =3D 18 },
> +       { .div =3D 0 },
> +};

Same comment applies here. Newlines between tables please.

> +
> +static u32 spi_mux_table[] =3D {0, 1, 2};
> +static const char * const spi_mux_names[] =3D {
> +       M10V_SPI_PARENT0, M10V_SPI_PARENT1, M10V_SPI_PARENT2
> +};
> +
> +static u32 uhs1clk2_mux_table[] =3D {2, 3, 4, 8};
> +static const char * const uhs1clk2_mux_names[] =3D {
> +       M10V_UHS1CLK2_PARENT0, M10V_UHS1CLK2_PARENT1,
> +       M10V_UHS1CLK2_PARENT2, M10V_PLL6DIV2
> +};
> +
> +static u32 uhs1clk1_mux_table[] =3D {3, 4, 8};
> +static const char * const uhs1clk1_mux_names[] =3D {
> +       M10V_UHS1CLK1_PARENT0, M10V_UHS1CLK1_PARENT1, M10V_PLL6DIV2
> +};
> +
[...]
> +
> +static const struct m10v_clk_mux_factors m10v_mux_factor_data[] =3D {
> +       {"spi", spi_mux_names, ARRAY_SIZE(spi_mux_names),
> +               CLKSEL(8), 3, 7, spi_mux_table, 0, M10V_SPICLK_ID},
> +       {"uhs1clk2", uhs1clk2_mux_names, ARRAY_SIZE(uhs1clk2_mux_names),
> +               CLKSEL(1), 13, 31, uhs1clk2_mux_table, 0, -1},
> +       {"uhs1clk1", uhs1clk1_mux_names, ARRAY_SIZE(uhs1clk1_mux_names),
> +               CLKSEL(1), 8, 31, uhs1clk1_mux_table, 0, -1},
> +       {"nfclk", nfclk_mux_names, ARRAY_SIZE(nfclk_mux_names),
> +               CLKSEL(1), 22, 127, nfclk_mux_table, 0, M10V_NFCLK_ID},
> +};
> +
> +static u8 m10v_mux_get_parent(struct clk_hw *hw)
> +{
> +       struct clk_mux *mux =3D to_clk_mux(hw);
> +       u32 val;
> +
> +       val =3D clk_readl(mux->reg) >> mux->shift;

Please don't use clk_readl() unless you absolutely need it.

> +       val &=3D mux->mask;
> +
> +       return clk_mux_val_to_index(hw, mux->table, mux->flags, val);
> +}
> +
[...]
> +static struct clk_hw *m10v_clk_hw_register_divider(struct device *dev,
> +               const char *name, const char *parent_name, unsigned long =
flags,
> +               void __iomem *reg, u8 shift, u8 width,
> +               u8 clk_divider_flags, const struct clk_div_table *table,
> +               spinlock_t *lock, void __iomem *write_valid_reg)
> +{
> +       struct m10v_clk_divider *div;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       div =3D kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)

Is this used?

> +               init.ops =3D &m10v_clk_divider_ro_ops;
> +       else
> +               init.ops =3D &m10v_clk_divider_ops;
> +       init.flags =3D flags;
> +       init.parent_names =3D &parent_name;
> +       init.num_parents =3D 1;
> +
> +       div->reg =3D reg;
> +       div->shift =3D shift;
> +       div->width =3D width;
> +       div->flags =3D clk_divider_flags;
> +       div->lock =3D lock;
> +       div->hw.init =3D &init;
> +       div->table =3D table;
> +       div->write_valid_reg =3D write_valid_reg;
> +
> +       /* register the clock */
> +       hw =3D &div->hw;
> +       ret =3D clk_hw_register(dev, hw);
> +       if (ret) {
> +               kfree(div);
> +               hw =3D ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
> +
> +static int m10v_clk_probe(struct platform_device *pdev)
> +{
[...]
> +       for (id =3D 0; id < ARRAY_SIZE(m10v_div_fixed_data); ++id) {
> +               const struct m10v_clk_div_fixed_data *dfd =3D
> +                               &m10v_div_fixed_data[id];
> +               const char *pn =3D dfd->parent_name ?
> +                               dfd->parent_name : parent_name;
> +               hw =3D clk_hw_register_fixed_factor(NULL, dfd->name,
> +                                       pn, 0, dfd->mult, dfd->div);
> +               if (dfd->onecell_idx >=3D 0)
> +                       m10v_clk_data->hws[dfd->onecell_idx] =3D hw;
> +       }
> +       for (id =3D 0; id < ARRAY_SIZE(m10v_mux_factor_data); ++id) {
> +               const struct m10v_clk_mux_factors *mfd =3D
> +                               &m10v_mux_factor_data[id];
> +               hw =3D m10v_clk_hw_register_mux(NULL, mfd->name,
> +                                       mfd->parent_names, mfd->num_paren=
ts,
> +                                       CLK_SET_RATE_PARENT,
> +                                       base + mfd->offset, mfd->shift,
> +                                       mfd->mask, mfd->mux_flags, mfd->t=
able,
> +                                       &m10v_crglock);
> +               if (mfd->onecell_idx >=3D 0)
> +                       m10v_clk_data->hws[mfd->onecell_idx] =3D hw;
> +       }

Similar style nitpick here. Add newlines between for loops. It may also
make sense to make functions for each of those so that we don't need to
put all the local variables interspersed throughout the function in each
for loop.

> +
> +       for (id =3D 0; id < M10V_NUM_CLKS; id++) {
> +               if (IS_ERR(m10v_clk_data->hws[id]))
> +                       return PTR_ERR(m10v_clk_data->hws[id]);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id m10v_clk_dt_ids[] =3D {
> +       { .compatible =3D "socionext,milbeaut-m10v-ccu", },
> +       { },

Drop the , on the sentinel please. That way nothing can ever go after it
without causing a compilation error.

> +};
