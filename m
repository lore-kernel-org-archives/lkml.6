Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C98C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB3F217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mzL3dYQh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KIDMZChB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbeLTLqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:46:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeLTLqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:46:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A07A6074E; Thu, 20 Dec 2018 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545306397;
        bh=+a604Dlu1vRnEhpaFL30Lbxces93nQdy+8/y8pq7l0A=;
        h=From:To:Cc:Subject:Date:From;
        b=mzL3dYQhSsShtKFZm8YlbBBgVEkCugNg5C9Opz4om766O/OM6t00jSzzjzdcCbSOz
         ErtTOaieEZ8mnbMU2vpLOFTpEQsEO7Mt8ykfjM2e+CCdydgosdHKR9rl3to7yETC9j
         Ayzg4IWyFTjyz1HkWRiW56SVHzFOTW6zZhz82z0c=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F515600E2;
        Thu, 20 Dec 2018 11:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545306396;
        bh=+a604Dlu1vRnEhpaFL30Lbxces93nQdy+8/y8pq7l0A=;
        h=From:To:Cc:Subject:Date:From;
        b=KIDMZChBkAytId4LcUp5HP52DQkU18ZFgn4HSAJ533hlh2ZZ59Ujucu2xedclyqfm
         syWQdKvJlrcUI+ccCt8ETKQT2dKF6O6HSZMOebIM6UozHSIKaCOZSSYx6wzVKZa2g4
         Jsb5qIoFVCff0NmYRYlgD3ll5RcrXQ+JPe7eXprc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F515600E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] clk: qcom: lpass: Add CLK_IGNORE_UNUSED for lpass clocks
Date:   Thu, 20 Dec 2018 17:16:25 +0530
Message-Id: <1545306385-31240-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPASS clocks has a dependency on the GCC lpass clocks to be enabled
before accessing them and that was the reason to mark the gcc lpass clocks
as critical. But in the case where the lpass subsystem would require a
restart, toggling the lpass reset would from HW clear the SW enable bits
of the GCC lpass clocks. Thus the next time bringing up the lpass subsystem
out of reset would fail.

Allow the lpass clock driver to enable/disable the gcc lpass clocks and
mark the lpass clocks not be accessed during late_init if no client vote.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/gcc-sdm845.c     | 2 --
 drivers/clk/qcom/lpasscc-sdm845.c | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index c782e62..8365c97 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3163,7 +3163,6 @@ enum {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_lpass_q6_axi_clk",
-			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3177,7 +3176,6 @@ enum {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_lpass_sway_clk",
-			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc-sdm845.c
index e246b99..1acc741 100644
--- a/drivers/clk/qcom/lpasscc-sdm845.c
+++ b/drivers/clk/qcom/lpasscc-sdm845.c
@@ -22,6 +22,7 @@
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "lpass_q6ss_ahbm_aon_clk",
+			.flags = CLK_IGNORE_UNUSED,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -35,6 +36,7 @@
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "lpass_q6ss_ahbs_aon_clk",
+			.flags = CLK_IGNORE_UNUSED,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -49,6 +51,7 @@
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "lpass_qdsp6ss_core_clk",
+			.flags = CLK_IGNORE_UNUSED,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -63,6 +66,7 @@
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "lpass_qdsp6ss_xo_clk",
+			.flags = CLK_IGNORE_UNUSED,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -77,6 +81,7 @@
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "lpass_qdsp6ss_sleep_clk",
+			.flags = CLK_IGNORE_UNUSED,
 			.ops = &clk_branch2_ops,
 		},
 	},
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

