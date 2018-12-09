Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA8BC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E51820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E51820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeLIWZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:25:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34932 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbeLIVzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:16 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002il-K5; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003LX-2k; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Marcel Holtmann" <marcel@holtmann.org>,
        "Alexander Aring" <alex.aring@gmail.com>,
        "Varka Bhadram" <varkab@cdac.in>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.637853056@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 104/328] mac802154: common tx error path
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

From: Varka Bhadram <varkab@cdac.in>

commit f55889128a776b51581394b20abd0b470304cf95 upstream.

This patch introduce the common error path on failure of Tx by
inserting the label 'err_tx'.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/mac802154/tx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -89,8 +89,7 @@ netdev_tx_t mac802154_tx(struct mac80215
 
 	if (!(priv->phy->channels_supported[page] & (1 << chan))) {
 		WARN_ON(1);
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
+		goto err_tx;
 	}
 
 	mac802154_monitors_rx(mac802154_to_priv(&priv->hw), skb);
@@ -102,12 +101,10 @@ netdev_tx_t mac802154_tx(struct mac80215
 		data[1] = crc >> 8;
 	}
 
-	if (skb_cow_head(skb, priv->hw.extra_tx_headroom)) {
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
-	}
+	if (skb_cow_head(skb, priv->hw.extra_tx_headroom))
+		goto err_tx;
 
-	work = kzalloc(sizeof(struct xmit_work), GFP_ATOMIC);
+	work = kzalloc(sizeof(*work), GFP_ATOMIC);
 	if (!work) {
 		kfree_skb(skb);
 		return NETDEV_TX_BUSY;
@@ -128,4 +125,8 @@ netdev_tx_t mac802154_tx(struct mac80215
 	queue_work(priv->dev_workqueue, &work->work);
 
 	return NETDEV_TX_OK;
+
+err_tx:
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
 }

