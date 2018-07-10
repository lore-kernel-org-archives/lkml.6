Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E261BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E0F20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E0F20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbeGJS0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:26:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43820 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbeGJS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:26:47 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17FF4E7D;
        Tue, 10 Jul 2018 18:26:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 08/23] net/sonic: Use dma_mapping_error()
Date:   Tue, 10 Jul 2018 20:24:41 +0200
Message-Id: <20180710182309.230532185@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182308.877332304@linuxfoundation.org>
References: <20180710182308.877332304@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 26de0b76d9ba3200f09c6cb9d9618bda338be5f7 ]

With CONFIG_DMA_API_DEBUG=y, calling sonic_open() produces the
message, "DMA-API: device driver failed to check map error".
Add the missing dma_mapping_error() call.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/natsemi/sonic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -71,7 +71,7 @@ static int sonic_open(struct net_device
 	for (i = 0; i < SONIC_NUM_RRS; i++) {
 		dma_addr_t laddr = dma_map_single(lp->device, skb_put(lp->rx_skb[i], SONIC_RBSIZE),
 		                                  SONIC_RBSIZE, DMA_FROM_DEVICE);
-		if (!laddr) {
+		if (dma_mapping_error(lp->device, laddr)) {
 			while(i > 0) { /* free any that were mapped successfully */
 				i--;
 				dma_unmap_single(lp->device, lp->rx_laddr[i], SONIC_RBSIZE, DMA_FROM_DEVICE);


