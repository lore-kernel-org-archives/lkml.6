Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F093CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD502222E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfBPOoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:44:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54487 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfBPOo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:44:29 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gv1Cb-00068M-7b; Sat, 16 Feb 2019 14:44:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jianyun Li <jyli@marvell.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mvumi: fix 32 bit shift of a 32 bit unsigned int
Date:   Sat, 16 Feb 2019 14:44:24 +0000
Message-Id: <20190216144424.21438-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently m_sg->baseaddr_h (a 32 bit unsigned int) is being shifted by a
total of 32 bits; this always produces a 0 result.  Fix this by casting
it to a dma_addr_t (a 64 bit unsigned int) before performing the shift.

Detected by CoverityScan, CID#147270 ("Operands don't affect result")

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/mvumi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 36f64205ecfa..d3582accfd09 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -313,7 +313,7 @@ static void mvumi_delete_internal_cmd(struct mvumi_hba *mhba,
 			sgd_getsz(mhba, m_sg, size);
 
 			phy_addr = (dma_addr_t) m_sg->baseaddr_l |
-				(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16);
+				(((dma_addr_t) m_sg->baseaddr_h << 16) << 16);
 
 			dma_free_coherent(&mhba->pdev->dev, size, cmd->data_buf,
 								phy_addr);
-- 
2.20.1

