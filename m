Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZod0agO9ETCPyjrGO+LOezX19EHbfu8i5RXsdn14gEfNhjBDG66eOmYADhPIv8QOK18Dp8O
ARC-Seal: i=1; a=rsa-sha256; t=1526631616; cv=none;
        d=google.com; s=arc-20160816;
        b=nLm8PHKR684GqGUqVhWCDeRyrtThaubmYEz/gwuoS37x8O1lTHcxmNXLoEVcniThjI
         uNuwDaB6y/EfcTDQoUeb+WSrhHfCLyFf/rkbGHA3xuH9CLUWyDrjvwj3lDas4UyNH6PW
         c0QanVM6QGw8+gSmZRHs1evZ1ISaT4v7oU+S4Yk+hXOLrZBZ0GDXT2GR8RZQHCXUoUg5
         cLhcTNzeTUvlDMPX63CwbPTxaUJqzRjof7RVVlZB3SioXFUWkwDIn5T/MJtIjlR5Sx0w
         2UbJzZfWk2+4eSCvrrYyTTxb/mu8sRgl9h/wd2msArzmmhnHOdAGxB4Y5IroBrzV33SZ
         noag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=BQSq8wqfGaxtYFE9RYyAIMlwaWucVhZh5IAGTp+A5k4=;
        b=PmH15LM9OOUYsUKcIJt2MTa5mvkLvyGRXNdWAZRnqcr7lTrHVPxtGpbrjM9Hms0SHb
         zRLpjn/BG4At0I/cd2uZcMidu5AESsY47d15A34eXYDieNrli9oHLwTKX1TnjTaARUGJ
         FEBE+Rh+VOhOIyXmQI9T+dM0VegB5QuGadENGumllT4zlJ/h2g4X/T7stwh2SGfhY45w
         rDLOINTMmKbVN9ZceTA8dsPDH16lWftNbDuN5VqWAfDixEJsuQPSlzzjwgpfexWSjBIa
         wVTDq9idHl7t0hvAoEPbVFn8jBdKWJawfSKv+l1zw79QFb+IHztlMfjtjjoSxDYbvIeY
         SrvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=apwhkKsF;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=apwhkKsF;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Debabrata Banerjee <dbanerje@akamai.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 31/45] bonding: send learning packets for vlans on slave
Date: Fri, 18 May 2018 10:15:48 +0200
Message-Id: <20180518081531.947157801@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789120269895465?=
X-GMAIL-MSGID: =?utf-8?q?1600789274396190611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Debabrata Banerjee <dbanerje@akamai.com>

[ Upstream commit 21706ee8a47d3ede7fdae0be6d7c0a0e31a83229 ]

There was a regression at some point from the intended functionality of
commit f60c3704e87d ("bonding: Fix alb mode to only use first level
vlans.")

Given the return value vlan_get_encap_level() we need to store the nest
level of the bond device, and then compare the vlan's encap level to
this. Without this, this check always fails and learning packets are
never sent.

In addition, this same commit caused a regression in the behavior of
balance_alb, which requires learning packets be sent for all interfaces
using the slave's mac in order to load balance properly. For vlan's
that have not set a user mac, we can send after checking one bit.
Otherwise we need send the set mac, albeit defeating rx load balancing
for that vlan.

Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_alb.c  |   13 ++++++++-----
 drivers/net/bonding/bond_main.c |    2 ++
 include/net/bonding.h           |    1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -943,6 +943,10 @@ static void alb_send_lp_vid(struct slave
 	skb->priority = TC_PRIO_CONTROL;
 	skb->dev = slave->dev;
 
+	netdev_dbg(slave->bond->dev,
+		   "Send learning packet: dev %s mac %pM vlan %d\n",
+		   slave->dev->name, mac_addr, vid);
+
 	if (vid)
 		__vlan_hwaccel_put_tag(skb, vlan_proto, vid);
 
@@ -965,14 +969,13 @@ static int alb_upper_dev_walk(struct net
 	u8 *mac_addr = data->mac_addr;
 	struct bond_vlan_tag *tags;
 
-	if (is_vlan_dev(upper) && vlan_get_encap_level(upper) == 0) {
-		if (strict_match &&
-		    ether_addr_equal_64bits(mac_addr,
-					    upper->dev_addr)) {
+	if (is_vlan_dev(upper) &&
+	    bond->nest_level == vlan_get_encap_level(upper) - 1) {
+		if (upper->addr_assign_type == NET_ADDR_STOLEN) {
 			alb_send_lp_vid(slave, mac_addr,
 					vlan_dev_vlan_proto(upper),
 					vlan_dev_vlan_id(upper));
-		} else if (!strict_match) {
+		} else {
 			alb_send_lp_vid(slave, upper->dev_addr,
 					vlan_dev_vlan_proto(upper),
 					vlan_dev_vlan_id(upper));
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1734,6 +1734,8 @@ int bond_enslave(struct net_device *bond
 	if (bond_mode_uses_xmit_hash(bond))
 		bond_update_slave_arr(bond, NULL);
 
+	bond->nest_level = dev_get_nest_level(bond_dev);
+
 	netdev_info(bond_dev, "Enslaving %s as %s interface with %s link\n",
 		    slave_dev->name,
 		    bond_is_active_slave(new_slave) ? "an active" : "a backup",
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -198,6 +198,7 @@ struct bonding {
 	struct   slave __rcu *primary_slave;
 	struct   bond_up_slave __rcu *slave_arr; /* Array of usable slaves */
 	bool     force_primary;
+	u32      nest_level;
 	s32      slave_cnt; /* never change this value outside the attach/detach wrappers */
 	int     (*recv_probe)(const struct sk_buff *, struct bonding *,
 			      struct slave *);
