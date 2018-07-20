Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531B6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022A9204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022A9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbeGTOef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:34:35 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36162 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731719AbeGTOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:33:59 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fgViw-0000P3-8p; Fri, 20 Jul 2018 14:45:34 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1fgViv-0003S4-Va; Fri, 20 Jul 2018 14:45:33 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, jonathanh@nvidia.co,
        thierry.reding@gmail.com, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/8] clk: tegra: fix fractional clocks for VDI, VI, EPP, MPE, 2D and 3D
Date:   Fri, 20 Jul 2018 14:45:27 +0100
Message-Id: <20180720134532.13148-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks vde, vi, epp, mpe, 2d and 3d are all fractional
divisors, and not integer divisors as setup in the current
kernel. This seems to be the same for tegra2 and tegra3.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/clk/tegra/clk-tegra-periph.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
index 8fa1cecf18a0..ed70419f4ff9 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -641,13 +641,13 @@ static struct tegra_periph_init_data periph_clks[] = {
 	I2C("i2c4", mux_pllp_clkm, CLK_SOURCE_I2C4, 103, tegra_clk_i2c4),
 	I2C("i2c5", mux_pllp_clkm, CLK_SOURCE_I2C5, 47, tegra_clk_i2c5),
 	I2C("i2c6", mux_pllp_clkm, CLK_SOURCE_I2C6, 166, tegra_clk_i2c6),
-	INT("vde", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_VDE, 61, 0, tegra_clk_vde),
-	INT("vi", mux_pllm_pllc_pllp_plla, CLK_SOURCE_VI, 20, 0, tegra_clk_vi),
-	INT("epp", mux_pllm_pllc_pllp_plla, CLK_SOURCE_EPP, 19, 0, tegra_clk_epp),
+	MUX("vde", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_VDE, 61, 0, tegra_clk_vde),
+	MUX("vi", mux_pllm_pllc_pllp_plla, CLK_SOURCE_VI, 20, 0, tegra_clk_vi),
+	MUX("epp", mux_pllm_pllc_pllp_plla, CLK_SOURCE_EPP, 19, 0, tegra_clk_epp),
 	MUX("host1x", mux_pllm_pllc_pllp_plla, CLK_SOURCE_HOST1X, 28, 0, tegra_clk_host1x),
-	INT("mpe", mux_pllm_pllc_pllp_plla, CLK_SOURCE_MPE, 60, 0, tegra_clk_mpe),
-	INT("2d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_2D, 21, 0, tegra_clk_gr2d),
-	INT("3d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 24, 0, tegra_clk_gr3d),
+	MUX("mpe", mux_pllm_pllc_pllp_plla, CLK_SOURCE_MPE, 60, 0, tegra_clk_mpe),
+	MUX("2d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_2D, 21, 0, tegra_clk_gr2d),
+	MUX("3d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 24, 0, tegra_clk_gr3d),
 	INT8("vde", mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_VDE, 61, 0, tegra_clk_vde_8),
 	INT8("vi", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI, 20, 0, tegra_clk_vi_8),
 	INT8("vi", mux_pllm_pllc2_c_c3_pllp_plla_pllc4, CLK_SOURCE_VI, 20, 0, tegra_clk_vi_9),
-- 
2.18.0

