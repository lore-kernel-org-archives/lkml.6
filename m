Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932904AbeCMLpr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:45:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37319 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeCMLpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:45:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jiri Pirko <jiri@mellanox.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: fix sysctl_fb_tunnels_only_for_init_net link error
Date: Tue, 13 Mar 2018 12:44:53 +0100
Message-Id: <20180313114515.2037554-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:6GKFQz2FBZp0L1y7yRaZlARK7cwF3DFXy9LUswsE3edCC1OrWNS
 K/RYdSngrBuxIFGQ9EInbBF9eJLAOIDjGdXnQaK3UtqnBmtuc8F6SxRoNAvq1RCJVUD5MTS
 WTmiBMuf/T4Ue3dMIW8vYnOcEGRMQQDbpGhH8jpmSWsGOJxIA3bu+lZ/qdJFWcFZp4ZtRbF
 nneJnQZOPrHOeBePfNQ0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LMjkRuVy+8c=:WkxZZBRSHBSrwjiujxsJ69
 dDOFIUhfSaP/PkKO0a08UVCMcgkCXMNAjMnzMUFusEWpEdg9weLY4P047VXXCN6mGvjeVXwu6
 vUuxt5TA5q+wZkzfqmZ0ahK2kV6gzR8k3wBOLl3y3K2oYOio16VpCF5K27Mc1JP1y54jQXnoi
 yGXwd94rMm3zxzJ9biiZuvzXucIYeHjWjEU9NKkqEPLdZmrAHedt7s9DeDI4u1CHRlD6yvP3Q
 7fBrnuqj94YIoRJE8o2I9WXX7aa5yljWJZNEAKuh76JgoochOd46Q1tTq036k6JjPMHD6M5nM
 6Ycgxf4ff+DvlREATmHs6fQR70+grXTn/gUEIUS6U3pcrAl0eT+eXwHvIKNkzQBvjWaGl9lAY
 YDhSTjeY1VI2fdiZEX7Ge5nAeWg/BNr19ImtWKAFSr6jqWI6MVo2q0uaIgo+7Bjrn8e7abtVh
 4jyKWDYQh9x2wsQqeobIKr/R05GculyrnDbg6+NTmafIcrCLDn6ePmZMIQK63dSdEhQideSbv
 PmocCLN1sqMQvX74nykhp3yfY9UmVlFK3QT4Ps6gVlOXP/xH+EB+iVqqxDWDl49sSQQnTUUTw
 vu75QOBpt0CVj7xnTVSkE2bXGO6uH5y1sI88zLpH8veCA8Zot1eBCkcubLHZypypeOdiAnqJK
 AArNox13e5JPWbPDk2N1V4jK47VQ7IzFi1G48jxv4GjMkP3lTFf0/rxxHTJbaQqSH6dm6xTg0
 4h184YeRNMZs8Y9Jw17/3d5en8EYmGpN7UN6rA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new variable is only available when CONFIG_SYSCTL is enabled,
otherwise we get a link error:

net/ipv4/ip_tunnel.o: In function `ip_tunnel_init_net':
ip_tunnel.c:(.text+0x278b): undefined reference to `sysctl_fb_tunnels_only_for_init_net'
net/ipv6/sit.o: In function `sit_init_net':
sit.c:(.init.text+0x4c): undefined reference to `sysctl_fb_tunnels_only_for_init_net'
net/ipv6/ip6_tunnel.o: In function `ip6_tnl_init_net':
ip6_tunnel.c:(.init.text+0x39): undefined reference to `sysctl_fb_tunnels_only_for_init_net'

This adds an extra condition, keeping the traditional behavior when
CONFIG_SYSCTL is disabled.

Fixes: 79134e6ce2c9 ("net: do not create fallback tunnels for non-default namespaces")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/netdevice.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5fbb9f1da7fd..913b1cc882cf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -589,7 +589,9 @@ extern int sysctl_fb_tunnels_only_for_init_net;
 
 static inline bool net_has_fallback_tunnels(const struct net *net)
 {
-	return net == &init_net || !sysctl_fb_tunnels_only_for_init_net;
+	return net == &init_net ||
+	       !IS_ENABLED(CONFIG_SYSCTL) ||
+	       !sysctl_fb_tunnels_only_for_init_net;
 }
 
 static inline int netdev_queue_numa_node_read(const struct netdev_queue *q)
-- 
2.9.0
