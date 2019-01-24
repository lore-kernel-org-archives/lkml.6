Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F66C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C1F21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360264;
	bh=FKb+VWK74aFnxQ1W5oJjSdHPDvorXnCcLR+tC9NSRZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v2N2dXgqQG5hYx52yFDsQcKynlKLktKjbLimqkLmZ9fJhVocZI2RD0HCEoCQXJRQ7
	 LSRUk/FNJa+2nOs6xLAz1Mh1ibFAmnET5bgx/xJDPelAjczcjxo2/XDxEckRW4q+iy
	 94+MyD49T7ZoEIMK5lDZavR0RnSpTX0UAqHyO95k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfAXTbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:31:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbfAXTbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:31:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6684021904;
        Thu, 24 Jan 2019 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358295;
        bh=FKb+VWK74aFnxQ1W5oJjSdHPDvorXnCcLR+tC9NSRZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v5PkcS3MwenTlZWZcLStisSXFF5aGpCZ57/pRLMzUlC9Sgdw6tDLPZJrDZ584ZXx+
         oaJlznT0nZckf63nmXDE6M8rmK4A7nJ1toRyuuiiK17DR1cgKLQ6sBMjo7D/FPbzoY
         B4OroXzfatJ7eeqiyf5HthhAV3uQqXc9BW5SSYJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 22/63] clk: imx: make mux parent strings const
Date:   Thu, 24 Jan 2019 20:20:11 +0100
Message-Id: <20190124190157.642347284@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



