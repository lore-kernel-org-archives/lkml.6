Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C405C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA562254A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl4Pjfqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA562254A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbeKOIbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:31:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389217AbeKOIbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:31:13 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434482254B;
        Wed, 14 Nov 2018 22:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234368;
        bh=43e4ScMAwofi2Co7N7LeyAcde7+k3iRoLGiQLiTwWIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gl4PjfqwwweRi1ZyXyT8G+69HziOsPzkTl87cQHxnJ67yxy5gohcL9dcbPvc+WHbY
         96ZeJNruGYUO6X2xvNuU/wiO2S1bjBFji5442c2CN4mSCeSl5Xg7g17ROqSIAsJJ18
         9VXqu2drgVr7eYqap86dhWGQroX27TUBq0lC5g2I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/13] clk: fixed-factor: fix of_node_get-put imbalance
Date:   Wed, 14 Nov 2018 17:25:50 -0500
Message-Id: <20181114222558.100213-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222558.100213-1-sashal@kernel.org>
References: <20181114222558.100213-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

[ Upstream commit f98e8a572bddbf27032114127d2fcc78fa5e6a9d ]

When the fixed factor clock is created by devicetree,
of_clk_add_provider is called.  Add a call to
of_clk_del_provider in the remove function to balance
it out.

Reported-by: Alan Tull <atull@kernel.org>
Fixes: 971451b3b15d ("clk: fixed-factor: Convert into a module platform driver")
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-fixed-factor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 20724abd38bd..7df6b5b1e7ee 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -210,6 +210,7 @@ static int of_fixed_factor_clk_remove(struct platform_device *pdev)
 {
 	struct clk *clk = platform_get_drvdata(pdev);
 
+	of_clk_del_provider(pdev->dev.of_node);
 	clk_unregister_fixed_factor(clk);
 
 	return 0;
-- 
2.17.1

