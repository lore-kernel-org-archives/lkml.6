Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D531AC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30C920870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078406;
	bh=NK31MLpZl/tO5KSXcZeb6tBSEOUdMqe990Nto6UnYz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mlyXUQoH+prpkcaQDYViHSS9q7YVuZGfPdtWrnTeKCaUlX4vgYiDiM6ggF42m/dnu
	 LFPjoPWSGs+uOoW838TKEvnMcVRR/1XLu6R7aQQr5hmKvIgw4kk9b8pvG5GAxhszzA
	 GTuFtEgJnJlCoQ5Y6qFbS5Uxcm6XWfUaNKr0Xqvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfAUNqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:46:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbfAUNql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:46:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76F1F21019;
        Mon, 21 Jan 2019 13:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078400;
        bh=NK31MLpZl/tO5KSXcZeb6tBSEOUdMqe990Nto6UnYz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=if8jCQ4HEIjAExJHd3QLV1l9mbxyN9V0wHlnHduAzoByhMynno2isbI53lbDciLx9
         VmyNSWmpD0EAu0Aw7lt0C7J3QXQtViyoCc8HvqQCv16FBB5GnLvtP+tnp9Vx40UPJa
         LALCRmTkkYbDlnqlSKScdRuy/qkwE4t8g4zbPzr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 019/111] packet: Do not leak dev refcounts on error exit
Date:   Mon, 21 Jan 2019 14:42:13 +0100
Message-Id: <20190121122457.841173346@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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
@@ -2628,7 +2628,7 @@ static int tpacket_snd(struct packet_soc
 		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out;
+			goto out_put;
 	}
 
 	err = -ENXIO;
@@ -2828,7 +2828,7 @@ static int packet_snd(struct socket *soc
 		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out;
+			goto out_unlock;
 	}
 
 	err = -ENXIO;


