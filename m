Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C006C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C152089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864447;
	bh=jBafVWRSfVPvN+OCi1I4F0Q05nc4boSDxW2dYu3+Mf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yZO8Vkr0GecdqQO/AByhKUm3HVk4clc7eCc+5iwgWvGbaG9wVlCosLhNL8Ux5YxxT
	 6+g9GanQUm5VsQR6/QLv+9wcarXXTPwMoxDTb4xECKNhoYI7eONqwIXnnSyTOV2uh8
	 n9IlcdpiUZop9x29r+J8whRZtR1Oid0L08PCnzAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfAGMeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:34:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfAGMeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 519DD2089F;
        Mon,  7 Jan 2019 12:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864444;
        bh=jBafVWRSfVPvN+OCi1I4F0Q05nc4boSDxW2dYu3+Mf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3e2i5RPfL9kTHKU/ElnPhZyqVrerYwIU2WIVClLu64oMAzb6ni4cEW7ZOG7eaCIj
         am1hQ9z+7IlZRuI0xAS00DxMfz04S87DTWjR7GLE9ydq7dJtb6dusKGurOqjB1dsxh
         KhyI12Wsdj6Qd1VzttEr8fyCilv3U5wqsCGXPwCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 005/145] tap: call skb_probe_transport_header after setting skb->dev
Date:   Mon,  7 Jan 2019 13:30:42 +0100
Message-Id: <20190107104438.019339514@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 8c76e77f9069f10505c08e02646c3ee11ad79038 ]

The BPF flow dissector expects either skb->sk or skb->dev set on
all skbs. Delay flow dissection until after skb->dev is set.

This requires calling from within an rcu read-side critical section.
That is fine, see also the call from tun_xdp_one.

Fixes: d0e13a1488ad ("flow_dissector: lookup netns by skb->sk if skb->dev is NULL")
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tap.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1177,8 +1177,6 @@ static int tap_get_user_xdp(struct tap_q
 			goto err_kfree;
 	}
 
-	skb_probe_transport_header(skb, ETH_HLEN);
-
 	/* Move network header to the right position for VLAN tagged packets */
 	if ((skb->protocol == htons(ETH_P_8021Q) ||
 	     skb->protocol == htons(ETH_P_8021AD)) &&
@@ -1189,6 +1187,7 @@ static int tap_get_user_xdp(struct tap_q
 	tap = rcu_dereference(q->tap);
 	if (tap) {
 		skb->dev = tap->dev;
+		skb_probe_transport_header(skb, ETH_HLEN);
 		dev_queue_xmit(skb);
 	} else {
 		kfree_skb(skb);


