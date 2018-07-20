Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1CCECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717A5206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717A5206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389534AbeGTN1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:27:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbeGTN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:27:13 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A4EFCB5;
        Fri, 20 Jul 2018 12:35:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Floris Bos <bos@je-eigen-domein.nl>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 52/92] net: lan78xx: Fix race in tx pending skb size calculation
Date:   Fri, 20 Jul 2018 14:13:56 +0200
Message-Id: <20180720121420.984831373@linuxfoundation.org>
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

From: Stefan Wahren <stefan.wahren@i2se.com>

commit dea39aca1d7aef1e2b95b07edeacf04cc8863a2e upstream.

The skb size calculation in lan78xx_tx_bh is in race with the start_xmit,
which could lead to rare kernel oopses. So protect the whole skb walk with
a spin lock. As a benefit we can unlink the skb directly.

This patch was tested on Raspberry Pi 3B+

Link: https://github.com/raspberrypi/linux/issues/2608
Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Floris Bos <bos@je-eigen-domein.nl>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/lan78xx.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3197,6 +3197,7 @@ static void lan78xx_tx_bh(struct lan78xx
 	pkt_cnt = 0;
 	count = 0;
 	length = 0;
+	spin_lock_irqsave(&tqp->lock, flags);
 	for (skb = tqp->next; pkt_cnt < tqp->qlen; skb = skb->next) {
 		if (skb_is_gso(skb)) {
 			if (pkt_cnt) {
@@ -3205,7 +3206,8 @@ static void lan78xx_tx_bh(struct lan78xx
 			}
 			count = 1;
 			length = skb->len - TX_OVERHEAD;
-			skb2 = skb_dequeue(tqp);
+			__skb_unlink(skb, tqp);
+			spin_unlock_irqrestore(&tqp->lock, flags);
 			goto gso_skb;
 		}
 
@@ -3214,6 +3216,7 @@ static void lan78xx_tx_bh(struct lan78xx
 		skb_totallen = skb->len + roundup(skb_totallen, sizeof(u32));
 		pkt_cnt++;
 	}
+	spin_unlock_irqrestore(&tqp->lock, flags);
 
 	/* copy to a single skb */
 	skb = alloc_skb(skb_totallen, GFP_ATOMIC);


