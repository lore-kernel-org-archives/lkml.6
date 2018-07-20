Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F1CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8598205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8598205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbeGTOd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:33:59 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36156 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbeGTOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:33:59 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fgViw-0000P0-8J; Fri, 20 Jul 2018 14:45:34 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1fgViv-0003Ry-T4; Fri, 20 Jul 2018 14:45:33 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, jonathanh@nvidia.co,
        thierry.reding@gmail.com, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/8] clk: tegra: implement reset status callback
Date:   Fri, 20 Jul 2018 14:45:25 +0100
Message-Id: <20180720134532.13148-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a the status callback for the reset controller part of the clock
code in the tegra to allow drivers to query the status of a reset line.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/clk/tegra/clk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index ffaf17f71860..a2cb3d0d38bf 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -146,6 +146,19 @@ static const struct tegra_clk_periph_regs periph_regs[] = {
 
 static void __iomem *clk_base;
 
+static int tegra_clk_rst_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	void __iomem *reg;
+
+	if (id < periph_banks * 32) {
+		reg = clk_base + periph_regs[id / 32].rst_reg;
+		return readl_relaxed(reg) & BIT(id % 32) ? 1 : 0;
+	}
+
+	return -EINVAL;
+}
+
 static int tegra_clk_rst_assert(struct reset_controller_dev *rcdev,
 		unsigned long id)
 {
@@ -288,6 +301,7 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 }
 
 static const struct reset_control_ops rst_ops = {
+	.status = tegra_clk_rst_status,
 	.assert = tegra_clk_rst_assert,
 	.deassert = tegra_clk_rst_deassert,
 	.reset = tegra_clk_rst_reset,
-- 
2.18.0

