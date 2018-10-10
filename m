Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B20CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4727B2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4727B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJKC3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:29:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13613 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbeJKC3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:29:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D19706BE9A70B;
        Thu, 11 Oct 2018 03:06:17 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Thu, 11 Oct 2018 03:06:11 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 2/4] net: hns3: Add RSS general configuration support for VF
Date:   Wed, 10 Oct 2018 20:05:35 +0100
Message-ID: <20181010190537.20972-3-salil.mehta@huawei.com>
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

This patch adds RSS key, hash algorithm configuration support
for VF in revision 0x21.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h   |   3 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 155 ++++++++++++++-------
 2 files changed, 106 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
index 19b3286..eb8ed11 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
@@ -148,7 +148,8 @@ struct hclgevf_query_res_cmd {
 	__le16 rsv[7];
 };
 
-#define HCLGEVF_RSS_HASH_KEY_OFFSET	4
+#define HCLGEVF_RSS_DEFAULT_OUTPORT_B	4
+#define HCLGEVF_RSS_HASH_KEY_OFFSET_B	4
 #define HCLGEVF_RSS_HASH_KEY_NUM	16
 struct hclgevf_rss_config_cmd {
 	u8 hash_config;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index ca4a9f7..f21196b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -386,6 +386,47 @@ static int hclgevf_get_vector_index(struct hclgevf_dev *hdev, int vector)
 	return -EINVAL;
 }
 
+static int hclgevf_set_rss_algo_key(struct hclgevf_dev *hdev,
+				    const u8 hfunc, const u8 *key)
+{
+	struct hclgevf_rss_config_cmd *req;
+	struct hclgevf_desc desc;
+	int key_offset;
+	int key_size;
+	int ret;
+
+	req = (struct hclgevf_rss_config_cmd *)desc.data;
+
+	for (key_offset = 0; key_offset < 3; key_offset++) {
+		hclgevf_cmd_setup_basic_desc(&desc,
+					     HCLGEVF_OPC_RSS_GENERIC_CONFIG,
+					     false);
+
+		req->hash_config |= (hfunc & HCLGEVF_RSS_HASH_ALGO_MASK);
+		req->hash_config |=
+			(key_offset << HCLGEVF_RSS_HASH_KEY_OFFSET_B);
+
+		if (key_offset == 2)
+			key_size =
+			HCLGEVF_RSS_KEY_SIZE - HCLGEVF_RSS_HASH_KEY_NUM * 2;
+		else
+			key_size = HCLGEVF_RSS_HASH_KEY_NUM;
+
+		memcpy(req->hash_key,
+		       key + key_offset * HCLGEVF_RSS_HASH_KEY_NUM, key_size);
+
+		ret = hclgevf_cmd_send(&hdev->hw, &desc, 1);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"Configure RSS config fail, status = %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static u32 hclgevf_get_rss_key_size(struct hnae3_handle *handle)
 {
 	return HCLGEVF_RSS_KEY_SIZE;
@@ -466,68 +507,40 @@ static int hclgevf_set_rss_tc_mode(struct hclgevf_dev *hdev,  u16 rss_size)
 	return status;
 }
 
-static int hclgevf_get_rss_hw_cfg(struct hnae3_handle *handle, u8 *hash,
-				  u8 *key)
+static int hclgevf_get_rss(struct hnae3_handle *handle, u32 *indir, u8 *key,
+			   u8 *hfunc)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
-	struct hclgevf_rss_config_cmd *req;
-	int lkup_times = key ? 3 : 1;
-	struct hclgevf_desc desc;
-	int key_offset;
-	int key_size;
-	int status;
-
-	req = (struct hclgevf_rss_config_cmd *)desc.data;
-	lkup_times = (lkup_times == 3) ? 3 : ((hash) ? 1 : 0);
-
-	for (key_offset = 0; key_offset < lkup_times; key_offset++) {
-		hclgevf_cmd_setup_basic_desc(&desc,
-					     HCLGEVF_OPC_RSS_GENERIC_CONFIG,
-					     true);
-		req->hash_config |= (key_offset << HCLGEVF_RSS_HASH_KEY_OFFSET);
+	struct hclgevf_rss_cfg *rss_cfg = &hdev->rss_cfg;
+	int i;
 
-		status = hclgevf_cmd_send(&hdev->hw, &desc, 1);
-		if (status) {
-			dev_err(&hdev->pdev->dev,
-				"failed to get hardware RSS cfg, status = %d\n",
-				status);
-			return status;
+	if (handle->pdev->revision >= 0x21) {
+		/* Get hash algorithm */
+		if (hfunc) {
+			switch (rss_cfg->hash_algo) {
+			case HCLGEVF_RSS_HASH_ALGO_TOEPLITZ:
+				*hfunc = ETH_RSS_HASH_TOP;
+				break;
+			case HCLGEVF_RSS_HASH_ALGO_SIMPLE:
+				*hfunc = ETH_RSS_HASH_XOR;
+				break;
+			default:
+				*hfunc = ETH_RSS_HASH_UNKNOWN;
+				break;
+			}
 		}
 
-		if (key_offset == 2)
-			key_size =
-			HCLGEVF_RSS_KEY_SIZE - HCLGEVF_RSS_HASH_KEY_NUM * 2;
-		else
-			key_size = HCLGEVF_RSS_HASH_KEY_NUM;
-
+		/* Get the RSS Key required by the user */
 		if (key)
-			memcpy(key + key_offset * HCLGEVF_RSS_HASH_KEY_NUM,
-			       req->hash_key,
-			       key_size);
+			memcpy(key, rss_cfg->rss_hash_key,
+			       HCLGEVF_RSS_KEY_SIZE);
 	}
 
-	if (hash) {
-		if ((req->hash_config & 0xf) == HCLGEVF_RSS_HASH_ALGO_TOEPLITZ)
-			*hash = ETH_RSS_HASH_TOP;
-		else
-			*hash = ETH_RSS_HASH_UNKNOWN;
-	}
-
-	return 0;
-}
-
-static int hclgevf_get_rss(struct hnae3_handle *handle, u32 *indir, u8 *key,
-			   u8 *hfunc)
-{
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
-	struct hclgevf_rss_cfg *rss_cfg = &hdev->rss_cfg;
-	int i;
-
 	if (indir)
 		for (i = 0; i < HCLGEVF_RSS_IND_TBL_SIZE; i++)
 			indir[i] = rss_cfg->rss_indirection_tbl[i];
 
-	return hclgevf_get_rss_hw_cfg(handle, hfunc, key);
+	return 0;
 }
 
 static int hclgevf_set_rss(struct hnae3_handle *handle, const u32 *indir,
@@ -535,7 +548,36 @@ static int hclgevf_set_rss(struct hnae3_handle *handle, const u32 *indir,
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	struct hclgevf_rss_cfg *rss_cfg = &hdev->rss_cfg;
-	int i;
+	int ret, i;
+
+	if (handle->pdev->revision >= 0x21) {
+		/* Set the RSS Hash Key if specififed by the user */
+		if (key) {
+			switch (hfunc) {
+			case ETH_RSS_HASH_TOP:
+				rss_cfg->hash_algo =
+					HCLGEVF_RSS_HASH_ALGO_TOEPLITZ;
+				break;
+			case ETH_RSS_HASH_XOR:
+				rss_cfg->hash_algo =
+					HCLGEVF_RSS_HASH_ALGO_SIMPLE;
+				break;
+			case ETH_RSS_HASH_NO_CHANGE:
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			ret = hclgevf_set_rss_algo_key(hdev, rss_cfg->hash_algo,
+						       key);
+			if (ret)
+				return ret;
+
+			/* Update the shadow RSS key with user specified qids */
+			memcpy(rss_cfg->rss_hash_key, key,
+			       HCLGEVF_RSS_KEY_SIZE);
+		}
+	}
 
 	/* update the shadow RSS table with user specified qids */
 	for (i = 0; i < HCLGEVF_RSS_IND_TBL_SIZE; i++)
@@ -1276,6 +1318,17 @@ static int hclgevf_rss_init_hw(struct hclgevf_dev *hdev)
 
 	rss_cfg->rss_size = hdev->rss_size_max;
 
+	if (hdev->pdev->revision >= 0x21) {
+		rss_cfg->hash_algo = HCLGEVF_RSS_HASH_ALGO_TOEPLITZ;
+		netdev_rss_key_fill(rss_cfg->rss_hash_key,
+				    HCLGEVF_RSS_KEY_SIZE);
+
+		ret = hclgevf_set_rss_algo_key(hdev, rss_cfg->hash_algo,
+					       rss_cfg->rss_hash_key);
+		if (ret)
+			return ret;
+	}
+
 	/* Initialize RSS indirect table for each vport */
 	for (i = 0; i < HCLGEVF_RSS_IND_TBL_SIZE; i++)
 		rss_cfg->rss_indirection_tbl[i] = i % hdev->rss_size_max;
-- 
2.7.4


