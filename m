Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED26C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BE42082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPrrXgTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BE42082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLDTeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:34:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeLDTeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:34:19 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83BCD206B7;
        Tue,  4 Dec 2018 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543952057;
        bh=GI77F+Yj+CEQQ3UgN11HA7GBZePy0yGn6BNz68Zo7O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPrrXgTWS648gwpq7Vew3dqhn0RZdXAsqMhbV5cTgxv983/5IjYLth71NpdQar0W/
         KzoGCQgcoMPcOa+DCjjPAGYc/9/WlYX6mMN93TBPaYfDIRhL1Qp6OYsOly+QKGVrB1
         YkvJElnKfpAEzPV36PK4g87hM3ablB7xMVvsZFco=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dinh Nguyen <dinguyen@opensource.altera.com>
Subject: [PATCH] clk: socfpga: Don't have get_parent for single parent ops
Date:   Tue,  4 Dec 2018 11:34:16 -0800
Message-Id: <20181204193416.24661-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204163257.32085-1-jbrunet@baylibre.com>
References: <20181204163257.32085-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver creates a gate clk with the possibility to have multiple
parents. That can cause problems if the common clk framework tries to
call the get_parent() op and gets back a number that's larger than the
number of parents the clk says it supports in
clk_init_data::num_parents. Let's duplicate the clk_ops structure each
time this function is called and drop the get/set parent ops when there
is only one parent. This allows the framework to consider a number
larger than clk_init_data::num_parents as an error condition of the
get_parent() clk op, clearing the way for proper code.

Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/socfpga/clk-gate.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index aa7a6e6a15b6..73e03328d5c5 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -176,8 +176,7 @@ static struct clk_ops gateclk_ops = {
 	.set_parent = socfpga_clk_set_parent,
 };
 
-static void __init __socfpga_gate_init(struct device_node *node,
-	const struct clk_ops *ops)
+void __init socfpga_gate_init(struct device_node *node)
 {
 	u32 clk_gate[2];
 	u32 div_reg[3];
@@ -188,12 +187,17 @@ static void __init __socfpga_gate_init(struct device_node *node,
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
 	struct clk_init_data init;
+	struct clk_ops *ops;
 	int rc;
 
 	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
 	if (WARN_ON(!socfpga_clk))
 		return;
 
+	ops = kmemdup(&gateclk_ops, sizeof(gateclk_ops), GFP_KERNEL);
+	if (WARN_ON(!ops))
+		return;
+
 	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
 	if (rc)
 		clk_gate[0] = 0;
@@ -202,8 +206,8 @@ static void __init __socfpga_gate_init(struct device_node *node,
 		socfpga_clk->hw.reg = clk_mgr_base_addr + clk_gate[0];
 		socfpga_clk->hw.bit_idx = clk_gate[1];
 
-		gateclk_ops.enable = clk_gate_ops.enable;
-		gateclk_ops.disable = clk_gate_ops.disable;
+		ops->enable = clk_gate_ops.enable;
+		ops->disable = clk_gate_ops.disable;
 	}
 
 	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
@@ -234,6 +238,11 @@ static void __init __socfpga_gate_init(struct device_node *node,
 	init.flags = 0;
 
 	init.num_parents = of_clk_parent_fill(node, parent_name, SOCFPGA_MAX_PARENTS);
+	if (init.num_parents < 2) {
+		ops->get_parent = NULL;
+		ops->set_parent = NULL;
+	}
+
 	init.parent_names = parent_name;
 	socfpga_clk->hw.hw.init = &init;
 
@@ -246,8 +255,3 @@ static void __init __socfpga_gate_init(struct device_node *node,
 	if (WARN_ON(rc))
 		return;
 }
-
-void __init socfpga_gate_init(struct device_node *node)
-{
-	__socfpga_gate_init(node, &gateclk_ops);
-}
-- 
Sent by a computer through tubes

