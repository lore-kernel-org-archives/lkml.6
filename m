Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2987DC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A0C217CC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jzzCXrLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A0C217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeHEPbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 11:31:03 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42878 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHEPbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 11:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533475638; x=1565011638;
  h=from:to:cc:subject:date:message-id;
  bh=20KydnLzX5bRvNXL/A55QwtNhGex024sla5+bUixs8w=;
  b=jzzCXrLPlBHWfsYO57q6d1PLcdd3CQGHu2OZzna6iRPnNR/qIiRBSohp
   4JhhZNuzs7y2PVW+x1vlUBVjCElu01inw44wW+jLXrhk6Lz3y3V4rAsdx
   KSJYApfa1vQsPVj8SbJaYRdTLxiy8nsG7oo8a/QrVXv49UDashLultIGW
   Q3XWPcgw3W1Hl4u9wjkiEEdagRVCqU3llRlx88860fyEN+O5PQA6wcoFC
   ylg4250e23NOER2Ixx42VlPJK6HKkfeMbKiu3yk3TQLDAqm+7ezDOjDs/
   ZJsCFo2WcoAlMBIu6f+SsjjMtiF4KdoxeYp08te3ulvDuxfXkiOgHMGBq
   w==;
X-IronPort-AV: E=Sophos;i="5.51,447,1526313600"; 
   d="scan'208";a="183900885"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Aug 2018 21:27:18 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 05 Aug 2018 06:14:47 -0700
Received: from ile419070.sdcorp.global.sandisk.com ([10.0.230.165])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Aug 2018 06:26:26 -0700
From:   Ohad Sharabi <ohad.sharabi@wdc.com>
To:     stanislav.nijnikov@wdc.com, avri.altman@wdc.com,
        alex.lemberg@wdc.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, gregkh@linuxfoundation.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ohad Sharabi <ohad.sharabi@wdc.com>
Subject: [PATCH v2] scsi: ufs: remove unnecessary query(DM) UPIU trace
Date:   Sun,  5 Aug 2018 16:26:23 +0300
Message-Id: <1533475583-16939-1-git-send-email-ohad.sharabi@wdc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes redundant trace that occurs when sending Device
Management(DM) request (fix behavior in patch
https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git/commit/?id=6667e6d91c88a788d5ab1b1e999d245473e84a9)
Since the function send_command is called also for DM request, UPIU trace
for DM request is called twice- one identified as query_* the other as
send/complete.

Signed-off-by: Ohad Sharabi <ohad.sharabi@wdc.com>
reviewed-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
reviewed-by: Avri Altman <avri.altman@wdc.com>
---
v1->v2:
	- modify sender's domain (sandisk->wdc)
	- add reviewers

 drivers/scsi/ufs/ufshcd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 397081d..33e6dd0 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -321,18 +321,19 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba,
 	sector_t lba = -1;
 	u8 opcode = 0;
 	u32 intr, doorbell;
-	struct ufshcd_lrb *lrbp;
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	int transfer_len = -1;
 
-	/* trace UPIU also */
-	ufshcd_add_cmd_upiu_trace(hba, tag, str);
-
-	if (!trace_ufshcd_command_enabled())
+	if (!trace_ufshcd_command_enabled()) {
+		/* trace UPIU W/O tracing command */
+		if (lrbp->cmd)
+			ufshcd_add_cmd_upiu_trace(hba, tag, str);
 		return;
-
-	lrbp = &hba->lrb[tag];
+	}
 
 	if (lrbp->cmd) { /* data phase exists */
+		/* trace UPIU also */
+		ufshcd_add_cmd_upiu_trace(hba, tag, str);
 		opcode = (u8)(*lrbp->cmd->cmnd);
 		if ((opcode == READ_10) || (opcode == WRITE_10)) {
 			/*
-- 
1.9.1

