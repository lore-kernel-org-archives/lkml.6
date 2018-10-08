Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F790C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC6A21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4ng2kDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC6A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeJHWib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbeJHWia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F42C214FA;
        Mon,  8 Oct 2018 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012375;
        bh=wE0d+Xpm740wxksxowzwVpuhsYdIKCoXXe7w+ze4l6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4ng2kDKrhnYJPH3Lz0rRQ2GqzB9FB0GzFM5aJsoQqbXx1WhyQ9n6JJdFopsknp4H
         1+xDQqxe5WEoxBbGIdLj8t80lPnYSRuDy2p5olg6tW9faXDkmAmJnUQ8WVxsbH+S/r
         1ju/yQyVXLyXDMHgDG4FDupmECxFkthhVmbf2BqI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 52/58] iommu/rockchip: Free irqs in shutdown handler
Date:   Mon,  8 Oct 2018 11:25:17 -0400
Message-Id: <20181008152523.70705-52-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit 74bc2abca7603c956d1e331e8b9bee7b874c1eec ]

In the iommu's shutdown handler we disable runtime-pm which could
result in the irq-handler running unclocked and since commit
    3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM framework")
we warn about that fact.

This can cause warnings on shutdown on some Rockchip machines, so
free the irqs in the shutdown handler before we disable runtime-pm.

Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Fixes: 3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM framework")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/rockchip-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 2b1724e8d307..701820b39fd1 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1242,6 +1242,12 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 static void rk_iommu_shutdown(struct platform_device *pdev)
 {
+	struct rk_iommu *iommu = platform_get_drvdata(pdev);
+	int i = 0, irq;
+
+	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO)
+		devm_free_irq(iommu->dev, irq, iommu);
+
 	pm_runtime_force_suspend(&pdev->dev);
 }
 
-- 
2.17.1

