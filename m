Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E72C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375D021019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546949545;
	bh=es46TivW9Kpxp/jDOK1Lil3w0c11Tvpf4AabeEtZPO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gy/C1Ot74ozBnHNjFNajsQn96pBeJD97ubyP5fSR6cQ3bhfqJE665wbeDunS9REh4
	 0us4ikDgaxZshRO1ZQEfCUx5WF1GY+J84tgtJwCSE28ToBmNxWHV35IuoF3Pz99qJ7
	 8dv7FcfxQEQNNkoFKR4LmuG28fngT9mB5AsFHcwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfAHMMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbfAHMMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:12:21 -0500
Received: from localhost.localdomain (unknown [37.223.143.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0DF32087E;
        Tue,  8 Jan 2019 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546949540;
        bh=es46TivW9Kpxp/jDOK1Lil3w0c11Tvpf4AabeEtZPO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFZjEtDs1AZHXXn7vAbebvOgp5xSSloJB1xI8pzf/dzV4CeNstN8HZulOetH/GTNS
         tUbKqABuYjWE+sThWZA30NwUdhaPzPDxEw35WZdzjqFVVR2W2r/ezWxTdK/sw0gvS6
         Y0yw5lmsg2Lg2ihtWbCHe8EGnBhxZuwhYs+lClZc=
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/3] clk: mediatek: Add flags to mtk_gate
Date:   Tue,  8 Jan 2019 13:12:07 +0100
Message-Id: <20190108121208.2473-3-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190108121208.2473-1-matthias.bgg@kernel.org>
References: <20190108121208.2473-1-matthias.bgg@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jasper Mattsson <jasu@njomotys.info>

This is required to mark gates as CLK_IS_CRITICAL.

Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
Acked-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clk/mediatek/clk-gate.c | 4 +++-
 drivers/clk/mediatek/clk-gate.h | 3 ++-
 drivers/clk/mediatek/clk-mtk.c  | 2 +-
 drivers/clk/mediatek/clk-mtk.h  | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 934bf0e45e26..9628d4e7690b 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -157,7 +157,8 @@ struct clk *mtk_clk_register_gate(
 		int clr_ofs,
 		int sta_ofs,
 		u8 bit,
-		const struct clk_ops *ops)
+		const struct clk_ops *ops,
+		unsigned long flags)
 {
 	struct mtk_clk_gate *cg;
 	struct clk *clk;
@@ -172,6 +173,7 @@ struct clk *mtk_clk_register_gate(
 	init.parent_names = parent_name ? &parent_name : NULL;
 	init.num_parents = parent_name ? 1 : 0;
 	init.ops = ops;
+	init.flags = flags;
 
 	cg->regmap = regmap;
 	cg->set_ofs = set_ofs;
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 72ef89b3ad7b..9f766dfe1d57 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -47,6 +47,7 @@ struct clk *mtk_clk_register_gate(
 		int clr_ofs,
 		int sta_ofs,
 		u8 bit,
-		const struct clk_ops *ops);
+		const struct clk_ops *ops,
+		unsigned long flags);
 
 #endif /* __DRV_CLK_GATE_H */
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9c0ae4278a94..ef410413bb0b 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -130,7 +130,7 @@ int mtk_clk_register_gates(struct device_node *node,
 				gate->regs->set_ofs,
 				gate->regs->clr_ofs,
 				gate->regs->sta_ofs,
-				gate->shift, gate->ops);
+				gate->shift, gate->ops, gate->flags);
 
 		if (IS_ERR(clk)) {
 			pr_err("Failed to register clk %s: %ld\n",
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index daab6ee94788..987ff2855249 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -162,6 +162,7 @@ struct mtk_gate {
 	const struct mtk_gate_regs *regs;
 	int shift;
 	const struct clk_ops *ops;
+	unsigned long flags;
 };
 
 int mtk_clk_register_gates(struct device_node *node,
-- 
2.20.1

