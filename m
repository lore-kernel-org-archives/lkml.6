Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8048C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFE320862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFE320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbeKFQGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:06:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33986 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387660AbeKFQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:06:14 -0500
X-UUID: 9f287ee12c6d470f9d67201fad341e99-20181106
X-UUID: 9f287ee12c6d470f9d67201fad341e99-20181106
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 859432018; Tue, 06 Nov 2018 14:42:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 6 Nov 2018 14:42:22 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 6 Nov 2018 14:42:22 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
Subject: [PATCH v1 01/11] clk: mediatek: add new clkmux register API
Date:   Tue, 6 Nov 2018 14:41:56 +0800
Message-ID: <20181106064206.17535-3-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181106064206.17535-1-weiyi.lu@mediatek.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6E3067512B49A1D506FB1A96D34EB9F2BFFAE7F5F276E550228B7B59A8AC37442000:8
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
 drivers/clk/mediatek/Makefile  |   2 +-
 drivers/clk/mediatek/clk-mux.c | 252 +++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.h | 101 +++++++++++++
 3 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mux.c
 create mode 100644 drivers/clk/mediatek/clk-mux.h

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 844b55d2770d..b97980dbb738 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o
+obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
 obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
 obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
 obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
new file mode 100644
index 000000000000..18bc9a146be0
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -0,0 +1,252 @@
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
+static inline struct mtk_clk_mux
+	*to_mtk_clk_mux(struct clk_hw *hw)
+{
+	return container_of(hw, struct mtk_clk_mux, hw);
+}
+
+static int mtk_clk_mux_enable(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = BIT(mux->gate_shift);
+
+	regmap_update_bits(mux->regmap, mux->mux_ofs, mask, 0);
+
+	return 0;
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
+	u32 val;
+
+	val = BIT(mux->gate_shift);
+	regmap_write(mux->regmap, mux->mux_clr_ofs, val);
+
+	return 0;
+}
+
+static void mtk_clk_mux_disable_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val;
+
+	val = BIT(mux->gate_shift);
+	regmap_write(mux->regmap, mux->mux_set_ofs, val);
+}
+
+static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val = 0;
+
+	regmap_read(mux->regmap, mux->mux_ofs, &val);
+
+	return ((val & BIT(mux->gate_shift)) == 0) ? 1 : 0;
+}
+
+static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	int num_parents = clk_hw_get_num_parents(hw);
+	u32 mask = GENMASK(mux->mux_width - 1, 0);
+	u32 val;
+
+	regmap_read(mux->regmap, mux->mux_ofs, &val);
+	val = (val >> mux->mux_shift) & mask;
+
+	if (val >= num_parents || val >= U8_MAX)
+		return -ERANGE;
+
+	return val;
+}
+
+static int mtk_clk_mux_set_parent_lock(struct clk_hw *hw, u8 index)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = GENMASK(mux->mux_width - 1, 0);
+	u32 val;
+	unsigned long flags = 0;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+	else
+		__acquire(mux->lock);
+
+	regmap_read(mux->regmap, mux->mux_ofs, &val);
+	val = (val & mask) >> mux->mux_shift;
+
+	if (val != index) {
+		val = index << mux->mux_shift;
+		regmap_update_bits(mux->regmap, mux->mux_ofs, mask, val);
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
+static int mtk_clk_mux_set_parent_setclr_lock(struct clk_hw *hw, u8 index)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = GENMASK(mux->mux_width - 1, 0);
+	u32 val, orig;
+	unsigned long flags = 0;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+	else
+		__acquire(mux->lock);
+
+	regmap_read(mux->regmap, mux->mux_ofs, &val);
+	orig = val;
+	val &= ~(mask << mux->mux_shift);
+	val |= index << mux->mux_shift;
+
+	if (val != orig) {
+		val = (mask << mux->mux_shift);
+		regmap_write(mux->regmap, mux->mux_clr_ofs, val);
+		val = (index << mux->mux_shift);
+		regmap_write(mux->regmap, mux->mux_set_ofs, val);
+
+		if (mux->upd_shift >= 0)
+			regmap_write(mux->regmap, mux->upd_ofs,
+				     BIT(mux->upd_shift));
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
+	struct mtk_clk_mux *mtk_mux = NULL;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	mtk_mux = kzalloc(sizeof(*mtk_mux), GFP_KERNEL);
+	if (!mtk_mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = mux->name;
+	init.flags = (mux->flags) | CLK_SET_RATE_PARENT;
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
+	if (!clk_data)
+		return -ENOMEM;
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
index 000000000000..ff0276bb771c
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Owen Chen <owen.chen@mediatek.com>
+ */
+
+#ifndef __DRV_CLK_MUX_H
+#define __DRV_CLK_MUX_H
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
+	u8 upd_shift;
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
+	u8 upd_shift;
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
+#endif /* __DRV_CLK_MUX_H */
-- 
2.18.0

