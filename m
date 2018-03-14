Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeCNOD3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:03:29 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42865 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeCNOD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:03:28 -0400
X-Google-Smtp-Source: AG47ELuPhcxT7XvJg5ANJ4y2B1qioql2cy66neXa7s6euZ/1dSUnyt5e3qmYGN/arzm2rtUXfgBHcA==
From: Alexander Potapenko <glider@google.com>
To: dvyukov@google.com, edumazet@google.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netlink: make sure nladdr has correct size in netlink_connect()
Date: Wed, 14 Mar 2018 15:03:22 +0100
Message-Id: <20180314140322.233047-1-glider@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reports use of uninitialized memory in the case when |alen| is
smaller than sizeof(struct netlink_sock), and therefore |nladdr| isn't
fully copied from the userspace.

Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
---
 net/netlink/af_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 07e8478068f0..5d49b39e81c3 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1085,6 +1085,9 @@ static int netlink_connect(struct socket *sock, struct sockaddr *addr,
 	if (addr->sa_family != AF_NETLINK)
 		return -EINVAL;
 
+	if (alen < sizeof(struct netlink_sock))
+		return -EINVAL;
+
 	if ((nladdr->nl_groups || nladdr->nl_pid) &&
 	    !netlink_allowed(sock, NL_CFG_F_NONROOT_SEND))
 		return -EPERM;
-- 
2.16.2.804.g6dcf76e118-goog
