Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F7EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE5A206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE5A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbeGTNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:22:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbeGTNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:22:32 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 53291C96;
        Fri, 20 Jul 2018 12:32:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 32/92] net: mvneta: fix the Rx desc DMA address in the Rx path
Date:   Fri, 20 Jul 2018 14:13:36 +0200
Message-Id: <20180720121419.853291413@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 271f7ff5aa5a73488b7a9d8b84b5205fb5b2f7cc ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvneta.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1959,7 +1959,7 @@ static int mvneta_rx_swbm(struct mvneta_
 		rx_bytes = rx_desc->data_size - (ETH_FCS_LEN + MVNETA_MH_SIZE);
 		index = rx_desc - rxq->descs;
 		data = rxq->buf_virt_addr[index];
-		phys_addr = rx_desc->buf_phys_addr;
+		phys_addr = rx_desc->buf_phys_addr - pp->rx_offset_correction;
 
 		if (!mvneta_rxq_desc_is_first_last(rx_status) ||
 		    (rx_status & MVNETA_RXD_ERR_SUMMARY)) {


