Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AD720666
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBmiOVUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AD720666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeLDLdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:33:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbeLDKzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A83214C1;
        Tue,  4 Dec 2018 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920919;
        bh=nPMvCg3ji7G6MT0dfQO3wg2D9wB1JrYhK136ZjvTWnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBmiOVUdfhsEX3XBERlCOEHHeBPhUkSCamhJHq7qUFdMmb9OuTMW6SQnPyyOX6R81
         vgPpfzAd3ta31zzO2iWZzjfgvdj2SerT8XJgPveMgX1YWB+xRUoY1+2thzEFYOJuXH
         gwcjOiiZzBfik1eYy0Y4YE2Mv4WcGED9nscO4wPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 011/139] lan743x: fix return value for lan743x_tx_napi_poll
Date:   Tue,  4 Dec 2018 11:48:12 +0100
Message-Id: <20181204103650.456389414@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryan Whitehead <Bryan.Whitehead@microchip.com>

[ Upstream commit cc5922054131f9abefdc0622ae64fc55e6b2671d ]

The lan743x driver, when under heavy traffic load, has been noticed
to sometimes hang, or cause a kernel panic.

Debugging reveals that the TX napi poll routine was returning
the wrong value, 'weight'. Most other drivers return 0.
And call napi_complete, instead of napi_complete_done.

Additionally when creating the tx napi poll routine.
Changed netif_napi_add, to netif_tx_napi_add.

Updates for v3:
    changed 'fixes' tag to match defined format

Updates for v2:
use napi_complete, instead of napi_complete_done in
    lan743x_tx_napi_poll
use netif_tx_napi_add, instead of netif_napi_add for
    registration of tx napi poll routine

fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Bryan Whitehead <Bryan.Whitehead@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1675,7 +1675,7 @@ static int lan743x_tx_napi_poll(struct n
 		netif_wake_queue(adapter->netdev);
 	}
 
-	if (!napi_complete_done(napi, weight))
+	if (!napi_complete(napi))
 		goto done;
 
 	/* enable isr */
@@ -1684,7 +1684,7 @@ static int lan743x_tx_napi_poll(struct n
 	lan743x_csr_read(adapter, INT_STS);
 
 done:
-	return weight;
+	return 0;
 }
 
 static void lan743x_tx_ring_cleanup(struct lan743x_tx *tx)
@@ -1873,9 +1873,9 @@ static int lan743x_tx_open(struct lan743
 	tx->vector_flags = lan743x_intr_get_vector_flags(adapter,
 							 INT_BIT_DMA_TX_
 							 (tx->channel_number));
-	netif_napi_add(adapter->netdev,
-		       &tx->napi, lan743x_tx_napi_poll,
-		       tx->ring_size - 1);
+	netif_tx_napi_add(adapter->netdev,
+			  &tx->napi, lan743x_tx_napi_poll,
+			  tx->ring_size - 1);
 	napi_enable(&tx->napi);
 
 	data = 0;


