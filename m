Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0491C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6571A208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6571A208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeHXU2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:28:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54661 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXU2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:28:05 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ftFK4-00035w-GD; Fri, 24 Aug 2018 16:52:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ixgb: replace dma_alloc_coherent + memset with dma_zalloc_coherent
Date:   Fri, 24 Aug 2018 17:52:32 +0100
Message-Id: <20180824165232.21585-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Use dma_zalloc_coherent rather than dam_alloc_coherent and memset.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgb/ixgb_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
index 43664adf7a3c..c71bc0237108 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
@@ -771,14 +771,12 @@ ixgb_setup_rx_resources(struct ixgb_adapter *adapter)
 	rxdr->size = rxdr->count * sizeof(struct ixgb_rx_desc);
 	rxdr->size = ALIGN(rxdr->size, 4096);
 
-	rxdr->desc = dma_alloc_coherent(&pdev->dev, rxdr->size, &rxdr->dma,
-					GFP_KERNEL);
-
+	rxdr->desc = dma_zalloc_coherent(&pdev->dev, rxdr->size, &rxdr->dma,
+					 GFP_KERNEL);
 	if (!rxdr->desc) {
 		vfree(rxdr->buffer_info);
 		return -ENOMEM;
 	}
-	memset(rxdr->desc, 0, rxdr->size);
 
 	rxdr->next_to_clean = 0;
 	rxdr->next_to_use = 0;
-- 
2.17.1

