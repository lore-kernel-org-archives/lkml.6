Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeCMPHt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:07:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60358 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeCMPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:07:47 -0400
From: Liran Alon <liran.alon@oracle.com>
To: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: idan.brown@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
Subject: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info only when crossing netns
Date: Tue, 13 Mar 2018 17:07:22 +0200
Message-Id: <1520953642-8145-1-git-send-email-liran.alon@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8830 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130179
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this commit, dev_forward_skb() always cleared packet's
per-network-namespace info. Even if the packet doesn't cross
network namespaces.

The comment above dev_forward_skb() describes that this is done
because the receiving device may be in another network namespace.
However, this case can easily be tested for and therefore we can
scrub packet's per-network-namespace info only when receiving device
is indeed in another network namespace.

Therefore, this commit changes ____dev_forward_skb() to tell
skb_scrub_packet() that skb has crossed network-namespace only in case
transmitting device (skb->dev) network namespace is different then
receiving device (dev) network namespace.

An example of a netdev that use skb_forward_skb() is veth.
Thus, before this commit a packet transmitted from one veth peer to
another when both veth peers are on same network namespace will lose
it's skb->mark. The bug could easily be demonstrated by the following:

ip netns add test
ip netns exec test bash
ip link add veth-a type veth peer name veth-b
ip link set veth-a up
ip link set veth-b up
ip addr add dev veth-a 12.0.0.1/24
tc qdisc add dev veth-a root handle 1 prio
tc qdisc add dev veth-b ingress
tc filter add dev veth-a parent 1: u32 match u32 0 0 action skbedit mark 1337
tc filter add dev veth-b parent ffff: basic match 'meta(nf_mark eq 1337)' action simple "skb->mark 1337!"
dmesg -C
ping 12.0.0.2
dmesg

Before this change, the above will print nothing to dmesg.
After this change, "skb->mark 1337!" will be printed as necessary.

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 include/linux/netdevice.h | 2 +-
 net/core/dev.c            | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5eef6c8e2741..5908f1e31ee2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3371,7 +3371,7 @@ static __always_inline int ____dev_forward_skb(struct net_device *dev,
 		return NET_RX_DROP;
 	}
 
-	skb_scrub_packet(skb, true);
+	skb_scrub_packet(skb, !net_eq(dev_net(dev), dev_net(skb->dev)));
 	skb->priority = 0;
 	return 0;
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 2cedf520cb28..087787dd0a50 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1877,9 +1877,9 @@ int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
  * start_xmit function of one device into the receive queue
  * of another device.
  *
- * The receiving device may be in another namespace, so
- * we have to clear all information in the skb that could
- * impact namespace isolation.
+ * The receiving device may be in another namespace.
+ * In that case, we have to clear all information in the
+ * skb that could impact namespace isolation.
  */
 int dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
 {
-- 
1.9.1
