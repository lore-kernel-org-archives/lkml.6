Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NSnfLghKGVtgUwAAmS7hNA
	; Thu, 07 Jun 2018 15:07:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0313D608B8; Thu,  7 Jun 2018 15:07:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 643406074D;
	Thu,  7 Jun 2018 15:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 643406074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935937AbeFGPG6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:06:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41552 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935993AbeFGPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:57 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbJ-0005Zx-6R; Thu, 07 Jun 2018 15:09:17 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0003JU-CA; Thu, 07 Jun 2018 15:09:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andy Gospodarek" <andy@greyhouse.net>,
        "Xin Long" <lucien.xin@gmail.com>,
        "Beniamino Galvani" <bgalvani@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.532757702@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 401/410] bonding: move dev_mc_sync after
 master_upper_dev_link in bond_enslave
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit ae42cc62a9f07f1f6979054ed92606b9c30f4a2e upstream.

Beniamino found a crash when adding vlan as slave of bond which is also
the parent link:

  ip link add bond1 type bond
  ip link set bond1 up
  ip link add link bond1 vlan1 type vlan id 80
  ip link set vlan1 master bond1

The call trace is as below:

  [<ffffffffa850842a>] queued_spin_lock_slowpath+0xb/0xf
  [<ffffffffa8515680>] _raw_spin_lock+0x20/0x30
  [<ffffffffa83f6f07>] dev_mc_sync+0x37/0x80
  [<ffffffffc08687dc>] vlan_dev_set_rx_mode+0x1c/0x30 [8021q]
  [<ffffffffa83efd2a>] __dev_set_rx_mode+0x5a/0xa0
  [<ffffffffa83f7138>] dev_mc_sync_multiple+0x78/0x80
  [<ffffffffc084127c>] bond_enslave+0x67c/0x1190 [bonding]
  [<ffffffffa8401909>] do_setlink+0x9c9/0xe50
  [<ffffffffa8403bf2>] rtnl_newlink+0x522/0x880
  [<ffffffffa8403ff7>] rtnetlink_rcv_msg+0xa7/0x260
  [<ffffffffa8424ecb>] netlink_rcv_skb+0xab/0xc0
  [<ffffffffa83fe498>] rtnetlink_rcv+0x28/0x30
  [<ffffffffa8424850>] netlink_unicast+0x170/0x210
  [<ffffffffa8424bf8>] netlink_sendmsg+0x308/0x420
  [<ffffffffa83cc396>] sock_sendmsg+0xb6/0xf0

This is actually a dead lock caused by sync slave hwaddr from master when
the master is the slave's 'slave'. This dead loop check is actually done
by netdev_master_upper_dev_link. However, Commit 1f718f0f4f97 ("bonding:
populate neighbour's private on enslave") moved it after dev_mc_sync.

This patch is to fix it by moving dev_mc_sync after master_upper_dev_link,
so that this loop check would be earlier than dev_mc_sync. It also moves
if (mode == BOND_MODE_8023AD) into if (!bond_uses_primary) clause as an
improvement.

Note team driver also has this issue, I will fix it in another patch.

Fixes: 1f718f0f4f97 ("bonding: populate neighbour's private on enslave")
Reported-by: Beniamino Galvani <bgalvani@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/bonding/bond_main.c | 73 ++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 38 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1414,44 +1414,11 @@ int bond_enslave(struct net_device *bond
 			goto err_close;
 	}
 
-	/* If the mode uses primary, then the following is handled by
-	 * bond_change_active_slave().
-	 */
-	if (!bond_uses_primary(bond)) {
-		/* set promiscuity level to new slave */
-		if (bond_dev->flags & IFF_PROMISC) {
-			res = dev_set_promiscuity(slave_dev, 1);
-			if (res)
-				goto err_close;
-		}
-
-		/* set allmulti level to new slave */
-		if (bond_dev->flags & IFF_ALLMULTI) {
-			res = dev_set_allmulti(slave_dev, 1);
-			if (res)
-				goto err_close;
-		}
-
-		netif_addr_lock_bh(bond_dev);
-
-		dev_mc_sync_multiple(slave_dev, bond_dev);
-		dev_uc_sync_multiple(slave_dev, bond_dev);
-
-		netif_addr_unlock_bh(bond_dev);
-	}
-
-	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
-		/* add lacpdu mc addr to mc list */
-		u8 lacpdu_multicast[ETH_ALEN] = MULTICAST_LACPDU_ADDR;
-
-		dev_mc_add(slave_dev, lacpdu_multicast);
-	}
-
 	res = vlan_vids_add_by_dev(slave_dev, bond_dev);
 	if (res) {
 		pr_err("%s: Error: Couldn't add bond vlan ids to %s\n",
 		       bond_dev->name, slave_dev->name);
-		goto err_hwaddr_unsync;
+		goto err_close;
 	}
 
 	prev_slave = bond_last_slave(bond);
@@ -1598,6 +1565,37 @@ int bond_enslave(struct net_device *bond
 		goto err_upper_unlink;
 	}
 
+	/* If the mode uses primary, then the following is handled by
+	 * bond_change_active_slave().
+	 */
+	if (!bond_uses_primary(bond)) {
+		/* set promiscuity level to new slave */
+		if (bond_dev->flags & IFF_PROMISC) {
+			res = dev_set_promiscuity(slave_dev, 1);
+			if (res)
+				goto err_sysfs_del;
+		}
+
+		/* set allmulti level to new slave */
+		if (bond_dev->flags & IFF_ALLMULTI) {
+			res = dev_set_allmulti(slave_dev, 1);
+			if (res)
+				goto err_sysfs_del;
+		}
+
+		netif_addr_lock_bh(bond_dev);
+		dev_mc_sync_multiple(slave_dev, bond_dev);
+		dev_uc_sync_multiple(slave_dev, bond_dev);
+		netif_addr_unlock_bh(bond_dev);
+
+		if (BOND_MODE(bond) == BOND_MODE_8023AD) {
+			/* add lacpdu mc addr to mc list */
+			u8 lacpdu_multicast[ETH_ALEN] = MULTICAST_LACPDU_ADDR;
+
+			dev_mc_add(slave_dev, lacpdu_multicast);
+		}
+	}
+
 	bond->slave_cnt++;
 	bond_compute_features(bond);
 	bond_set_carrier(bond);
@@ -1619,6 +1617,9 @@ int bond_enslave(struct net_device *bond
 	return 0;
 
 /* Undo stages on error */
+err_sysfs_del:
+	bond_sysfs_slave_del(new_slave);
+
 err_upper_unlink:
 	bond_upper_dev_unlink(bond_dev, slave_dev);
 
@@ -1639,10 +1640,6 @@ err_detach:
 	}
 	slave_disable_netpoll(new_slave);
 
-err_hwaddr_unsync:
-	if (!bond_uses_primary(bond))
-		bond_hw_addr_flush(bond_dev, slave_dev);
-
 err_close:
 	slave_dev->priv_flags &= ~IFF_BONDING;
 	dev_close(slave_dev);
