Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A7EC67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D552082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D552082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeLJHdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:33:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12184 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726701AbeLJHdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:33:15 -0500
X-UUID: a29a3a166c004044a6c5de1ca27bdb8e-20181210
X-UUID: a29a3a166c004044a6c5de1ca27bdb8e-20181210
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 330002837; Mon, 10 Dec 2018 15:32:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 15:32:51 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 15:32:51 +0800
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
Subject: [PATCH v3 02/12] clk: mediatek: add new clkmux register API
Date:   Mon, 10 Dec 2018 15:32:30 +0800
Message-ID: <20181210073240.32278-4-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210073240.32278-1-weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CC1466E429EE890041C24559D18C71DA2DBBF852FCF11A268E2E222F2B785C8D2000:8
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
 drivers/clk/mediatek/clk-mux.c | 229 +++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.h | 101 +++++++++++++++
 3 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mux.c
 create mode 100644 drivers/clk/mediatek/clk-mux.h

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 844b55d2770d..00e4d405231e 100644
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
index 000000000000..efbbb35eb185
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -0,0 +1,229 @@
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
+	u32 mask = BIT(mux->gate_shift);
+
+	return regmap_update_bits(mux->regmap, mux->mux_ofs, mask, ~mask);
+}
+
+static void mtk_clk_mux_disable(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = BIT(mux->gate_shift);
+
+	regmap_update_bits(mux->regmap, mux->mux_ofs, mask, mask);
+}
+
+static int mtk_clk_mux_enable_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+
+	return regmap_write(mux->regmap, mux->mux_clr_ofs,
+			BIT(mux->gate_shift));
+}
+
+static void mtk_clk_mux_disable_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+
+	regmap_write(mux->regmap, mux->mux_set_ofs, BIT(mux->gate_shift));
+}
+
+static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val;
+
+	regmap_read(mux->regmap, mux->mux_ofs, &val);
+
+	return (val & BIT(mux->gate_shift)) == 0;
+}
+
+static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = GENMASK(mux->mux_width - 1, 0);
+	u32 val;
+
+	regmap_read(mux->regmap, mux->mux_ofs, &val);
+	val = (val >> mux->mux_shift) & mask;
+
+	return val;
+}
+
+static int mtk_clk_mux_set_parent_lock(struct clk_hw *hw, u8 index)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = GENMASK(mux->mux_width - 1, 0);
+	unsigned long flags;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+	else
+		__acquire(mux->lock);
+
+	regmap_update_bits(mux->regmap, mux->mux_ofs, mask,
+		index << mux->mux_shift);
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
+	u32 mask = GENMASK(mux->mux_width - 1, 0);
+	u32 val, orig;
+	unsigned long flags;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+	else
+		__acquire(mux->lock);
+
+	regmap_read(mux->regmap, mux->mux_ofs, &orig);
+	val = (orig & ~(mask << mux->mux_shift)) | (index << mux->mux_shift);
+
+	if (val != orig) {
+		regmap_write(mux->regmap, mux->mux_clr_ofs,
+				mask << mux->mux_shift);
+		regmap_write(mux->regmap, mux->mux_set_ofs,
+				index << mux->mux_shift);
+
+		if (mux->upd_shift >= 0)
+			regmap_write(mux->regmap, mux->upd_ofs,
+					BIT(mux->upd_shift));
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
+	struct mtk_clk_mux *mtk_mux;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	mtk_mux = kzalloc(sizeof(*mtk_mux), GFP_KERNEL);
+	if (!mtk_mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = mux->name;
+	init.flags = mux->flags | CLK_SET_RATE_PARENT;
+	init.parent_names = mux->parent_names;
+	init.num_parents = mux->num_parents;
+	init.ops = mux->ops;
+
+	mtk_mux->regmap = regmap;
+	mtk_mux->name = mux->name;
+	mtk_mux->mux_ofs = mux->mux_ofs;
+	mtk_mux->mux_set_ofs = mux->set_ofs;
+	mtk_mux->mux_clr_ofs = mux->clr_ofs;
+	mtk_mux->upd_ofs = mux->upd_ofs;
+	mtk_mux->mux_shift = mux->mux_shift;
+	mtk_mux->mux_width = mux->mux_width;
+	mtk_mux->gate_shift = mux->gate_shift;
+	mtk_mux->upd_shift = mux->upd_shift;
+
+	mtk_mux->lock = lock;
+	mtk_mux->hw.init = &init;
+
+	clk = clk_register(NULL, &mtk_mux->hw);
+	if (IS_ERR(clk)) {
+		kfree(mtk_mux);
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
index 000000000000..830a6117e670
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -0,0 +1,101 @@
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
+
+	const char *name;
+
+	u32 mux_set_ofs;
+	u32 mux_clr_ofs;
+	u32 mux_ofs;
+	u32 upd_ofs;
+
+	u8 mux_shift;
+	u8 mux_width;
+	u8 gate_shift;
+	s8 upd_shift;
+
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

