Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61484ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BA62146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BA62146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeGQJYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:24:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38628 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729686AbeGQJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:24:32 -0400
X-UUID: f7dd584806f14b9b8bd4b5704eef9b88-20180717
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1781550286; Tue, 17 Jul 2018 16:52:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 17 Jul 2018 16:52:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 17 Jul 2018 16:52:35 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Owen Chen <owen.chen@mediatek.com>
Subject: [PATCH v5 09/11] clk: mediatek: add new clkmux register API
Date:   Tue, 17 Jul 2018 16:52:30 +0800
Message-ID: <1531817552-17221-10-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Owen Chen <owen.chen@mediatek.com>

MT6765 add "set/clr" register for each clkmux setting, and
one update register to trigger value change. It is designed
to prevent read-modify-write racing issue. The sw design
need to add a new API to handle this hw change with a new
mtk_clk_mux/mtk_clk_upd struct in new file "clk-mux"and
clk-upd".

Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile  |    2 +-
 drivers/clk/mediatek/clk-mtk.c |   41 +++++++
 drivers/clk/mediatek/clk-mtk.h |   85 ++++++++++++---
 drivers/clk/mediatek/clk-mux.c |  236 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.h |   38 +++++++
 5 files changed, 388 insertions(+), 14 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mux.c
 create mode 100644 drivers/clk/mediatek/clk-mux.h

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 844b55d..b97980d 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o
+obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
 obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
 obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
 obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9c0ae42..50becd0 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -22,6 +22,7 @@
 #include <linux/mfd/syscon.h>
 
 #include "clk-mtk.h"
+#include "clk-mux.h"
 #include "clk-gate.h"
 
 struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
@@ -144,6 +145,46 @@ int mtk_clk_register_gates(struct device_node *node,
 	return 0;
 }
 
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
+		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+			continue;
+
+		clk = mtk_clk_register_mux(mux, regmap, lock);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n",
+			       mux->name, PTR_ERR(clk));
+			continue;
+		}
+
+		if (clk_data)
+			clk_data->clks[mux->id] = clk;
+	}
+
+	return 0;
+}
+
 struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 1882221..61693f6 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -24,7 +24,9 @@
 
 #define MAX_MUX_GATE_BIT	31
 #define INVALID_MUX_GATE_BIT	(MAX_MUX_GATE_BIT + 1)
-
+#define INVALID_OFS		-1
+#define INVALID_SHFT		-1
+#define INVALID_WIDTH		-1
 #define MHZ (1000 * 1000)
 
 struct mtk_fixed_clk {
@@ -84,10 +86,72 @@ struct mtk_composite {
 	signed char num_parents;
 };
 
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
+	signed char mux_shift;
+	signed char mux_width;
+	signed char gate_shift;
+	signed char upd_shift;
+
+	const struct clk_ops *ops;
+
+	signed char num_parents;
+};
+
 /*
  * In case the rate change propagation to parent clocks is undesirable,
  * this macro allows to specify the clock flags manually.
  */
+#define CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs, _mux_set_ofs,\
+			_mux_clr_ofs, _shift, _width, _gate,		\
+			_upd_ofs, _upd, _flags, _ops) {			\
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
+#define MUX_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs, _mux_set_ofs,\
+			_mux_clr_ofs, _shift, _width, _gate,		\
+			_upd_ofs, _upd, _flags)			\
+		CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
+			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
+			_gate, _upd_ofs, _upd, _flags,			\
+			mtk_mux_clr_set_upd_ops)
+
+#define MUX_CLR_SET_UPD(_id, _name, _parents, _mux_ofs, _mux_set_ofs,	\
+			_mux_clr_ofs, _shift, _width, _gate,		\
+			_upd_ofs, _upd)				\
+		MUX_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
+			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
+			_gate, _upd_ofs, _upd, CLK_SET_RATE_PARENT)
+
+#define MUX_UPD(_id, _name, _parents, _mux_ofs, _shift, _width, _gate,	\
+			_upd_ofs, _upd)				\
+		CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
+			INVALID_OFS, INVALID_OFS, _shift, _width,	\
+			_gate, _upd_ofs, _upd, CLK_SET_RATE_PARENT,	\
+			mtk_mux_upd_ops)
+
 #define MUX_GATE_FLAGS(_id, _name, _parents, _reg, _shift, _width,	\
 			_gate, _flags) {				\
 		.id = _id,						\
@@ -111,18 +175,8 @@ struct mtk_composite {
 	MUX_GATE_FLAGS(_id, _name, _parents, _reg, _shift, _width,	\
 		_gate, CLK_SET_RATE_PARENT)
 
-#define MUX(_id, _name, _parents, _reg, _shift, _width) {		\
-		.id = _id,						\
-		.name = _name,						\
-		.mux_reg = _reg,					\
-		.mux_shift = _shift,					\
-		.mux_width = _width,					\
-		.gate_shift = -1,					\
-		.divider_shift = -1,					\
-		.parent_names = _parents,				\
-		.num_parents = ARRAY_SIZE(_parents),			\
-		.flags = CLK_SET_RATE_PARENT,				\
-	}
+#define MUX(_id, _name, _parents, _reg, _shift, _width)		\
+	MUX_GATE(_id, _name, _parents, _reg, _shift, _width, INVALID_SHFT)
 
 #define DIV_GATE(_id, _name, _parent, _gate_reg, _gate_shift, _div_reg,	\
 					_div_width, _div_shift) {	\
@@ -138,6 +192,11 @@ struct mtk_composite {
 		.flags = 0,						\
 	}
 
+int mtk_clk_register_muxes(const struct mtk_mux *muxes,
+			   int num, struct device_node *node,
+			   spinlock_t *lock,
+			   struct clk_onecell_data *clk_data);
+
 struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock);
 
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
new file mode 100644
index 0000000..219181b
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Owen Chen <owen.chen@mediatek.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
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
+static int mtk_mux_enable(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = BIT(mux->gate_shift);
+	unsigned long flags = 0;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+
+	regmap_update_bits(mux->regmap, mux->mux_ofs, mask, 0);
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+	return 0;
+}
+
+static void mtk_mux_disable(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = BIT(mux->gate_shift);
+	unsigned long flags = 0;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+
+	regmap_update_bits(mux->regmap, mux->mux_ofs, mask, mask);
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+}
+
+static int mtk_mux_enable_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val;
+	unsigned long flags = 0;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+
+	val = BIT(mux->gate_shift);
+	regmap_write(mux->regmap, mux->mux_clr_ofs, val);
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+	return 0;
+}
+
+static void mtk_mux_disable_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val;
+	unsigned long flags = 0;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+
+	val = BIT(mux->gate_shift);
+	regmap_write(mux->regmap, mux->mux_set_ofs, val);
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+}
+
+static int mtk_mux_is_enabled(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val = 0;
+
+	if (mux->gate_shift < 0)
+		return true;
+
+	regmap_read(mux->regmap, mux->mux_ofs, &val);
+
+	return (val & BIT(mux->gate_shift)) == 0;
+}
+
+static u8 mtk_mux_get_parent(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	int num_parents = clk_hw_get_num_parents(hw);
+	u32 mask = GENMASK(mux->mux_width - 1, 0);
+	u32 val;
+
+	regmap_read(mux->regmap, mux->mux_ofs, &val);
+	val = (val >> mux->mux_shift) & mask;
+
+	if (val >= num_parents)
+		return -EINVAL;
+
+	return val;
+}
+
+static int mtk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = GENMASK(mux->mux_width - 1, 0);
+	u32 val, orig;
+	unsigned long flags = 0;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+
+	regmap_read(mux->regmap, mux->mux_ofs, &val);
+	orig = val;
+	val &= ~(mask << mux->mux_shift);
+	val |= index << mux->mux_shift;
+
+	if (val != orig) {
+		regmap_write(mux->regmap, mux->mux_ofs, val);
+
+		if (mux->upd_shift >= 0)
+			regmap_write(mux->regmap, mux->upd_ofs,
+				     BIT(mux->upd_shift));
+	}
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+
+	return 0;
+}
+
+static int mtk_mux_set_parent_setclr(struct clk_hw *hw, u8 index)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 mask = GENMASK(mux->mux_width - 1, 0);
+	u32 val, orig;
+	unsigned long flags = 0;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
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
+
+	return 0;
+}
+
+const struct clk_ops mtk_mux_upd_ops = {
+	.enable = mtk_mux_enable,
+	.disable = mtk_mux_disable,
+	.is_enabled = mtk_mux_is_enabled,
+	.get_parent = mtk_mux_get_parent,
+	.set_parent = mtk_mux_set_parent,
+	.determine_rate = NULL,
+};
+
+const struct clk_ops mtk_mux_clr_set_upd_ops = {
+	.enable = mtk_mux_enable_setclr,
+	.disable = mtk_mux_disable_setclr,
+	.is_enabled = mtk_mux_is_enabled,
+	.get_parent = mtk_mux_get_parent,
+	.set_parent = mtk_mux_set_parent_setclr,
+	.determine_rate = NULL,
+};
+
+struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
+				 struct regmap *regmap,
+				 spinlock_t *lock)
+{
+	struct clk *clk;
+	struct clk_init_data init;
+	struct mtk_clk_mux *mtk_mux = NULL;
+	int ret;
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
+		ret = PTR_ERR(clk);
+		goto err_out;
+	}
+
+	return clk;
+err_out:
+	kfree(mtk_mux);
+
+	return ERR_PTR(ret);
+}
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
new file mode 100644
index 0000000..64f8e7c
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -0,0 +1,38 @@
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
+	int mux_set_ofs;
+	int mux_clr_ofs;
+	int mux_ofs;
+	int upd_ofs;
+
+	s8 mux_shift;
+	s8 mux_width;
+	s8 gate_shift;
+	s8 upd_shift;
+
+	spinlock_t *lock;
+};
+
+extern const struct clk_ops mtk_mux_upd_ops;
+extern const struct clk_ops mtk_mux_clr_set_upd_ops;
+
+struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
+				 struct regmap *regmap,
+				 spinlock_t *lock);
+
+#endif /* __DRV_CLK_MUX_H */
-- 
1.7.9.5

