Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E74C04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175EE2245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPN4bdw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175EE2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbeKOIsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:48:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbeKOI1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:20 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D64022528;
        Wed, 14 Nov 2018 22:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234137;
        bh=43e4ScMAwofi2Co7N7LeyAcde7+k3iRoLGiQLiTwWIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vPN4bdw3wEN5muZTv2f6ors38ricgZfA2HopRBheoFcpCd0aK7SDIm8zl1Gooi2rY
         jpyX7ozKKQnf3UTKGF1xFyitpxUKFiAQo2W9HTVbmbVRJGcFmR/XQOGSavQPYd1ogX
         Ira6jH2dBoAfcLAdc5EqejtverBnI9H4dovAQyaU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 37/73] clk: fixed-factor: fix of_node_get-put imbalance
Date:   Wed, 14 Nov 2018 17:21:31 -0500
Message-Id: <20181114222207.98701-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
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

