Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C294C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A7620836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O3jY2N9q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n5YF4lP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A7620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966619AbeFSNtH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:49:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966469AbeFSNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:46:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B47C360714; Tue, 19 Jun 2018 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415974;
        bh=vYu2GME9Dbyj9lVRS+cY/jEIU1rd0U/4bBuNuw+q3fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3jY2N9qNol4eRUCkmK76mFbDLvVtZUIeEe/RN4wyiSjVZ7MTuRC3o70yB9dZnuXL
         C0NTfaulc9KOHnHMflS7lbnlUzkRdb6ALT+u4oFVMyqB3x8LTJ+8psY5mdr9MixD0F
         SK6Y4skNsRbcdPx50LSjfK1EGVPuG3lqBTM5ZqlE=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B2F160B16;
        Tue, 19 Jun 2018 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415971;
        bh=vYu2GME9Dbyj9lVRS+cY/jEIU1rd0U/4bBuNuw+q3fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5YF4lP3y9w6+2PBF+vBfeTi4a8xulcldjncJj8wCzJ4uIf+ZcQ6gFH3qdNOBYVrJ
         CGX1wNxwX8KfbwH4W+k0wuey1DiotJSlu+t5j9sXAZ2MXJ7VjF5ZmoEIt4MQFA88+n
         H4Gkb0JEPUCITQWgMcooz+et0ctpifH3wfcORjEM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B2F160B16
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk,
        thierry.escande@linaro.org, ctatlor97@gmail.com
Cc:     sricharan@codeaurora.org
Subject: [PATCH v10 06/14] clk: qcom: Add IPQ806X's HFPLLs
Date:   Tue, 19 Jun 2018 19:15:17 +0530
Message-Id: <1529415925-28915-7-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Describe the HFPLLs present on IPQ806X devices.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/gcc-ipq806x.c | 82 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 28eb200..d571cf8 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -30,6 +30,7 @@
 #include "clk-pll.h"
 #include "clk-rcg.h"
 #include "clk-branch.h"
+#include "clk-hfpll.h"
 #include "reset.h"
 
 static struct clk_pll pll0 = {
@@ -113,6 +114,84 @@
 	},
 };
 
+static struct hfpll_data hfpll0_data = {
+	.mode_reg = 0x3200,
+	.l_reg = 0x3208,
+	.m_reg = 0x320c,
+	.n_reg = 0x3210,
+	.config_reg = 0x3204,
+	.status_reg = 0x321c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3214,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll0 = {
+	.d = &hfpll0_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll0",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll0.lock),
+};
+
+static struct hfpll_data hfpll1_data = {
+	.mode_reg = 0x3240,
+	.l_reg = 0x3248,
+	.m_reg = 0x324c,
+	.n_reg = 0x3250,
+	.config_reg = 0x3244,
+	.status_reg = 0x325c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3314,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll1 = {
+	.d = &hfpll1_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll1",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll1.lock),
+};
+
+static struct hfpll_data hfpll_l2_data = {
+	.mode_reg = 0x3300,
+	.l_reg = 0x3308,
+	.m_reg = 0x330c,
+	.n_reg = 0x3310,
+	.config_reg = 0x3304,
+	.status_reg = 0x331c,
+	.config_val = 0x7845c665,
+	.droop_reg = 0x3314,
+	.droop_val = 0x0108c000,
+	.min_rate = 600000000UL,
+	.max_rate = 1800000000UL,
+};
+
+static struct clk_hfpll hfpll_l2 = {
+	.d = &hfpll_l2_data,
+	.clkr.hw.init = &(struct clk_init_data){
+		.parent_names = (const char *[]){ "pxo" },
+		.num_parents = 1,
+		.name = "hfpll_l2",
+		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.lock = __SPIN_LOCK_UNLOCKED(hfpll_l2.lock),
+};
+
 static struct clk_pll pll14 = {
 	.l_reg = 0x31c4,
 	.m_reg = 0x31c8,
@@ -2800,6 +2879,9 @@ enum {
 	[UBI32_CORE2_CLK_SRC] = &ubi32_core2_src_clk.clkr,
 	[NSSTCM_CLK_SRC] = &nss_tcm_src.clkr,
 	[NSSTCM_CLK] = &nss_tcm_clk.clkr,
+	[PLL9] = &hfpll0.clkr,
+	[PLL10] = &hfpll1.clkr,
+	[PLL12] = &hfpll_l2.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq806x_resets[] = {
-- 
1.9.1

