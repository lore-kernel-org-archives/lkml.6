Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeEBP5t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:57:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751988AbeEBP5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:57:46 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiaofei Tan <tanxiaofei@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 09/11] scsi: hisi_sas: remove redundant handling to event95 for v3
Date: Wed, 2 May 2018 23:56:32 +0800
Message-ID: <1525276594-92173-10-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525276594-92173-1-git-send-email-john.garry@huawei.com>
References: <1525276594-92173-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

Event95 is used for DFX purpose. The relevant bit for this
interrupt in the ENT_INT_SRC_MSK3 register has been disabled,
so remove the processing.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 026faee..d6e705f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1331,14 +1331,9 @@ static irqreturn_t int_chnl_int_v3_hw(int irq_no, void *p)
 {
 	struct hisi_hba *hisi_hba = p;
 	struct device *dev = hisi_hba->dev;
-	u32 ent_msk, ent_tmp, irq_msk;
+	u32 irq_msk;
 	int phy_no = 0;
 
-	ent_msk = hisi_sas_read32(hisi_hba, ENT_INT_SRC_MSK3);
-	ent_tmp = ent_msk;
-	ent_msk |= ENT_INT_SRC_MSK3_ENT95_MSK_MSK;
-	hisi_sas_write32(hisi_hba, ENT_INT_SRC_MSK3, ent_msk);
-
 	irq_msk = hisi_sas_read32(hisi_hba, CHNL_INT_STATUS)
 				& 0xeeeeeeee;
 
@@ -1415,8 +1410,6 @@ static irqreturn_t int_chnl_int_v3_hw(int irq_no, void *p)
 		phy_no++;
 	}
 
-	hisi_sas_write32(hisi_hba, ENT_INT_SRC_MSK3, ent_tmp);
-
 	return IRQ_HANDLED;
 }
 
-- 
1.9.1
