Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C81C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800AE21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216071;
	bh=lcq1Z4cqy0Wl1pJ8Rma7/uBWZj11aNM/dct79nFJbes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bB1z3IRQD33oScm/6Rf/8LkFonMmNakrATu+CD3UaL+cjzrvh2zC7booBKuKQPOUL
	 WW/N2oyntmmMJahN9Ux6iSRy0kOZvtqd+gfgpnBlaLIF8+J3uwSRB5+Bee0U9ZldfW
	 Qx1jiGuD4G0xqLeVmtLm0QUbsI7T6E+wdrP5I7MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbfAKOOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:14:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfAKOO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:14:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7731D214D8;
        Fri, 11 Jan 2019 14:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216068;
        bh=lcq1Z4cqy0Wl1pJ8Rma7/uBWZj11aNM/dct79nFJbes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vl6XtZbQjNrP6VoBzKkRwybhKrTG7yXZiXqmeYDCZS7oGJxhUj5tIHeUrXxy604tW
         VAT8lZzkm574TNKhgdguVMRSKbPXFTY2gJ3tb33c//CWGD+R426i8EMZ8FjuivP7Ah
         4hrJwcqmnA3VeS3CqTU3u0j2t7Rj5Q7J6gAynef8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 10/47] ipv6: explicitly initialize udp6_addr in udp_sock_create6()
Date:   Fri, 11 Jan 2019 15:07:55 +0100
Message-Id: <20190111130957.420881422@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
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
 
@@ -35,6 +35,7 @@ int udp_sock_create6(struct net *net, st
 		goto error;
 
 	if (cfg->peer_udp_port) {
+		memset(&udp6_addr, 0, sizeof(udp6_addr));
 		udp6_addr.sin6_family = AF_INET6;
 		memcpy(&udp6_addr.sin6_addr, &cfg->peer_ip6,
 		       sizeof(udp6_addr.sin6_addr));


