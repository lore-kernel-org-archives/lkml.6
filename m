Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B938FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7655C20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7655C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbeHAJFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:05:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733096AbeHAJFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:05:19 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 02D3D1B10EC4C;
        Wed,  1 Aug 2018 15:20:49 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 15:20:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <sameo@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] NFC: nci: remove redundant variable 'status'
Date:   Wed, 1 Aug 2018 15:20:20 +0800
Message-ID: <20180801072020.14696-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit d8cd37ed2fc8 ("NFC: nci: Fix improper management of HCI return code")
variable 'status' is being assigned but never used,
so can be removed. Also make a trival cleanup.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/nfc/nci/hci.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index ddfc52a..4debba8 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -370,17 +370,11 @@ static void nci_hci_resp_received(struct nci_dev *ndev, u8 pipe,
 				  u8 result, struct sk_buff *skb)
 {
 	struct nci_conn_info    *conn_info;
-	u8 status = result;
 
 	conn_info = ndev->hci_dev->conn_info;
-	if (!conn_info) {
-		status = NCI_STATUS_REJECTED;
-		goto exit;
-	}
-
-	conn_info->rx_skb = skb;
+	if (conn_info)
+		conn_info->rx_skb = skb;
 
-exit:
 	nci_req_complete(ndev, NCI_STATUS_OK);
 }
 
-- 
2.7.0


