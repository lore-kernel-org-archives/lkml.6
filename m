Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A28C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C770A20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C770A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeIHCI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:08:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46928 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbeIHCI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:08:26 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EE8C6F07;
        Fri,  7 Sep 2018 21:25:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Palma <david.palma@ntnu.no>,
        Rabi Narayan Sahoo <rabinarayans0828@gmail.com>,
        Alexander Aring <aring@mojatatu.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 4.14 01/89] net: 6lowpan: fix reserved space for single frames
Date:   Fri,  7 Sep 2018 23:08:55 +0200
Message-Id: <20180907210852.404092852@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ieee802154/6lowpan/tx.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -265,9 +265,24 @@ netdev_tx_t lowpan_xmit(struct sk_buff *
 	/* We must take a copy of the skb before we modify/replace the ipv6
 	 * header as the header could be used elsewhere
 	 */
-	skb = skb_unshare(skb, GFP_ATOMIC);
-	if (!skb)
-		return NET_XMIT_DROP;
+	if (unlikely(skb_headroom(skb) < ldev->needed_headroom ||
+		     skb_tailroom(skb) < ldev->needed_tailroom)) {
+		struct sk_buff *nskb;
+
+		nskb = skb_copy_expand(skb, ldev->needed_headroom,
+				       ldev->needed_tailroom, GFP_ATOMIC);
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
 
 	ret = lowpan_header(skb, ldev, &dgram_size, &dgram_offset);
 	if (ret < 0) {


