Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CABC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674BA25293
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674BA25293
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932988AbeF1Dnv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:43:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753024AbeF1DlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:41:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 53FB5B1248E14;
        Thu, 28 Jun 2018 11:40:58 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 11:40:53 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 05/11] net: hns3: add unlikely for error check
Date:   Thu, 28 Jun 2018 12:12:23 +0800
Message-ID: <1530159149-122284-6-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
References: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first bd of a packet is invalid and invalid ring head for tx
IRQ is not offen, they may occur when there is error,
Add unlikely for error check branch is better for performance.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 99bb6a8..1a68952 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1917,7 +1917,7 @@ bool hns3_clean_tx_ring(struct hns3_enet_ring *ring, int budget)
 	if (is_ring_empty(ring) || head == ring->next_to_clean)
 		return true; /* no data to poll */
 
-	if (!is_valid_clean_head(ring, head)) {
+	if (unlikely(!is_valid_clean_head(ring, head))) {
 		netdev_err(netdev, "wrong head (%d, %d-%d)\n", head,
 			   ring->next_to_use, ring->next_to_clean);
 
@@ -2174,7 +2174,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
 
 	/* Check valid BD */
-	if (!hnae_get_bit(bd_base_info, HNS3_RXD_VLD_B))
+	if (unlikely(!hnae_get_bit(bd_base_info, HNS3_RXD_VLD_B)))
 		return -EFAULT;
 
 	va = (unsigned char *)desc_cb->buf + desc_cb->page_offset;
-- 
2.9.3

