Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B32C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 03:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E54C20659
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 03:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E54C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeKRNjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 08:39:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15113 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbeKRNjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 08:39:48 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 95FD9FCA895C9;
        Sun, 18 Nov 2018 11:20:53 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.178) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Sun, 18 Nov 2018 11:20:47 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 5/5] net: hns3: up/down netdev in hclge module when setting mtu
Date:   Sun, 18 Nov 2018 03:19:14 +0000
Message-ID: <20181118031914.23892-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181118031914.23892-1-salil.mehta@huawei.com>
References: <20181118031914.23892-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.88.178]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Currently netdev is down in enet module, and it is before
mtu range checking in hclge module, which may be cause
netdev being down unnecessarily.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c       | 11 -----------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |  3 +++
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 5cae14c991ee..7f81db3df041 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1573,18 +1573,11 @@ static int hns3_ndo_set_vf_vlan(struct net_device *netdev, int vf, u16 vlan,
 static int hns3_nic_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	bool if_running = netif_running(netdev);
 	int ret;
 
 	if (!h->ae_algo->ops->set_mtu)
 		return -EOPNOTSUPP;
 
-	/* if this was called with netdev up then bring netdevice down */
-	if (if_running) {
-		(void)hns3_nic_net_stop(netdev);
-		msleep(100);
-	}
-
 	ret = h->ae_algo->ops->set_mtu(h, new_mtu);
 	if (ret)
 		netdev_err(netdev, "failed to change MTU in hardware %d\n",
@@ -1592,10 +1585,6 @@ static int hns3_nic_change_mtu(struct net_device *netdev, int new_mtu)
 	else
 		netdev->mtu = new_mtu;
 
-	/* if the netdev was running earlier, bring it up again */
-	if (if_running && hns3_nic_net_open(netdev))
-		ret = -EINVAL;
-
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 967cb83f32d6..f78b8e188443 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6450,6 +6450,8 @@ int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu)
 			return -EINVAL;
 		}
 
+	hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
+
 	ret = hclge_set_mac_mtu(hdev, max_frm_size);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
@@ -6466,6 +6468,7 @@ int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu)
 			"Allocate buffer fail, ret =%d\n", ret);
 
 out:
+	hclge_notify_client(hdev, HNAE3_UP_CLIENT);
 	mutex_unlock(&hdev->vport_lock);
 	return ret;
 }
-- 
2.17.1


