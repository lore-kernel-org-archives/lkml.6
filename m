Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49AAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCF820871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApBbgU/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCF820871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbeKLIRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731012AbeKLIRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:30 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833FF21582;
        Sun, 11 Nov 2018 22:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975254;
        bh=OtL1vIwBQ7+pfGowdws6SVXiXQKmkUKP4EPSEYTjtF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ApBbgU/lH4Vo9XbMRLiOc4udMzAJ50zPFtnRgO00zHENxPrvhFxUS7o2NJywwisTN
         zu3hT2MNGTcp+CcoNL2BSq3zhdc/dgY1cV4/Ecm4MIFG0nJ4VhxZzOIodc/FRPcNhX
         7aJ3J2L180DaW0rHfM2P+y+LuNeIdegVcMWk57gg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 125/361] wil6210: fix RX buffers release and unmap
Date:   Sun, 11 Nov 2018 14:17:52 -0800
Message-Id: <20181111221637.671021663@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/wil6210/txrx_edma.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -279,9 +279,6 @@ static void wil_move_all_rx_buff_to_free
 		u16 buff_id;
 
 		*d = *_d;
-		pa = wil_rx_desc_get_addr_edma(&d->dma);
-		dmalen = le16_to_cpu(d->dma.length);
-		dma_unmap_single(dev, pa, dmalen, DMA_FROM_DEVICE);
 
 		/* Extract the SKB from the rx_buff management array */
 		buff_id = __le16_to_cpu(d->mac.buff_id);
@@ -291,10 +288,15 @@ static void wil_move_all_rx_buff_to_free
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
@@ -906,6 +908,9 @@ again:
 	wil->rx_buff_mgmt.buff_arr[buff_id].skb = NULL;
 	if (!skb) {
 		wil_err(wil, "No Rx skb at buff_id %d\n", buff_id);
+		/* Move the buffer from the active list to the free list */
+		list_move(&wil->rx_buff_mgmt.buff_arr[buff_id].list,
+			  &wil->rx_buff_mgmt.free);
 		goto again;
 	}
 


