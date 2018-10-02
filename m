Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB469C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6357E2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6357E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeJBXkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:40:31 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:38360 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeJBXkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:40:31 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g7Nxr-0000Ve-Mm; Tue, 02 Oct 2018 17:56:03 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1g7Nxr-0005Ty-B8; Tue, 02 Oct 2018 17:56:03 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     David.Laight@ACULAB.COM, oneukum@suse.com, davem@davemloft.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] usbnet: smsc95xx: simplify tx_fixup code
Date:   Tue,  2 Oct 2018 17:56:02 +0100
Message-Id: <20181002165602.21033-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <59988ed22559410881addfecf58335eb@AcuMS.aculab.com>
References: <59988ed22559410881addfecf58335eb@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smsc95xx_tx_fixup is doing multiple calls to skb_push() to
put an 8-byte command header onto the packet. It would be easier
to do one skb_push() and then copy the data in once the push is
done.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/smsc95xx.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index cb19aea139d3..813ab93ee2c3 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -2006,6 +2006,7 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 	bool csum = skb->ip_summed == CHECKSUM_PARTIAL;
 	int overhead = csum ? SMSC95XX_TX_OVERHEAD_CSUM : SMSC95XX_TX_OVERHEAD;
 	u32 tx_cmd_a, tx_cmd_b;
+	void *ptr;
 
 	/* We do not advertise SG, so skbs should be already linearized */
 	BUG_ON(skb_shinfo(skb)->nr_frags);
@@ -2019,6 +2020,9 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 		return NULL;
 	}
 
+	tx_cmd_b = (u32)skb->len;
+	tx_cmd_a = tx_cmd_b | TX_CMD_A_FIRST_SEG_ | TX_CMD_A_LAST_SEG_;
+
 	if (csum) {
 		if (skb->len <= 45) {
 			/* workaround - hardware tx checksum does not work
@@ -2035,21 +2039,18 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 			skb_push(skb, 4);
 			cpu_to_le32s(&csum_preamble);
 			memcpy(skb->data, &csum_preamble, 4);
+
+			tx_cmd_a += 4;
+			tx_cmd_b += 4;
+			tx_cmd_b |= TX_CMD_B_CSUM_ENABLE;
 		}
 	}
 
-	skb_push(skb, 4);
-	tx_cmd_b = (u32)(skb->len - 4);
-	if (csum)
-		tx_cmd_b |= TX_CMD_B_CSUM_ENABLE;
-	cpu_to_le32s(&tx_cmd_b);
-	memcpy(skb->data, &tx_cmd_b, 4);
-
-	skb_push(skb, 4);
-	tx_cmd_a = (u32)(skb->len - 8) | TX_CMD_A_FIRST_SEG_ |
-		TX_CMD_A_LAST_SEG_;
-	cpu_to_le32s(&tx_cmd_a);
-	memcpy(skb->data, &tx_cmd_a, 4);
+	ptr = skb_push(skb, 8);
+	tx_cmd_a = cpu_to_le32(tx_cmd_a);
+	tx_cmd_b = cpu_to_le32(tx_cmd_b);
+	memcpy(ptr, &tx_cmd_a, 4);
+	memcpy(ptr+4, &tx_cmd_b, 4);
 
 	return skb;
 }
-- 
2.19.0

