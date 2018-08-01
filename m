Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C645DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80888208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80888208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406069AbeHATIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405915AbeHATIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0587B110A;
        Wed,  1 Aug 2018 17:04:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 217/336] scsi: hisi_sas: config ATA de-reset as an constrained command for v3 hw
Date:   Wed,  1 Aug 2018 18:49:12 +0200
Message-Id: <20180801165037.375210669@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit 9413532788df7470297dd0475995c5dc5b07f362 ]

As a unconstrained command, a command can be sent to SATA disk even if
SATA disk status is BUSY, ERR or DRQ.

If an ATA reset assert is successful but ATA reset de-assert fails, then
it will retry the reset de-assert. If reset de- assert retry is
successful, we think it is okay to probe the device but actually it
still has Err status.

Apparently we need to retry the ATA reset assertion and de- assertion
instead for this mentioned scenario.

As such, we config ATA reset assert as a constrained command, if ATA
reset de-assert fails, then ATA reset de-assert retry will also
fail. Then we will retry the proper process of ATA reset assert and
de-assert again.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -348,10 +348,11 @@ struct hisi_sas_err_record_v3 {
 #define DIR_TO_DEVICE 2
 #define DIR_RESERVED 3
 
-#define CMD_IS_UNCONSTRAINT(cmd) \
-	((cmd == ATA_CMD_READ_LOG_EXT) || \
-	(cmd == ATA_CMD_READ_LOG_DMA_EXT) || \
-	(cmd == ATA_CMD_DEV_RESET))
+#define FIS_CMD_IS_UNCONSTRAINED(fis) \
+	((fis.command == ATA_CMD_READ_LOG_EXT) || \
+	(fis.command == ATA_CMD_READ_LOG_DMA_EXT) || \
+	((fis.command == ATA_CMD_DEV_RESET) && \
+	((fis.control & ATA_SRST) != 0)))
 
 static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
 {
@@ -1046,7 +1047,7 @@ static int prep_ata_v3_hw(struct hisi_hb
 		<< CMD_HDR_FRAME_TYPE_OFF;
 	dw1 |= sas_dev->device_id << CMD_HDR_DEV_ID_OFF;
 
-	if (CMD_IS_UNCONSTRAINT(task->ata_task.fis.command))
+	if (FIS_CMD_IS_UNCONSTRAINED(task->ata_task.fis))
 		dw1 |= 1 << CMD_HDR_UNCON_CMD_OFF;
 
 	hdr->dw1 = cpu_to_le32(dw1);


