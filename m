Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4152C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA58208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="erReW1O1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA58208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbeKQEWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKQEWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:22:48 -0500
Received: from ziggy.de (unknown [93.176.147.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56922086C;
        Fri, 16 Nov 2018 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542391763;
        bh=LhHNEdjEs4rrpLVEQp3kQ55FDm4QGJbhZjnMbBd5oZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erReW1O1CohS1GaP++mSZY+hxB6NNE70evw9KwFO/1oc0hVq310nhUj3aolx5paxe
         Xt6bVtWXEMm1p6z4trtQmk9I9qwdMbFDgCwr7/vKe0eCi5HuB/VsSpz3oPzMjznKoV
         vPRmun9J8nZGHwz/nDk6a5PIFaggD/KuB/xCwa6U=
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com
Cc:     jasu@njomotys.info, sean.wang@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/3] clk: mediatek: Add flags to mtk_gate
Date:   Fri, 16 Nov 2018 19:09:00 +0100
Message-Id: <20181116180901.17737-3-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116180901.17737-1-matthias.bgg@kernel.org>
References: <20181116180901.17737-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jasper Mattsson <jasu@njomotys.info>

This is required to mark gates as CLK_IS_CRITICAL.

Fixes: 96596aa06628 ("clk: mediatek: add clk support for MT6797")
Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
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
2.19.1

