Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16038C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D21218E0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfAERtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:49:00 -0500
Received: from kozue.soulik.info ([108.61.200.231]:40158 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfAERtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:49:00 -0500
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:a00])
        by kozue.soulik.info (Postfix) with ESMTPA id 91048101714;
        Sun,  6 Jan 2019 02:49:36 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     linux-rockchip@lists.infradead.org
Cc:     Randy Li <ayaka@soulik.info>, mturquette@baylibre.com,
        sboyd@kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, zhangqing@rock-chips.com,
        geert+renesas@glider.be
Subject: [PATCH 1/3] clk: rockchip: add video clk parents for rk3399
Date:   Sun,  6 Jan 2019 01:48:35 +0800
Message-Id: <20190105174837.19378-2-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105174837.19378-1-ayaka@soulik.info>
References: <20190105174837.19378-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video codec won't work properly with a clock too low nor
too high. We need to export them, allowing the device
tree to assign a suitable clocks for them.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/clk/rockchip/clk-rk3399.c      | 5 +++--
 include/dt-bindings/clock/rk3399-cru.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 5a628148f3f0..fe6cebcb26b6 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -740,7 +740,8 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(15), 6, GFLAGS),
 
 	/* vcodec */
-	COMPOSITE(0, "aclk_vcodec_pre", mux_pll_src_cpll_gpll_npll_ppll_p, 0,
+	COMPOSITE(ACLK_VCODEC_PRE, "aclk_vcodec_pre",
+			mux_pll_src_cpll_gpll_npll_ppll_p, 0,
 			RK3399_CLKSEL_CON(7), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(4), 0, GFLAGS),
 	COMPOSITE_NOMUX(0, "hclk_vcodec_pre", "aclk_vcodec_pre", 0,
@@ -764,7 +765,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(9), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK3399_CLKGATE_CON(4), 5, GFLAGS),
 
-	COMPOSITE(0, "aclk_vdu_pre", mux_pll_src_cpll_gpll_npll_ppll_p, 0,
+	COMPOSITE(ACLK_VDU_PRE, "aclk_vdu_pre", mux_pll_src_cpll_gpll_npll_ppll_p, 0,
 			RK3399_CLKSEL_CON(8), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(4), 2, GFLAGS),
 	COMPOSITE_NOMUX(0, "hclk_vdu_pre", "aclk_vdu_pre", 0,
diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
index 22cb1dfa9004..dd13554aaf76 100644
--- a/include/dt-bindings/clock/rk3399-cru.h
+++ b/include/dt-bindings/clock/rk3399-cru.h
@@ -219,6 +219,8 @@
 #define ACLK_GIC_PRE			262
 #define ACLK_VOP0_PRE			263
 #define ACLK_VOP1_PRE			264
+#define ACLK_VCODEC_PRE			265
+#define ACLK_VDU_PRE			266
 
 /* pclk gates */
 #define PCLK_PERIHP			320
-- 
2.20.1

