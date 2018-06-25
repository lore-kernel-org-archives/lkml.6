Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D23EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64197257F1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64197257F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755178AbeFYLVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:21:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752711AbeFYLVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:21:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C19DAE55;
        Mon, 25 Jun 2018 11:21:05 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 2/2] scsi: don't add scsi command result bytes
Date:   Mon, 25 Jun 2018 13:20:59 +0200
Message-Id: <20180625112059.12872-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180625112059.12872-1-jthumshirn@suse.de>
References: <20180625112059.12872-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers are ADDing the scsi command's result bytes instead of
ORing them.

While this can produce correct results it has unexpected side effects.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>

---
Changes since v2:
- Re-added braces around shift operators (Bart, Christoph)
- Add Reviewed-bys

Changes since v1:
- Fix kbuild robot warnings
---
 drivers/scsi/imm.c                  | 2 +-
 drivers/scsi/mesh.c                 | 4 ++--
 drivers/scsi/sym53c8xx_2/sym_glue.c | 2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 87c94191033b..8c6627bc8a39 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -892,7 +892,7 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 			/* Check for optional message byte */
 			if (imm_wait(dev) == (unsigned char) 0xb8)
 				imm_in(dev, &h, 1);
-			cmd->result = (DID_OK << 16) + (l & STATUS_MASK);
+			cmd->result = (DID_OK << 16) | (l & STATUS_MASK);
 		}
 		if ((dev->mode == IMM_NIBBLE) || (dev->mode == IMM_PS2)) {
 			w_ctr(ppb, 0x4);
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index 1753e42826dd..82e01dbe90af 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -594,9 +594,9 @@ static void mesh_done(struct mesh_state *ms, int start_next)
 	ms->current_req = NULL;
 	tp->current_req = NULL;
 	if (cmd) {
-		cmd->result = (ms->stat << 16) + cmd->SCp.Status;
+		cmd->result = (ms->stat << 16) | cmd->SCp.Status;
 		if (ms->stat == DID_OK)
-			cmd->result += (cmd->SCp.Message << 8);
+			cmd->result |= cmd->SCp.Message << 8;
 		if (DEBUG_TARGET(cmd)) {
 			printk(KERN_DEBUG "mesh_done: result = %x, data_ptr=%d, buflen=%d\n",
 			       cmd->result, ms->data_ptr, scsi_bufflen(cmd));
diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
index 7320d5fe4cbc..5f10aa9bad9b 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -252,7 +252,7 @@ void sym_set_cam_result_error(struct sym_hcb *np, struct sym_ccb *cp, int resid)
 		cam_status = sym_xerr_cam_status(DID_ERROR, cp->xerr_status);
 	}
 	scsi_set_resid(cmd, resid);
-	cmd->result = (drv_status << 24) + (cam_status << 16) + scsi_status;
+	cmd->result = (drv_status << 24) | (cam_status << 16) | scsi_status;
 }
 
 static int sym_scatter(struct sym_hcb *np, struct sym_ccb *cp, struct scsi_cmnd *cmd)
diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.h b/drivers/scsi/sym53c8xx_2/sym_glue.h
index 805369521df8..e34801ae5d69 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.h
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.h
@@ -256,7 +256,7 @@ sym_get_cam_status(struct scsi_cmnd *cmd)
 static inline void sym_set_cam_result_ok(struct sym_ccb *cp, struct scsi_cmnd *cmd, int resid)
 {
 	scsi_set_resid(cmd, resid);
-	cmd->result = (((DID_OK) << 16) + ((cp->ssss_status) & 0x7f));
+	cmd->result = (DID_OK << 16) | (cp->ssss_status & 0x7f);
 }
 void sym_set_cam_result_error(struct sym_hcb *np, struct sym_ccb *cp, int resid);
 
-- 
2.16.4

