Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EFAC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8414F2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbeLXTls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 14:41:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45794 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLXTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 14:41:48 -0500
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gbW6k-0007Yt-BQ; Mon, 24 Dec 2018 19:41:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] drivers/net: appletalk/cops: remove redundant if statement and mask
Date:   Mon, 24 Dec 2018 19:41:46 +0000
Message-Id: <20181224194146.11511-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The two different assignments for pkt_len are actually the same and
so the if statement is redundant and can be removed.  Masking a u8
return value from inb() with 0xFF is also redundant and can also be
emoved.

Similarly, the two different outb calls are identical as the mask
of 0xff on the second outb is redundant since a u8 is being written,
so the if statement is also redundant and can be also removed.

Detected by CoverityScan, CID#1475639 ("Identical code for different
branches")

---

V2: Remove the if statement for the outb calls, thanks to David
Miller for spotting this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/appletalk/cops.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/appletalk/cops.c b/drivers/net/appletalk/cops.c
index bb49f6e40a19..494663a18ce0 100644
--- a/drivers/net/appletalk/cops.c
+++ b/drivers/net/appletalk/cops.c
@@ -777,10 +777,7 @@ static void cops_rx(struct net_device *dev)
         }
 
         /* Get response length. */
-	if(lp->board==DAYNA)
-        	pkt_len = inb(ioaddr) & 0xFF;
-	else
-		pkt_len = inb(ioaddr) & 0x00FF;
+	pkt_len = inb(ioaddr);
         pkt_len |= (inb(ioaddr) << 8);
         /* Input IO code. */
         rsp_type=inb(ioaddr);
@@ -892,10 +889,7 @@ static netdev_tx_t cops_send_packet(struct sk_buff *skb,
 
 	/* Output IO length. */
 	outb(skb->len, ioaddr);
-	if(lp->board == DAYNA)
-               	outb(skb->len >> 8, ioaddr);
-	else
-		outb((skb->len >> 8)&0x0FF, ioaddr);
+	outb(skb->len >> 8, ioaddr);
 
 	/* Output IO code. */
 	outb(LAP_WRITE, ioaddr);
-- 
2.19.1

