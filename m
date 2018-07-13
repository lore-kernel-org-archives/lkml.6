Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE00ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36DD208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36DD208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbeGMDPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:15:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9615 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387696AbeGMDPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:15:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 25D58ACDCB582;
        Fri, 13 Jul 2018 11:02:24 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 11:02:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <michael.chan@broadcom.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] bnxt_en: remove redundant debug register dma mem allocation
Date:   Fri, 13 Jul 2018 11:02:04 +0800
Message-ID: <20180713030204.884-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwrm_dbg_resp_addr and hwrm_dbg_resp_dma_addr are never used
and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 13 -------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  3 ---
 2 files changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4394c11..4db3180 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3012,13 +3012,6 @@ static void bnxt_free_hwrm_resources(struct bnxt *bp)
 			  bp->hwrm_cmd_resp_dma_addr);
 
 	bp->hwrm_cmd_resp_addr = NULL;
-	if (bp->hwrm_dbg_resp_addr) {
-		dma_free_coherent(&pdev->dev, HWRM_DBG_REG_BUF_SIZE,
-				  bp->hwrm_dbg_resp_addr,
-				  bp->hwrm_dbg_resp_dma_addr);
-
-		bp->hwrm_dbg_resp_addr = NULL;
-	}
 }
 
 static int bnxt_alloc_hwrm_resources(struct bnxt *bp)
@@ -3030,12 +3023,6 @@ static int bnxt_alloc_hwrm_resources(struct bnxt *bp)
 						   GFP_KERNEL);
 	if (!bp->hwrm_cmd_resp_addr)
 		return -ENOMEM;
-	bp->hwrm_dbg_resp_addr = dma_alloc_coherent(&pdev->dev,
-						    HWRM_DBG_REG_BUF_SIZE,
-						    &bp->hwrm_dbg_resp_dma_addr,
-						    GFP_KERNEL);
-	if (!bp->hwrm_dbg_resp_addr)
-		netdev_warn(bp->dev, "fail to alloc debug register dma mem\n");
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 91575ef..934aa11 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1287,9 +1287,6 @@ struct bnxt {
 	dma_addr_t		hwrm_short_cmd_req_dma_addr;
 	void			*hwrm_cmd_resp_addr;
 	dma_addr_t		hwrm_cmd_resp_dma_addr;
-	void			*hwrm_dbg_resp_addr;
-	dma_addr_t		hwrm_dbg_resp_dma_addr;
-#define HWRM_DBG_REG_BUF_SIZE	128
 
 	struct rx_port_stats	*hw_rx_port_stats;
 	struct tx_port_stats	*hw_tx_port_stats;
-- 
2.7.0


