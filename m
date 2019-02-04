Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD4DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58DD217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277457;
	bh=OJWVK0coh+9poardxakNUk4i9WABBaCoX3f37sWtyZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zRJrOxFutBezjgOrJgYLOp/59cdBttKGfJzRpcXHkW+jyukppBNiO+PRrWfhTF3wg
	 /W5KtW/FwviTQ0yzKab0xlw7LUdvG+IrznCCfFqnDYAv9bsXEj0251BygG865yG7E9
	 RB6Djhx5hdCoTiSn1pDM767wesOGKeKRJQ9ywqKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbfBDKuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbfBDKuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B277217FA;
        Mon,  4 Feb 2019 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277450;
        bh=OJWVK0coh+9poardxakNUk4i9WABBaCoX3f37sWtyZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=go3SNVbELrlh6YWfhMKF4g/+WUc6VbifqB6EzSt4sCyo4xLEUqHoBuhKW+ztA2Yae
         QXWYtvm4ylQqVkYIzfVNsAoQnmcDZkO5PWFocDjiN/g5TETVT48WO9Mkkvjn0RfPqN
         aESHQDvK+oRwYp64B4WYS4fE0kN7iYCE3Pio+o4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Brendan Galloway <brendan.galloway@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 08/80] net/ipv6: dont return positive numbers when nothing was dumped
Date:   Mon,  4 Feb 2019 11:36:28 +0100
Message-Id: <20190204103621.371850870@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 1518039f6b5ac794313c24c76f85cead0cd60f6c ]

in6_dump_addrs() returns a positive 1 if there was nothing to dump.
This return value can not be passed as return from inet6_dump_addr()
as is, because it will confuse rtnetlink, resulting in NLMSG_DONE
never getting set:

$ ip addr list dev lo
EOF on netlink
Dump terminated

v2: flip condition to avoid a new goto (DaveA)

Fixes: 7c1e8a3817c5 ("netlink: fixup regression in RTM_GETADDR")
Reported-by: Brendan Galloway <brendan.galloway@netronome.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Tested-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5120,6 +5120,8 @@ static int inet6_dump_addr(struct sk_buf
 			if (idev) {
 				err = in6_dump_addrs(idev, skb, cb, s_ip_idx,
 						     &fillargs);
+				if (err > 0)
+					err = 0;
 			}
 			goto put_tgt_net;
 		}


