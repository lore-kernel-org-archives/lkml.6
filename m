Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9494DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576432075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576432075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeJKC3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:29:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727101AbeJKC3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:29:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D96307A8579DB;
        Thu, 11 Oct 2018 03:06:17 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Thu, 11 Oct 2018 03:06:08 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 1/4] net: hns3: Add new RSS hash algorithm support for PF
Date:   Wed, 10 Oct 2018 20:05:34 +0100
Message-ID: <20181010190537.20972-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181010190537.20972-1-salil.mehta@huawei.com>
References: <20181010190537.20972-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

This patch adds ETH_RSS_HASH_XOR hash algorithm supports, which
is supported by hw revision 0x21.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  9 ++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 31 +++++++++++++++++-----
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 7d79a07..cbf9a65 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -678,12 +678,13 @@ static int hns3_set_rss(struct net_device *netdev, const u32 *indir,
 	if (!h->ae_algo || !h->ae_algo->ops || !h->ae_algo->ops->set_rss)
 		return -EOPNOTSUPP;
 
-	/* currently we only support Toeplitz hash */
-	if ((hfunc != ETH_RSS_HASH_NO_CHANGE) && (hfunc != ETH_RSS_HASH_TOP)) {
-		netdev_err(netdev,
-			   "hash func not supported (only Toeplitz hash)\n");
+	if ((h->pdev->revision == 0x20 &&
+	     hfunc != ETH_RSS_HASH_TOP) || (hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	     hfunc != ETH_RSS_HASH_TOP && hfunc != ETH_RSS_HASH_XOR)) {
+		netdev_err(netdev, "hash func not supported\n");
 		return -EOPNOTSUPP;
 	}
+
 	if (!indir) {
 		netdev_err(netdev,
 			   "set rss failed for indir is empty\n");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ca1a936..0c5a053 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2806,8 +2806,19 @@ static int hclge_get_rss(struct hnae3_handle *handle, u32 *indir,
 	int i;
 
 	/* Get hash algorithm */
-	if (hfunc)
-		*hfunc = vport->rss_algo;
+	if (hfunc) {
+		switch (vport->rss_algo) {
+		case HCLGE_RSS_HASH_ALGO_TOEPLITZ:
+			*hfunc = ETH_RSS_HASH_TOP;
+			break;
+		case HCLGE_RSS_HASH_ALGO_SIMPLE:
+			*hfunc = ETH_RSS_HASH_XOR;
+			break;
+		default:
+			*hfunc = ETH_RSS_HASH_UNKNOWN;
+			break;
+		}
+	}
 
 	/* Get the RSS Key required by the user */
 	if (key)
@@ -2831,12 +2842,20 @@ static int hclge_set_rss(struct hnae3_handle *handle, const u32 *indir,
 
 	/* Set the RSS Hash Key if specififed by the user */
 	if (key) {
-
-		if (hfunc == ETH_RSS_HASH_TOP ||
-		    hfunc == ETH_RSS_HASH_NO_CHANGE)
+		switch (hfunc) {
+		case ETH_RSS_HASH_TOP:
 			hash_algo = HCLGE_RSS_HASH_ALGO_TOEPLITZ;
-		else
+			break;
+		case ETH_RSS_HASH_XOR:
+			hash_algo = HCLGE_RSS_HASH_ALGO_SIMPLE;
+			break;
+		case ETH_RSS_HASH_NO_CHANGE:
+			hash_algo = vport->rss_algo;
+			break;
+		default:
 			return -EINVAL;
+		}
+
 		ret = hclge_set_rss_algo_key(hdev, hash_algo, key);
 		if (ret)
 			return ret;
-- 
2.7.4


