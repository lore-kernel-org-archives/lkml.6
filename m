Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ioINC3w+bILboCO5umB7r0S8vm2opkF/qN7+bNj0RkQ61OL4ThlONIm/l2JuMVqXHxRIM
ARC-Seal: i=1; a=rsa-sha256; t=1523399580; cv=none;
        d=google.com; s=arc-20160816;
        b=IfAa93lCOfgKJE5QqizMn5ZhNDoxtdC+C1Pd29bkudmwC6Ee3UjN8iTezG/2Q25Dzu
         WhgiiJrxjrxhnzwYUcCINurKaEqO8vVnBPivpAhekdHcehu61bHze4f46cHyDY2pvn+s
         HF33IUctlOfZv1iwUNw1Fgo1MCCc4ktCsVVJ3BkfWzm0wBEFYxNIzHblZMjj1IjM/jMr
         6OvOb3Tn+o0LviqK7lwIpHZ69L8M9YkUqrHdtOavZ4Vtfm7GZPJ9l/7n1JgKTtO76XsB
         1Kzq5KxXWE4W+Z+5OTKvHSeVkWLqz1CKhtW44qBOeB3+B+x2cwNSAVzxizAXTW2vpbAl
         Kj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SoAh9GNAE+j1ygCXJaYLr9nG/G6yS+ynqPTDCinGdTE=;
        b=dGTe72H+MdMc3k5MvO8OOhdO616A55UHg5k9IHfZcIQNwuySYwXrJ/n1rQOEU2z9ew
         f784A5uoq6C9hvAg0f4q1CXE6uujfhLIXX7T61LnXGiLPiltKrWT3sDL9/eft4yaUYNf
         ZGPvQxlFOs7EzxRDxddZQK5zikzMnRAOt1n3LUKsel488ITDNsD0qpxBGy/3rTz0qw+5
         TGaGJsqidplBwzW2bFvesLykkVwvpwYA4oaKB20iNqy0jWWMKWk/0XlR+TxzNQwKis51
         0yrnnIHFQpMHMTn9IvGPU1Kfd1VqRkkxJWjmg20wBk/95aQOqYRi4vaavW31tKATbQUV
         WnzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Beniamino Galvani <bgalvani@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 141/168] bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave
Date: Wed, 11 Apr 2018 00:24:43 +0200
Message-Id: <20180410212807.084971367@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400238682125252?=
X-GMAIL-MSGID: =?utf-8?q?1597400238682125252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit ae42cc62a9f07f1f6979054ed92606b9c30f4a2e ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |   73 +++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1528,44 +1528,11 @@ int bond_enslave(struct net_device *bond
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
 		netdev_err(bond_dev, "Couldn't add bond vlan ids to %s\n",
 			   slave_dev->name);
-		goto err_hwaddr_unsync;
+		goto err_close;
 	}
 
 	prev_slave = bond_last_slave(bond);
@@ -1725,6 +1692,37 @@ int bond_enslave(struct net_device *bond
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
@@ -1748,6 +1746,9 @@ int bond_enslave(struct net_device *bond
 	return 0;
 
 /* Undo stages on error */
+err_sysfs_del:
+	bond_sysfs_slave_del(new_slave);
+
 err_upper_unlink:
 	bond_upper_dev_unlink(bond, new_slave);
 
@@ -1768,10 +1769,6 @@ err_detach:
 	synchronize_rcu();
 	slave_disable_netpoll(new_slave);
 
-err_hwaddr_unsync:
-	if (!bond_uses_primary(bond))
-		bond_hw_addr_flush(bond_dev, slave_dev);
-
 err_close:
 	slave_dev->priv_flags &= ~IFF_BONDING;
 	dev_close(slave_dev);
