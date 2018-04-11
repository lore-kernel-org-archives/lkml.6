Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/es7S4amQMLgInP2aSjNaXTfLZAFpWPeRgCBlgLMrd2je26J34lkDPTIBRDoLSAIRuMtiE
ARC-Seal: i=1; a=rsa-sha256; t=1523472746; cv=none;
        d=google.com; s=arc-20160816;
        b=UaCZKF03SlHWlnFbojDALn5qLZMrjpGsuTgLj2S5Pfz7Oeo4wpmjrPUVa+3J5Qa37I
         kSK/84NppMpuy/veHWBRnnkL7LmlBIa8KsuAMYsuNl1t1T4nQfonJQP+m8Byj8ryymUW
         ttrdMlff4NaK6BNlcTHiEynH2JMEUwIxCRFFrYUPjt81SZ3xQ0qxACt3YYJl0ABP3kug
         wRMCw8PUdnRtRkdifNT4AqUGYp8PyLzmFPxFtvGYkSd4+mBQbM3IuM2V+gFPV1zyJ4iZ
         68PLPkr1HZnXYGYbNXykFMxLUJaaDGcRpYJzxdtvZuChkn4kGFasX2jVzuiSv4ixP6iw
         KdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v4QoTR7jUNBoCSlmNJ0xARUnu4vblsZ/x9LXDjqoZrg=;
        b=KEoAKuLn37H2vaWgluNdButrrZ3V/DGd6FAhbvDJ+Jk1c6jSjTWnUg4OzENZ63CI8R
         dCsIC/B+8tTkGRo1SePY73jC4T6P8wOBC17WNuS+Jsq32JYyDWarbgh0aUhEhZAREwEa
         HzPeXEMjK6h9PHbY0LkXPbWoOv7dVrATJcBpKBcJfhtn2lOyUANv/Hq+4FFmMc0iG28Z
         YEFtCTpAPnwjO6frema8+64+n/QxkrJ4nVmXiqqgrc3hXY+2uC3/xpbYclPr/J2AAtmU
         5n1uRjwfteZU9AXbHt+cHpUTTJW34rc7Xvqk5SrDXouTiHjoes0YRKl9rWf9nWIYwPgw
         eEaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 177/190] bonding: fix the err path for dev hwaddr sync in bond_enslave
Date: Wed, 11 Apr 2018 20:37:03 +0200
Message-Id: <20180411183603.459911790@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476349058540941?=
X-GMAIL-MSGID: =?utf-8?q?1597476958763252179?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 5c78f6bfae2b10ff70e21d343e64584ea6280c26 ]

vlan_vids_add_by_dev is called right after dev hwaddr sync, so on
the err path it should unsync dev hwaddr. Otherwise, the slave
dev's hwaddr will never be unsync when this err happens.

Fixes: 1ff412ad7714 ("bonding: change the bond's vlan syncing functions with the standard ones")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Acked-by: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1527,7 +1527,7 @@ int bond_enslave(struct net_device *bond
 	if (res) {
 		netdev_err(bond_dev, "Couldn't add bond vlan ids to %s\n",
 			   slave_dev->name);
-		goto err_close;
+		goto err_hwaddr_unsync;
 	}
 
 	prev_slave = bond_last_slave(bond);
@@ -1709,9 +1709,6 @@ err_unregister:
 	netdev_rx_handler_unregister(slave_dev);
 
 err_detach:
-	if (!bond_uses_primary(bond))
-		bond_hw_addr_flush(bond_dev, slave_dev);
-
 	vlan_vids_del_by_dev(slave_dev, bond_dev);
 	if (rcu_access_pointer(bond->primary_slave) == new_slave)
 		RCU_INIT_POINTER(bond->primary_slave, NULL);
@@ -1725,6 +1722,10 @@ err_detach:
 	synchronize_rcu();
 	slave_disable_netpoll(new_slave);
 
+err_hwaddr_unsync:
+	if (!bond_uses_primary(bond))
+		bond_hw_addr_flush(bond_dev, slave_dev);
+
 err_close:
 	slave_dev->priv_flags &= ~IFF_BONDING;
 	dev_close(slave_dev);
