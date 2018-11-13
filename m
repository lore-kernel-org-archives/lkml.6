Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42F7C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A337A2251A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQrPWO55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A337A2251A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbeKMPsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732651AbeKMPsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:36 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0192C22511;
        Tue, 13 Nov 2018 05:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088329;
        bh=mKTDncJN5Vv58uIazmiZKQ2OpBIakVsP2G19l4JQJmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQrPWO55JAKn1xU1UZR4wnCEEoknjSJY+ZFgAPH55SrwhoDRVEk20XG56atrllPdJ
         mnwSIrNHvrLhuxQ2rVoQF1kSaFz9CbW1Xn+NBVtuodUDb16NdD158jWHiGNqBwdi+1
         dv8M/XCKc1fLHdbpMNtZULfZKJ8XLmo1UFMdZ/Lw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alan Tull <atull@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/26] clk: fixed-rate: fix of_node_get-put imbalance
Date:   Tue, 13 Nov 2018 00:51:39 -0500
Message-Id: <20181113055150.78773-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Tull <atull@kernel.org>

[ Upstream commit 52091c256bdcad0d01e2852a63f19cd2cce6af96 ]

When the fixed rate clock is created by devicetree,
of_clk_add_provider is called.  Add a call to
of_clk_del_provider in the remove function to balance
it out.

Signed-off-by: Alan Tull <atull@kernel.org>
Fixes: 435779fe1336 ("clk: fixed-rate: Convert into a module platform driver")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-fixed-rate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index b5c46b3f8764..6d6475c32ee5 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -200,6 +200,7 @@ static int of_fixed_clk_remove(struct platform_device *pdev)
 {
 	struct clk *clk = platform_get_drvdata(pdev);
 
+	of_clk_del_provider(pdev->dev.of_node);
 	clk_unregister_fixed_rate(clk);
 
 	return 0;
-- 
2.17.1

