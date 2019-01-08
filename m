Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA35C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5702070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975976;
	bh=+apJMKxbZ20lG+Sqi2LU4XLodGyrcE5VCHqUJWbZ0wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NnUdmTiG9SzIHLqtdgP6XMPBedpVm+bdFBIadkC5/3dsLcJcehgrYVVjxwhsdPHTC
	 /mwtbZgtaVNc6UsEn1wUQjIaLGHCt979MRvjJHWE1bunU0vMO/Aw3cqnPNt5FrCP9Q
	 Pliz+sQHroVqYa27XUzme1+GMrsqGpoPfLYQgrAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfAHTc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbfAHTcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDCC320883;
        Tue,  8 Jan 2019 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975971;
        bh=+apJMKxbZ20lG+Sqi2LU4XLodGyrcE5VCHqUJWbZ0wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2dyUsoUHQ2/Ssv70DdEiCpDhguLrPHnsEKXeU25QxrfD9qj4nPfivpNX2WVZtbSH
         sRIUDqFx7Jp/qSrTPsfUuvxEKV3DylecvIxcfrIpFoPne+3+6tzEjsp+TOA8dukLM6
         JjaCGfkRKcPABJGbVuCWSVetLOZVH4blHA68VGb0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "A.s. Dong" <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 16/53] clk: imx: make mux parent strings const
Date:   Tue,  8 Jan 2019 14:31:44 -0500
Message-Id: <20190108193222.123316-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "A.s. Dong" <aisheng.dong@nxp.com>

[ Upstream commit 9e5ef7a57ca75a1b9411c46caeeb6881124284a3 ]

As the commit 2893c379461a ("clk: make strings in parent name arrays
const"), let's make the parent strings const, otherwise we may meet
the following warning when compiling:

drivers/clk/imx/clk-imx7ulp.c: In function 'imx7ulp_clocks_init':
drivers/clk/imx/clk-imx7ulp.c:73:35: warning: passing argument 5 of
	'imx_clk_mux_flags' discards 'const' qualifier from pointer target type

  clks[IMX7ULP_CLK_APLL_PRE_SEL] = imx_clk_mux_flags("apll_pre_sel", base + 0x508, 0,
	1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
                                   ^
In file included from drivers/clk/imx/clk-imx7ulp.c:23:0:
drivers/clk/imx/clk.h:200:27: note: expected 'const char **' but argument is
 of type 'const char * const*'
...

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-busy.c      |  2 +-
 drivers/clk/imx/clk-fixup-mux.c |  2 +-
 drivers/clk/imx/clk.h           | 18 +++++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
index 5cc99590f9a3..097625c5715c 100644
--- a/drivers/clk/imx/clk-busy.c
+++ b/drivers/clk/imx/clk-busy.c
@@ -154,7 +154,7 @@ static struct clk_ops clk_busy_mux_ops = {
 
 struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
-			     const char **parent_names, int num_parents)
+			     const char * const *parent_names, int num_parents)
 {
 	struct clk_busy_mux *busy;
 	struct clk *clk;
diff --git a/drivers/clk/imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mux.c
index c9b327e0a8dd..44817c1b0b88 100644
--- a/drivers/clk/imx/clk-fixup-mux.c
+++ b/drivers/clk/imx/clk-fixup-mux.c
@@ -70,7 +70,7 @@ static const struct clk_ops clk_fixup_mux_ops = {
 };
 
 struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
-			      u8 shift, u8 width, const char **parents,
+			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val))
 {
 	struct clk_fixup_mux *fixup_mux;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d69c4bbf3597..b03fbd502528 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -63,14 +63,14 @@ struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
 
 struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
-			     const char **parent_names, int num_parents);
+			     const char * const *parent_names, int num_parents);
 
 struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val));
 
 struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
-			      u8 shift, u8 width, const char **parents,
+			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val));
 
 static inline struct clk *imx_clk_fixed(const char *name, int rate)
@@ -79,7 +79,8 @@ static inline struct clk *imx_clk_fixed(const char *name, int rate)
 }
 
 static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT, reg,
@@ -178,7 +179,8 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 }
 
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT, reg, shift,
@@ -186,7 +188,8 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 }
 
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
@@ -194,8 +197,9 @@ static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 }
 
 static inline struct clk *imx_clk_mux_flags(const char *name,
-		void __iomem *reg, u8 shift, u8 width, const char **parents,
-		int num_parents, unsigned long flags)
+			void __iomem *reg, u8 shift, u8 width,
+			const char * const *parents, int num_parents,
+			unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
-- 
2.19.1

