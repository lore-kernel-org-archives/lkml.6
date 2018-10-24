Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A999C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F4A20832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F4A20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeJXLSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:18:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42450 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbeJXLSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:18:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DF3C1A00FA;
        Wed, 24 Oct 2018 04:15:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E7591A0040;
        Wed, 24 Oct 2018 04:15:31 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 01B92402EE;
        Wed, 24 Oct 2018 10:15:23 +0800 (SGT)
From:   andy.tang@nxp.com
To:     sboyd@kernel.org, mturquette@baylibre.com, oss@buserror.net
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 3/3 v2] clk: qoriq: update clock driver
Date:   Wed, 24 Oct 2018 10:11:22 +0800
Message-Id: <20181024021122.3942-3-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181024021122.3942-2-andy.tang@nxp.com>
References: <20181024021122.3942-1-andy.tang@nxp.com>
 <20181024021122.3942-2-andy.tang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

Legacy bindings are deleted. So the legacy support in driver
can be deleted safely.
Add more chip-specific compatible as well to support more Socs.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
v2:
  - remove all legacy code

 drivers/clk/clk-qoriq.c |  159 +++-------------------------------------------
 1 files changed, 11 insertions(+), 148 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f..405a9ab 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -914,43 +914,6 @@ static void __init create_muxes(struct clockgen *cg)
 	}
 }
 
-static void __init clockgen_init(struct device_node *np);
-
-/*
- * Legacy nodes may get probed before the parent clockgen node.
- * It is assumed that device trees with legacy nodes will not
- * contain a "clocks" property -- otherwise the input clocks may
- * not be initialized at this point.
- */
-static void __init legacy_init_clockgen(struct device_node *np)
-{
-	if (!clockgen.node)
-		clockgen_init(of_get_parent(np));
-}
-
-/* Legacy node */
-static void __init core_mux_init(struct device_node *np)
-{
-	struct clk *clk;
-	struct resource res;
-	int idx, rc;
-
-	legacy_init_clockgen(np);
-
-	if (of_address_to_resource(np, 0, &res))
-		return;
-
-	idx = (res.start & 0xf0) >> 5;
-	clk = clockgen.cmux[idx];
-
-	rc = of_clk_add_provider(np, of_clk_src_simple_get, clk);
-	if (rc) {
-		pr_err("%s: Couldn't register clk provider for node %s: %d\n",
-		       __func__, np->name, rc);
-		return;
-	}
-}
-
 static struct clk __init
 *sysclk_from_fixed(struct device_node *node, const char *name)
 {
@@ -1036,30 +999,9 @@ static void __init core_mux_init(struct device_node *np)
 	if (!IS_ERR(clk))
 		return clk;
 
-	/*
-	 * This indicates a mix of legacy nodes with the new coreclk
-	 * mechanism, which should never happen.  If this error occurs,
-	 * don't use the wrong input clock just because coreclk isn't
-	 * ready yet.
-	 */
-	if (WARN_ON(PTR_ERR(clk) == -EPROBE_DEFER))
-		return clk;
-
 	return NULL;
 }
 
-/* Legacy node */
-static void __init sysclk_init(struct device_node *node)
-{
-	struct clk *clk;
-
-	legacy_init_clockgen(node);
-
-	clk = clockgen.sysclk;
-	if (clk)
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-}
-
 #define PLL_KILL BIT(31)
 
 static void __init create_one_pll(struct clockgen *cg, int idx)
@@ -1162,82 +1104,6 @@ static void __init create_plls(struct clockgen *cg)
 		create_one_pll(cg, i);
 }
 
-static void __init legacy_pll_init(struct device_node *np, int idx)
-{
-	struct clockgen_pll *pll;
-	struct clk_onecell_data *onecell_data;
-	struct clk **subclks;
-	int count, rc;
-
-	legacy_init_clockgen(np);
-
-	pll = &clockgen.pll[idx];
-	count = of_property_count_strings(np, "clock-output-names");
-
-	BUILD_BUG_ON(ARRAY_SIZE(pll->div) < 4);
-	subclks = kcalloc(4, sizeof(struct clk *), GFP_KERNEL);
-	if (!subclks)
-		return;
-
-	onecell_data = kmalloc(sizeof(*onecell_data), GFP_KERNEL);
-	if (!onecell_data)
-		goto err_clks;
-
-	if (count <= 3) {
-		subclks[0] = pll->div[0].clk;
-		subclks[1] = pll->div[1].clk;
-		subclks[2] = pll->div[3].clk;
-	} else {
-		subclks[0] = pll->div[0].clk;
-		subclks[1] = pll->div[1].clk;
-		subclks[2] = pll->div[2].clk;
-		subclks[3] = pll->div[3].clk;
-	}
-
-	onecell_data->clks = subclks;
-	onecell_data->clk_num = count;
-
-	rc = of_clk_add_provider(np, of_clk_src_onecell_get, onecell_data);
-	if (rc) {
-		pr_err("%s: Couldn't register clk provider for node %s: %d\n",
-		       __func__, np->name, rc);
-		goto err_cell;
-	}
-
-	return;
-err_cell:
-	kfree(onecell_data);
-err_clks:
-	kfree(subclks);
-}
-
-/* Legacy node */
-static void __init pltfrm_pll_init(struct device_node *np)
-{
-	legacy_pll_init(np, PLATFORM_PLL);
-}
-
-/* Legacy node */
-static void __init core_pll_init(struct device_node *np)
-{
-	struct resource res;
-	int idx;
-
-	if (of_address_to_resource(np, 0, &res))
-		return;
-
-	if ((res.start & 0xfff) == 0xc00) {
-		/*
-		 * ls1021a devtree labels the platform PLL
-		 * with the core PLL compatible
-		 */
-		pltfrm_pll_init(np);
-	} else {
-		idx = (res.start & 0xf0) >> 5;
-		legacy_pll_init(np, CGA_PLL1 + idx);
-	}
-}
-
 static struct clk *clockgen_clk_get(struct of_phandle_args *clkspec, void *data)
 {
 	struct clockgen *cg = data;
@@ -1347,10 +1213,6 @@ static void __init clockgen_init(struct device_node *np)
 	int i, ret;
 	bool is_old_ls1021a = false;
 
-	/* May have already been called by a legacy probe */
-	if (clockgen.node)
-		return;
-
 	clockgen.node = np;
 	clockgen.regs = of_iomap(np, 0);
 	if (!clockgen.regs &&
@@ -1418,19 +1280,20 @@ static void __init clockgen_init(struct device_node *np)
 
 CLK_OF_DECLARE(qoriq_clockgen_1, "fsl,qoriq-clockgen-1.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_b4420, "fsl,fsl,b4420-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_b4860, "fsl,fsl,b4860-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
-
-/* Legacy nodes */
-CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
-CLK_OF_DECLARE(qoriq_sysclk_2, "fsl,qoriq-sysclk-2.0", sysclk_init);
-CLK_OF_DECLARE(qoriq_core_pll_1, "fsl,qoriq-core-pll-1.0", core_pll_init);
-CLK_OF_DECLARE(qoriq_core_pll_2, "fsl,qoriq-core-pll-2.0", core_pll_init);
-CLK_OF_DECLARE(qoriq_core_mux_1, "fsl,qoriq-core-mux-1.0", core_mux_init);
-CLK_OF_DECLARE(qoriq_core_mux_2, "fsl,qoriq-core-mux-2.0", core_mux_init);
-CLK_OF_DECLARE(qoriq_pltfrm_pll_1, "fsl,qoriq-platform-pll-1.0", pltfrm_pll_init);
-CLK_OF_DECLARE(qoriq_pltfrm_pll_2, "fsl,qoriq-platform-pll-2.0", pltfrm_pll_init);
+CLK_OF_DECLARE(qoriq_clockgen_p2041, "fsl,p2041-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_p3041, "fsl,p3041-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_p4080, "fsl,p4080-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_p5020, "fsl,p5020-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_p5040, "fsl,p5040-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_t1023, "fsl,t1023-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_t1040, "fsl,t1040-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_t2080, "fsl,t2080-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_t4240, "fsl,t4240-clockgen", clockgen_init);
-- 
1.7.1

