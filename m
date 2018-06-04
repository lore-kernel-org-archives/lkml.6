Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeFDQu4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:50:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751203AbeFDQuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:50:54 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH V2 net] net: hns: Fix the process of adding broadcast addresses to tcam
Date: Mon, 4 Jun 2018 17:50:09 +0100
Message-ID: <20180604165009.24476-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

If the multicast mask value in device tree is configured not all
0xff, the broadcast mac will be lost from tcam table after the
execution of command 'ifconfig up'. The address is appended by
hns_ae_start, but will be clear later by hns_nic_set_rx_mode
called in dev_open process.

This patch fixed it by not use the multicast mask when add a
broadcast address.

Fixes: b5996f11ea54 ("net: add Hisilicon Network Subsystem basic ethernet support")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
Patch V2: Fixed comments by David Miller
   Link: https://lkml.org/lkml/2018/6/4/671
Patch V1: Initial Submit
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index e0bc79e..85e1d14 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -1648,6 +1648,15 @@ int hns_dsaf_rm_mac_addr(
 				      mac_entry->addr);
 }
 
+static void hns_dsaf_setup_mc_mask(struct dsaf_device *dsaf_dev,
+				   u8 port_num, u8 *mask, u8 *addr)
+{
+	if (MAC_IS_BROADCAST(addr))
+		memset(mask, 0xff, ETH_ALEN);
+	else
+		memcpy(mask, dsaf_dev->mac_cb[port_num]->mc_mask, ETH_ALEN);
+}
+
 static void hns_dsaf_mc_mask_bit_clear(char *dst, const char *src)
 {
 	u16 *a = (u16 *)dst;
@@ -1676,7 +1685,6 @@ int hns_dsaf_add_mac_mc_port(struct dsaf_device *dsaf_dev,
 	struct dsaf_drv_tbl_tcam_key tmp_mac_key;
 	struct dsaf_tbl_tcam_data tcam_data;
 	u8 mc_addr[ETH_ALEN];
-	u8 *mc_mask;
 	int mskid;
 
 	/*chechk mac addr */
@@ -1687,9 +1695,12 @@ int hns_dsaf_add_mac_mc_port(struct dsaf_device *dsaf_dev,
 	}
 
 	ether_addr_copy(mc_addr, mac_entry->addr);
-	mc_mask = dsaf_dev->mac_cb[mac_entry->in_port_num]->mc_mask;
 	if (!AE_IS_VER1(dsaf_dev->dsaf_ver)) {
+		u8 mc_mask[ETH_ALEN];
+
 		/* prepare for key data setting */
+		hns_dsaf_setup_mc_mask(dsaf_dev, mac_entry->in_port_num,
+				       mc_mask, mac_entry->addr);
 		hns_dsaf_mc_mask_bit_clear(mc_addr, mc_mask);
 
 		/* config key mask */
@@ -1844,7 +1855,6 @@ int hns_dsaf_del_mac_mc_port(struct dsaf_device *dsaf_dev,
 	struct dsaf_drv_tbl_tcam_key mask_key, tmp_mac_key;
 	struct dsaf_tbl_tcam_data *pmask_key = NULL;
 	u8 mc_addr[ETH_ALEN];
-	u8 *mc_mask;
 
 	if (!(void *)mac_entry) {
 		dev_err(dsaf_dev->dev,
@@ -1861,14 +1871,17 @@ int hns_dsaf_del_mac_mc_port(struct dsaf_device *dsaf_dev,
 
 	/* always mask vlan_id field */
 	ether_addr_copy(mc_addr, mac_entry->addr);
-	mc_mask = dsaf_dev->mac_cb[mac_entry->in_port_num]->mc_mask;
 
 	if (!AE_IS_VER1(dsaf_dev->dsaf_ver)) {
+		u8 mc_mask[ETH_ALEN];
+
 		/* prepare for key data setting */
+		hns_dsaf_setup_mc_mask(dsaf_dev, mac_entry->in_port_num,
+				       mc_mask, mac_entry->addr);
 		hns_dsaf_mc_mask_bit_clear(mc_addr, mc_mask);
 
 		/* config key mask */
-		hns_dsaf_set_mac_key(dsaf_dev, &mask_key, 0x00, 0xff, mc_addr);
+		hns_dsaf_set_mac_key(dsaf_dev, &mask_key, 0x00, 0xff, mc_mask);
 
 		mask_key.high.val = le32_to_cpu(mask_key.high.val);
 		mask_key.low.val = le32_to_cpu(mask_key.low.val);
-- 
2.7.4
