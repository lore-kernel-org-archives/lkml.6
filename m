Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA70C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2883D2403D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2883D2403D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753887AbeGELBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:01:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753602AbeGELBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:01:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35C68AFAA;
        Thu,  5 Jul 2018 11:01:43 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 4/4] scsi: ncr53c8xx: remove ScsiResult macro
Date:   Thu,  5 Jul 2018 13:01:40 +0200
Message-Id: <20180705110140.19545-5-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180705110140.19545-1-jthumshirn@suse.de>
References: <20180705110140.19545-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ScsiResult macro and open code it on all call sites.

This will make subsequent refactoring in this area easier.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/ncr53c8xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index dc4e801b2cef..6cd3e289ef99 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -4611,7 +4611,7 @@ static int ncr_reset_bus (struct ncb *np, struct scsi_cmnd *cmd, int sync_reset)
  * in order to keep it alive.
  */
 	if (!found && sync_reset && !retrieve_from_waiting_list(0, np, cmd)) {
-		cmd->result = ScsiResult(DID_RESET, 0);
+		cmd->result = DID_RESET << 16;
 		ncr_queue_done_cmd(np, cmd);
 	}
 
@@ -4957,7 +4957,7 @@ void ncr_complete (struct ncb *np, struct ccb *cp)
 		/*
 		**   Check condition code
 		*/
-		cmd->result = ScsiResult(DID_OK, S_CHECK_COND);
+		cmd->result = DID_OK << 16 | S_CHECK_COND;
 
 		/*
 		**	Copy back sense data to caller's buffer.
@@ -4978,7 +4978,7 @@ void ncr_complete (struct ncb *np, struct ccb *cp)
 		/*
 		**   Reservation Conflict condition code
 		*/
-		cmd->result = ScsiResult(DID_OK, S_CONFLICT);
+		cmd->result = DID_OK << 16 | S_CONFLICT;
 	
 	} else if ((cp->host_status == HS_COMPLETE)
 		&& (cp->scsi_status == S_BUSY ||
@@ -8043,7 +8043,7 @@ printk("ncr53c8xx_queue_command\n");
      spin_lock_irqsave(&np->smp_lock, flags);
 
      if ((sts = ncr_queue_command(np, cmd)) != DID_OK) {
-	  cmd->result = ScsiResult(sts, 0);
+	  cmd->result = sts << 16;
 #ifdef DEBUG_NCR53C8XX
 printk("ncr53c8xx : command not queued - result=%d\n", sts);
 #endif
@@ -8234,7 +8234,7 @@ static void process_waiting_list(struct ncb *np, int sts)
 #ifdef DEBUG_WAITING_LIST
 	printk("%s: cmd %lx done forced sts=%d\n", ncr_name(np), (u_long) wcmd, sts);
 #endif
-			wcmd->result = ScsiResult(sts, 0);
+			wcmd->result = sts << 16;
 			ncr_queue_done_cmd(np, wcmd);
 		}
 	}
-- 
2.16.4

