Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZosd3TLqMoZbI7hf0DMk5raHaPm/q8yO219DBh5IqFjuBBO614kkGBf6RzWTV/YVN1pOVQ9
ARC-Seal: i=1; a=rsa-sha256; t=1526631469; cv=none;
        d=google.com; s=arc-20160816;
        b=CXhXi1U1WsF9z/4Y6MjSqRblyV0ftRhq3FiDuao2rX2lomS5YKuPTZOkx35wvLGto0
         Z3SFpYq68b8X31+4Qujf7E+4gd28byYUk8vdfWGB9t9MrjKH8rSUyGZDvRV5uSR6wL2u
         bhsIfCxrWicwYiYNi/Dm6FXyZCMQG76esObk93HK3N6NlBw1djGcDCnQnb5kUl3xPq2Q
         vNHM0F18kXhRvDfHRhAkvEk4F6fBc5tz2dvgebPLLZ9YjM22dHK3FSaLHjcYL0XNnlka
         e9O9xBdvX2HoN0zRkilIX5ySiNpw7Zr315h8XFH2BB7Muii522EqDx7bt2u9qcs1q4S6
         i54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=rDpD96VqyMtGE6aVOIVgEa3YS47pLyr9WUi7koH0R0E=;
        b=xlUUzm9PNCaUSLB4BjBcFyT4SnofktaYmOH3Es6GFLsl9OTZYYkSz7pnjntqnkyy3h
         6WqnxbrjknXaKI24xV6f5inoOlXry/5qnzyrCg7ftJbOSrnxJSwV7BAMTHa8BHs/AULT
         uS0C+3a17+XcQXB0OJw+ENpfmONj5+zrqRikzsuD9g9InGa2ITnIly2bwWaTKVudw650
         4rYtsbxX9Pvcm2YqANxIxSpABY8qVsEIp/+44M4rDknB7r1lk0s4UsVSc965G9C/nr9x
         Tm27Wf9lEvEdFBjqeffB2/eyBuH6Jt77lFFSs7XjYgdxrJElNrvIW51uAz3xKUcgM61k
         IemA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=X5++4T9D;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=X5++4T9D;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Debabrata Banerjee <dbanerje@akamai.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 32/55] bonding: send learning packets for vlans on slave
Date: Fri, 18 May 2018 10:15:28 +0200
Message-Id: <20180518081459.004685744@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789120269895465?=
X-GMAIL-MSGID: =?utf-8?q?1600789120269895465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1738,6 +1738,8 @@ int bond_enslave(struct net_device *bond
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
