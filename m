Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41975C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA14C208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA14C208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbeHAMDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:03:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732300AbeHAMC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:02:59 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7106ECB2DB22F;
        Wed,  1 Aug 2018 18:17:52 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 18:17:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <shenjian15@huawei.com>, <joe@perches.com>,
        <keescook@chromium.org>, <wangxi11@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] net: hns: remove redundant variables 'max_frm' and 'tmp_mac_key'
Date:   Wed, 1 Aug 2018 18:16:47 +0800
Message-ID: <20180801101647.16968-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables 'max_frm' and 'tmp_mac_key' are being assigned,
but are never used,hence they are redundant and can be removed.

fix fllowing warning:

drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:461:6: warning: variable 'max_frm' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:1685:31: warning: variable 'tmp_mac_key' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:1855:41: warning: variable 'tmp_mac_key' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  5 -----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 10 +---------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 6e5107d..3545a5d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -458,11 +458,6 @@ int hns_mac_set_mtu(struct hns_mac_cb *mac_cb, u32 new_mtu, u32 buf_size)
 {
 	struct mac_driver *drv = hns_mac_get_drv(mac_cb);
 	u32 new_frm = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
-	u32 max_frm = AE_IS_VER1(mac_cb->dsaf_dev->dsaf_ver) ?
-			MAC_MAX_MTU : MAC_MAX_MTU_V2;
-
-	if (mac_cb->mac_type == HNAE_PORT_DEBUG)
-		max_frm = MAC_MAX_MTU_DBG;
 
 	if (new_frm > HNS_RCB_RING_MAX_BD_PER_PKT * buf_size)
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index 619e6ce..ca50c25 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -1683,7 +1683,6 @@ int hns_dsaf_add_mac_mc_port(struct dsaf_device *dsaf_dev,
 	struct dsaf_tbl_tcam_mcast_cfg mac_data;
 	struct dsaf_drv_priv *priv = hns_dsaf_dev_priv(dsaf_dev);
 	struct dsaf_drv_soft_mac_tbl *soft_mac_entry = priv->soft_mac_tbl;
-	struct dsaf_drv_tbl_tcam_key tmp_mac_key;
 	struct dsaf_tbl_tcam_data tcam_data;
 	u8 mc_addr[ETH_ALEN];
 	int mskid;
@@ -1740,10 +1739,6 @@ int hns_dsaf_add_mac_mc_port(struct dsaf_device *dsaf_dev,
 		/* if exist, add in */
 		hns_dsaf_tcam_mc_get(dsaf_dev, entry_index, &tcam_data,
 				     &mac_data);
-
-		tmp_mac_key.high.val =
-			le32_to_cpu(tcam_data.tbl_tcam_data_high);
-		tmp_mac_key.low.val = le32_to_cpu(tcam_data.tbl_tcam_data_low);
 	}
 
 	/* config hardware entry */
@@ -1853,7 +1848,7 @@ int hns_dsaf_del_mac_mc_port(struct dsaf_device *dsaf_dev,
 	struct dsaf_tbl_tcam_data tcam_data;
 	int mskid;
 	const u8 empty_msk[sizeof(mac_data.tbl_mcast_port_msk)] = {0};
-	struct dsaf_drv_tbl_tcam_key mask_key, tmp_mac_key;
+	struct dsaf_drv_tbl_tcam_key mask_key;
 	struct dsaf_tbl_tcam_data *pmask_key = NULL;
 	u8 mc_addr[ETH_ALEN];
 
@@ -1916,9 +1911,6 @@ int hns_dsaf_del_mac_mc_port(struct dsaf_device *dsaf_dev,
 	/* read entry */
 	hns_dsaf_tcam_mc_get(dsaf_dev, entry_index, &tcam_data, &mac_data);
 
-	tmp_mac_key.high.val = le32_to_cpu(tcam_data.tbl_tcam_data_high);
-	tmp_mac_key.low.val = le32_to_cpu(tcam_data.tbl_tcam_data_low);
-
 	/*del the port*/
 	if (mac_entry->port_num < DSAF_SERVICE_NW_NUM) {
 		mskid = mac_entry->port_num;
-- 
2.7.0


