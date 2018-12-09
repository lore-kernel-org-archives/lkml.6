Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC11C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD542081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD542081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeLIWHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:07:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37164 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727274AbeLIWHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:01 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73I-0002if-Jh; Sun, 09 Dec 2018 21:55:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003LS-1O; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Alexander Aring" <aring@mojatatu.com>,
        "Rabi Narayan Sahoo" <rabinarayans0828@gmail.com>,
        "Stefan Schmidt" <stefan@datenfreihafen.org>,
        "David Palma" <david.palma@ntnu.no>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.519503291@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 103/328] net: 6lowpan: fix reserved space for single
 frames
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

commit ac74f87c789af40936a80131c4759f3e72579c3a upstream.

This patch fixes patch add handling to take care tail and headroom for
single 6lowpan frames. We need to be sure we have a skb with the right
head and tailroom for single frames. This patch do it by using
skb_copy_expand() if head and tailroom is not enough allocated by upper
layer.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195059
Reported-by: David Palma <david.palma@ntnu.no>
Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
Signed-off-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
[bwh: Backported to 3.16:
 - s/ldev/dev/
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ieee802154/6lowpan_rtnl.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -388,9 +388,24 @@ static netdev_tx_t lowpan_xmit(struct sk
 	/* We must take a copy of the skb before we modify/replace the ipv6
 	 * header as the header could be used elsewhere
 	 */
-	skb = skb_unshare(skb, GFP_ATOMIC);
-	if (!skb)
-		return NET_XMIT_DROP;
+	if (unlikely(skb_headroom(skb) < dev->needed_headroom ||
+		     skb_tailroom(skb) < dev->needed_tailroom)) {
+		struct sk_buff *nskb;
+
+		nskb = skb_copy_expand(skb, dev->needed_headroom,
+				       dev->needed_tailroom, GFP_ATOMIC);
+		if (likely(nskb)) {
+			consume_skb(skb);
+			skb = nskb;
+		} else {
+			kfree_skb(skb);
+			return NET_XMIT_DROP;
+		}
+	} else {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb)
+			return NET_XMIT_DROP;
+	}
 
 	ret = lowpan_header(skb, dev);
 	if (ret < 0) {

