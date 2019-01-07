Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B099C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C00D2183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfAGOlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:41:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:35164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728418AbfAGOlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:41:15 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4C790C515E02D1F4D80;
        Mon,  7 Jan 2019 22:41:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Mon, 7 Jan 2019 22:41:02 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: sd: Make protection lookup tables static
Date:   Mon, 7 Jan 2019 22:41:51 +0800
Message-ID: <1546872111-5627-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the protection lookup tables in sd_prot_flag_mask() and
sd_prot_op() are declared non-static. As such, they will be rebuilt for
each respective function call.

Optimise by making them static.

This saves ~100B object code for sd.c:

Before:
   text	   data	    bss	    dec	    hex	filename
  25403	   1024	     16	  26443	   674b	drivers/scsi/sd.o

After:
  text	   data	    bss	    dec	    hex	filename
  25299	   1024	     16	  26339	   66e3	drivers/scsi/sd.o

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 1d63f3a..89e6d42 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -195,15 +195,15 @@ static inline sector_t sectors_to_logical(struct scsi_device *sdev, sector_t sec
 static inline unsigned int sd_prot_op(bool write, bool dix, bool dif)
 {
 	/* Lookup table: bit 2 (write), bit 1 (dix), bit 0 (dif) */
-	const unsigned int ops[] = {	/* wrt dix dif */
-		SCSI_PROT_NORMAL,	/*  0	0   0  */
-		SCSI_PROT_READ_STRIP,	/*  0	0   1  */
-		SCSI_PROT_READ_INSERT,	/*  0	1   0  */
-		SCSI_PROT_READ_PASS,	/*  0	1   1  */
-		SCSI_PROT_NORMAL,	/*  1	0   0  */
-		SCSI_PROT_WRITE_INSERT, /*  1	0   1  */
-		SCSI_PROT_WRITE_STRIP,	/*  1	1   0  */
-		SCSI_PROT_WRITE_PASS,	/*  1	1   1  */
+	static const unsigned int ops[] = {	/* wrt dix dif */
+		SCSI_PROT_NORMAL,		/*  0	0   0  */
+		SCSI_PROT_READ_STRIP,		/*  0	0   1  */
+		SCSI_PROT_READ_INSERT,		/*  0	1   0  */
+		SCSI_PROT_READ_PASS,		/*  0	1   1  */
+		SCSI_PROT_NORMAL,		/*  1	0   0  */
+		SCSI_PROT_WRITE_INSERT,		/*  1	0   1  */
+		SCSI_PROT_WRITE_STRIP,		/*  1	1   0  */
+		SCSI_PROT_WRITE_PASS,		/*  1	1   1  */
 	};
 
 	return ops[write << 2 | dix << 1 | dif];
@@ -215,7 +215,7 @@ static inline unsigned int sd_prot_op(bool write, bool dix, bool dif)
  */
 static inline unsigned int sd_prot_flag_mask(unsigned int prot_op)
 {
-	const unsigned int flag_mask[] = {
+	static const unsigned int flag_mask[] = {
 		[SCSI_PROT_NORMAL]		= 0,
 
 		[SCSI_PROT_READ_STRIP]		= SCSI_PROT_TRANSFER_PI |
-- 
1.9.1

