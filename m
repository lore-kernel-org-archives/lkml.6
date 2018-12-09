Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD090C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1E620661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1E620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeLIWLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:11:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37638 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727754AbeLIWLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:11:07 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73I-0002ij-I7; Sun, 09 Dec 2018 21:55:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003Lm-7Q; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Rabi Narayan Sahoo" <rabinarayans0828@gmail.com>,
        "Stefan Schmidt" <stefan@datenfreihafen.org>,
        "Alexander Aring" <aring@mojatatu.com>,
        "David Palma" <david.palma@ntnu.no>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.966357251@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 107/328] net: mac802154: tx: expand tailroom if necessary
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aring@mojatatu.com>

commit f9c52831133050c6b82aa8b6831c92da2bbf2a0b upstream.

This patch is necessary if case of AF_PACKET or other socket interface
which I am aware of it and didn't allocated the necessary room.

Reported-by: David Palma <david.palma@ntnu.no>
Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
Signed-off-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
[bwh: Backported to 3.16:
 - Substitute literal number for IEEE802154_FCS_LEN
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -96,8 +96,20 @@ netdev_tx_t mac802154_tx(struct mac80215
 	mac802154_monitors_rx(mac802154_to_priv(&priv->hw), skb);
 
 	if (!(priv->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
-		u16 crc = crc_ccitt(0, skb->data, skb->len);
+		struct sk_buff *nskb;
+		u16 crc;
 
+		if (unlikely(skb_tailroom(skb) < 2)) {
+			nskb = skb_copy_expand(skb, 0, 2, GFP_ATOMIC);
+			if (likely(nskb)) {
+				consume_skb(skb);
+				skb = nskb;
+			} else {
+				goto err_tx;
+			}
+		}
+
+		crc = crc_ccitt(0, skb->data, skb->len);
 		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
 

