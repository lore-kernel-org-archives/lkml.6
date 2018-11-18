Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471B1C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 03:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0810520817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 03:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0810520817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeKRNj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 08:39:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48617 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbeKRNj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 08:39:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 694775BCD9977;
        Sun, 18 Nov 2018 11:20:33 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.178) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Sun, 18 Nov 2018 11:20:24 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 1/5] net: hns3: Support two vlan header when setting mtu
Date:   Sun, 18 Nov 2018 03:19:10 +0000
Message-ID: <20181118031914.23892-2-salil.mehta@huawei.com>
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

This patch adds supports for two vlan header when setting mtu.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 5 +++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 22220af92aa9..c944090d3adf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3609,8 +3609,9 @@ static int hns3_client_init(struct hnae3_handle *handle)
 
 	hns3_dcbnl_setup(handle);
 
-	/* MTU range: (ETH_MIN_MTU(kernel default) - 9706) */
-	netdev->max_mtu = HNS3_MAX_MTU - (ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN);
+	/* MTU range: (ETH_MIN_MTU(kernel default) - 9702) */
+	netdev->max_mtu =
+		HNS3_MAX_MTU - (ETH_HLEN + ETH_FCS_LEN + 2 * VLAN_HLEN);
 
 	set_bit(HNS3_NIC_STATE_INITED, &priv->state);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 33885a7529fc..019f747e486a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6364,7 +6364,7 @@ static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mtu)
 	int max_frm_size;
 	int ret;
 
-	max_frm_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+	max_frm_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + 2 * VLAN_HLEN;
 
 	if (max_frm_size < HCLGE_MAC_MIN_FRAME ||
 	    max_frm_size > HCLGE_MAC_MAX_FRAME)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index ca90b662e33b..279661764910 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -120,7 +120,7 @@ enum HLCGE_PORT_TYPE {
 #define HCLGE_VECTOR0_IMP_RESET_INT_B	1
 
 #define HCLGE_MAC_DEFAULT_FRAME \
-	(ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN + ETH_DATA_LEN)
+	(ETH_HLEN + ETH_FCS_LEN + 2 * VLAN_HLEN + ETH_DATA_LEN)
 #define HCLGE_MAC_MIN_FRAME		64
 #define HCLGE_MAC_MAX_FRAME		9728
 
-- 
2.17.1


