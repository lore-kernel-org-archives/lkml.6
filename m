Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED936C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7A42250E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7A42250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbeKNVxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:53:44 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:60566 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeKNVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:53:25 -0500
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gMtge-000205-HU; Wed, 14 Nov 2018 11:50:24 +0000
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gMtge-0002XV-7Y; Wed, 14 Nov 2018 11:50:24 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, steve.glendinning@shawell.net,
        linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 4/4] usbnet: smsc95xx: check for csum being in last four bytes
Date:   Wed, 14 Nov 2018 11:50:22 +0000
Message-Id: <20181114115022.9584-5-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
References: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manual states that the checksum cannot lie in the last DWORD of the
transmission, so add a basic check for this and fall back to software
checksumming the packet.

This only seems to trigger for ACK packets with no options or data to
return to the other end, and the use of the tx-alignment option makes
it more likely to happen.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Fixes for v2:
- Fix spelling of check at Sergei's suggestion
- Move skb->len check into smsc95xx_can_tx_checksum()
- Change name of smsc95xx_can_checksum to explicitly say it is tx-csum
---
 drivers/net/usb/smsc95xx.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 8f7c473f3260..cc78ef78cc93 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1997,6 +1997,23 @@ static u32 smsc95xx_calc_csum_preamble(struct sk_buff *skb)
 	return (high_16 << 16) | low_16;
 }
 
+/* The TX CSUM won't work if the checksum lies in the last 4 bytes of the
+ * transmission. This is fairly unlikely, only seems to trigger with some
+ * short TCP ACK packets sent.
+ *
+ * Note, this calculation should probably check for the alignment of the
+ * data as well, but a straight check for csum being in the last four bytes
+ * of the packet should be ok for now.
+*/
+static bool smsc95xx_can_tx_checksum(struct sk_buff *skb)
+{
+       unsigned int len = skb->len - skb_checksum_start_offset(skb);
+
+       if (skb->len <= 45)
+	       return false;
+       return skb->csum_offset < (len - (4 + 1));
+}
+
 static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 					 struct sk_buff *skb, gfp_t flags)
 {
@@ -2021,7 +2038,7 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 	tx_cmd_a = tx_cmd_b | TX_CMD_A_FIRST_SEG_ | TX_CMD_A_LAST_SEG_;
 
 	if (csum) {
-		if (skb->len <= 45) {
+		if (!smsc95xx_can_tx_checksum(skb)) {
 			/* workaround - hardware tx checksum does not work
 			 * properly with extremely small packets */
 			long csstart = skb_checksum_start_offset(skb);
-- 
2.19.1

