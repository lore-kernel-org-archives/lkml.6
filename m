Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7828ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E1A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E1A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390095AbeGTNbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:31:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53282 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389343AbeGTNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:01 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4857BCBE;
        Fri, 20 Jul 2018 12:37:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 048/101] net: macb: initialize bp->queues[0].bp for at91rm9200
Date:   Fri, 20 Jul 2018 14:13:54 +0200
Message-Id: <20180720121425.057743700@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit fec9d3b1dc4c481f20f5d2f5aef3ad1cb7504186 ]

The macb driver currently crashes on at91rm9200 with the following trace:

Unable to handle kernel NULL pointer dereference at virtual address 00000014
[...]
[<c031da44>] (macb_rx_desc) from [<c031f2bc>] (at91ether_open+0x2e8/0x3f8)
[<c031f2bc>] (at91ether_open) from [<c041e8d8>] (__dev_open+0x120/0x13c)
[<c041e8d8>] (__dev_open) from [<c041ec08>] (__dev_change_flags+0x17c/0x1a8)
[<c041ec08>] (__dev_change_flags) from [<c041ec4c>] (dev_change_flags+0x18/0x4c)
[<c041ec4c>] (dev_change_flags) from [<c07a5f4c>] (ip_auto_config+0x220/0x10b0)
[<c07a5f4c>] (ip_auto_config) from [<c000a4fc>] (do_one_initcall+0x78/0x18c)
[<c000a4fc>] (do_one_initcall) from [<c0783e50>] (kernel_init_freeable+0x184/0x1c4)
[<c0783e50>] (kernel_init_freeable) from [<c0574d70>] (kernel_init+0x8/0xe8)
[<c0574d70>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)

Solve that by initializing bp->queues[0].bp in at91ether_init (as is done
in macb_init).

Fixes: ae1f2a56d273 ("net: macb: Added support for many RX queues")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3732,6 +3732,8 @@ static int at91ether_init(struct platfor
 	int err;
 	u32 reg;
 
+	bp->queues[0].bp = bp;
+
 	dev->netdev_ops = &at91ether_netdev_ops;
 	dev->ethtool_ops = &macb_ethtool_ops;
 


