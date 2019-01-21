Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D20C2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C740020879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080115;
	bh=Lj1r9kN4fbE0OcdiJWWSHr7jdoFgyrq0Ydj3VzyUI8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ogFDiasKXKZELCXrd1vNP83hxjntXwVFm3ig1W1jyoJXCEsuE0Vpus/wKhny3Alut
	 +bktdUMCPyS6RQp7kJ5U7rscH0yVukIF+rXEnvFsEtY5DteVm963wkBLUx3oJKXdIf
	 hu/M7DEga4nemqvfQfegm3mNXnin2Di3b3XfJdu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfAUOPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730872AbfAUNvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:51:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 626B320989;
        Mon, 21 Jan 2019 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078706;
        bh=Lj1r9kN4fbE0OcdiJWWSHr7jdoFgyrq0Ydj3VzyUI8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUE9ByfyOaDIjHYEoszefWpiO8TJ9zWSCHD5Kjy/VJ+hsy8ylpwAf8mWZIQLAxGeF
         43vAZmPFcri2lU0qia3zOcMDsUvmVsbxFxYseCu+3Pc80xZVmm6iFNq9RdRLr3gKj6
         I99YXEtwDa0ZKsWT1/+YDpyKFBcMLieQpP2q6doo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 15/59] packet: Do not leak dev refcounts on error exit
Date:   Mon, 21 Jan 2019 14:43:40 +0100
Message-Id: <20190121122458.238488179@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2666,7 +2666,7 @@ static int tpacket_snd(struct packet_soc
 		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out;
+			goto out_put;
 	}
 
 	err = -ENXIO;
@@ -2866,7 +2866,7 @@ static int packet_snd(struct socket *soc
 		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out;
+			goto out_unlock;
 	}
 
 	err = -ENXIO;


