Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E64C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9207218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357726;
	bh=oSFAlD8KNnB/Xleoz9VtWlMPcttqDHCMEbxq3loW6sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zmWngvEEsbVI911zsM/L6fDOmaZmqFnSQNeX4rgqAMFdrxofuX6AsECk0+NnxvFMm
	 eIgGWpVlYHRDPBylIK7towHWpFkXfSW4klHaACqnFyWrsSMByPs8DXecaOaiGzifBC
	 X8cvkis5ECI5ix1Zc+Goz/YS8Tr9jI2N7Slh1cw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfAXTWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729346AbfAXTV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:21:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3277D218CD;
        Thu, 24 Jan 2019 19:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357717;
        bh=oSFAlD8KNnB/Xleoz9VtWlMPcttqDHCMEbxq3loW6sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVTyFCyA6mNC975hFdbSDU+t34c/JTbEQUBxltiONjDir4uQiW1QjZJfai/x6BkNz
         pmcEeWIxqn13aGW2zZ5ZNbzQBTspBkBiRXDVn5jSuY6h00J8aQrdG0NvRN7zXH7GtD
         wV+i/ZTco1mVQ0YJQU8WG9zRLx2lkKunhHrKx2mg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 16/52] packet: Do not leak dev refcounts on error exit
Date:   Thu, 24 Jan 2019 20:19:40 +0100
Message-Id: <20190124190143.761944530@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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
@@ -2276,7 +2276,7 @@ static int tpacket_snd(struct packet_soc
 		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out;
+			goto out_put;
 	}
 
 	err = -ENXIO;
@@ -2439,7 +2439,7 @@ static int packet_snd(struct socket *soc
 		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(sk), saddr->sll_ifindex);
 		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out;
+			goto out_unlock;
 	}
 
 	err = -ENXIO;


