Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4510DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD4B206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbeLODSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:18:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729908AbeLODRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:17:34 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0541CCE646CEC;
        Sat, 15 Dec 2018 11:17:30 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 11:17:23 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [Patch net 07/10] net: hns: Avoid net reset caused by pause frames storm
Date:   Sat, 15 Dec 2018 11:53:26 +0800
Message-ID: <1544846009-50276-8-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544846009-50276-1-git-send-email-lipeng321@huawei.com>
References: <1544846009-50276-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

There will be a large number of MAC pause frames on the net,
which caused tx timeout of net device. And then the net device
was reset to try to recover it. So that is not useful, and will
cause some other problems.

So need doubled ndev->watchdog_timeo if device watchdog occurred
until watchdog_timeo up to 40s and then try resetting to recover
it.

When collecting dfx information such as hardware registers when tx timeout.
Some registers for count were cleared when read. So need move this task
before update net state which also read the count registers.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 03d959c..8a53c82 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1509,11 +1509,19 @@ static int hns_nic_net_stop(struct net_device *ndev)
 }
 
 static void hns_tx_timeout_reset(struct hns_nic_priv *priv);
+#define HNS_TX_TIMEO_LIMIT (40 * HZ)
 static void hns_nic_net_timeout(struct net_device *ndev)
 {
 	struct hns_nic_priv *priv = netdev_priv(ndev);
 
-	hns_tx_timeout_reset(priv);
+	if (ndev->watchdog_timeo < HNS_TX_TIMEO_LIMIT) {
+		ndev->watchdog_timeo *= 2;
+		netdev_info(ndev, "watchdog_timo changed to %d.\n",
+			    ndev->watchdog_timeo);
+	} else {
+		ndev->watchdog_timeo = HNS_NIC_TX_TIMEOUT;
+		hns_tx_timeout_reset(priv);
+	}
 }
 
 static int hns_nic_do_ioctl(struct net_device *netdev, struct ifreq *ifr,
@@ -2076,11 +2084,11 @@ static void hns_nic_service_task(struct work_struct *work)
 		= container_of(work, struct hns_nic_priv, service_task);
 	struct hnae_handle *h = priv->ae_handle;
 
+	hns_nic_reset_subtask(priv);
 	hns_nic_update_link_status(priv->netdev);
 	h->dev->ops->update_led_status(h);
 	hns_nic_update_stats(priv->netdev);
 
-	hns_nic_reset_subtask(priv);
 	hns_nic_service_event_complete(priv);
 }
 
-- 
1.9.1

