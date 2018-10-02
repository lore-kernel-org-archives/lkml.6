Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50839C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A152089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A152089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJBQJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:09:31 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50409 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeJBQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:09:12 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g7Gx6-0002zb-Di; Tue, 02 Oct 2018 10:26:48 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1g7Gx6-0000Jh-5c; Tue, 02 Oct 2018 10:26:48 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/4] usbnet: smsc95xx: check for csum being in last four bytes
Date:   Tue,  2 Oct 2018 10:26:44 +0100
Message-Id: <20181002092645.1115-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
References: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
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
 drivers/net/usb/smsc95xx.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index d244357bf1ad..46385a4b8b98 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -2003,6 +2003,20 @@ static u32 smsc95xx_calc_csum_preamble(struct sk_buff *skb)
 	return (high_16 << 16) | low_16;
 }
 
+/* The CSUM won't work if the checksum lies in the last 4 bytes of the
+ * transmission. This is fairly unlikely, only seems to trigger with some
+ * short TCP ACK packets sent.
+ *
+ * Note, this calculation should probably check for the alignment of the
+ * data as well, but a straight chec for csum being in the last four bytes
+ * of the packet should be ok for now.
+*/
+static bool smsc95xx_can_checksum(struct sk_buff *skb)
+{
+       unsigned int len = skb->len - skb_checksum_start_offset(skb);
+       return skb->csum_offset < (len - (4 + 1));
+}
+
 static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 					 struct sk_buff *skb, gfp_t flags)
 {
@@ -2031,7 +2045,8 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 	}
 
 	if (csum) {
-		if (skb->len <= 45) {
+		/* note, csum does not work if csum in last DWORD of packet */
+		if (skb->len <= 45 || !smsc95xx_can_checksum(skb)) {
 			/* workaround - hardware tx checksum does not work
 			 * properly with extremely small packets */
 			long csstart = skb_checksum_start_offset(skb);
-- 
2.19.0

