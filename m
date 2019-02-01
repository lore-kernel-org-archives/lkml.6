Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AFCC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F388D20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfBAIbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:31:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:15467 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729008AbfBAIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:30:37 -0500
X-UUID: 8b06eb2db5194a2d9affc9ab41027d2f-20190201
X-UUID: 8b06eb2db5194a2d9affc9ab41027d2f-20190201
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1439682094; Fri, 01 Feb 2019 16:30:26 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:30:25 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:30:25 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
Subject: [PATCH v4 02/12] clk: mediatek: add new clkmux register API
Date:   Fri, 1 Feb 2019 16:30:06 +0800
Message-ID: <20190201083016.25856-4-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190201083016.25856-1-weiyi.lu@mediatek.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BDC90F0C289CD08594CF36032A68DC0C11B995AE7E796BEDBD60CF576971B2E52000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Owen Chen <owen.chen@mediatek.com>

On both MT8183 & MT6765, there add "set/clr" register for
each clkmux setting, and one update register to trigger value change.
It is designed to prevent read-modify-write racing issue.
The sw design need to add a new API to handle this hw change with
a new mtk_clk_mux/mtk_mux struct in new file "clk-mux.c", "clk-mux.h".

Signed-off-by: Owen Chen <owen.chen@mediatek.com>
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/Makefile  |   3 +-
 drivers/clk/mediatek/clk-mux.c | 223 +++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.h |  89 +++++++++++++
 3 files changed, 314 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mux.c
 create mode 100644 drivers/clk/mediatek/clk-mux.h

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index ee4410ff43ab..20cf9eea4171 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o
+obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
+
 obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
 obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
 obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
new file mode 100644
index 000000000000..877a883fa616
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Owen Chen <owen.chen@mediatek.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+
+#include "clk-mtk.h"
+#include "clk-mux.h"
+
+static inline struct mtk_clk_mux *to_mtk_clk_mux(struct clk_hw *hw)
+{
+	return container_of(hw, struct mtk_clk_mux, hw);
+}
+
+static int mtk_clk_mux_enable(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = BIT(mux->data->gate_shift);
+
+	return regmap_update_bits(mux->regmap, mux->data->mux_ofs,
+			mask, ~mask);
+}
+
+static void mtk_clk_mux_disable(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = BIT(mux->data->gate_shift);
+
+	regmap_update_bits(mux->regmap, mux->data->mux_ofs, mask, mask);
+}
+
+static int mtk_clk_mux_enable_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+
+	return regmap_write(mux->regmap, mux->data->clr_ofs,
+			BIT(mux->data->gate_shift));
+}
+
+static void mtk_clk_mux_disable_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+
+	regmap_write(mux->regmap, mux->data->set_ofs,
+			BIT(mux->data->gate_shift));
+}
+
+static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val;
+
+	regmap_read(mux->regmap, mux->data->mux_ofs, &val);
+
+	return (val & BIT(mux->data->gate_shift)) == 0;
+}
+
+static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = GENMASK(mux->data->mux_width - 1, 0);
+	u32 val;
+
+	regmap_read(mux->regmap, mux->data->mux_ofs, &val);
+	val = (val >> mux->data->mux_shift) & mask;
+
+	return val;
+}
+
+static int mtk_clk_mux_set_parent_lock(struct clk_hw *hw, u8 index)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = GENMASK(mux->data->mux_width - 1, 0);
+	unsigned long flags;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+	else
+		__acquire(mux->lock);
+
+	regmap_update_bits(mux->regmap, mux->data->mux_ofs, mask,
+		index << mux->data->mux_shift);
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+	else
+		__release(mux->lock);
+
+	return 0;
+}
+
+static int mtk_clk_mux_set_parent_setclr_lock(struct clk_hw *hw, u8 index)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = GENMASK(mux->data->mux_width - 1, 0);
+	u32 val, orig;
+	unsigned long flags;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+	else
+		__acquire(mux->lock);
+
+	regmap_read(mux->regmap, mux->data->mux_ofs, &orig);
+	val = (orig & ~(mask << mux->data->mux_shift))
+			| (index << mux->data->mux_shift);
+
+	if (val != orig) {
+		regmap_write(mux->regmap, mux->data->clr_ofs,
+				mask << mux->data->mux_shift);
+		regmap_write(mux->regmap, mux->data->set_ofs,
+				index << mux->data->mux_shift);
+
+		if (mux->data->upd_shift >= 0)
+			regmap_write(mux->regmap, mux->data->upd_ofs,
+					BIT(mux->data->upd_shift));
+	}
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+	else
+		__release(mux->lock);
+
+	return 0;
+}
+
+const struct clk_ops mtk_mux_ops = {
+	.get_parent = mtk_clk_mux_get_parent,
+	.set_parent = mtk_clk_mux_set_parent_lock,
+};
+
+const struct clk_ops mtk_mux_clr_set_upd_ops = {
+	.get_parent = mtk_clk_mux_get_parent,
+	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
+};
+
+const struct clk_ops mtk_mux_gate_ops = {
+	.enable = mtk_clk_mux_enable,
+	.disable = mtk_clk_mux_disable,
+	.is_enabled = mtk_clk_mux_is_enabled,
+	.get_parent = mtk_clk_mux_get_parent,
+	.set_parent = mtk_clk_mux_set_parent_lock,
+};
+
+const struct clk_ops mtk_mux_gate_clr_set_upd_ops = {
+	.enable = mtk_clk_mux_enable_setclr,
+	.disable = mtk_clk_mux_disable_setclr,
+	.is_enabled = mtk_clk_mux_is_enabled,
+	.get_parent = mtk_clk_mux_get_parent,
+	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
+};
+
+struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
+				 struct regmap *regmap,
+				 spinlock_t *lock)
+{
+	struct mtk_clk_mux *clk_mux;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	clk_mux = kzalloc(sizeof(*clk_mux), GFP_KERNEL);
+	if (!clk_mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = mux->name;
+	init.flags = mux->flags | CLK_SET_RATE_PARENT;
+	init.parent_names = mux->parent_names;
+	init.num_parents = mux->num_parents;
+	init.ops = mux->ops;
+
+	clk_mux->regmap = regmap;
+	clk_mux->data = mux;
+	clk_mux->lock = lock;
+	clk_mux->hw.init = &init;
+
+	clk = clk_register(NULL, &clk_mux->hw);
+	if (IS_ERR(clk)) {
+		kfree(clk_mux);
+		return clk;
+	}
+
+	return clk;
+}
+
+int mtk_clk_register_muxes(const struct mtk_mux *muxes,
+			   int num, struct device_node *node,
+			   spinlock_t *lock,
+			   struct clk_onecell_data *clk_data)
+{
+	struct regmap *regmap;
+	struct clk *clk;
+	int i;
+
+	regmap = syscon_node_to_regmap(node);
+	if (IS_ERR(regmap)) {
+		pr_err("Cannot find regmap for %pOF: %ld\n", node,
+		       PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	for (i = 0; i < num; i++) {
+		const struct mtk_mux *mux = &muxes[i];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
+			clk = mtk_clk_register_mux(mux, regmap, lock);
+
+			if (IS_ERR(clk)) {
+				pr_err("Failed to register clk %s: %ld\n",
+				       mux->name, PTR_ERR(clk));
+				continue;
+			}
+
+			clk_data->clks[mux->id] = clk;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
new file mode 100644
index 000000000000..f5625f4d9e6c
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Owen Chen <owen.chen@mediatek.com>
+ */
+
+#ifndef __DRV_CLK_MTK_MUX_H
+#define __DRV_CLK_MTK_MUX_H
+
+#include <linux/clk-provider.h>
+
+struct mtk_clk_mux {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	const struct mtk_mux *data;
+	spinlock_t *lock;
+};
+
+struct mtk_mux {
+	int id;
+	const char *name;
+	const char * const *parent_names;
+	unsigned int flags;
+
+	u32 mux_ofs;
+	u32 set_ofs;
+	u32 clr_ofs;
+	u32 upd_ofs;
+
+	u8 mux_shift;
+	u8 mux_width;
+	u8 gate_shift;
+	s8 upd_shift;
+
+	const struct clk_ops *ops;
+
+	signed char num_parents;
+};
+
+extern const struct clk_ops mtk_mux_ops;
+extern const struct clk_ops mtk_mux_clr_set_upd_ops;
+extern const struct clk_ops mtk_mux_gate_ops;
+extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
+
+#define GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,		\
+			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
+			_gate, _upd_ofs, _upd, _flags, _ops) {		\
+		.id = _id,						\
+		.name = _name,						\
+		.mux_ofs = _mux_ofs,					\
+		.set_ofs = _mux_set_ofs,				\
+		.clr_ofs = _mux_clr_ofs,				\
+		.upd_ofs = _upd_ofs,					\
+		.mux_shift = _shift,					\
+		.mux_width = _width,					\
+		.gate_shift = _gate,					\
+		.upd_shift = _upd,					\
+		.parent_names = _parents,				\
+		.num_parents = ARRAY_SIZE(_parents),			\
+		.flags = _flags,					\
+		.ops = &_ops,						\
+	}
+
+#define MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
+			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
+			_gate, _upd_ofs, _upd, _flags)			\
+		GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
+			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
+			_gate, _upd_ofs, _upd, _flags,			\
+			mtk_mux_gate_clr_set_upd_ops)
+
+#define MUX_GATE_CLR_SET_UPD(_id, _name, _parents, _mux_ofs,		\
+			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
+			_gate, _upd_ofs, _upd)				\
+		MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents,	\
+			_mux_ofs, _mux_set_ofs, _mux_clr_ofs, _shift,	\
+			_width, _gate, _upd_ofs, _upd,			\
+			CLK_SET_RATE_PARENT)
+
+struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
+				 struct regmap *regmap,
+				 spinlock_t *lock);
+
+int mtk_clk_register_muxes(const struct mtk_mux *muxes,
+			   int num, struct device_node *node,
+			   spinlock_t *lock,
+			   struct clk_onecell_data *clk_data);
+
+#endif /* __DRV_CLK_MTK_MUX_H */
-- 
2.18.0

