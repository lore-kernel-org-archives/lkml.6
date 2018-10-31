Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DBAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764772064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw16Hp+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764772064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbeKAIr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728583AbeKAIHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CAB020664;
        Wed, 31 Oct 2018 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027215;
        bh=cve0JzjkBBXhjrqg833vz0Rlg8TWz0LtQLnu86rwY2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gw16Hp+omLNdTGS3KMf4Jk3qDDL+94kSzHrNx5bn+5Focrbq/+c8/LowURL6hJPp9
         Nu53PuDE8E/TB8pMhSREuwNGonBQl+efzN5tnkHA44WT1IUVzsffkqU6cYHYYyxK/f
         RA9o0WrCXWDW0z1Y0Z1+02wc6suXDm1WSzsQNlZY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 080/146] wil6210: fix RX buffers release and unmap
Date:   Wed, 31 Oct 2018 19:04:35 -0400
Message-Id: <20181031230541.28822-80-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maya Erez <merez@codeaurora.org>

[ Upstream commit 84f16fbb62384fb209cd35741d94eb00b5ca2746 ]

RX SKBs are released in both wil6210 rmmod and RX handle.
As there is no lock to protect the buffers DMA unmap,
the SKB pointer in buff_arr is used to check if the buffer
memory was already released.
Setting wil->rx_buff_mgmt.buff_arr[buff_id].skb to NULL before the DMA
memory unmap will prevent duplicate unmapping of the same memory.
Move the buffer ID to the free list also in case the SKB is NULL.

Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/txrx_edma.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index bca61cb44c37..3e7fc2983cbb 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -279,9 +279,6 @@ static void wil_move_all_rx_buff_to_free_list(struct wil6210_priv *wil,
 		u16 buff_id;
 
 		*d = *_d;
-		pa = wil_rx_desc_get_addr_edma(&d->dma);
-		dmalen = le16_to_cpu(d->dma.length);
-		dma_unmap_single(dev, pa, dmalen, DMA_FROM_DEVICE);
 
 		/* Extract the SKB from the rx_buff management array */
 		buff_id = __le16_to_cpu(d->mac.buff_id);
@@ -291,10 +288,15 @@ static void wil_move_all_rx_buff_to_free_list(struct wil6210_priv *wil,
 		}
 		skb = wil->rx_buff_mgmt.buff_arr[buff_id].skb;
 		wil->rx_buff_mgmt.buff_arr[buff_id].skb = NULL;
-		if (unlikely(!skb))
+		if (unlikely(!skb)) {
 			wil_err(wil, "No Rx skb at buff_id %d\n", buff_id);
-		else
+		} else {
+			pa = wil_rx_desc_get_addr_edma(&d->dma);
+			dmalen = le16_to_cpu(d->dma.length);
+			dma_unmap_single(dev, pa, dmalen, DMA_FROM_DEVICE);
+
 			kfree_skb(skb);
+		}
 
 		/* Move the buffer from the active to the free list */
 		list_move(&wil->rx_buff_mgmt.buff_arr[buff_id].list,
@@ -906,6 +908,9 @@ static struct sk_buff *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
 	wil->rx_buff_mgmt.buff_arr[buff_id].skb = NULL;
 	if (!skb) {
 		wil_err(wil, "No Rx skb at buff_id %d\n", buff_id);
+		/* Move the buffer from the active list to the free list */
+		list_move(&wil->rx_buff_mgmt.buff_arr[buff_id].list,
+			  &wil->rx_buff_mgmt.free);
 		goto again;
 	}
 
-- 
2.17.1

