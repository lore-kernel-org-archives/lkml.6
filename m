Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B22ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BFE204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BFE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbeGTOe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:34:29 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36147 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbeGTOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:33:59 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fgViw-0000P5-CD; Fri, 20 Jul 2018 14:45:34 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1fgViw-0003SA-1x; Fri, 20 Jul 2018 14:45:34 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, jonathanh@nvidia.co,
        thierry.reding@gmail.com, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 5/8] clk: tegra: add mux-only clock option
Date:   Fri, 20 Jul 2018 14:45:29 +0100
Message-Id: <20180720134532.13148-6-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both the TEGRA_PERIPH_NO_DIV and TEGRA_PERIPH_NO_GATE are set
as the clock is a mux only, then the clock code fails as it does
not handle both these at the same time. Add support for this by
adding new ops with just the parent get/set.

This is required to add the 2d and 3d idle clocks.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/clk/tegra/clk-periph.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
index 9475c00b7cf9..0c377d2dac43 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -137,6 +137,11 @@ static const struct clk_ops tegra_clk_periph_no_gate_ops = {
 	.set_rate = clk_periph_set_rate,
 };
 
+static const struct clk_ops tegra_clk_periph_nodivgate_ops = {
+	.get_parent = clk_periph_get_parent,
+	.set_parent = clk_periph_set_parent,
+};
+
 static struct clk *_tegra_clk_register_periph(const char *name,
 			const char * const *parent_names, int num_parents,
 			struct tegra_clk_periph *periph,
@@ -147,8 +152,11 @@ static struct clk *_tegra_clk_register_periph(const char *name,
 	struct clk_init_data init;
 	const struct tegra_clk_periph_regs *bank;
 	bool div = !(periph->gate.flags & TEGRA_PERIPH_NO_DIV);
+	bool gate = !(periph->gate.flags & TEGRA_PERIPH_NO_GATE);
 
-	if (periph->gate.flags & TEGRA_PERIPH_NO_DIV) {
+	if (!div && !gate)
+		init.ops = &tegra_clk_periph_nodivgate_ops;
+	else if (periph->gate.flags & TEGRA_PERIPH_NO_DIV) {
 		flags |= CLK_SET_RATE_PARENT;
 		init.ops = &tegra_clk_periph_nodiv_ops;
 	} else if (periph->gate.flags & TEGRA_PERIPH_NO_GATE)
@@ -171,7 +179,7 @@ static struct clk *_tegra_clk_register_periph(const char *name,
 	periph->mux.reg = clk_base + offset;
 	periph->divider.reg = div ? (clk_base + offset) : NULL;
 	periph->gate.clk_base = clk_base;
-	periph->gate.regs = bank;
+	periph->gate.regs = gate ? bank : NULL;
 	periph->gate.enable_refcnt = periph_clk_enb_refcnt;
 
 	clk = clk_register(NULL, &periph->hw);
@@ -180,7 +188,7 @@ static struct clk *_tegra_clk_register_periph(const char *name,
 
 	periph->mux.hw.clk = clk;
 	periph->divider.hw.clk = div ? clk : NULL;
-	periph->gate.hw.clk = clk;
+	periph->gate.hw.clk = gate ? clk : NULL;
 
 	return clk;
 }
-- 
2.18.0

