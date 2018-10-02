Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDB8C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF2E2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF2E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbeJBUcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:32:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35174 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbeJBUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:26 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EE8BF5AA;
        Tue,  2 Oct 2018 13:34:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 058/137] ath10k: protect ath10k_htt_rx_ring_free with rx_ring.lock
Date:   Tue,  2 Oct 2018 06:24:19 -0700
Message-Id: <20181002132502.582670848@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Greear <greearb@candelatech.com>

[ Upstream commit 168f75f11fe68455e0d058a818ebccfc329d8685 ]

While debugging driver crashes related to a buggy firmware
crashing under load, I noticed that ath10k_htt_rx_ring_free
could be called without being under lock.  I'm not sure if this
is the root cause of the crash or not, but it seems prudent to
protect it.

Originally tested on 4.16+ kernel with ath10k-ct 10.4 firmware
running on 9984 NIC.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -215,11 +215,12 @@ int ath10k_htt_rx_ring_refill(struct ath
 	spin_lock_bh(&htt->rx_ring.lock);
 	ret = ath10k_htt_rx_ring_fill_n(htt, (htt->rx_ring.fill_level -
 					      htt->rx_ring.fill_cnt));
-	spin_unlock_bh(&htt->rx_ring.lock);
 
 	if (ret)
 		ath10k_htt_rx_ring_free(htt);
 
+	spin_unlock_bh(&htt->rx_ring.lock);
+
 	return ret;
 }
 
@@ -231,7 +232,9 @@ void ath10k_htt_rx_free(struct ath10k_ht
 	skb_queue_purge(&htt->rx_in_ord_compl_q);
 	skb_queue_purge(&htt->tx_fetch_ind_q);
 
+	spin_lock_bh(&htt->rx_ring.lock);
 	ath10k_htt_rx_ring_free(htt);
+	spin_unlock_bh(&htt->rx_ring.lock);
 
 	dma_free_coherent(htt->ar->dev,
 			  (htt->rx_ring.size *


