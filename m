Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EFEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED22221905
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499226;
	bh=ux3LlgsOWX42zrVPz0W+U3QMMEsBW6XW0OpkHNLc51E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g1x7C7EuXyfkBR2mTTpnINy+NjJs3IcuuUHuAby1l7thPdLQTvEJykygwC49T6YiV
	 Nk++IXkuNNRGfsAftekGxYtdsKtN/bZ6XpQ1twz8k7qfVaAsz+omNqw+LLo9X54mXt
	 WnLN3oKz80VUs3idN2h21eDgDz4EP2lSj0Ww3CnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392419AbfBRONo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392379AbfBRONh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:13:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 110D321905;
        Mon, 18 Feb 2019 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499216;
        bh=ux3LlgsOWX42zrVPz0W+U3QMMEsBW6XW0OpkHNLc51E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZoUYd3DY3+ss/NMyKTzcSrjTlUMFbEzdDVoTOIHcZuMQrrtgMI+wDVRRTLnuakRG
         NDlGp+Es89B50hh1DSDgjnIWBcwkcfQxu+9kPLG76KivZpY0H5Q9Rlxu0TcTLDnjP2
         Y7yowF0Wuu5df8jVKB+3E+LMxER5+Xr5yGhFTEKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        James Hughes <james.hughes@raspberrypi.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3.18 106/108] kaweth: use skb_cow_head() to deal with cloned skbs
Date:   Mon, 18 Feb 2019 14:44:42 +0100
Message-Id: <20190218133524.581030970@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -812,18 +812,12 @@ static netdev_tx_t kaweth_start_xmit(str
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


