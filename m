Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E020848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdonf6fK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412E020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbeKCECI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbeKCECF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:02:05 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A8662082D;
        Fri,  2 Nov 2018 18:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184829;
        bh=RgpCeq2ojEiP3p3P0b2kdI1ydHjxf0Bn34GEqW8DndE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mdonf6fKS16AJcbpEZASWF7z92RRYb/Jh6Hn28Cb2PRDaOkhdcVVE/GIDUTbX7UtK
         i9xSPrrarrxeaeQOh+3uaEMWcFyowuE4J5mzz+yCIhMtdooRgHtbSUl/Xm95xQ/lw7
         Y1mHDb48h0B3W3H9oKfMd/2RFhTHDsPzhFaLJfCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arthur Kiyanovski <akiyano@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 103/143] net: ena: fix NULL dereference due to untimely napi initialization
Date:   Fri,  2 Nov 2018 19:34:48 +0100
Message-Id: <20181102182906.096144529@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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
index 08c9c99a8331..3c7813f04962 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1571,8 +1571,6 @@ static int ena_up_complete(struct ena_adapter *adapter)
 	if (rc)
 		return rc;
 
-	ena_init_napi(adapter);
-
 	ena_change_mtu(adapter->netdev, adapter->netdev->mtu);
 
 	ena_refill_all_rx_bufs(adapter);
@@ -1726,6 +1724,13 @@ static int ena_up(struct ena_adapter *adapter)
 
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



