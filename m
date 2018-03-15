Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCOQyd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:54:33 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42357 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeCOQyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:54:31 -0400
X-Google-Smtp-Source: AG47ELv/goOOCpVIAfnw962sULZ9iZm3ZNeIdvwuPQTyuK0nIjLndjI63kaBCZkzG2TMJu7Y3Et86w==
From: Matthias Brugger <matthias.bgg@gmail.com>
X-Google-Original-From: Matthias Brugger <mbrugger@suse.com>
To: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net
Cc: tianjinchuan1@huawei.com, lipeng321@huawei.com, lixiaoping3@huawei.com,
        mbrugger@suse.com, yankejian@huawei.com, linyunsheng@huawei.com,
        huangdaode@hisilicon.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com
Subject: [PATCH] net: hns: Fix ethtool private flags
Date: Thu, 15 Mar 2018 17:54:20 +0100
Message-Id: <20180315165420.16086-1-mbrugger@suse.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver implementation returns support for private flags, while
no private flags are present. When asked for the number of private
flags it returns the number of statistic flag names.

Fix this by returning EOPNOTSUPP for not implemented ethtool flags.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 4 +++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
index 86944bc3b273..74bd260ca02a 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -666,7 +666,7 @@ static void hns_gmac_get_strings(u32 stringset, u8 *data)
 
 static int hns_gmac_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return ARRAY_SIZE(g_gmac_stats_string);
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
index b62816c1574e..93e71e27401b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -422,7 +422,7 @@ void hns_ppe_update_stats(struct hns_ppe_cb *ppe_cb)
 
 int hns_ppe_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return ETH_PPE_STATIC_NUM;
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index 6f3570cfb501..e2e28532e4dc 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -876,7 +876,7 @@ void hns_rcb_get_stats(struct hnae_queue *queue, u64 *data)
  */
 int hns_rcb_get_ring_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return HNS_RING_STATIC_REG_NUM;
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index 7ea7f8a4aa2a..2e14a3ae1d8b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -993,8 +993,10 @@ int hns_get_sset_count(struct net_device *netdev, int stringset)
 			cnt--;
 
 		return cnt;
-	} else {
+	} else if (stringset == ETH_SS_STATS) {
 		return (HNS_NET_STATS_CNT + ops->get_sset_count(h, stringset));
+	} else {
+		return -EOPNOTSUPP;
 	}
 }
 
-- 
2.16.2
