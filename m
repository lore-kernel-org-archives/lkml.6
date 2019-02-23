Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA67C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBE320661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957613;
	bh=/6g9tgN/IGreHyPOlJaXx5BLwwU70A7bcOQOjGsyyBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pqs3gZA95McimBPo44qVKxlFs51vJCIbLk6/tg8wJGGhlvAA4rnzaKFMM5Oz8XoZm
	 eiN7z8B6A8MTLoJ8kUWbnTZKgYmmXqULPtf5kO8dIlb4p3+DleQ4OI0qircEkEqLNE
	 IRxaRVexcqROVvpC6jODe8TzbsvrmMEKVCvsQP6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfBWVdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfBWVEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:04:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA2320855;
        Sat, 23 Feb 2019 21:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955893;
        bh=/6g9tgN/IGreHyPOlJaXx5BLwwU70A7bcOQOjGsyyBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cKlYd4tYyQKQ1/WDeDN6c0c+J2EiU02rT4JF8ebMgkCu0mStTfpga8bUIkBYt3v4m
         3Zn3QvsxQFHqVa13rhDf5ojMor480K4oyP4d3I9hnZGdt22akC6+NOO4vvXBIPZYe4
         2uMS0rynJ3qa5CrIOdM1kJnl4nrNG8Acfc8fjG30=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 19/72] clk: ti: Fix error handling in ti_clk_parse_divider_data()
Date:   Sat, 23 Feb 2019 16:03:29 -0500
Message-Id: <20190223210422.199966-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 303aef8b84272d73999a3207dd05bbe10ed89dc5 ]

The ti_clk_parse_divider_data() function is only called from
_get_div_table_from_setup().  That function doesn't look at the return
value but instead looks at the "*table" pointer.  In this case, if the
kcalloc() fails then *table is NULL (which means success).  It should
instead be an error pointer.

The ti_clk_parse_divider_data() function has two callers.  One checks
for errors and the other doesn't.  I have fixed it so now both handle
errors.

Fixes: 4f6be5655dc9 ("clk: ti: divider: add driver internal API for parsing divider data")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/divider.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 8d77090ad94ae..0241450f3eb3c 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -403,8 +403,10 @@ int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
 	num_dividers = i;
 
 	tmp = kcalloc(valid_div + 1, sizeof(*tmp), GFP_KERNEL);
-	if (!tmp)
+	if (!tmp) {
+		*table = ERR_PTR(-ENOMEM);
 		return -ENOMEM;
+	}
 
 	valid_div = 0;
 	*width = 0;
@@ -439,6 +441,7 @@ struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
 {
 	struct clk_omap_divider *div;
 	struct clk_omap_reg *reg;
+	int ret;
 
 	if (!setup)
 		return NULL;
@@ -458,6 +461,12 @@ struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
 		div->flags |= CLK_DIVIDER_POWER_OF_TWO;
 
 	div->table = _get_div_table_from_setup(setup, &div->width);
+	if (IS_ERR(div->table)) {
+		ret = PTR_ERR(div->table);
+		kfree(div);
+		return ERR_PTR(ret);
+	}
+
 
 	div->shift = setup->bit_shift;
 	div->latch = -EINVAL;
-- 
2.19.1

