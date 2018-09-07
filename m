Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D695C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5AE2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5AE2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbeIHCQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:16:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbeIHCQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:16:20 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ADE64D6B;
        Fri,  7 Sep 2018 21:33:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Palma <david.palma@ntnu.no>,
        Rabi Narayan Sahoo <rabinarayans0828@gmail.com>,
        Alexander Aring <aring@mojatatu.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 4.9 02/63] net: mac802154: tx: expand tailroom if necessary
Date:   Fri,  7 Sep 2018 23:09:33 +0200
Message-Id: <20180907211013.089716732@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aring@mojatatu.com>

commit f9c52831133050c6b82aa8b6831c92da2bbf2a0b upstream.

This patch is necessary if case of AF_PACKET or other socket interface
which I am aware of it and didn't allocated the necessary room.

Reported-by: David Palma <david.palma@ntnu.no>
Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac802154/tx.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -63,8 +63,21 @@ ieee802154_tx(struct ieee802154_local *l
 	int ret;
 
 	if (!(local->hw.flags & IEEE802154_HW_TX_OMIT_CKSUM)) {
-		u16 crc = crc_ccitt(0, skb->data, skb->len);
+		struct sk_buff *nskb;
+		u16 crc;
 
+		if (unlikely(skb_tailroom(skb) < IEEE802154_FCS_LEN)) {
+			nskb = skb_copy_expand(skb, 0, IEEE802154_FCS_LEN,
+					       GFP_ATOMIC);
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
 


