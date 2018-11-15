Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBCEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F87C2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F87C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeKPOK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 09:10:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36585 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbeKPOK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 09:10:57 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EF9BD35F567C3;
        Fri, 16 Nov 2018 12:00:10 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Fri, 16 Nov 2018 12:00:03 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <xuechaojing@huawei.com>,
        <netdev@vger.kernel.org>, <wulike1@huawei.com>,
        <chiqijun@huawei.com>, <fy.wang@huawei.com>, <tony.qu@huawei.com>,
        <luoshaokai@huawei.com>
Subject: [PATCH 1/3] net-next/hinic:fix a bug in set mac address
Date:   Thu, 15 Nov 2018 20:05:46 +0000
Message-ID: <20181115200548.5326-1-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In add_mac_addr(), if the MAC address is a muliticast address,
it will not be set, which causes the network card fail to receive
the multicast packet. This patch fixes this bug.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index fdf2bdb6b0d0..cefd441bb117 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -600,9 +600,6 @@ static int add_mac_addr(struct net_device *netdev, const u8 *addr)
 	u16 vid = 0;
 	int err;
 
-	if (!is_valid_ether_addr(addr))
-		return -EADDRNOTAVAIL;
-
 	netif_info(nic_dev, drv, netdev, "set mac addr = %02x %02x %02x %02x %02x %02x\n",
 		   addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
 
@@ -733,6 +730,9 @@ static void set_rx_mode(struct work_struct *work)
 
 	__dev_uc_sync(nic_dev->netdev, add_mac_addr, remove_mac_addr);
 	__dev_mc_sync(nic_dev->netdev, add_mac_addr, remove_mac_addr);
+
+	netdev_for_each_mc_addr(ha, nic_dev->netdev)
+		add_mac_addr(nic_dev->netdev, ha->addr);
 }
 
 static void hinic_set_rx_mode(struct net_device *netdev)
-- 
2.17.1

