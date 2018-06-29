Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F088C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DE127A8F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DE127A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030679AbeF2Cv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:51:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41590 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S966685AbeF2Cvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:51:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1E521207DE17B;
        Fri, 29 Jun 2018 10:51:52 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Fri, 29 Jun 2018
 10:51:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <simon@thekelleys.org.uk>, <kvalo@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <davem@davemloft.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] atmel: using strlcpy() to avoid possible buffer overflows
Date:   Fri, 29 Jun 2018 10:51:35 +0800
Message-ID: <20180629025135.12236-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'firmware' is a module param which may been longer than firmware_id,
so using strlcpy() to guard against overflows

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/atmel/atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index b01dc34..604d5ac 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -1519,7 +1519,7 @@ struct net_device *init_atmel_card(unsigned short irq, unsigned long port,
 	priv->firmware_id[0] = '\0';
 	priv->firmware_type = fw_type;
 	if (firmware) /* module parameter */
-		strcpy(priv->firmware_id, firmware);
+		strlcpy(priv->firmware_id, firmware, sizeof(priv->firmware_id));
 	priv->bus_type = card_present ? BUS_TYPE_PCCARD : BUS_TYPE_PCI;
 	priv->station_state = STATION_STATE_DOWN;
 	priv->do_rx_crc = 0;
-- 
2.7.0


