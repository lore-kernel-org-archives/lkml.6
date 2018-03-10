Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933020AbeCJC7Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:59:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932701AbeCJC5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:57:37 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: fix for ipv6 address loss problem after setting channels
Date: Sat, 10 Mar 2018 11:29:24 +0800
Message-ID: <1520652573-75644-4-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
References: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

The function of dev_close and dev_open is just likes ifconfig <netif> down
and ifconfig <netif> up. The ipv6 address will be lost after dev_close and
dev_open are called. This patch uses hns3_nic_net_stop to replace dev_close
and uses hns3_nic_net_open to replace dev_open.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 8113d22..4dba974 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3503,7 +3503,7 @@ int hns3_set_channels(struct net_device *netdev,
 		return 0;
 
 	if (if_running)
-		dev_close(netdev);
+		hns3_nic_net_stop(netdev);
 
 	hns3_clear_all_ring(h);
 
@@ -3546,7 +3546,7 @@ int hns3_set_channels(struct net_device *netdev,
 
 open_netdev:
 	if (if_running)
-		dev_open(netdev);
+		hns3_nic_net_open(netdev);
 
 	return ret;
 }
-- 
2.9.3
