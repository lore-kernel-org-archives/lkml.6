Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeE3LH3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:07:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60689 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751929AbeE3LG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:58 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Xin Long" <lucien.xin@gmail.com>,
        "Andy Gospodarek" <andy@greyhouse.net>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.932263668@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 147/153] bonding: process the err returned by
 dev_set_allmulti properly in bond_enslave
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit 9f5a90c107741b864398f4ac0014711a8c1d8474 upstream.

When dev_set_promiscuity(1) succeeds but dev_set_allmulti(1) fails,
dev_set_promiscuity(-1) should be done before going to the err path.
Otherwise, dev->promiscuity will leak.

Fixes: 7e1a1ac1fbaa ("bonding: Check return of dev_set_promiscuity/allmulti")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/bonding/bond_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1704,8 +1704,11 @@ int bond_enslave(struct net_device *bond
 		/* set allmulti level to new slave */
 		if (bond_dev->flags & IFF_ALLMULTI) {
 			res = dev_set_allmulti(slave_dev, 1);
-			if (res)
+			if (res) {
+				if (bond_dev->flags & IFF_PROMISC)
+					dev_set_promiscuity(slave_dev, -1);
 				goto err_close;
+			}
 		}
 
 		netif_addr_lock_bh(bond_dev);
