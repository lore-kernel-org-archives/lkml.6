Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FB0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12092147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12092147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403872AbeHPQcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:32:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43005 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeHPQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:32:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fqIOu-00084q-UM; Thu, 16 Aug 2018 13:33:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aacraid: remove unused variables dev and cpu
Date:   Thu, 16 Aug 2018 14:33:20 +0100
Message-Id: <20180816133320.19682-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables dev and cpu are not being used and are redundant and hence can
be removed.

Cleans up clang warnings:
warning: variable 'dev' set but not used [-Wunused-but-set-variable]
warning: variable 'cpu' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/aacraid/aachba.c  | 7 -------
 drivers/scsi/aacraid/commsup.c | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 6e356325d8d9..bd7f352c28f3 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -3480,7 +3480,6 @@ int aac_dev_ioctl(struct aac_dev *dev, int cmd, void __user *arg)
 
 static void aac_srb_callback(void *context, struct fib * fibptr)
 {
-	struct aac_dev *dev;
 	struct aac_srb_reply *srbreply;
 	struct scsi_cmnd *scsicmd;
 
@@ -3491,8 +3490,6 @@ static void aac_srb_callback(void *context, struct fib * fibptr)
 
 	BUG_ON(fibptr == NULL);
 
-	dev = fibptr->dev;
-
 	srbreply = (struct aac_srb_reply *) fib_data(fibptr);
 
 	scsicmd->sense_buffer[0] = '\0';  /* Initialize sense valid flag to false */
@@ -3921,13 +3918,11 @@ static int aac_send_hba_fib(struct scsi_cmnd *scsicmd)
 
 static long aac_build_sg(struct scsi_cmnd *scsicmd, struct sgmap *psg)
 {
-	struct aac_dev *dev;
 	unsigned long byte_count = 0;
 	int nseg;
 	struct scatterlist *sg;
 	int i;
 
-	dev = (struct aac_dev *)scsicmd->device->host->hostdata;
 	// Get rid of old data
 	psg->count = 0;
 	psg->sg[0].addr = 0;
@@ -3963,14 +3958,12 @@ static long aac_build_sg(struct scsi_cmnd *scsicmd, struct sgmap *psg)
 
 static long aac_build_sg64(struct scsi_cmnd *scsicmd, struct sgmap64 *psg)
 {
-	struct aac_dev *dev;
 	unsigned long byte_count = 0;
 	u64 addr;
 	int nseg;
 	struct scatterlist *sg;
 	int i;
 
-	dev = (struct aac_dev *)scsicmd->device->host->hostdata;
 	// Get rid of old data
 	psg->count = 0;
 	psg->sg[0].addr[0] = 0;
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 6e1b022a823d..1e77d96a18f2 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -2586,9 +2586,7 @@ int aac_acquire_irq(struct aac_dev *dev)
 void aac_free_irq(struct aac_dev *dev)
 {
 	int i;
-	int cpu;
 
-	cpu = cpumask_first(cpu_online_mask);
 	if (aac_is_src(dev)) {
 		if (dev->max_msix > 1) {
 			for (i = 0; i < dev->max_msix; i++)
-- 
2.17.1

