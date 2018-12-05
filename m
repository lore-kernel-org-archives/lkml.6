Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7979BC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A674206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkgoKwHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A674206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeLEKHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbeLEJkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:40:47 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1568820878;
        Wed,  5 Dec 2018 09:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002846;
        bh=jCMRr+lxR8TGpNzuMhMAa6G7cNf3gaivT9ltZ3v4o/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HkgoKwHyzJGL/lUQ9fWbXhvOYp4ItlTU0xQRioi0bmyOOGXZE4bHxOs6/feoBfoSt
         Gb/i9W14wXeyq4R26vCvbpIR+omW0SKD0E29XESQB8s/nJg97VfiY0qxGG04OFIMhr
         wj2DjY1S1wZRsqP4LoN/YPE8CsDQzK6sOtd3NN8g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 086/123] lan743x: fix return value for lan743x_tx_napi_poll
Date:   Wed,  5 Dec 2018 04:35:18 -0500
Message-Id: <20181205093555.5386-86-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 001b5f714c1b..5c3ac70abeca 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1675,7 +1675,7 @@ static int lan743x_tx_napi_poll(struct napi_struct *napi, int weight)
 		netif_wake_queue(adapter->netdev);
 	}
 
-	if (!napi_complete_done(napi, weight))
+	if (!napi_complete(napi))
 		goto done;
 
 	/* enable isr */
@@ -1684,7 +1684,7 @@ static int lan743x_tx_napi_poll(struct napi_struct *napi, int weight)
 	lan743x_csr_read(adapter, INT_STS);
 
 done:
-	return weight;
+	return 0;
 }
 
 static void lan743x_tx_ring_cleanup(struct lan743x_tx *tx)
@@ -1873,9 +1873,9 @@ static int lan743x_tx_open(struct lan743x_tx *tx)
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
-- 
2.17.1

