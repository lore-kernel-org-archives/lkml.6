Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD1BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0FA20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0FA20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392280AbeKVRa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:30:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbeKVRa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:30:58 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 643C385E6EE46;
        Thu, 22 Nov 2018 14:52:52 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 14:52:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <thomas.petazzoni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: mvneta: remove redundant check for eee->tx_lpi_timer < 0
Date:   Thu, 22 Nov 2018 14:42:00 +0800
Message-ID: <20181122064200.11572-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixes the smatch warning:

drivers/net/ethernet/marvell/mvneta.c:4252 mvneta_ethtool_set_eee() warn:
 unsigned 'eee->tx_lpi_timer' is never less than zero.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index e5397c8..46a0f6b 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4248,8 +4248,7 @@ static int mvneta_ethtool_set_eee(struct net_device *dev,
 
 	/* The Armada 37x documents do not give limits for this other than
 	 * it being an 8-bit register. */
-	if (eee->tx_lpi_enabled &&
-	    (eee->tx_lpi_timer < 0 || eee->tx_lpi_timer > 255))
+	if (eee->tx_lpi_enabled && eee->tx_lpi_timer > 255)
 		return -EINVAL;
 
 	lpi_ctl0 = mvreg_read(pp, MVNETA_LPI_CTRL_0);
-- 
2.7.0


