Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380E1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F370F20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGRO94Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F370F20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeKAIGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbeKAIGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B465B20843;
        Wed, 31 Oct 2018 23:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027183;
        bh=SYlUz+5LaDSURpKfbJR8lBKb/o70zFxoVbwW6Og2P3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGRO94VblgUIcJ/pdX03BRpFN4bNzj/P7YztXBPVEVnY1MA61leRr5v1Y8E74au2w
         gU4rlj6Q0ObhEih0vh3hTn9Veu7p+pE7dBvzIOXDahkxKUCIAH/hbyoy8/kv/Zu8RX
         fHuq/mYmtziRw+WGT/R6iHquQlOHlX89RGXDIbUg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 045/146] net: hns3: Fix for packet buffer setting bug
Date:   Wed, 31 Oct 2018 19:04:00 -0400
Message-Id: <20181031230541.28822-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 996ff91840eb6f288826e472685abde78bac20ea ]

The hardware expects a unit of 128 bytes when setting
packet buffer. When calculating the packet buffer size,
hclge_rx_buffer_calc does not round up the size as a unit
of 128 byte, which may casue packet lost problem when stress
testing.

This patch fixes it by rounding up packet size when calculating.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 8577dfc799ad..023910abc831 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1657,11 +1657,13 @@ static int hclge_tx_buffer_calc(struct hclge_dev *hdev,
 static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 				struct hclge_pkt_buf_alloc *buf_alloc)
 {
-	u32 rx_all = hdev->pkt_buf_size;
+#define HCLGE_BUF_SIZE_UNIT	128
+	u32 rx_all = hdev->pkt_buf_size, aligned_mps;
 	int no_pfc_priv_num, pfc_priv_num;
 	struct hclge_priv_buf *priv;
 	int i;
 
+	aligned_mps = round_up(hdev->mps, HCLGE_BUF_SIZE_UNIT);
 	rx_all -= hclge_get_tx_buff_alloced(buf_alloc);
 
 	/* When DCB is not supported, rx private
@@ -1680,13 +1682,13 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 		if (hdev->hw_tc_map & BIT(i)) {
 			priv->enable = 1;
 			if (hdev->tm_info.hw_pfc_map & BIT(i)) {
-				priv->wl.low = hdev->mps;
-				priv->wl.high = priv->wl.low + hdev->mps;
+				priv->wl.low = aligned_mps;
+				priv->wl.high = priv->wl.low + aligned_mps;
 				priv->buf_size = priv->wl.high +
 						HCLGE_DEFAULT_DV;
 			} else {
 				priv->wl.low = 0;
-				priv->wl.high = 2 * hdev->mps;
+				priv->wl.high = 2 * aligned_mps;
 				priv->buf_size = priv->wl.high;
 			}
 		} else {
@@ -1718,11 +1720,11 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 
 		if (hdev->tm_info.hw_pfc_map & BIT(i)) {
 			priv->wl.low = 128;
-			priv->wl.high = priv->wl.low + hdev->mps;
+			priv->wl.high = priv->wl.low + aligned_mps;
 			priv->buf_size = priv->wl.high + HCLGE_DEFAULT_DV;
 		} else {
 			priv->wl.low = 0;
-			priv->wl.high = hdev->mps;
+			priv->wl.high = aligned_mps;
 			priv->buf_size = priv->wl.high;
 		}
 	}
-- 
2.17.1

