Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB98C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EDA20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS4xMERx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EDA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbeJYWsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbeJYWsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:38 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F172085B;
        Thu, 25 Oct 2018 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476941;
        bh=aqAN6ZdEelJPOq3OJijwwrVfbBsBQ99TVnWUojaopSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OS4xMERx2jCh3dKIeEem3M4lQ9LKjYV/uD2+l6UqqAtfzKGwyYshw6O4GtDAsGUvz
         jSRacca1HuVwZ7bC/S9NxWFCxQj0Bu+PAYq7dC7JpqjWh48v7XgynetDWXc0axoF42
         3EZo0TZ+1fMd4AJifnKbILgK2MZlGsxHkjw+DJkw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 52/98] clk: samsung: Fix m2m scaler clock on Exynos542x
Date:   Thu, 25 Oct 2018 10:13:37 -0400
Message-Id: <20181025141423.213774-52-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>

[ Upstream commit c07c1a0f68d0f2f7ca9aff924e2772526027b019 ]

The TOP "aclk400_mscl" clock should be kept enabled all the time
to allow proper access to power management control for MSC power
domain and devices that are a part of it. This change is required
for the scaler to work properly after domain power on/off sequence.

Fixes: 318fa46cc60d ("clk/samsung: exynos542x: mark some clocks as critical")
Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index cdc092a1d9ef..07fb667e258f 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -987,7 +987,7 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 	GATE(0, "aclk400_isp", "mout_user_aclk400_isp",
 			GATE_BUS_TOP, 16, 0, 0),
 	GATE(0, "aclk400_mscl", "mout_user_aclk400_mscl",
-			GATE_BUS_TOP, 17, 0, 0),
+			GATE_BUS_TOP, 17, CLK_IS_CRITICAL, 0),
 	GATE(0, "aclk200_disp1", "mout_user_aclk200_disp1",
 			GATE_BUS_TOP, 18, CLK_IS_CRITICAL, 0),
 	GATE(CLK_SCLK_MPHY_IXTAL24, "sclk_mphy_ixtal24", "mphy_refclk_ixtal24",
-- 
2.17.1

