Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9D4C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CC020645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2evBYy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CC020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbeJICEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731676AbeJICEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C0EE204FD;
        Mon,  8 Oct 2018 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024659;
        bh=XPzgpIce/bLK+YgFNfSsWZQLS/SNweQqVH8dSjArpQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2evBYy209T2w7z42sIqBV1QACexNFxI4uECWlQe2uTZKHwM5hppdRvVjTtbai8un
         g2oNS/Ap5USio6qgB2FmMmKFzpuaacmdcDEVSMH9Y8E9aKEKd964KHWZqSUvhrlzOF
         EQrTq5y4hwIQRRoGHIbF+LFm/t8QKqvvKsea3GZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nilesh Javali <nilesh.javali@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 088/168] scsi: qedi: Add the CRC size within iSCSI NVM image
Date:   Mon,  8 Oct 2018 20:31:08 +0200
Message-Id: <20181008175623.408159324@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nilesh Javali <nilesh.javali@cavium.com>

[ Upstream commit c77a2fa3ff8f73d1a485e67e6f81c64823739d59 ]

The QED driver commit, 1ac4329a1cff ("qed: Add configuration information
to register dump and debug data"), removes the CRC length validation
causing nvm_get_image failure while loading qedi driver:

[qed_mcp_get_nvm_image:2700(host_10-0)]Image [0] is too big - 00006008 bytes
where only 00006004 are available
[qedi_get_boot_info:2253]:10: Could not get NVM image. ret = -12

Hence add and adjust the CRC size to iSCSI NVM image to read boot info at
qedi load time.

Signed-off-by: Nilesh Javali <nilesh.javali@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qedi/qedi.h      |    7 ++++++-
 drivers/scsi/qedi/qedi_main.c |   28 +++++++++++++++-------------
 2 files changed, 21 insertions(+), 14 deletions(-)

--- a/drivers/scsi/qedi/qedi.h
+++ b/drivers/scsi/qedi/qedi.h
@@ -77,6 +77,11 @@ enum qedi_nvm_tgts {
 	QEDI_NVM_TGT_SEC,
 };
 
+struct qedi_nvm_iscsi_image {
+	struct nvm_iscsi_cfg iscsi_cfg;
+	u32 crc;
+};
+
 struct qedi_uio_ctrl {
 	/* meta data */
 	u32 uio_hsi_version;
@@ -294,7 +299,7 @@ struct qedi_ctx {
 	void *bdq_pbl_list;
 	dma_addr_t bdq_pbl_list_dma;
 	u8 bdq_pbl_list_num_entries;
-	struct nvm_iscsi_cfg *iscsi_cfg;
+	struct qedi_nvm_iscsi_image *iscsi_image;
 	dma_addr_t nvm_buf_dma;
 	void __iomem *bdq_primary_prod;
 	void __iomem *bdq_secondary_prod;
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1346,23 +1346,26 @@ exit_setup_int:
 
 static void qedi_free_nvm_iscsi_cfg(struct qedi_ctx *qedi)
 {
-	if (qedi->iscsi_cfg)
+	if (qedi->iscsi_image)
 		dma_free_coherent(&qedi->pdev->dev,
-				  sizeof(struct nvm_iscsi_cfg),
-				  qedi->iscsi_cfg, qedi->nvm_buf_dma);
+				  sizeof(struct qedi_nvm_iscsi_image),
+				  qedi->iscsi_image, qedi->nvm_buf_dma);
 }
 
 static int qedi_alloc_nvm_iscsi_cfg(struct qedi_ctx *qedi)
 {
-	qedi->iscsi_cfg = dma_zalloc_coherent(&qedi->pdev->dev,
-					     sizeof(struct nvm_iscsi_cfg),
-					     &qedi->nvm_buf_dma, GFP_KERNEL);
-	if (!qedi->iscsi_cfg) {
+	struct qedi_nvm_iscsi_image nvm_image;
+
+	qedi->iscsi_image = dma_zalloc_coherent(&qedi->pdev->dev,
+						sizeof(nvm_image),
+						&qedi->nvm_buf_dma,
+						GFP_KERNEL);
+	if (!qedi->iscsi_image) {
 		QEDI_ERR(&qedi->dbg_ctx, "Could not allocate NVM BUF.\n");
 		return -ENOMEM;
 	}
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
-		  "NVM BUF addr=0x%p dma=0x%llx.\n", qedi->iscsi_cfg,
+		  "NVM BUF addr=0x%p dma=0x%llx.\n", qedi->iscsi_image,
 		  qedi->nvm_buf_dma);
 
 	return 0;
@@ -1905,7 +1908,7 @@ qedi_get_nvram_block(struct qedi_ctx *qe
 	struct nvm_iscsi_block *block;
 
 	pf = qedi->dev_info.common.abs_pf_id;
-	block = &qedi->iscsi_cfg->block[0];
+	block = &qedi->iscsi_image->iscsi_cfg.block[0];
 	for (i = 0; i < NUM_OF_ISCSI_PF_SUPPORTED; i++, block++) {
 		flags = ((block->id) & NVM_ISCSI_CFG_BLK_CTRL_FLAG_MASK) >>
 			NVM_ISCSI_CFG_BLK_CTRL_FLAG_OFFSET;
@@ -2194,15 +2197,14 @@ static void qedi_boot_release(void *data
 static int qedi_get_boot_info(struct qedi_ctx *qedi)
 {
 	int ret = 1;
-	u16 len;
-
-	len = sizeof(struct nvm_iscsi_cfg);
+	struct qedi_nvm_iscsi_image nvm_image;
 
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
 		  "Get NVM iSCSI CFG image\n");
 	ret = qedi_ops->common->nvm_get_image(qedi->cdev,
 					      QED_NVM_IMAGE_ISCSI_CFG,
-					      (char *)qedi->iscsi_cfg, len);
+					      (char *)qedi->iscsi_image,
+					      sizeof(nvm_image));
 	if (ret)
 		QEDI_ERR(&qedi->dbg_ctx,
 			 "Could not get NVM image. ret = %d\n", ret);


