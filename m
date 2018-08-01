Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A81C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEE72083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEE72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbeHAUOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:14:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404299AbeHATDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 08E3A1293;
        Wed,  1 Aug 2018 17:10:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gal Pressman <pressmangal@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 316/336] net: ena: Fix use of uninitialized DMA address bits field
Date:   Wed,  1 Aug 2018 18:50:51 +0200
Message-Id: <20180801165041.134923675@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <pressmangal@gmail.com>

[ Upstream commit 101f0cd4f2216d32f1b8a75a2154cf3997484ee2 ]

UBSAN triggers the following undefined behaviour warnings:
[...]
[   13.236124] UBSAN: Undefined behaviour in drivers/net/ethernet/amazon/ena/ena_eth_com.c:468:22
[   13.240043] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
[...]
[   13.744769] UBSAN: Undefined behaviour in drivers/net/ethernet/amazon/ena/ena_eth_com.c:373:4
[   13.748694] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
[...]

When splitting the address to high and low, GENMASK_ULL is used to generate
a bitmask with dma_addr_bits field from io_sq (in ena_com_prepare_tx and
ena_com_add_single_rx_desc).
The problem is that dma_addr_bits is not initialized with a proper value
(besides being cleared in ena_com_create_io_queue).
Assign dma_addr_bits the correct value that is stored in ena_dev when
initializing the SQ.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Gal Pressman <pressmangal@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -333,6 +333,7 @@ static int ena_com_init_io_sq(struct ena
 
 	memset(&io_sq->desc_addr, 0x0, sizeof(io_sq->desc_addr));
 
+	io_sq->dma_addr_bits = ena_dev->dma_addr_bits;
 	io_sq->desc_entry_size =
 		(io_sq->direction == ENA_COM_IO_QUEUE_DIRECTION_TX) ?
 		sizeof(struct ena_eth_io_tx_desc) :


