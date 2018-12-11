Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B990CC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EEC20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EEC20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeLKUNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:13:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbeLKUM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:12:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBBK9x3i106370
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:12:55 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pagp81qrb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:12:54 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 11 Dec 2018 20:12:53 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Dec 2018 20:12:50 -0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBBKCnQP19792072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 20:12:49 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 748D0136055;
        Tue, 11 Dec 2018 20:12:49 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC644136053;
        Tue, 11 Dec 2018 20:12:48 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 11 Dec 2018 20:12:48 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, joel@jms.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/2] clk: aspeed: Setup video engine clocking
Date:   Tue, 11 Dec 2018 14:12:41 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544559161-21468-1-git-send-email-eajames@linux.ibm.com>
References: <1544559161-21468-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121120-0020-0000-0000-00000E9849CE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130351; UDB=6.00587356; IPR=6.00910485;
 MB=3.00024657; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-11 20:12:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121120-0021-0000-0000-000064044618
Message-Id: <1544559161-21468-3-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the video engine reset bit. Add eclk mux and clock divider table.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-aspeed.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 5961367..f16ce7d 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -87,7 +87,7 @@ struct aspeed_clk_gate {
 /* TODO: ask Aspeed about the actual parent data */
 static const struct aspeed_gate_data aspeed_gates[] = {
 	/*				 clk rst   name			parent	flags */
-	[ASPEED_CLK_GATE_ECLK] =	{  0, -1, "eclk-gate",		"eclk",	0 }, /* Video Engine */
+	[ASPEED_CLK_GATE_ECLK] =	{  0,  6, "eclk-gate",		"eclk",	0 }, /* Video Engine */
 	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
 	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
 	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
@@ -113,6 +113,24 @@ struct aspeed_clk_gate {
 	[ASPEED_CLK_GATE_LHCCLK] =	{ 28, -1, "lhclk-gate",		"lhclk", 0 }, /* LPC master/LPC+ */
 };
 
+static const char * const eclk_parent_names[] = {
+	"mpll",
+	"hpll",
+	"dpll",
+};
+
+static const struct clk_div_table ast2500_eclk_div_table[] = {
+	{ 0x0, 2 },
+	{ 0x1, 2 },
+	{ 0x2, 3 },
+	{ 0x3, 4 },
+	{ 0x4, 5 },
+	{ 0x5, 6 },
+	{ 0x6, 7 },
+	{ 0x7, 8 },
+	{ 0 }
+};
+
 static const struct clk_div_table ast2500_mac_div_table[] = {
 	{ 0x0, 4 }, /* Yep, really. Aspeed confirmed this is correct */
 	{ 0x1, 4 },
@@ -192,18 +210,21 @@ static struct clk_hw *aspeed_ast2500_calc_pll(const char *name, u32 val)
 
 struct aspeed_clk_soc_data {
 	const struct clk_div_table *div_table;
+	const struct clk_div_table *eclk_div_table;
 	const struct clk_div_table *mac_div_table;
 	struct clk_hw *(*calc_pll)(const char *name, u32 val);
 };
 
 static const struct aspeed_clk_soc_data ast2500_data = {
 	.div_table = ast2500_div_table,
+	.eclk_div_table = ast2500_eclk_div_table,
 	.mac_div_table = ast2500_mac_div_table,
 	.calc_pll = aspeed_ast2500_calc_pll,
 };
 
 static const struct aspeed_clk_soc_data ast2400_data = {
 	.div_table = ast2400_div_table,
+	.eclk_div_table = ast2400_div_table,
 	.mac_div_table = ast2400_div_table,
 	.calc_pll = aspeed_ast2400_calc_pll,
 };
@@ -317,6 +338,7 @@ struct aspeed_reset {
 	[ASPEED_RESET_PECI]	= 10,
 	[ASPEED_RESET_I2C]	=  2,
 	[ASPEED_RESET_AHB]	=  1,
+	[ASPEED_RESET_VIDEO]	=  6,
 
 	/*
 	 * SCUD4 resets start at an offset to separate them from
@@ -522,6 +544,22 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_clk_data->hws[ASPEED_CLK_24M] = hw;
 
+	hw = clk_hw_register_mux(dev, "eclk-mux", eclk_parent_names,
+				 ARRAY_SIZE(eclk_parent_names), 0,
+				 scu_base + ASPEED_CLK_SELECTION, 2, 0x3, 0,
+				 &aspeed_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_clk_data->hws[ASPEED_CLK_ECLK_MUX] = hw;
+
+	hw = clk_hw_register_divider_table(dev, "eclk", "eclk-mux", 0,
+					   scu_base + ASPEED_CLK_SELECTION, 28,
+					   3, 0, soc_data->eclk_div_table,
+					   &aspeed_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_clk_data->hws[ASPEED_CLK_ECLK] = hw;
+
 	/*
 	 * TODO: There are a number of clocks that not included in this driver
 	 * as more information is required:
@@ -531,7 +569,6 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 	 *   RGMII
 	 *   RMII
 	 *   UART[1..5] clock source mux
-	 *   Video Engine (ECLK) mux and clock divider
 	 */
 
 	for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
-- 
1.8.3.1

