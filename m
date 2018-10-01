Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E14C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E892064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E892064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeJAS0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:26:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729250AbeJAS0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:26:08 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 17AA42E10E613;
        Mon,  1 Oct 2018 19:48:37 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Mon, 1 Oct 2018 19:48:29 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 7/7] net: hns3: Add support for enable/disable flow director
Date:   Mon, 1 Oct 2018 12:46:47 +0100
Message-ID: <20181001114647.15504-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181001114647.15504-1-salil.mehta@huawei.com>
References: <20181001114647.15504-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

This patch adds switch for flow director with ethtool command

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 15 ++++++++++++++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 13 +++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index e185d04..591ee2e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -430,6 +430,7 @@ struct hnae3_ae_ops {
 	int (*get_fd_all_rules)(struct hnae3_handle *handle,
 				struct ethtool_rxnfc *cmd, u32 *rule_locs);
 	int (*restore_fd_rules)(struct hnae3_handle *handle);
+	void (*enable_fd)(struct hnae3_handle *handle, bool enable);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 96f07ca..c269256 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1285,6 +1285,13 @@ static int hns3_nic_set_features(struct net_device *netdev,
 			return ret;
 	}
 
+	if ((changed & NETIF_F_NTUPLE) && h->ae_algo->ops->enable_fd) {
+		if (features & NETIF_F_NTUPLE)
+			h->ae_algo->ops->enable_fd(h, true);
+		else
+			h->ae_algo->ops->enable_fd(h, false);
+	}
+
 	netdev->features = features;
 	return 0;
 }
@@ -1770,8 +1777,14 @@ static void hns3_set_default_feature(struct net_device *netdev)
 		NETIF_F_GSO_GRE_CSUM | NETIF_F_GSO_UDP_TUNNEL |
 		NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_SCTP_CRC;
 
-	if (pdev->revision != 0x20)
+	if (pdev->revision >= 0x21) {
 		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+		if (!(h->flags & HNAE3_SUPPORT_VF)) {
+			netdev->hw_features |= NETIF_F_NTUPLE;
+			netdev->features |= NETIF_F_NTUPLE;
+		}
+	}
 }
 
 static int hns3_alloc_buffer(struct hns3_enet_ring *ring,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 00ec4db..0ce7ccb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4597,6 +4597,18 @@ static int hclge_get_all_rules(struct hnae3_handle *handle,
 	return 0;
 }
 
+static void hclge_enable_fd(struct hnae3_handle *handle, bool enable)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+
+	hdev->fd_cfg.fd_en = enable;
+	if (!enable)
+		hclge_del_all_fd_entries(handle, false);
+	else
+		hclge_restore_fd_entries(handle);
+}
+
 static void hclge_cfg_mac_mode(struct hclge_dev *hdev, bool enable)
 {
 	struct hclge_desc desc;
@@ -7341,6 +7353,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_fd_rule_info = hclge_get_fd_rule_info,
 	.get_fd_all_rules = hclge_get_all_rules,
 	.restore_fd_rules = hclge_restore_fd_entries,
+	.enable_fd = hclge_enable_fd,
 };
 
 static struct hnae3_ae_algo ae_algo = {
-- 
2.7.4


