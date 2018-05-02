Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbeEBHOo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbeEBHOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:14:40 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525105210-8689-3-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1525105210-8689-1-git-send-email-anischal@codeaurora.org>
 <1525105210-8689-3-git-send-email-anischal@codeaurora.org>
Message-ID: <152524527938.138124.8505584329413678951@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 2/3] clk: qcom: Add support for BRANCH_NO_DELAY flag for
 branch clocks
Date: Wed, 02 May 2018 00:14:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w427EmZN023874

Quoting Amit Nischal (2018-04-30 09:20:09)
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 284df3f..5d621f3 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -42,6 +42,7 @@ struct clk_branch {
>  #define BRANCH_HALT_ENABLE             1 /* pol: 0 = halt */
>  #define BRANCH_HALT_ENABLE_VOTED       (BRANCH_HALT_ENABLE | BRANCH_VOTED)
>  #define BRANCH_HALT_DELAY              2 /* No bit to check; just delay */
> +#define BRANCH_NO_DELAY                        3 /* No bit to check; without delay */

Let's call it BRANCH_HALT_SKIP and indicate that it's skipping the halt
bit check. Technically there is a bit to check, we just refuse to check
it. I've reworked and applied this patch as below.

>From f9ddbd74bf4940d3b7a0eb076eb254833660643c Mon Sep 17 00:00:00 2001
From: Amit Nischal <anischal@codeaurora.org>
Date: Mon, 30 Apr 2018 21:50:09 +0530
Subject: [PATCH] clk: qcom: Add support for BRANCH_HALT_SKIP flag for branch
 clocks

There could be few clocks where the clock status bit is not
required to be polled as the clock on/off would be controlled
by enabling/disabling external source. Add support for the
same by introducing new flag named as 'BRANCH_HALT_SKIP'.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
[sboyd@kernel.org: Rename flag to BRANCH_HALT_SKIP]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/clk-branch.c | 7 +++++--
 drivers/clk/qcom/clk-branch.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index 26f7af315066..c58c5538b1b6 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -77,8 +77,11 @@ static int clk_branch_wait(const struct clk_branch *br, bool enabling,
 	bool voted = br->halt_check & BRANCH_VOTED;
 	const char *name = clk_hw_get_name(&br->clkr.hw);
 
-	/* Skip checking halt bit if the clock is in hardware gated mode */
-	if (clk_branch_in_hwcg_mode(br))
+	/*
+	 * Skip checking halt bit if we're explicitly ignoring the bit or the
+	 * clock is in hardware gated mode
+	 */
+	if (br->halt_check == BRANCH_HALT_SKIP || clk_branch_in_hwcg_mode(br))
 		return 0;
 
 	if (br->halt_check == BRANCH_HALT_DELAY || (!enabling && voted)) {
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 284df3f3c55f..1702efb1c511 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -42,6 +42,7 @@ struct clk_branch {
 #define BRANCH_HALT_ENABLE		1 /* pol: 0 = halt */
 #define BRANCH_HALT_ENABLE_VOTED	(BRANCH_HALT_ENABLE | BRANCH_VOTED)
 #define BRANCH_HALT_DELAY		2 /* No bit to check; just delay */
+#define BRANCH_HALT_SKIP		3 /* Don't check halt bit */
 
 	struct clk_regmap clkr;
 };
-- 
Sent by a computer through tubes
