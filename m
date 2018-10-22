Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE40CC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8355920898
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2aQWaN4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8355920898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeJVSjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbeJVSjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:39:45 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B8DB20853;
        Mon, 22 Oct 2018 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203709;
        bh=hfbeKRKpabubDMopwc59uYTNe5JbQCit0+8kdwpNQow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2aQWaN4AIsPdJnIdgZFgMewxG1WBO8gWXuSRISJ9jxY5SpVqJB4ZRTPraugIVeBKT
         PbAOERD1I51QgOB60wcrwWyJJEYF7iSyH8zy0wSFJJagn7XqYbPhdHIqw+Jm0ZlIxh
         UQq5KulTvD5hQkFMq3RD3/Vcb+uh4dMp/OG4J1QY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arthur Kiyanovski <akiyano@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 7/9] net: ena: fix NULL dereference due to untimely napi initialization
Date:   Mon, 22 Oct 2018 06:21:31 -0400
Message-Id: <20181022102133.41222-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102133.41222-1-sashal@kernel.org>
References: <20181022102133.41222-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit 78a55d05def95144ca5fa9a64c49b2a0636a9866 ]

napi poll functions should be initialized before running request_irq(),
to handle a rare condition where there is a pending interrupt, causing
the ISR to fire immediately while the poll function wasn't set yet,
causing a NULL dereference.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 1d92e034febc..0c298878bf46 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1482,8 +1482,6 @@ static int ena_up_complete(struct ena_adapter *adapter)
 	if (rc)
 		return rc;
 
-	ena_init_napi(adapter);
-
 	ena_change_mtu(adapter->netdev, adapter->netdev->mtu);
 
 	ena_refill_all_rx_bufs(adapter);
@@ -1643,6 +1641,13 @@ static int ena_up(struct ena_adapter *adapter)
 
 	ena_setup_io_intr(adapter);
 
+	/* napi poll functions should be initialized before running
+	 * request_irq(), to handle a rare condition where there is a pending
+	 * interrupt, causing the ISR to fire immediately while the poll
+	 * function wasn't set yet, causing a null dereference
+	 */
+	ena_init_napi(adapter);
+
 	rc = ena_request_io_irq(adapter);
 	if (rc)
 		goto err_req_irq;
-- 
2.17.1

