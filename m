Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605DBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141182084A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141182084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeHWM0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:26:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeHWM0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:26:54 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0507EC83;
        Thu, 23 Aug 2018 08:58:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 164/324] ipvlan: call dev_change_flags when ipvlan mode is reset
Date:   Thu, 23 Aug 2018 09:53:50 +0200
Message-Id: <20180823075004.279319516@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 5dc2d3996a8b221c20dd0900bdad45031a572530 ]

After we change the ipvlan mode from l3 to l2, or vice versa, we only
reset IFF_NOARP flag, but don't flush the ARP table cache, which will
cause eth->h_dest to be equal to eth->h_source in ipvlan_xmit_mode_l2().
Then the message will not come out of host.

Here is the reproducer on local host:

ip link set eth1 up
ip addr add 192.168.1.1/24 dev eth1
ip link add link eth1 ipvlan1 type ipvlan mode l3

ip netns add net1
ip link set ipvlan1 netns net1
ip netns exec net1 ip link set ipvlan1 up
ip netns exec net1 ip addr add 192.168.2.1/24 dev ipvlan1

ip route add 192.168.2.0/24 via 192.168.1.2
ping 192.168.2.2 -c 2

ip netns exec net1 ip link set ipvlan1 type ipvlan mode l2
ping 192.168.2.2 -c 2

Add the same configuration on remote host. After we set the mode to l2,
we could find that the src/dst MAC addresses are the same on eth1:

21:26:06.648565 00:b7:13:ad:d3:05 > 00:b7:13:ad:d3:05, ethertype IPv4 (0x0800), length 98: (tos 0x0, ttl 64, id 58356, offset 0, flags [DF], proto ICMP (1), length 84)
    192.168.2.1 > 192.168.2.2: ICMP echo request, id 22686, seq 1, length 64

Fix this by calling dev_change_flags(), which will call netdevice notifier
with flag change info.

v2:
a) As pointed out by Wang Cong, check return value for dev_change_flags() when
change dev flags.
b) As suggested by Stefano and Sabrina, move flags setting before l3mdev_ops.
So we don't need to redo ipvlan_{, un}register_nf_hook() again in err path.

Reported-by: Jianlin Shi <jishi@redhat.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Fixes: 2ad7bf3638411 ("ipvlan: Initial check-in of the IPVLAN driver.")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ipvlan/ipvlan_main.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -75,10 +75,23 @@ static int ipvlan_set_port_mode(struct i
 {
 	struct ipvl_dev *ipvlan;
 	struct net_device *mdev = port->dev;
-	int err = 0;
+	unsigned int flags;
+	int err;
 
 	ASSERT_RTNL();
 	if (port->mode != nval) {
+		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
+			flags = ipvlan->dev->flags;
+			if (nval == IPVLAN_MODE_L3 || nval == IPVLAN_MODE_L3S) {
+				err = dev_change_flags(ipvlan->dev,
+						       flags | IFF_NOARP);
+			} else {
+				err = dev_change_flags(ipvlan->dev,
+						       flags & ~IFF_NOARP);
+			}
+			if (unlikely(err))
+				goto fail;
+		}
 		if (nval == IPVLAN_MODE_L3S) {
 			/* New mode is L3S */
 			err = ipvlan_register_nf_hook(read_pnet(&port->pnet));
@@ -86,21 +99,28 @@ static int ipvlan_set_port_mode(struct i
 				mdev->l3mdev_ops = &ipvl_l3mdev_ops;
 				mdev->priv_flags |= IFF_L3MDEV_MASTER;
 			} else
-				return err;
+				goto fail;
 		} else if (port->mode == IPVLAN_MODE_L3S) {
 			/* Old mode was L3S */
 			mdev->priv_flags &= ~IFF_L3MDEV_MASTER;
 			ipvlan_unregister_nf_hook(read_pnet(&port->pnet));
 			mdev->l3mdev_ops = NULL;
 		}
-		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
-			if (nval == IPVLAN_MODE_L3 || nval == IPVLAN_MODE_L3S)
-				ipvlan->dev->flags |= IFF_NOARP;
-			else
-				ipvlan->dev->flags &= ~IFF_NOARP;
-		}
 		port->mode = nval;
 	}
+	return 0;
+
+fail:
+	/* Undo the flags changes that have been done so far. */
+	list_for_each_entry_continue_reverse(ipvlan, &port->ipvlans, pnode) {
+		flags = ipvlan->dev->flags;
+		if (port->mode == IPVLAN_MODE_L3 ||
+		    port->mode == IPVLAN_MODE_L3S)
+			dev_change_flags(ipvlan->dev, flags | IFF_NOARP);
+		else
+			dev_change_flags(ipvlan->dev, flags & ~IFF_NOARP);
+	}
+
 	return err;
 }
 


