Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEF4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2844D204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2844D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbeGTOen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:34:43 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36150 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbeGTOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:33:59 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fgViw-0000P7-E5; Fri, 20 Jul 2018 14:45:34 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1fgViw-0003SG-47; Fri, 20 Jul 2018 14:45:34 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, jonathanh@nvidia.co,
        thierry.reding@gmail.com, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 7/8] clk: tegra: replace warn on with single line
Date:   Fri, 20 Jul 2018 14:45:31 +0100
Message-Id: <20180720134532.13148-8-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of WARN_ON(1) is a bit extreme for something that is called from
very few places. Add a function to print the ID (and maybe more info if
people really want it).

This was done as during the development of the tegra-automotive branches
we got swamped with clock errors of not very useful data.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/clk/tegra/clk.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index a2cb3d0d38bf..3bba3509ca1f 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -258,6 +258,11 @@ void __init tegra_init_dup_clks(struct tegra_clk_duplicate *dup_list,
 	}
 }
 
+static void tegra_clk_init_error(struct tegra_clk_init_table *tbl)
+{
+	pr_err("ERROR: Failed to initialise clock id %d\n", tbl->clk_id);
+}
+
 void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 				  struct clk *clks[], int clk_max)
 {
@@ -268,8 +273,7 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 		if (IS_ERR_OR_NULL(clk)) {
 			pr_err("%s: invalid entry %ld in clks array for id %d\n",
 			       __func__, PTR_ERR(clk), tbl->clk_id);
-			WARN_ON(1);
-
+			tegra_clk_init_error(tbl);
 			continue;
 		}
 
@@ -279,7 +283,7 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 				pr_err("%s: Failed to set parent %s of %s\n",
 				       __func__, __clk_get_name(parent),
 				       __clk_get_name(clk));
-				WARN_ON(1);
+				tegra_clk_init_error(tbl);
 			}
 		}
 
@@ -288,14 +292,14 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 				pr_err("%s: Failed to set rate %lu of %s\n",
 				       __func__, tbl->rate,
 				       __clk_get_name(clk));
-				WARN_ON(1);
+				tegra_clk_init_error(tbl);
 			}
 
 		if (tbl->state)
 			if (clk_prepare_enable(clk)) {
 				pr_err("%s: Failed to enable %s\n", __func__,
 				       __clk_get_name(clk));
-				WARN_ON(1);
+				tegra_clk_init_error(tbl);
 			}
 	}
 }
-- 
2.18.0

