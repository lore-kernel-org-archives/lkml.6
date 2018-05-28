Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165353AbeE1NYg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163274AbeE1Ksa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:48:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 164/496] ip6_tunnel: fix IFLA_MTU ignored on NEWLINK
Date: Mon, 28 May 2018 11:59:09 +0200
Message-Id: <20180528100326.778418658@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit a6aa80446234ec0ad38eecdb8efc59e91daae565 ]

Commit 128bb975dc3c ("ip6_gre: init dev->mtu and dev->hard_header_len
correctly") fixed IFLA_MTU ignored on NEWLINK for ip6_gre. The same
mtu fix is also needed for ip6_tunnel.

Note that dev->hard_header_len setting for ip6_tunnel works fine,
no need to fix it.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1990,14 +1990,14 @@ static int ip6_tnl_newlink(struct net *s
 {
 	struct net *net = dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
-	struct ip6_tnl *nt, *t;
 	struct ip_tunnel_encap ipencap;
+	struct ip6_tnl *nt, *t;
+	int err;
 
 	nt = netdev_priv(dev);
 
 	if (ip6_tnl_netlink_encap_parms(data, &ipencap)) {
-		int err = ip6_tnl_encap_setup(nt, &ipencap);
-
+		err = ip6_tnl_encap_setup(nt, &ipencap);
 		if (err < 0)
 			return err;
 	}
@@ -2013,7 +2013,11 @@ static int ip6_tnl_newlink(struct net *s
 			return -EEXIST;
 	}
 
-	return ip6_tnl_create2(dev);
+	err = ip6_tnl_create2(dev);
+	if (!err && tb[IFLA_MTU])
+		ip6_tnl_change_mtu(dev, nla_get_u32(tb[IFLA_MTU]));
+
+	return err;
 }
 
 static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
