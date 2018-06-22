Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2001DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E900B21CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E900B21CE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeFVIUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:20:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45211 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeFVIUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:20:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF962207EB; Fri, 22 Jun 2018 10:20:00 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8BD1D20794;
        Fri, 22 Jun 2018 10:20:00 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, gregory.clement@bootlin.com, mw@semihalf.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com
Subject: [PATCH net] net: mvneta: fix the Rx desc DMA address in the Rx path
Date:   Fri, 22 Jun 2018 10:15:39 +0200
Message-Id: <20180622081539.16584-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using s/w buffer management, buffers are allocated and DMA mapped.
When doing so on an arm64 platform, an offset correction is applied on
the DMA address, before storing it in an Rx descriptor. The issue is
this DMA address is then used later in the Rx path without removing the
offset correction. Thus the DMA address is wrong, which can led to
various issues.

This patch fixes this by removing the offset correction from the DMA
address retrieved from the Rx descriptor before using it in the Rx path.

Fixes: 8d5047cf9ca2 ("net: mvneta: Convert to be 64 bits compatible")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 17a904cc6a5e..0ad2f3f7da85 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1932,7 +1932,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 		rx_bytes = rx_desc->data_size - (ETH_FCS_LEN + MVNETA_MH_SIZE);
 		index = rx_desc - rxq->descs;
 		data = rxq->buf_virt_addr[index];
-		phys_addr = rx_desc->buf_phys_addr;
+		phys_addr = rx_desc->buf_phys_addr - pp->rx_offset_correction;
 
 		if (!mvneta_rxq_desc_is_first_last(rx_status) ||
 		    (rx_status & MVNETA_RXD_ERR_SUMMARY)) {
-- 
2.17.1

