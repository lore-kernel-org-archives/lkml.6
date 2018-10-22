Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A659C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F4A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCOxsMHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F4A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeJVShu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbeJVSht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:37:49 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5618520853;
        Mon, 22 Oct 2018 10:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203594;
        bh=iSokpCXAN3zUlCakcSc9Mv936/2ngERXGZ3hvo9tAyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCOxsMHufjRgX/DwPwOx9sSIKsZGrgOu0N4lmUSPMrPMdo/wU1V3JaGBqDM4YC8iv
         YhzNFrQFGCwTtAUixl3r2dOsndILWMTPqtofYSOAJ7DzuthYO94nE+dpoukKiuPLCT
         sr6R8iYb1m9HqI6bDv1S60OlWPCfAbdjE5sPFr5Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arthur Kiyanovski <akiyano@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 15/27] net: ena: fix warning in rmmod caused by double iounmap
Date:   Mon, 22 Oct 2018 06:19:12 -0400
Message-Id: <20181022101924.40531-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit d79c3888bde6581da7ff9f9d6f581900ecb5e632 ]

Memory mapped with devm_ioremap is automatically freed when the driver
is disconnected from the device. Therefore there is no need to
explicitly call devm_iounmap.

Fixes: 0857d92f71b6 ("net: ena: add missing unmap bars on device removal")
Fixes: 411838e7b41c ("net: ena: fix rare kernel crash when bar memory remap fails")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 1b01cd2820ba..7093b661c50e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3128,15 +3128,8 @@ static int ena_rss_init_default(struct ena_adapter *adapter)
 
 static void ena_release_bars(struct ena_com_dev *ena_dev, struct pci_dev *pdev)
 {
-	int release_bars;
+	int release_bars = pci_select_bars(pdev, IORESOURCE_MEM) & ENA_BAR_MASK;
 
-	if (ena_dev->mem_bar)
-		devm_iounmap(&pdev->dev, ena_dev->mem_bar);
-
-	if (ena_dev->reg_bar)
-		devm_iounmap(&pdev->dev, ena_dev->reg_bar);
-
-	release_bars = pci_select_bars(pdev, IORESOURCE_MEM) & ENA_BAR_MASK;
 	pci_release_selected_regions(pdev, release_bars);
 }
 
-- 
2.17.1

