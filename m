Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A5FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C76A22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhcsHpxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C76A22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbeKMPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731477AbeKMPrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:04 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4916B2250F;
        Tue, 13 Nov 2018 05:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088236;
        bh=0TPpHlUsaHzJegStfDXj8ImOiNKPRTMI/2oEu/QolJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhcsHpxX8SGxf8wMKE0Yto9OFioi9HUpVor8zpNzj52FRFXpS4IFU5wHwD8+EnsIU
         gWKSKpsI2nyMki31IirzSuq4qvFpFoYz1PtW/U4GnOBfRRTWxpHR4T4ojx7fz9fcSf
         u05c5hOcYbr8dUU51oYsJAjbY0QfbRlqnQtrzTgk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 33/44] clk: meson: clk-pll: drop CLK_GET_RATE_NOCACHE where unnecessary
Date:   Tue, 13 Nov 2018 00:49:39 -0500
Message-Id: <20181113054950.77898-33-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 2303a9ca693e585a558497ad737728fec97e2b8a ]

CLK_GET_RATE_NOCACHE should only be necessary when the registers
controlling the rate of clock may change outside of CCF. On Amlogic,
it should only be the case for the hdmi pll which is directly controlled
by the display driver (WIP to fix this).

The other plls should not require this flag.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/axg.c     |  1 -
 drivers/clk/meson/gxbb.c    | 12 ++++++++----
 drivers/clk/meson/meson8b.c |  3 ---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index a95152071087..f24d38c12e09 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -96,7 +96,6 @@ static struct clk_regmap axg_sys_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 86d3ae58e84c..58e4b66bfc55 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -213,7 +213,6 @@ static struct clk_regmap gxbb_fixed_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -276,6 +275,10 @@ static struct clk_regmap gxbb_hdmi_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "hdmi_pll_pre_mult" },
 		.num_parents = 1,
+		/*
+		 * Display directly handle hdmi pll registers ATM, we need
+		 * NOCACHE to keep our view of the clock as accurate as possible
+		 */
 		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
@@ -334,6 +337,10 @@ static struct clk_regmap gxl_hdmi_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
+		/*
+		 * Display directly handle hdmi pll registers ATM, we need
+		 * NOCACHE to keep our view of the clock as accurate as possible
+		 */
 		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
@@ -371,7 +378,6 @@ static struct clk_regmap gxbb_sys_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -418,7 +424,6 @@ static struct clk_regmap gxbb_gp0_pll = {
 		.ops = &meson_clk_pll_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -472,7 +477,6 @@ static struct clk_regmap gxl_gp0_pll = {
 		.ops = &meson_clk_pll_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 7447d96a265f..74697e145dde 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -132,7 +132,6 @@ static struct clk_regmap meson8b_fixed_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -169,7 +168,6 @@ static struct clk_regmap meson8b_vid_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -207,7 +205,6 @@ static struct clk_regmap meson8b_sys_pll = {
 		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_GET_RATE_NOCACHE,
 	},
 };
 
-- 
2.17.1

