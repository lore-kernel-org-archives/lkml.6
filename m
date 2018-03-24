Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeCXDCi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 23:02:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752077AbeCXDBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 23:01:13 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 4/5] net: hns3: fix for not initializing VF rss_hash_key problem
Date: Sat, 24 Mar 2018 11:32:46 +0800
Message-ID: <1521862367-111399-5-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521862367-111399-1-git-send-email-lipeng321@huawei.com>
References: <1521862367-111399-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

Default rss_hash_key value should be given to all vports. But just the
PF rss_hash_key has the default value here. This patch adds rss_hash_key
Initialization for all vports.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index bede411..ce093c3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3466,8 +3466,6 @@ static void hclge_rss_init_cfg(struct hclge_dev *hdev)
 	struct hclge_vport *vport = hdev->vport;
 	int i;
 
-	netdev_rss_key_fill(vport->rss_hash_key, HCLGE_RSS_KEY_SIZE);
-
 	for (i = 0; i < hdev->num_vmdq_vport + 1; i++) {
 		vport[i].rss_tuple_sets.ipv4_tcp_en =
 			HCLGE_RSS_INPUT_TUPLE_OTHER;
@@ -3487,6 +3485,8 @@ static void hclge_rss_init_cfg(struct hclge_dev *hdev)
 			HCLGE_RSS_INPUT_TUPLE_OTHER;
 
 		vport[i].rss_algo = HCLGE_RSS_HASH_ALGO_TOEPLITZ;
+
+		netdev_rss_key_fill(vport[i].rss_hash_key, HCLGE_RSS_KEY_SIZE);
 	}
 
 	hclge_rss_indir_init_cfg(hdev);
-- 
2.9.3
