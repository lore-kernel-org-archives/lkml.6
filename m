Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD19C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0427E21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms4NlmS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0427E21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbeK0VLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:11:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730295AbeK0VLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:11:10 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 901E1208E4;
        Tue, 27 Nov 2018 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543313625;
        bh=/SbckQH1vgSNT6q2LyWeBCSIEfdsxmfF5Ra2OQo8BVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ms4NlmS7spDqrn+w08AF72/zGg/JS+bXl3dBD2UV75FSu+BOPbhMq+p9UU0mDUhIO
         /Z2S9rKJtDm8bthPMCRQiZPiEvWx0G5+8G/Ldr0tguEcVeE+Qwxxs1AngpA6t+UmOL
         IYPAwlYKa99QAiLkfaIeKbWR3uzbvD3kUoGqZhoc=
Received: by mail-wm1-f46.google.com with SMTP id k198so21615195wmd.3;
        Tue, 27 Nov 2018 02:13:45 -0800 (PST)
X-Gm-Message-State: AA+aEWbkBXGFaBoch72WvAIKDtVy43PW2N4NZjVULnRf/B201smlds9E
        CCo377fyBWIwdrXxUqdq6TCEJUjVDycjvF0drQk=
X-Google-Smtp-Source: AFSGD/UCM5e5du/B8uyIf9jQlK9Qj00+8aY1B3lOxG179P9lfmP4Bu3/eMKyBX3bp7Y2Cvl3EqjNTibnqZCkLvJ9bgM=
X-Received: by 2002:a1c:b406:: with SMTP id d6mr5115290wmf.129.1543313623970;
 Tue, 27 Nov 2018 02:13:43 -0800 (PST)
MIME-Version: 1.0
References: <20181127034254.24721-1-weiyi.lu@mediatek.com> <20181127034254.24721-3-weiyi.lu@mediatek.com>
In-Reply-To: <20181127034254.24721-3-weiyi.lu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 27 Nov 2018 02:13:33 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpxF8haQVVVM00xHX_vXc-ddtBZzZJ9AJCx13CrJqGs5A@mail.gmail.com>
Message-ID: <CAGp9LzpxF8haQVVVM00xHX_vXc-ddtBZzZJ9AJCx13CrJqGs5A@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] clk: mediatek: add new clkmux register API
To:     weiyi.lu@mediatek.com
Cc:     drinkcat@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        sboyd@codeaurora.org, robh@kernel.org, jamesjj.liao@mediatek.com,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        owen.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 >
> From: Owen Chen <owen.chen@mediatek.com>
>
> On both MT8183 & MT6765, there add "set/clr" register for
> each clkmux setting, and one update register to trigger value change.
> It is designed to prevent read-modify-write racing issue.
> The sw design need to add a new API to handle this hw change with
> a new mtk_clk_mux/mtk_mux struct in new file "clk-mux.c", "clk-mux.h".
>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/clk/mediatek/Makefile  |   2 +-
>  drivers/clk/mediatek/clk-mux.c | 240 +++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-mux.h | 101 ++++++++++++++
>  3 files changed, 342 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mux.c
>  create mode 100644 drivers/clk/mediatek/clk-mux.h
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 844b55d2770d..b97980dbb738 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o
> +obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o

add a proper words wrap?

>  obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
>  obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
>  obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> new file mode 100644
> index 000000000000..8618e5fa2b30
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <owen.chen@mediatek.com>
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-mux.h"
> +
> +static inline struct mtk_clk_mux
> +       *to_mtk_clk_mux(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct mtk_clk_mux, hw);
> +}
> +
> +static int mtk_clk_mux_enable(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 mask = BIT(mux->gate_shift);
> +
> +       return regmap_update_bits(mux->regmap, mux->mux_ofs, mask, 0);

prefer to
return regmap_update_bits(mux->regmap, mux->mux_ofs, mask, ~mask);
just to align with mtk_clk_mux_disable

> +}
> +
> +static void mtk_clk_mux_disable(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 mask = BIT(mux->gate_shift);
> +
> +       regmap_update_bits(mux->regmap, mux->mux_ofs, mask, mask);
> +}
> +
> +static int mtk_clk_mux_enable_setclr(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 val;
> +
> +       val = BIT(mux->gate_shift);
> +
> +       return regmap_write(mux->regmap, mux->mux_clr_ofs, val);

prefer to
return regmap_write(mux->regmap, mux->mux_clr_ofs, BIT(mux->gate_shift));
and drop u32 val declaration

> +}
> +
> +static void mtk_clk_mux_disable_setclr(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 val;
> +
> +       val = BIT(mux->gate_shift);
> +       regmap_write(mux->regmap, mux->mux_set_ofs, val);

perfer to
regmap_write(mux->regmap, mux->mux_set_ofs, BIT(mux->gate_shift));
and drop u32 val

> +}
> +
> +static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 val;
> +
> +       regmap_read(mux->regmap, mux->mux_ofs, &val);
> +
> +       return (val & BIT(mux->gate_shift)) == 0;
> +}
> +
> +static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 mask = GENMASK(mux->mux_width - 1, 0);
> +       u32 val;
> +
> +       regmap_read(mux->regmap, mux->mux_ofs, &val);
> +       val = (val >> mux->mux_shift) & mask;
> +
> +       return val;

an u32 to u8 happens here

> +}
> +
> +static int mtk_clk_mux_set_parent_lock(struct clk_hw *hw, u8 index)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 mask = GENMASK(mux->mux_width - 1, 0);
> +       u32 val;
> +       unsigned long flags = 0;

zero init is unnecessary

> +
> +       if (mux->lock)
> +               spin_lock_irqsave(mux->lock, flags);
> +       else
> +               __acquire(mux->lock);
> +
> +       regmap_read(mux->regmap, mux->mux_ofs, &val);
> +       val = (val & mask) >> mux->mux_shift;
> +
> +       if (val != index) {
> +               val = index << mux->mux_shift;
> +               regmap_update_bits(mux->regmap, mux->mux_ofs, mask, val);
> +       }

regmap_update_bits(mux->regmap, mux->mux_ofs, mask, index << mux->mux_shift);
appears to be sufficient. regmap_update_bits would check whether the
register write is necessary.

> +
> +       if (mux->lock)
> +               spin_unlock_irqrestore(mux->lock, flags);
> +       else
> +               __release(mux->lock);
> +
> +       return 0;
> +}
> +
> +static int mtk_clk_mux_set_parent_setclr_lock(struct clk_hw *hw, u8 index)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 mask = GENMASK(mux->mux_width - 1, 0);
> +       u32 val, orig;
> +       unsigned long flags = 0;

zero init is unnecessary

> +
> +       if (mux->lock)
> +               spin_lock_irqsave(mux->lock, flags);
> +       else
> +               __acquire(mux->lock);
> +
> +       regmap_read(mux->regmap, mux->mux_ofs, &orig);
> +       val = (orig & ~(mask << mux->mux_shift)) | (index << mux->mux_shift);
> +
> +       if (val != orig) {
> +               regmap_write(mux->regmap, mux->mux_clr_ofs,
> +                               mask << mux->mux_shift);
> +               regmap_write(mux->regmap, mux->mux_set_ofs,
> +                               index << mux->mux_shift);
> +
> +               if (mux->upd_shift >= 0)

upd_shift is an u8

> +                       regmap_write(mux->regmap, mux->upd_ofs,
> +                                       BIT(mux->upd_shift));
> +       }
> +
> +       if (mux->lock)
> +               spin_unlock_irqrestore(mux->lock, flags);
> +       else
> +               __release(mux->lock);
> +
> +       return 0;
> +}
> +
> +const struct clk_ops mtk_mux_ops = {
> +       .get_parent = mtk_clk_mux_get_parent,
> +       .set_parent = mtk_clk_mux_set_parent_lock,
> +};
> +
> +const struct clk_ops mtk_mux_clr_set_upd_ops = {
> +       .get_parent = mtk_clk_mux_get_parent,
> +       .set_parent = mtk_clk_mux_set_parent_setclr_lock,
> +};
> +
> +const struct clk_ops mtk_mux_gate_ops = {
> +       .enable = mtk_clk_mux_enable,
> +       .disable = mtk_clk_mux_disable,
> +       .is_enabled = mtk_clk_mux_is_enabled,
> +       .get_parent = mtk_clk_mux_get_parent,
> +       .set_parent = mtk_clk_mux_set_parent_lock,
> +};
> +
> +const struct clk_ops mtk_mux_gate_clr_set_upd_ops = {
> +       .enable = mtk_clk_mux_enable_setclr,
> +       .disable = mtk_clk_mux_disable_setclr,
> +       .is_enabled = mtk_clk_mux_is_enabled,
> +       .get_parent = mtk_clk_mux_get_parent,
> +       .set_parent = mtk_clk_mux_set_parent_setclr_lock,
> +};
> +
> +struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
> +                                struct regmap *regmap,
> +                                spinlock_t *lock)
> +{
> +       struct mtk_clk_mux *mtk_mux;
> +       struct clk_init_data init;
> +       struct clk *clk;
> +
> +       mtk_mux = kzalloc(sizeof(*mtk_mux), GFP_KERNEL);
> +       if (!mtk_mux)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = mux->name;
> +       init.flags = mux->flags | CLK_SET_RATE_PARENT;
> +       init.parent_names = mux->parent_names;
> +       init.num_parents = mux->num_parents;
> +       init.ops = mux->ops;
> +
> +       mtk_mux->regmap = regmap;
> +       mtk_mux->name = mux->name;
> +       mtk_mux->mux_ofs = mux->mux_ofs;
> +       mtk_mux->mux_set_ofs = mux->set_ofs;
> +       mtk_mux->mux_clr_ofs = mux->clr_ofs;
> +       mtk_mux->upd_ofs = mux->upd_ofs;
> +       mtk_mux->mux_shift = mux->mux_shift;
> +       mtk_mux->mux_width = mux->mux_width;
> +       mtk_mux->gate_shift = mux->gate_shift;
> +       mtk_mux->upd_shift = mux->upd_shift;
> +
> +       mtk_mux->lock = lock;
> +       mtk_mux->hw.init = &init;
> +
> +       clk = clk_register(NULL, &mtk_mux->hw);
> +       if (IS_ERR(clk)) {
> +               kfree(mtk_mux);
> +               return clk;
> +       }
> +
> +       return clk;
> +}
> +
> +int mtk_clk_register_muxes(const struct mtk_mux *muxes,
> +                          int num, struct device_node *node,
> +                          spinlock_t *lock,
> +                          struct clk_onecell_data *clk_data)
> +{
> +       struct regmap *regmap;
> +       struct clk *clk;
> +       int i;
> +
> +       regmap = syscon_node_to_regmap(node);
> +       if (IS_ERR(regmap)) {
> +               pr_err("Cannot find regmap for %pOF: %ld\n", node,
> +                      PTR_ERR(regmap));
> +               return PTR_ERR(regmap);
> +       }
> +
> +       for (i = 0; i < num; i++) {
> +               const struct mtk_mux *mux = &muxes[i];
> +
> +               if (IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
> +                       clk = mtk_clk_register_mux(mux, regmap, lock);
> +
> +                       if (IS_ERR(clk)) {
> +                               pr_err("Failed to register clk %s: %ld\n",
> +                                      mux->name, PTR_ERR(clk));
> +                               continue;
> +                       }
> +
> +                       clk_data->clks[mux->id] = clk;
> +               }
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> new file mode 100644
> index 000000000000..ff0276bb771c
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mux.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <owen.chen@mediatek.com>
> + */
> +
> +#ifndef __DRV_CLK_MUX_H
> +#define __DRV_CLK_MUX_H

how about adding a mtk specific prefix?

> +
> +#include <linux/clk-provider.h>
> +
> +struct mtk_clk_mux {
> +       struct clk_hw hw;
> +       struct regmap *regmap;
> +
> +       const char *name;
> +
> +       u32 mux_set_ofs;
> +       u32 mux_clr_ofs;
> +       u32 mux_ofs;
> +       u32 upd_ofs;
> +
> +       u8 mux_shift;
> +       u8 mux_width;
> +       u8 gate_shift;
> +       u8 upd_shift;
> +
> +       spinlock_t *lock;
> +};
> +
> +struct mtk_mux {
> +       int id;
> +       const char *name;
> +       const char * const *parent_names;
> +       unsigned int flags;
> +
> +       u32 mux_ofs;
> +       u32 set_ofs;
> +       u32 clr_ofs;
> +       u32 upd_ofs;
> +
> +       u8 mux_shift;
> +       u8 mux_width;
> +       u8 gate_shift;
> +       u8 upd_shift;
> +
> +       const struct clk_ops *ops;
> +
> +       signed char num_parents;
> +};
> +
> +extern const struct clk_ops mtk_mux_ops;
> +extern const struct clk_ops mtk_mux_clr_set_upd_ops;
> +extern const struct clk_ops mtk_mux_gate_ops;
> +extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
> +
> +#define GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,         \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       _gate, _upd_ofs, _upd, _flags, _ops) {          \
> +               .id = _id,                                              \
> +               .name = _name,                                          \
> +               .mux_ofs = _mux_ofs,                                    \
> +               .set_ofs = _mux_set_ofs,                                \
> +               .clr_ofs = _mux_clr_ofs,                                \
> +               .upd_ofs = _upd_ofs,                                    \
> +               .mux_shift = _shift,                                    \
> +               .mux_width = _width,                                    \
> +               .gate_shift = _gate,                                    \
> +               .upd_shift = _upd,                                      \
> +               .parent_names = _parents,                               \
> +               .num_parents = ARRAY_SIZE(_parents),                    \
> +               .flags = _flags,                                        \
> +               .ops = &_ops,                                           \
> +       }
> +
> +#define MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,     \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       _gate, _upd_ofs, _upd, _flags)                  \
> +               GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,  \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       _gate, _upd_ofs, _upd, _flags,                  \
> +                       mtk_mux_gate_clr_set_upd_ops)
> +
> +#define MUX_GATE_CLR_SET_UPD(_id, _name, _parents, _mux_ofs,           \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       _gate, _upd_ofs, _upd)                          \
> +               MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents,        \
> +                       _mux_ofs, _mux_set_ofs, _mux_clr_ofs, _shift,   \
> +                       _width, _gate, _upd_ofs, _upd,                  \
> +                       CLK_SET_RATE_PARENT)
> +
> +struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
> +                                struct regmap *regmap,
> +                                spinlock_t *lock);
> +
> +int mtk_clk_register_muxes(const struct mtk_mux *muxes,
> +                          int num, struct device_node *node,
> +                          spinlock_t *lock,
> +                          struct clk_onecell_data *clk_data);
> +
> +#endif /* __DRV_CLK_MUX_H */
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
