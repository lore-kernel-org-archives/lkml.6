Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140F7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E012086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E012086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388828AbeKGNfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:35:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14605 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730906AbeKGNev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:34:51 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B931DDEFAFA1E;
        Wed,  7 Nov 2018 12:06:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 12:06:05 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 04/12] net: hns3: adjust the location of clearing the table when doing reset
Date:   Wed, 7 Nov 2018 12:06:10 +0800
Message-ID: <1541563578-28973-5-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
References: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing a function reset, the hardware table should be cleared
before the hardware reset. In current code, this clearing is done
in hns3_reset_notify_uninit_enet, but it is too late, because
the hardware reset is already done, hns3_reset_notify_down_enet
is more suitable to do that.

Fixes: bb6b94a896d4 ("net: hns3: Add reset interface implementation in client")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index d51469c..75e3e79 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3716,9 +3716,19 @@ static void hns3_restore_coal(struct hns3_nic_priv *priv)
 
 static int hns3_reset_notify_down_enet(struct hnae3_handle *handle)
 {
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct net_device *ndev = kinfo->netdev;
 
+	/* it is cumbersome for hardware to pick-and-choose entries for deletion
+	 * from table space. Hence, for function reset software intervention is
+	 * required to delete the entries
+	 */
+	if (hns3_dev_ongoing_func_reset(ae_dev)) {
+		hns3_remove_hw_addr(ndev);
+		hns3_del_all_fd_rules(ndev, false);
+	}
+
 	if (!netif_running(ndev))
 		return 0;
 
@@ -3797,7 +3807,6 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 
 static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 {
-	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
 	struct net_device *netdev = handle->kinfo.netdev;
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	int ret;
@@ -3821,15 +3830,6 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 	if (ret)
 		netdev_err(netdev, "uninit ring error\n");
 
-	/* it is cumbersome for hardware to pick-and-choose entries for deletion
-	 * from table space. Hence, for function reset software intervention is
-	 * required to delete the entries
-	 */
-	if (hns3_dev_ongoing_func_reset(ae_dev)) {
-		hns3_remove_hw_addr(netdev);
-		hns3_del_all_fd_rules(netdev, false);
-	}
-
 	clear_bit(HNS3_NIC_STATE_INITED, &priv->state);
 
 	return ret;
-- 
2.7.4

