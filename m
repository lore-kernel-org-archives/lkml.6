Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDCC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAE72084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBVI0mUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAE72084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeJ3DYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbeJ3DYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:24:34 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E23AE2080A;
        Mon, 29 Oct 2018 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540838083;
        bh=jeFpxn8Zxr6nDwuAcGWyFbQ0JdigRSQlGsAvItab+6I=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=iBVI0mULuC9g3WlpFBwOg41r6GNPYH2Xdrgg1f5pQuPqxkBG5YqeX3YEEH3bOCpx4
         Vr7KhQpbvwu8ZAJUQoFw0BU8W96+J3BOXVHG1OOtEVesBrGiNbdWCY5h0k92/91+ps
         aChh8WkzYS+3EBJu0IMoedus/E02nDfwAN6GiqEE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     geert+renesas@glider.be, horms@verge.net.au, jiada_wang@mentor.com,
        magnus.damm@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181025072349.15173-2-jiada_wang@mentor.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        jiada_wang@mentor.com
References: <20181025072349.15173-1-jiada_wang@mentor.com>
 <20181025072349.15173-2-jiada_wang@mentor.com>
Message-ID: <154083808229.98144.11678069495682135918@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH linux-next v1 1/4] clk: renesas: clk-avb: add AVB Clock driver
Date:   Mon, 29 Oct 2018 11:34:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting jiada_wang@mentor.com (2018-10-25 00:23:46)
> diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
> index 71d4cafe15c0..17b05955e4f4 100644
> --- a/drivers/clk/renesas/Makefile
> +++ b/drivers/clk/renesas/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_CLK_RCAR_USB2_CLOCK_SEL) +=3D rcar-usb2-cl=
ock-sel.o
>  obj-$(CONFIG_CLK_RENESAS_CPG_MSSR)     +=3D renesas-cpg-mssr.o
>  obj-$(CONFIG_CLK_RENESAS_CPG_MSTP)     +=3D clk-mstp.o
>  obj-$(CONFIG_CLK_RENESAS_DIV6)         +=3D clk-div6.o
> +obj-$(CONFIG_CLK_RENESAS_CLK_AVB)      +=3D clk-avb.o

Any reason this can't be placed in some sort of alphabetical order
instead of at the end of the file?

> diff --git a/drivers/clk/renesas/clk-avb.c b/drivers/clk/renesas/clk-avb.c
> new file mode 100644
> index 000000000000..bb1eef0e9bee
> --- /dev/null
> +++ b/drivers/clk/renesas/clk-avb.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017  Mentor
> + *
> + * Contact: Jiada Wang <jiada_wang@mentor.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.

Can you remove this paragraph? It duplicates the SPDX tag.

> + *
> + * avb Common Clock Framework support
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +
> +struct clk_avb_data {
> +       void __iomem *base;
> +
> +       struct clk_onecell_data clk_data;
> +       /* lock reg access */
> +       spinlock_t lock;
> +};
> +
> +struct clk_avb {
> +       struct clk_hw hw;
> +       unsigned int idx;
> +       struct clk_avb_data *data;
> +};
> +
> +#define to_clk_avb(_hw) container_of(_hw, struct clk_avb, hw)
> +
> +#define AVB_DIV_MASK   0x3ffff
> +#define AVB_MAX_DIV    0x3ffc0
> +#define AVB_COUNTER_MAX_FREQ   25000000
> +#define AVB_COUNTER_NUM                8
> +#define AVB_CLK_NAME_SIZE      10
> +#define AVB_ID_TO_DIV(id)      ((id) * 4)
> +
> +#define AVB_CLK_CONFIG         0x20
> +#define AVB_DIV_EN_COM         BIT(31)
> +#define AVB_CLK_NAME           "avb"
> +#define ADG_CLK_NAME           "adg"
> +
> +static int clk_avb_is_enabled(struct clk_hw *hw)
> +{
> +       struct clk_avb *avb =3D to_clk_avb(hw);
> +
> +       return (clk_readl(avb->data->base + AVB_CLK_CONFIG) & BIT(avb->id=
x));

Please drop the extra parenthesis.

> +}
> +
> +static int clk_avb_enabledisable(struct clk_hw *hw, int enable)
> +{
> +       struct clk_avb *avb =3D to_clk_avb(hw);
> +       u32 val;
> +
> +       spin_lock(&avb->data->lock);
> +
> +       val =3D clk_readl(avb->data->base + AVB_CLK_CONFIG);
> +       if (enable)
> +               val |=3D BIT(avb->idx);
> +       else
> +               val &=3D ~BIT(avb->idx);
> +       clk_writel(val, avb->data->base + AVB_CLK_CONFIG);
> +
> +       spin_unlock(&avb->data->lock);
> +
> +       return 0;
> +}
> +
> +static int clk_avb_enable(struct clk_hw *hw)
> +{
> +       return clk_avb_enabledisable(hw, 1);
> +}
> +
> +static void clk_avb_disable(struct clk_hw *hw)
> +{
> +       clk_avb_enabledisable(hw, 0);
> +}
> +
> +static unsigned long clk_avb_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct clk_avb *avb =3D to_clk_avb(hw);
> +       u32 div;
> +
> +       div =3D clk_readl(avb->data->base + AVB_ID_TO_DIV(avb->idx)) &
> +                       AVB_DIV_MASK;

Split this to two lines:

	div =3D readl(...);
	div &=3D AVB_DIV_MASK;

> +       if (!div)
> +               return parent_rate;
> +
> +       return parent_rate * 32 / div;
> +}
> +
> +static unsigned int clk_avb_calc_div(unsigned long rate,
> +                                    unsigned long parent_rate)
> +{
> +       unsigned int div;
> +
> +       if (!rate)
> +               rate =3D 1;
> +
> +       if (rate > AVB_COUNTER_MAX_FREQ)
> +               rate =3D AVB_COUNTER_MAX_FREQ;

rate =3D min(rate, AVB_COUNTER_MAX_FREQ);

> +
> +       div =3D DIV_ROUND_CLOSEST(parent_rate * 32, rate);
> +
> +       if (div > AVB_MAX_DIV)
> +               div =3D AVB_MAX_DIV;

div =3D min(div, AVB_MAX_DIV);

> +
> +       return div;
> +}
> +
> +static long clk_avb_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *parent_rate)
> +{
> +       unsigned int div =3D clk_avb_calc_div(rate, *parent_rate);
> +
> +       return (*parent_rate * 32) / div;
> +}
> +
> +static int clk_avb_set_rate(struct clk_hw *hw, unsigned long rate,
> +                           unsigned long parent_rate)
> +{
> +       struct clk_avb *avb =3D to_clk_avb(hw);
> +       unsigned int div =3D clk_avb_calc_div(rate, parent_rate);
> +       u32 val;
> +
> +       val =3D clk_readl(avb->data->base + AVB_ID_TO_DIV(avb->idx)) &
> +                       ~AVB_DIV_MASK;
> +       clk_writel(val | div, avb->data->base + AVB_ID_TO_DIV(avb->idx));

Any reason to use clk_readl/writel? Preferably these APIs aren't used
and you just use readl/writel instead.

> +
> +       return 0;
> +}
> +
> +static const struct clk_ops clk_avb_ops =3D {
> +       .enable =3D clk_avb_enable,
> +       .disable =3D clk_avb_disable,
> +       .is_enabled =3D clk_avb_is_enabled,
> +       .recalc_rate =3D clk_avb_recalc_rate,
> +       .round_rate =3D clk_avb_round_rate,
> +       .set_rate =3D clk_avb_set_rate,
> +};
> +
> +static struct clk *clk_register_avb(struct clk_avb_data *data,
> +                                   unsigned int id)
> +{
> +       struct clk_init_data init;
> +       struct clk_avb *avb;
> +       struct clk *clk;
> +       char name[AVB_CLK_NAME_SIZE];
> +       const char *parent_name =3D ADG_CLK_NAME;
> +
> +       avb =3D kzalloc(sizeof(*avb), GFP_KERNEL);
> +       if (!avb)
> +               return ERR_PTR(-ENOMEM);
> +
> +       snprintf(name, AVB_CLK_NAME_SIZE, "%s.%u", AVB_CLK_NAME, id);
> +
> +       avb->idx =3D id;
> +       avb->data =3D data;
> +
> +       /* Register the clock. */
> +       init.name =3D name;
> +       init.ops =3D &clk_avb_ops;
> +       init.flags =3D CLK_IS_BASIC;
> +       init.parent_names =3D &parent_name;
> +       init.num_parents =3D 1;
> +
> +       avb->hw.init =3D &init;
> +
> +       /* init DIV to a valid state */
> +       writel(AVB_MAX_DIV, data->base + AVB_ID_TO_DIV(avb->idx));
> +
> +       clk =3D clk_register(NULL, &avb->hw);
> +       if (IS_ERR(clk))
> +               kfree(avb);
> +
> +       return clk;
> +}
> +
> +static void clk_unregister_avb(struct clk *clk)
> +{
> +       struct clk_avb *avb;
> +       struct clk_hw *hw;
> +
> +       if (IS_ERR(clk))
> +               return;
> +
> +       hw =3D __clk_get_hw(clk);
> +       if (!hw)
> +               return;
> +
> +       avb =3D to_clk_avb(hw);
> +
> +       clk_unregister(clk);
> +       kfree(avb);

Using clk_hw based registration APIs would make this a little cleaner.

> +}
> +
> +static void __init clk_avb_setup(struct device_node *node)
> +{
> +       struct clk_avb_data *data;
> +       struct clk_onecell_data *clk_data;
> +       int ret, i;
> +       struct resource res;
> +
> +       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return;
> +
> +       data->base =3D of_io_request_and_map(node, 0, of_node_full_name(n=
ode));
> +       if (IS_ERR(data->base))
> +               goto err_data;
> +
> +       spin_lock_init(&data->lock);
> +
> +       clk_data =3D &data->clk_data;
> +       clk_data->clk_num =3D AVB_COUNTER_NUM;
> +       clk_data->clks =3D kmalloc_array(AVB_COUNTER_NUM,
> +                                      sizeof(struct clk *),
> +                                      GFP_KERNEL);
> +       if (!clk_data->clks)
> +               goto err_unmap;
> +
> +       for (i =3D 0; i < AVB_COUNTER_NUM; i++) {
> +               clk_data->clks[i] =3D clk_register_avb(data, i);
> +               if (IS_ERR(clk_data->clks[i])) {
> +                       pr_err("failed to register clock %s.%d\n",
> +                              AVB_CLK_NAME, i);
> +                       goto err_clks;
> +               }
> +       }
> +
> +       ret =3D of_clk_add_provider(node, of_clk_src_onecell_get, clk_dat=
a);

Can you use the clk_hw based registration and provider APIs?

> +       if (ret) {
> +               pr_err("failed to register clock provider\n");
> +               goto err_clks;
> +       }
> +
> +       writel(AVB_DIV_EN_COM, data->base + AVB_CLK_CONFIG);
> +
> +       return;
> +
> +err_clks:
> +       for (i =3D 0; i < AVB_COUNTER_NUM; i++)
> +               clk_unregister_avb(clk_data->clks[i]);
> +err_unmap:
> +       iounmap(data->base);
> +       of_address_to_resource(node, 0, &res);
> +       release_mem_region(res.start, resource_size(&res));
> +err_data:
> +       kfree(data);
> +}
> +
> +CLK_OF_DECLARE(avb, "renesas,clk-avb", clk_avb_setup);

Any reason to not use platform device APIs? If not, please change this
to a platform driver. Otherwise, add a comment indicating why it can't
be done.


