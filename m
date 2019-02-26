Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBE7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161B62173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfBZNl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:41:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52227 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZNl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:41:27 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gycz3-0003G8-Qn; Tue, 26 Feb 2019 13:41:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Hannes Reinecke <hare@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: lpfc: ensure error is set to -ENODEV on failing exit paths
Date:   Tue, 26 Feb 2019 13:41:21 +0000
Message-Id: <20190226134121.23650-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A previous commit assigned error to the return value from the call to
dma_set_mask_and_coherent and on the non-failure path error is zero. The
subsequent error return paths now return 0 instead of -ENODEV causing
failures to now be ignored.  Fix this by setting error to -ENODEV before
these exit paths. This is indentical to an earlier fix in function
lpfc_sli_pci_mem_setup but accidentally omitted for the function
lpfc_sli4_pci_mem_setup.

Detected by cppcheck ("(warning) Identical condition 'error', second
condition is always false")

Fixes: 56de8357049c ("scsi: lpfc: fix calls to dma_set_mask_and_coherent()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 3b5873f6751e..e88c606317e1 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -10064,6 +10064,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 		error = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (error)
 		return error;
+	error = -ENODEV;
 
 	/*
 	 * The BARs and register set definitions and offset locations are
-- 
2.20.1

