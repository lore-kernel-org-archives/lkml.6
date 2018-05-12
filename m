Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbeELLBE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 07:01:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43971 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbeELLBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 07:01:03 -0400
From: <liuqifa@huawei.com>
To: <davem@davemloft.net>, <dsahern@gmail.com>, <maheshb@google.com>,
        <weiyongjun1@huawei.com>, <maowenan@huawei.com>,
        <dingtianhong@huawei.com>, <liuqifa@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipvlan: flush arp table when mac address changed
Date: Sat, 12 May 2018 19:00:37 +0800
Message-ID: <20180512110037.9116-1-liuqifa@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.68.80]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keefe Liu <liuqifa@huawei.com>

When master device's mac has been changed, the
commit <32c10bbfe914> "ipvlan: always use the current L2
addr of the master" makes the IPVlan devices's mac changed
also, but it doesn't flush the IPVlan's arp table.

Signed-off-by: Keefe Liu <liuqifa@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 450eec2..a1edfe1 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -7,6 +7,8 @@
  *
  */
 
+#include <net/neighbour.h>
+#include <net/arp.h>
 #include "ipvlan.h"
 
 static unsigned int ipvlan_netid __read_mostly;
@@ -792,8 +794,10 @@ static int ipvlan_device_event(struct notifier_block *unused,
 		break;
 
 	case NETDEV_CHANGEADDR:
-		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
+		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			ether_addr_copy(ipvlan->dev->dev_addr, dev->dev_addr);
+			neigh_changeaddr(&arp_tbl, ipvlan->dev);
+		}
 		break;
 
 	case NETDEV_PRE_TYPE_CHANGE:
-- 
1.8.3.1
