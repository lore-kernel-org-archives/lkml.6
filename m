Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E849C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFD020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFD020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeLIWEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:04:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36744 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727191AbeLIWEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:04:00 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73I-0002iq-Il; Sun, 09 Dec 2018 21:55:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003Lh-64; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Alexander Aring" <alex.aring@gmail.com>,
        "Marcel Holtmann" <marcel@holtmann.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.55747507@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 106/328] mac802154: tx: use put_unaligned_le16 for
 copy crc
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

From: Alexander Aring <alex.aring@gmail.com>

commit 061ef8f915988839b12460c47ebfcf3700e124f0 upstream.

This patch replaces the memcpy with a put_unaligned_le16. The placement
of crc inside of PSDU can also be unaligned. With memcpy this can fail
on some architectures.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/mac802154/tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -24,6 +24,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/crc-ccitt.h>
+#include <asm/unaligned.h>
 
 #include <net/ieee802154_netdev.h>
 #include <net/mac802154.h>
@@ -95,9 +96,9 @@ netdev_tx_t mac802154_tx(struct mac80215
 	mac802154_monitors_rx(mac802154_to_priv(&priv->hw), skb);
 
 	if (!(priv->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
-		__le16 crc = cpu_to_le16(crc_ccitt(0, skb->data, skb->len));
+		u16 crc = crc_ccitt(0, skb->data, skb->len);
 
-		memcpy(skb_put(skb, 2), &crc, 2);
+		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
 
 	if (skb_cow_head(skb, priv->hw.extra_tx_headroom))

