Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B2EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CE52184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfBAIWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:22:24 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25902 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727907AbfBAIWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:22:23 -0500
X-UUID: cfd8d523f99d4a4aab68925c899b991f-20190201
X-UUID: cfd8d523f99d4a4aab68925c899b991f-20190201
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2055242150; Fri, 01 Feb 2019 16:22:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:22:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:22:08 +0800
Message-ID: <1549009328.22634.1.camel@mtksdaap41>
Subject: Re: [PATCH v3 02/12] clk: mediatek: add new clkmux register API
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>, <sboyd@codeaurora.org>,
        "Rob Herring" <robh@kernel.org>, <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>,
        <owen.chen@mediatek.com>
Date:   Fri, 1 Feb 2019 16:22:08 +0800
In-Reply-To: <CANMq1KA=VBQNuda8RC7Ote1L8gJgPZxsO_dG47RY3sfpAv2SQg@mail.gmail.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
         <20181210073240.32278-4-weiyi.lu@mediatek.com>
         <CANMq1KA=VBQNuda8RC7Ote1L8gJgPZxsO_dG47RY3sfpAv2SQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: EB3C8BBCE186FCC59C3C76758C13B0AC344A8F16D6A0678DF507DD19BBD2E1A52000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2018-12-10 at 20:30 +0800, Nicolas Boichat wrote:
> On Mon, Dec 10, 2018 at 3:33 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> >
> > From: Owen Chen <owen.chen@mediatek.com>
> >
> > On both MT8183 & MT6765, there add "set/clr" register for
> > each clkmux setting, and one update register to trigger value change.
> > It is designed to prevent read-modify-write racing issue.
> > The sw design need to add a new API to handle this hw change with
> > a new mtk_clk_mux/mtk_mux struct in new file "clk-mux.c", "clk-mux.h".
> >
> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  drivers/clk/mediatek/Makefile  |   3 +-
> >  drivers/clk/mediatek/clk-mux.c | 229 +++++++++++++++++++++++++++++++++
> >  drivers/clk/mediatek/clk-mux.h | 101 +++++++++++++++
> >  3 files changed, 332 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/clk/mediatek/clk-mux.c
> >  create mode 100644 drivers/clk/mediatek/clk-mux.h
> >
> > diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> > index 844b55d2770d..00e4d405231e 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o
> > +obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
> > +
> >  obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
> >  obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
> >  obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
> > diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> > new file mode 100644
> > index 000000000000..efbbb35eb185
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mux.c
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: Owen Chen <owen.chen@mediatek.com>
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/slab.h>
> > +#include <linux/mfd/syscon.h>
> > +
> > +#include "clk-mtk.h"
> > +#include "clk-mux.h"
> > +
> > +static inline struct mtk_clk_mux *to_mtk_clk_mux(struct clk_hw *hw)
> > +{
> > +       return container_of(hw, struct mtk_clk_mux, hw);
> > +}
> > +
> > +static int mtk_clk_mux_enable(struct clk_hw *hw)
> > +{
> > +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +       u32 mask = BIT(mux->gate_shift);
> > +
> > +       return regmap_update_bits(mux->regmap, mux->mux_ofs, mask, ~mask);
> > +}
> > +
> > +static void mtk_clk_mux_disable(struct clk_hw *hw)
> > +{
> > +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +       u32 mask = BIT(mux->gate_shift);
> > +
> > +       regmap_update_bits(mux->regmap, mux->mux_ofs, mask, mask);
> > +}
> > +
> > +static int mtk_clk_mux_enable_setclr(struct clk_hw *hw)
> > +{
> > +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +
> > +       return regmap_write(mux->regmap, mux->mux_clr_ofs,
> > +                       BIT(mux->gate_shift));
> > +}
> > +
> > +static void mtk_clk_mux_disable_setclr(struct clk_hw *hw)
> > +{
> > +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +
> > +       regmap_write(mux->regmap, mux->mux_set_ofs, BIT(mux->gate_shift));
> > +}
> > +
> > +static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
> > +{
> > +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +       u32 val;
> > +
> > +       regmap_read(mux->regmap, mux->mux_ofs, &val);
> > +
> > +       return (val & BIT(mux->gate_shift)) == 0;
> > +}
> > +
> > +static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
> > +{
> > +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +       u32 mask = GENMASK(mux->mux_width - 1, 0);
> > +       u32 val;
> > +
> > +       regmap_read(mux->regmap, mux->mux_ofs, &val);
> > +       val = (val >> mux->mux_shift) & mask;
> > +
> > +       return val;
> > +}
> > +
> > +static int mtk_clk_mux_set_parent_lock(struct clk_hw *hw, u8 index)
> > +{
> > +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +       u32 mask = GENMASK(mux->mux_width - 1, 0);
> > +       unsigned long flags;
> > +
> > +       if (mux->lock)
> > +               spin_lock_irqsave(mux->lock, flags);
> > +       else
> > +               __acquire(mux->lock);
> > +
> > +       regmap_update_bits(mux->regmap, mux->mux_ofs, mask,
> > +               index << mux->mux_shift);
> > +
> > +       if (mux->lock)
> > +               spin_unlock_irqrestore(mux->lock, flags);
> > +       else
> > +               __release(mux->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static int mtk_clk_mux_set_parent_setclr_lock(struct clk_hw *hw, u8 index)
> > +{
> > +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> > +       u32 mask = GENMASK(mux->mux_width - 1, 0);
> > +       u32 val, orig;
> > +       unsigned long flags;
> > +
> > +       if (mux->lock)
> > +               spin_lock_irqsave(mux->lock, flags);
> > +       else
> > +               __acquire(mux->lock);
> > +
> > +       regmap_read(mux->regmap, mux->mux_ofs, &orig);
> > +       val = (orig & ~(mask << mux->mux_shift)) | (index << mux->mux_shift);
> > +
> > +       if (val != orig) {
> > +               regmap_write(mux->regmap, mux->mux_clr_ofs,
> > +                               mask << mux->mux_shift);
> > +               regmap_write(mux->regmap, mux->mux_set_ofs,
> > +                               index << mux->mux_shift);
> > +
> > +               if (mux->upd_shift >= 0)
> > +                       regmap_write(mux->regmap, mux->upd_ofs,
> > +                                       BIT(mux->upd_shift));
> > +       }
> > +
> > +       if (mux->lock)
> > +               spin_unlock_irqrestore(mux->lock, flags);
> > +       else
> > +               __release(mux->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +const struct clk_ops mtk_mux_ops = {
> > +       .get_parent = mtk_clk_mux_get_parent,
> > +       .set_parent = mtk_clk_mux_set_parent_lock,
> > +};
> > +
> > +const struct clk_ops mtk_mux_clr_set_upd_ops = {
> > +       .get_parent = mtk_clk_mux_get_parent,
> > +       .set_parent = mtk_clk_mux_set_parent_setclr_lock,
> > +};
> > +
> > +const struct clk_ops mtk_mux_gate_ops = {
> > +       .enable = mtk_clk_mux_enable,
> > +       .disable = mtk_clk_mux_disable,
> > +       .is_enabled = mtk_clk_mux_is_enabled,
> > +       .get_parent = mtk_clk_mux_get_parent,
> > +       .set_parent = mtk_clk_mux_set_parent_lock,
> > +};
> > +
> > +const struct clk_ops mtk_mux_gate_clr_set_upd_ops = {
> > +       .enable = mtk_clk_mux_enable_setclr,
> > +       .disable = mtk_clk_mux_disable_setclr,
> > +       .is_enabled = mtk_clk_mux_is_enabled,
> > +       .get_parent = mtk_clk_mux_get_parent,
> > +       .set_parent = mtk_clk_mux_set_parent_setclr_lock,
> > +};
> > +
> > +struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
> > +                                struct regmap *regmap,
> > +                                spinlock_t *lock)
> > +{
> > +       struct mtk_clk_mux *mtk_mux;
> 
> I'd call this variable clk_mux.
> 

OK, I'll fix in next version.

> > +       struct clk_init_data init;
> > +       struct clk *clk;
> > +
> > +       mtk_mux = kzalloc(sizeof(*mtk_mux), GFP_KERNEL);
> > +       if (!mtk_mux)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       init.name = mux->name;
> > +       init.flags = mux->flags | CLK_SET_RATE_PARENT;
> > +       init.parent_names = mux->parent_names;
> > +       init.num_parents = mux->num_parents;
> > +       init.ops = mux->ops;
> > +
> > +       mtk_mux->regmap = regmap;
> > +       mtk_mux->name = mux->name;
> > +       mtk_mux->mux_ofs = mux->mux_ofs;
> > +       mtk_mux->mux_set_ofs = mux->set_ofs;
> > +       mtk_mux->mux_clr_ofs = mux->clr_ofs;
> > +       mtk_mux->upd_ofs = mux->upd_ofs;
> > +       mtk_mux->mux_shift = mux->mux_shift;
> > +       mtk_mux->mux_width = mux->mux_width;
> > +       mtk_mux->gate_shift = mux->gate_shift;
> > +       mtk_mux->upd_shift = mux->upd_shift;
> 
> These copies seem a bit wasteful. If the lifetime of the objects are
> the same, can you just keep a pointer to struct mtk_mux in struct
> mtk_clk_mux?
> 
> If not, maybe move all the settings to a "params" structure or
> something like that, so we can do a simpler memcpy?
> 

I'll make a change like below.

struct mtk_clk_mux {
	struct clk_hw hw;
	struct regmap *regmap;
	const struct mtk_mux *data;
	spinlock_t *lock;
};

and do mtk_mux->data = mux; directly.

> > +
> > +       mtk_mux->lock = lock;
> > +       mtk_mux->hw.init = &init;
> > +
> > +       clk = clk_register(NULL, &mtk_mux->hw);
> > +       if (IS_ERR(clk)) {
> > +               kfree(mtk_mux);
> > +               return clk;
> > +       }
> > +
> > +       return clk;
> > +}
> > +
> > +int mtk_clk_register_muxes(const struct mtk_mux *muxes,
> > +                          int num, struct device_node *node,
> > +                          spinlock_t *lock,
> > +                          struct clk_onecell_data *clk_data)
> > +{
> > +       struct regmap *regmap;
> > +       struct clk *clk;
> > +       int i;
> > +
> > +       regmap = syscon_node_to_regmap(node);
> > +       if (IS_ERR(regmap)) {
> > +               pr_err("Cannot find regmap for %pOF: %ld\n", node,
> > +                      PTR_ERR(regmap));
> > +               return PTR_ERR(regmap);
> > +       }
> > +
> > +       for (i = 0; i < num; i++) {
> > +               const struct mtk_mux *mux = &muxes[i];
> > +
> > +               if (IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
> > +                       clk = mtk_clk_register_mux(mux, regmap, lock);
> > +
> > +                       if (IS_ERR(clk)) {
> > +                               pr_err("Failed to register clk %s: %ld\n",
> > +                                      mux->name, PTR_ERR(clk));
> > +                               continue;
> > +                       }
> > +
> > +                       clk_data->clks[mux->id] = clk;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> > new file mode 100644
> > index 000000000000..830a6117e670
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mux.h
> > @@ -0,0 +1,101 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: Owen Chen <owen.chen@mediatek.com>
> > + */
> > +
> > +#ifndef __DRV_CLK_MTK_MUX_H
> > +#define __DRV_CLK_MTK_MUX_H
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +struct mtk_clk_mux {
> > +       struct clk_hw hw;
> > +       struct regmap *regmap;
> > +
> > +       const char *name;
> > +
> > +       u32 mux_set_ofs;
> > +       u32 mux_clr_ofs;
> > +       u32 mux_ofs;
> > +       u32 upd_ofs;
> > +
> > +       u8 mux_shift;
> > +       u8 mux_width;
> > +       u8 gate_shift;
> > +       s8 upd_shift;
> > +
> > +       spinlock_t *lock;
> > +};
> > +
> > +struct mtk_mux {
> > +       int id;
> > +       const char *name;
> > +       const char * const *parent_names;
> > +       unsigned int flags;
> > +
> > +       u32 mux_ofs;
> > +       u32 set_ofs;
> > +       u32 clr_ofs;
> > +       u32 upd_ofs;
> > +
> > +       u8 mux_shift;
> > +       u8 mux_width;
> > +       u8 gate_shift;
> > +       s8 upd_shift;
> > +
> > +       const struct clk_ops *ops;
> > +
> > +       signed char num_parents;
> > +};
> > +
> > +extern const struct clk_ops mtk_mux_ops;
> > +extern const struct clk_ops mtk_mux_clr_set_upd_ops;
> > +extern const struct clk_ops mtk_mux_gate_ops;
> > +extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
> > +
> > +#define GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,         \
> > +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> > +                       _gate, _upd_ofs, _upd, _flags, _ops) {          \
> > +               .id = _id,                                              \
> > +               .name = _name,                                          \
> > +               .mux_ofs = _mux_ofs,                                    \
> > +               .set_ofs = _mux_set_ofs,                                \
> > +               .clr_ofs = _mux_clr_ofs,                                \
> > +               .upd_ofs = _upd_ofs,                                    \
> > +               .mux_shift = _shift,                                    \
> > +               .mux_width = _width,                                    \
> > +               .gate_shift = _gate,                                    \
> > +               .upd_shift = _upd,                                      \
> > +               .parent_names = _parents,                               \
> > +               .num_parents = ARRAY_SIZE(_parents),                    \
> > +               .flags = _flags,                                        \
> > +               .ops = &_ops,                                           \
> > +       }
> > +
> > +#define MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,     \
> > +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> > +                       _gate, _upd_ofs, _upd, _flags)                  \
> > +               GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,  \
> > +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> > +                       _gate, _upd_ofs, _upd, _flags,                  \
> > +                       mtk_mux_gate_clr_set_upd_ops)
> > +
> > +#define MUX_GATE_CLR_SET_UPD(_id, _name, _parents, _mux_ofs,           \
> > +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> > +                       _gate, _upd_ofs, _upd)                          \
> > +               MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents,        \
> > +                       _mux_ofs, _mux_set_ofs, _mux_clr_ofs, _shift,   \
> > +                       _width, _gate, _upd_ofs, _upd,                  \
> > +                       CLK_SET_RATE_PARENT)
> > +
> > +struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
> > +                                struct regmap *regmap,
> > +                                spinlock_t *lock);
> > +
> > +int mtk_clk_register_muxes(const struct mtk_mux *muxes,
> > +                          int num, struct device_node *node,
> > +                          spinlock_t *lock,
> > +                          struct clk_onecell_data *clk_data);
> > +
> > +#endif /* __DRV_CLK_MTK_MUX_H */
> > --
> > 2.18.0
> >



