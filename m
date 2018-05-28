Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935299AbeE1KJR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934596AbeE1KJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:09:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 080/185] sit: fix IFLA_MTU ignored on NEWLINK
Date: Mon, 28 May 2018 12:02:01 +0200
Message-Id: <20180528100057.471581620@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 2b3957c34b6d7f03544b12ebbf875eee430745db ]

Commit 128bb975dc3c ("ip6_gre: init dev->mtu and dev->hard_header_len
correctly") fixed IFLA_MTU ignored on NEWLINK for ip6_gre. The same
mtu fix is also needed for sit.

Note that dev->hard_header_len setting for sit works fine, no need to
fix it. sit is actually ipv4 tunnel, it can't call ip6_tnl_change_mtu
to set mtu.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1572,6 +1572,13 @@ static int ipip6_newlink(struct net *src
 	if (err < 0)
 		return err;
 
+	if (tb[IFLA_MTU]) {
+		u32 mtu = nla_get_u32(tb[IFLA_MTU]);
+
+		if (mtu >= IPV6_MIN_MTU && mtu <= 0xFFF8 - dev->hard_header_len)
+			dev->mtu = mtu;
+	}
+
 #ifdef CONFIG_IPV6_SIT_6RD
 	if (ipip6_netlink_6rd_parms(data, &ip6rd))
 		err = ipip6_tunnel_update_6rd(nt, &ip6rd);
