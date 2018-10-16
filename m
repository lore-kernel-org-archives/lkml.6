Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC778C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3D220881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3D220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeJPVcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:32:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41432 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeJPVcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:32:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 33F91260A2F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Michael Turquette <mturquette@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: rockchip: Fix static checker warning in rockchip_ddrclk_get_parent call
Date:   Tue, 16 Oct 2018 15:41:44 +0200
Message-Id: <20181016134144.12461-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the signedness bug returning '(-22)' on the return type by removing the
sanity checker in rockchip_ddrclk_get_parent(). The function should return
and unsigned value only and it's safe to remove the sanity checker as the
core functions that call get_parent like clk_core_get_parent_by_index already
ensures the validity of the clk index returned (index >= core->num_parents).

Fixes: a4f182bf81f18 ("clk: rockchip: add new clock-type for the ddrclk")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/clk/rockchip/clk-ddr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
index de00590af167..fd5c90371dbf 100644
--- a/drivers/clk/rockchip/clk-ddr.c
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -185,16 +185,12 @@ rockchip_ddrclk_sip_recalc_rate(struct clk_hw *hw,
 static u8 rockchip_ddrclk_get_parent(struct clk_hw *hw)
 {
 	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
-	int num_parents = clk_hw_get_num_parents(hw);
 	u32 val;
 
 	val = clk_readl(ddrclk->reg_base +
 			ddrclk->mux_offset) >> ddrclk->mux_shift;
 	val &= GENMASK(ddrclk->mux_width - 1, 0);
 
-	if (val >= num_parents)
-		return -EINVAL;
-
 	return val;
 }
 
-- 
2.19.1

