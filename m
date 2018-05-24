Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969567AbeEXVhm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:37:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40590 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969483AbeEXVhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:37:39 -0400
X-Google-Smtp-Source: AB8JxZq51H681stc8cqSeoTm7Ieu6ff19QTU1RTzDNmh+KgMmkXFbDYE9Ba5zF6BfkYmhYN36UTaGA==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-msm8996: Disable halt check on UFS clocks
Date: Thu, 24 May 2018 14:37:35 -0700
Message-Id: <20180524213735.12121-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The halt check of the UFS symbol clocks always fails, as such probing
UFS after clk_disable_unused always fails. This makes it impossible to
boot a system with the UFS phy or UFS HCD drivers compiled as modules.

Follow SDM845 and disable the halt check on these clocks.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/gcc-msm8996.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 3d6452932797..5f17080c5804 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -2792,6 +2792,7 @@ static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
 
 static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
 	.halt_reg = 0x7501c,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x7501c,
 		.enable_mask = BIT(0),
@@ -2807,6 +2808,7 @@ static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
 
 static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
 	.halt_reg = 0x75020,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x75020,
 		.enable_mask = BIT(0),
-- 
2.17.0
