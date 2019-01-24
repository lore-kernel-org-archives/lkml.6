Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6298C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79340218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360630;
	bh=hR4olMqd1NEqG1mWkgRVGZ+rYlMyutcZ9O6dQ/S6ro0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wZj/wApA2yaxdWAnoGD2Chm8yECdHS+2p43hJw1VAWyYMwmnZxRWl4r1BnQQgfFhA
	 WYVOVbyBTPIXIPd9Nmycz9HExDwy07bal2Ta2SKkjBujj5JXs8YounFtF1cw0MiVQD
	 Evg6uJJ9eWUYllIhcKe1eFdbZuVnAVtUHESG42hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfAXT1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbfAXT1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:27:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F37D218FC;
        Thu, 24 Jan 2019 19:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358055;
        bh=hR4olMqd1NEqG1mWkgRVGZ+rYlMyutcZ9O6dQ/S6ro0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qu2sLid748tzB1BLalRmSLu1gpmpU4vB8+c30QzClkL42aEfvB9GVzMd654rtfc6y
         7NMcOLpILur1c7j9DgrDSmPZ71U+tJtwJiyau2IwdKdcrYIcrMUsG5r72G5bpwDqe+
         qyzhLYKf7lLD5qtwdMnVvZ9DFWUzQQ8nY4FimQq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 044/104] packet: Do not leak dev refcounts on error exit
Date:   Thu, 24 Jan 2019 20:19:33 +0100
Message-Id: <20190124190200.350118601@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2514,7 +2514,7 @@ static int tpacket_snd(struct packet_soc
 		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out;
+			goto out_put;
 	}
 
 	err = -ENXIO;
@@ -2683,7 +2683,7 @@ static int packet_snd(struct socket *soc
 		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out;
+			goto out_unlock;
 	}
 
 	err = -ENXIO;


