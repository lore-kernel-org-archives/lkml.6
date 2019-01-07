Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EEAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998CB2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866101;
	bh=yhQnisEEuN/SZaaio0jGsKZJTWWT8X9VWItVRaOZ7lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kmCRcZIX8CyT6WSaV+ipvIziL1hG/Uwis8HBUC9v6US875i+9Y9ZD4Gnyd3eBVwCi
	 GZW8U3GeizDNLjYi2AT+eKMd01vIZ7QMtYDFtA90OyUZO1ahITidw7+i0svqVzWiRV
	 qYRkParPgR9m9beCbpg+JzlskySmwmS8rnL1vObA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfAGNBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:01:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbfAGNBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C0021736;
        Mon,  7 Jan 2019 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866095;
        bh=yhQnisEEuN/SZaaio0jGsKZJTWWT8X9VWItVRaOZ7lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvX9Aaqi9vpk5DqoYJXq1WoJmjFoo4m7zISLHPRwfEpXpU1yYnYRhinPbbOG0zjpt
         VjshTXNYwpXYxzPtFripNbFQtoxXJboyJYz5VsoHhEDcZvZRJug5dtWHSMZGUzRDh5
         DgdwAZ4H4E8GRltk23atG2KMv0rzd/zCd+JYeX9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 009/101] ipv6: explicitly initialize udp6_addr in udp_sock_create6()
Date:   Mon,  7 Jan 2019 13:31:57 +0100
Message-Id: <20190107105331.079740240@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit fb24274546310872eeeaf3d1d53799d8414aa0f2 ]

syzbot reported the use of uninitialized udp6_addr::sin6_scope_id.
We can just set ::sin6_scope_id to zero, as tunnels are unlikely
to use an IPv6 address that needs a scope id and there is no
interface to bind in this context.

For net-next, it looks different as we have cfg->bind_ifindex there
so we can probably call ipv6_iface_scope_id().

Same for ::sin6_flowinfo, tunnels don't use it.

Fixes: 8024e02879dd ("udp: Add udp_sock_create for UDP tunnels to open listener socket")
Reported-by: syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com
Cc: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_udp_tunnel.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -15,7 +15,7 @@
 int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 		     struct socket **sockp)
 {
-	struct sockaddr_in6 udp6_addr;
+	struct sockaddr_in6 udp6_addr = {};
 	int err;
 	struct socket *sock = NULL;
 
@@ -42,6 +42,7 @@ int udp_sock_create6(struct net *net, st
 		goto error;
 
 	if (cfg->peer_udp_port) {
+		memset(&udp6_addr, 0, sizeof(udp6_addr));
 		udp6_addr.sin6_family = AF_INET6;
 		memcpy(&udp6_addr.sin6_addr, &cfg->peer_ip6,
 		       sizeof(udp6_addr.sin6_addr));


