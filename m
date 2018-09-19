Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AC9ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788FC2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788FC2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbeISXKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:10:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732969AbeISXKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:10:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 31660BB239529;
        Thu, 20 Sep 2018 01:31:13 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 01:31:06 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH net-next 05/12] net: hns3: Add support for hns3_nic_netdev_ops.ndo_do_ioctl
Date:   Wed, 19 Sep 2018 18:29:51 +0100
Message-ID: <20180919172958.12992-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180919172958.12992-1-salil.mehta@huawei.com>
References: <20180919172958.12992-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

This patch adds the .ndo_do_ioctl net_device_ops operation to support
the PHY MII ioctl for PF driver.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             |  2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 15 +++++++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 13 +++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 67befff..c48c187 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -337,6 +337,8 @@ struct hnae3_ae_ops {
 	void (*get_mac_addr)(struct hnae3_handle *handle, u8 *p);
 	int (*set_mac_addr)(struct hnae3_handle *handle, void *p,
 			    bool is_first);
+	int (*do_ioctl)(struct hnae3_handle *handle,
+			struct ifreq *ifr, int cmd);
 	int (*add_uc_addr)(struct hnae3_handle *handle,
 			   const unsigned char *addr);
 	int (*rm_uc_addr)(struct hnae3_handle *handle,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 99209a0..e404130 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1239,6 +1239,20 @@ static int hns3_nic_net_set_mac_address(struct net_device *netdev, void *p)
 	return 0;
 }
 
+static int hns3_nic_do_ioctl(struct net_device *netdev,
+			     struct ifreq *ifr, int cmd)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+
+	if (!netif_running(netdev))
+		return -EINVAL;
+
+	if (!h->ae_algo->ops->do_ioctl)
+		return -EOPNOTSUPP;
+
+	return h->ae_algo->ops->do_ioctl(h, ifr, cmd);
+}
+
 static int hns3_nic_set_features(struct net_device *netdev,
 				 netdev_features_t features)
 {
@@ -1565,6 +1579,7 @@ static const struct net_device_ops hns3_nic_netdev_ops = {
 	.ndo_start_xmit		= hns3_nic_net_xmit,
 	.ndo_tx_timeout		= hns3_nic_net_timeout,
 	.ndo_set_mac_address	= hns3_nic_net_set_mac_address,
+	.ndo_do_ioctl		= hns3_nic_do_ioctl,
 	.ndo_change_mtu		= hns3_nic_change_mtu,
 	.ndo_set_features	= hns3_nic_set_features,
 	.ndo_get_stats64	= hns3_nic_get_stats64,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index aececf5..ad15ba7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4308,6 +4308,18 @@ static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p,
 	return 0;
 }
 
+static int hclge_do_ioctl(struct hnae3_handle *handle, struct ifreq *ifr,
+			  int cmd)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+
+	if (!hdev->hw.mac.phydev)
+		return -EOPNOTSUPP;
+
+	return phy_mii_ioctl(hdev->hw.mac.phydev, ifr, cmd);
+}
+
 static int hclge_set_vlan_filter_ctrl(struct hclge_dev *hdev, u8 vlan_type,
 				      bool filter_en)
 {
@@ -5977,6 +5989,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_tc_size = hclge_get_tc_size,
 	.get_mac_addr = hclge_get_mac_addr,
 	.set_mac_addr = hclge_set_mac_addr,
+	.do_ioctl = hclge_do_ioctl,
 	.add_uc_addr = hclge_add_uc_addr,
 	.rm_uc_addr = hclge_rm_uc_addr,
 	.add_mc_addr = hclge_add_mc_addr,
-- 
2.7.4


