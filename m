Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEBEC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA10320861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079830;
	bh=W0jUWP8stA44jKMDWvMUqc3SmOv3crdsTcUx1fopP8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uAfzS61CD+hZJ0g+buhZ8haqCXq04+plQLi/3KMH/ZNXO5naIRPP34hZFNhb6qeL/
	 aI1WbXTx14AoIkLC6OUa9oNndzS7E9Rk1+9/yXo3L3/w8y+F2QOw1y50w+COyUL3Xh
	 Nd5ZnvjGDD9mqqfSeZ4Dh759rbfMm+XiB8By0vw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfAUOK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731537AbfAUNyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:54:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D7A020861;
        Mon, 21 Jan 2019 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078877;
        bh=W0jUWP8stA44jKMDWvMUqc3SmOv3crdsTcUx1fopP8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pj/JWXa1D5Jnq4nDDSjXVXe7S6Wqx6Kc44MsAgAlif6OwfxXPT9Ud+4dIl3pIzflP
         4ycJzbB1t8ho2pmudW+k/tt7iRmFDqnagsNScaI3FHkaa1tv9nx4NRehZE2sJi6vww
         DuQvufQbGZPLGM1acZEwk/eiApxnJyxD8zoreA4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 15/51] packet: Do not leak dev refcounts on error exit
Date:   Mon, 21 Jan 2019 14:44:11 +0100
Message-Id: <20190121122454.916353666@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

From: Jason Gunthorpe <jgg@mellanox.com>

[ Upstream commit d972f3dce8d161e2142da0ab1ef25df00e2f21a9 ]

'dev' is non NULL when the addr_len check triggers so it must goto a label
that does the dev_put otherwise dev will have a leaked refcount.

This bug causes the ib_ipoib module to become unloadable when using
systemd-network as it triggers this check on InfiniBand links.

Fixes: 99137b7888f4 ("packet: validate address length")
Reported-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2663,7 +2663,7 @@ static int tpacket_snd(struct packet_soc
 		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out;
+			goto out_put;
 	}
 
 	err = -ENXIO;
@@ -2862,7 +2862,7 @@ static int packet_snd(struct socket *soc
 		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out;
+			goto out_unlock;
 	}
 
 	err = -ENXIO;


