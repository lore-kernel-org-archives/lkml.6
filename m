Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56402086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56402086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeK1Xbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:31:40 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727676AbeK1Xbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:31:40 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8EC7F43166C83;
        Wed, 28 Nov 2018 20:30:06 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 20:30:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <Shahed.Shaikh@cavium.com>,
        <manish.chopra@cavium.com>, <Dept-GELinuxNICDev@cavium.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] qlcnic: remove set but not used variables 'cur_rings, max_hw_rings, tx_desc_info'
Date:   Wed, 28 Nov 2018 20:29:39 +0800
Message-ID: <20181128122939.28132-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:4011:5:
 warning: variable 'max_hw_rings' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:4013:6:
 warning: variable 'cur_rings' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:2996:25:
 warning: variable 'tx_desc_info' set but not used [-Wunused-but-set-variable]

'cur_rings, max_hw_rings' never used since introduction in commit
34e8c406fda5 ("qlcnic: refactor Tx/SDS ring calculation and validation in driver.")
'tx_desc_info' never used since commit
95b3890ae39f ("qlcnic: Enhance Tx timeout debugging.")
Also 'queue_type' only can be QLCNIC_RX_QUEUE/QLCNIC_TX_QUEUE,
so make a trival cleanup on if statement.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index d42ba22..16d0479 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -2993,10 +2993,8 @@ int qlcnic_check_temp(struct qlcnic_adapter *adapter)
 static inline void dump_tx_ring_desc(struct qlcnic_host_tx_ring *tx_ring)
 {
 	int i;
-	struct cmd_desc_type0 *tx_desc_info;
 
 	for (i = 0; i < tx_ring->num_desc; i++) {
-		tx_desc_info = &tx_ring->desc_head[i];
 		pr_info("TX Desc: %d\n", i);
 		print_hex_dump(KERN_INFO, "TX: ", DUMP_PREFIX_OFFSET, 16, 1,
 			       &tx_ring->desc_head[i],
@@ -4008,19 +4006,12 @@ int qlcnic_validate_rings(struct qlcnic_adapter *adapter, __u32 ring_cnt,
 			  int queue_type)
 {
 	struct net_device *netdev = adapter->netdev;
-	u8 max_hw_rings = 0;
 	char buf[8];
-	int cur_rings;
 
-	if (queue_type == QLCNIC_RX_QUEUE) {
-		max_hw_rings = adapter->max_sds_rings;
-		cur_rings = adapter->drv_sds_rings;
+	if (queue_type == QLCNIC_RX_QUEUE)
 		strcpy(buf, "SDS");
-	} else if (queue_type == QLCNIC_TX_QUEUE) {
-		max_hw_rings = adapter->max_tx_rings;
-		cur_rings = adapter->drv_tx_rings;
+	else
 		strcpy(buf, "Tx");
-	}
 
 	if (!is_power_of_2(ring_cnt)) {
 		netdev_err(netdev, "%s rings value should be a power of 2\n",
-- 
2.7.0


