Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B812C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1911F23D61
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1911F23D61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbeF2Oim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:38:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18816 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbeF2Oij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:38:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b36444f0000>; Fri, 29 Jun 2018 07:38:07 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 29 Jun 2018 07:38:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 29 Jun 2018 07:38:39 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 29 Jun
 2018 14:38:38 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 29 Jun
 2018 14:38:38 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 29 Jun 2018 14:38:38 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b36446c0001>; Fri, 29 Jun 2018 07:38:38 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <pdeschrijver@nvidia.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swarren@nvidia.com>,
        <vbhadram@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH] clk: tegra: bpmp: Don't crash when a clock fails to register
Date:   Fri, 29 Jun 2018 17:38:14 +0300
Message-ID: <20180629143814.17950-1-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When registering clocks, we just skip any that fail to register
(leaving a NULL hole in the clock table). However, our of_xlate
function still tries to dereference each entry while looking for
the clock with the requested id, causing a crash if any clocks
failed to register. Add a check to of_xlate to skip any NULL
clocks.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/clk/tegra/clk-bpmp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index a896692b74ec..01dada561c10 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -586,9 +586,15 @@ static struct clk_hw *tegra_bpmp_clk_of_xlate(struct of_phandle_args *clkspec,
 	unsigned int id = clkspec->args[0], i;
 	struct tegra_bpmp *bpmp = data;
 
-	for (i = 0; i < bpmp->num_clocks; i++)
-		if (bpmp->clocks[i]->id == id)
-			return &bpmp->clocks[i]->hw;
+	for (i = 0; i < bpmp->num_clocks; i++) {
+		struct tegra_bpmp_clk *clk = bpmp->clocks[i];
+
+		if (!clk)
+			continue;
+
+		if (clk->id == id)
+			return &clk->hw;
+	}
 
 	return NULL;
 }
-- 
2.16.1

