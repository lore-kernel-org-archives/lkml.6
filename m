Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09769C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C103F2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaQgoZpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C103F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388521AbeKLJ0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:26:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388205AbeKLIT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:58 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0884F2241B;
        Sun, 11 Nov 2018 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975402;
        bh=H5dqA70ss3Ia46ag+hXXPkZNsnqKPEnMNPfqjhtA9vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FaQgoZpH4vtOo/1tn7wVJ0gJc8DDDjNoGniUTUVMO6wzrCh7YNYPZFmuBty3NEVu8
         vj/SYi65yspg8DqL8LT9paPd+NTTy0tXDelPedCo3UFs141uMMJJVm/Kqa5o76h9gf
         7uMm74l4E63tp1zttLn5wm7fFPnB/TSOkdn/JHAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 100/350] net: hns3: Fix for packet buffer setting bug
Date:   Sun, 11 Nov 2018 14:19:24 -0800
Message-Id: <20181111221711.288346472@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1669,11 +1669,13 @@ static int hclge_tx_buffer_calc(struct h
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
@@ -1692,13 +1694,13 @@ static int hclge_rx_buffer_calc(struct h
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
@@ -1730,11 +1732,11 @@ static int hclge_rx_buffer_calc(struct h
 
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


