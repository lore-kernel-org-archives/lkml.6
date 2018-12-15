Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAFAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57686206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeLODSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:18:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729943AbeLODRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:17:34 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F0BC1617D818D;
        Sat, 15 Dec 2018 11:17:29 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 11:17:22 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [Patch net 02/10] net: hns: All ports can not work when insmod hns ko after rmmod.
Date:   Sat, 15 Dec 2018 11:53:21 +0800
Message-ID: <1544846009-50276-3-git-send-email-lipeng321@huawei.com>
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

There are two test cases:
1. Remove the 4 modules:hns_enet_drv/hns_dsaf/hnae/hns_mdio,
   and install them again, must use "ifconfig down/ifconfig up"
   command pair to bring port to work.

   This patch calls phy_stop function when init phy to fix this bug.

2. Remove the 2 modules:hns_enet_drv/hns_dsaf, and install them again,
   all ports can not use anymore, because of the phy devices register
   failed(phy devices already exists).

   Phy devices are registered when hns_dsaf installed, this patch
   removes them when hns_dsaf removed.

The two cases are sometimes related, fixing the second case also requires
fixing the first case, so fix them together.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 15 +++++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_enet.c     |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 3613e40..a97228c 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -778,6 +778,17 @@ static int hns_mac_register_phy(struct hns_mac_cb *mac_cb)
 	return rc;
 }
 
+static void hns_mac_remove_phydev(struct hns_mac_cb *mac_cb)
+{
+	if (!to_acpi_device_node(mac_cb->fw_port) || !mac_cb->phy_dev)
+		return;
+
+	phy_device_remove(mac_cb->phy_dev);
+	phy_device_free(mac_cb->phy_dev);
+
+	mac_cb->phy_dev = NULL;
+}
+
 #define MAC_MEDIA_TYPE_MAX_LEN		16
 
 static const struct {
@@ -1117,7 +1128,11 @@ void hns_mac_uninit(struct dsaf_device *dsaf_dev)
 	int max_port_num = hns_mac_get_max_port_num(dsaf_dev);
 
 	for (i = 0; i < max_port_num; i++) {
+		if (!dsaf_dev->mac_cb[i])
+			continue;
+
 		dsaf_dev->misc_op->cpld_reset_led(dsaf_dev->mac_cb[i]);
+		hns_mac_remove_phydev(dsaf_dev->mac_cb[i]);
 		dsaf_dev->mac_cb[i] = NULL;
 	}
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 28e9078..c205a0e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1186,6 +1186,9 @@ int hns_nic_init_phy(struct net_device *ndev, struct hnae_handle *h)
 	if (h->phy_if == PHY_INTERFACE_MODE_XGMII)
 		phy_dev->autoneg = false;
 
+	if (h->phy_if == PHY_INTERFACE_MODE_SGMII)
+		phy_stop(phy_dev);
+
 	return 0;
 }
 
-- 
1.9.1

