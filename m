Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51577C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28897222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfBPIzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:55:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfBPIzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:55:40 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 04E1A382F4554B57FFD9;
        Sat, 16 Feb 2019 16:55:36 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 16:55:27 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <linux-ide@vger.kernel.org>, <tj@kernel.org>, <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2] ata: fix a race condition when internal cmd time out
Date:   Sat, 16 Feb 2019 16:53:47 +0800
Message-ID: <20190216085347.35228-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For internal cmds, we will unmap DMA memory associated with the cmd
before we abort the cmd. If DMA transferring data before the aborting,
bus error will occur.

ata_exec_internal_sg
  ->ata_port_freeze if timeout
    ->ata_qc_complete
      ->ata_sg_clean
                                      dma transferring data = bus error
  ->ap->ops->post_internal_cmd
    ->sas_ata_post_internal
      ->sas_ata_internal_abort
        ->abort the cmd

Fix this by moving post_internal_cmd() before unmapping the DMA memory
when time out. Notice that we have to set ATA_QCFLAG_FAILED flag before
calling post_internal_cmd() so that the aborting will work.

Reported-by: luojian <luojian5@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
v2: fix some typos

 drivers/ata/libata-core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index adf28788cab5..d0ff5711e805 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1665,6 +1665,13 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 		 */
 		if (qc->flags & ATA_QCFLAG_ACTIVE) {
 			qc->err_mask |= AC_ERR_TIMEOUT;
+			qc->flags |= ATA_QCFLAG_FAILED;
+
+			spin_unlock_irqrestore(ap->lock, flags);
+			/* do post_internal_cmd */
+			if (ap->ops->post_internal_cmd)
+				ap->ops->post_internal_cmd(qc);
+			spin_lock_irqsave(ap->lock, flags);
 
 			if (ap->ops->error_handler)
 				ata_port_freeze(ap);
@@ -1679,9 +1686,10 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 		spin_unlock_irqrestore(ap->lock, flags);
 	}
 
-	/* do post_internal_cmd */
-	if (ap->ops->post_internal_cmd)
-		ap->ops->post_internal_cmd(qc);
+	if (!(qc->err_mask & AC_ERR_TIMEOUT))
+		/* do post_internal_cmd */
+		if (ap->ops->post_internal_cmd)
+			ap->ops->post_internal_cmd(qc);
 
 	/* perform minimal error analysis */
 	if (qc->flags & ATA_QCFLAG_FAILED) {
-- 
2.14.4

