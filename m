Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E072C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359582173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498395;
	bh=J7IZgV5rQHeYcNkalBMpdRaAo/i/QB+uMfCCmVgkOZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TlfnclOYj8GKYpMj0bLi6eT0hY5TMOnJIhSGnJI5x+rt3oVuF3wlLAAi5uyzWudAp
	 KQFMUah0VolhAmkDhEKNxWVkVB1kt3cmU8C36J0lTDoQ6Mg+sLRCbPPAT2yyME/sHc
	 RkWLR9bMV4+91/Qc79hPsy/N4QHuyUOCceoDz3EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbfBRN7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388685AbfBRN7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:59:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE0321901;
        Mon, 18 Feb 2019 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498391;
        bh=J7IZgV5rQHeYcNkalBMpdRaAo/i/QB+uMfCCmVgkOZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWGZLSZqPNWYSratbn21XnwnhfEwn90asWAjnKjoIy4wvy2rEvUX0mBzdAjBrFdTK
         OGhBnczvMlczehvNuyBx3Lj9Sy4xyrdFnCE9tk+9WKA/xyMFrZ358F/jRLRSASArJk
         OgJNHfQFnaTeGdRyKJtGXRHls2copOX6YALrUYLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        James Hughes <james.hughes@raspberrypi.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 54/58] kaweth: use skb_cow_head() to deal with cloned skbs
Date:   Mon, 18 Feb 2019 14:44:15 +0100
Message-Id: <20190218133512.592074350@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 39fba7835aacda65284a86e611774cbba71dac20 upstream.

We can use skb_cow_head() to properly deal with clones,
especially the ones coming from TCP stack that allow their head being
modified. This avoids a copy.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: James Hughes <james.hughes@raspberrypi.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/kaweth.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

--- a/drivers/net/usb/kaweth.c
+++ b/drivers/net/usb/kaweth.c
@@ -803,18 +803,12 @@ static netdev_tx_t kaweth_start_xmit(str
 	}
 
 	/* We now decide whether we can put our special header into the sk_buff */
-	if (skb_cloned(skb) || skb_headroom(skb) < 2) {
-		/* no such luck - we make our own */
-		struct sk_buff *copied_skb;
-		copied_skb = skb_copy_expand(skb, 2, 0, GFP_ATOMIC);
-		dev_kfree_skb_irq(skb);
-		skb = copied_skb;
-		if (!copied_skb) {
-			kaweth->stats.tx_errors++;
-			netif_start_queue(net);
-			spin_unlock_irq(&kaweth->device_lock);
-			return NETDEV_TX_OK;
-		}
+	if (skb_cow_head(skb, 2)) {
+		kaweth->stats.tx_errors++;
+		netif_start_queue(net);
+		spin_unlock_irq(&kaweth->device_lock);
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
 	}
 
 	private_header = (__le16 *)__skb_push(skb, 2);


