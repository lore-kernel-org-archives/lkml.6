Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A2FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D51C2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D51C2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbeIXVMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:12:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729102AbeIXVMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:12:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E7E5B6DFF0AA5;
        Mon, 24 Sep 2018 23:09:38 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Mon, 24 Sep 2018 23:09:33 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 7/7] scsi: hisi_sas: Update v3 hw AIP_LIMIT and CFG_AGING_TIME register values
Date:   Mon, 24 Sep 2018 23:06:34 +0800
Message-ID: <1537801594-207139-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Update registers as follows:
- Default value of AIP timer is 1ms, and it is easy for some expanders to
  cause IO error. Change the value to max value 65ms to avoid IO error for
  those expanders.

- A CQ completion will be reported by HW when 4 CQs have occurred or the
  aging timer expires, whichever happens first. Sor serial IO scenario, it
  will still wait 8us for every IO before it is reported. So in the
  situation, the performance is poor. So to improve it, change the limit
  time to the least value.
  For other scenario, it does little affect to the performance.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index f30c4e4..bd4ce38 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -127,6 +127,7 @@
 #define PHY_CTRL_RESET_OFF		0
 #define PHY_CTRL_RESET_MSK		(0x1 << PHY_CTRL_RESET_OFF)
 #define SL_CFG				(PORT_BASE + 0x84)
+#define AIP_LIMIT			(PORT_BASE + 0x90)
 #define SL_CONTROL			(PORT_BASE + 0x94)
 #define SL_CONTROL_NOTIFY_EN_OFF	0
 #define SL_CONTROL_NOTIFY_EN_MSK	(0x1 << SL_CONTROL_NOTIFY_EN_OFF)
@@ -431,6 +432,7 @@ static void init_reg_v3_hw(struct hisi_hba *hisi_hba)
 			 (u32)((1ULL << hisi_hba->queue_count) - 1));
 	hisi_sas_write32(hisi_hba, CFG_MAX_TAG, 0xfff0400);
 	hisi_sas_write32(hisi_hba, HGC_SAS_TXFAIL_RETRY_CTRL, 0x108);
+	hisi_sas_write32(hisi_hba, CFG_AGING_TIME, 0x1);
 	hisi_sas_write32(hisi_hba, INT_COAL_EN, 0x1);
 	hisi_sas_write32(hisi_hba, OQ_INT_COAL_TIME, 0x1);
 	hisi_sas_write32(hisi_hba, OQ_INT_COAL_CNT, 0x1);
@@ -495,6 +497,7 @@ static void init_reg_v3_hw(struct hisi_hba *hisi_hba)
 
 		/* used for 12G negotiate */
 		hisi_sas_phy_write32(hisi_hba, i, COARSETUNE_TIME, 0x1e);
+		hisi_sas_phy_write32(hisi_hba, i, AIP_LIMIT, 0x2ffff);
 	}
 
 	for (i = 0; i < hisi_hba->queue_count; i++) {
-- 
1.9.1

