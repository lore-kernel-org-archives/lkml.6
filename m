Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBFOeU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:34:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48237 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeBFOeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:34:14 -0500
From: Colin King <colin.king@canonical.com>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: pmcraid: remove redundant initializations of pointer 'ioadl'
Date: Tue,  6 Feb 2018 14:34:10 +0000
Message-Id: <20180206143410.32210-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several occurrances where pointer ioadl is initialized with a
value that is never read and where it is re-assigned a new value later
on, hence the initialization is redundant and can be removed.

Cleans up clang warnings:
drivers/scsi/pmcraid.c:1028:29: warning: Value stored to 'ioadl' during
its initialization is never read
drivers/scsi/pmcraid.c:3178:29: warning: Value stored to 'ioadl' during
its initialization is never read
drivers/scsi/pmcraid.c:5495:29: warning: Value stored to 'ioadl' during
its initialization is never read
drivers/scsi/pmcraid.c:5668:29: warning: Value stored to 'ioadl' during
its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/pmcraid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 201c8de1853d..9330cc5ba34d 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -1025,7 +1025,7 @@ static void pmcraid_get_fwversion_done(struct pmcraid_cmd *cmd)
 static void pmcraid_get_fwversion(struct pmcraid_cmd *cmd)
 {
 	struct pmcraid_ioarcb *ioarcb = &cmd->ioa_cb->ioarcb;
-	struct pmcraid_ioadl_desc *ioadl = ioarcb->add_data.u.ioadl;
+	struct pmcraid_ioadl_desc *ioadl;
 	struct pmcraid_instance *pinstance = cmd->drv_inst;
 	u16 data_size = sizeof(struct pmcraid_inquiry_data);
 
@@ -3175,7 +3175,7 @@ static int pmcraid_build_ioadl(
 
 	struct scsi_cmnd *scsi_cmd = cmd->scsi_cmd;
 	struct pmcraid_ioarcb *ioarcb = &(cmd->ioa_cb->ioarcb);
-	struct pmcraid_ioadl_desc *ioadl = ioarcb->add_data.u.ioadl;
+	struct pmcraid_ioadl_desc *ioadl;
 
 	u32 length = scsi_bufflen(scsi_cmd);
 
@@ -5492,7 +5492,7 @@ static void pmcraid_set_timestamp(struct pmcraid_cmd *cmd)
 	struct pmcraid_instance *pinstance = cmd->drv_inst;
 	struct pmcraid_ioarcb *ioarcb = &cmd->ioa_cb->ioarcb;
 	__be32 time_stamp_len = cpu_to_be32(PMCRAID_TIMESTAMP_LEN);
-	struct pmcraid_ioadl_desc *ioadl = ioarcb->add_data.u.ioadl;
+	struct pmcraid_ioadl_desc *ioadl;
 	u64 timestamp;
 
 	timestamp = ktime_get_real_seconds() * 1000;
@@ -5665,7 +5665,7 @@ static void pmcraid_init_res_table(struct pmcraid_cmd *cmd)
 static void pmcraid_querycfg(struct pmcraid_cmd *cmd)
 {
 	struct pmcraid_ioarcb *ioarcb = &cmd->ioa_cb->ioarcb;
-	struct pmcraid_ioadl_desc *ioadl = ioarcb->add_data.u.ioadl;
+	struct pmcraid_ioadl_desc *ioadl;
 	struct pmcraid_instance *pinstance = cmd->drv_inst;
 	__be32 cfg_table_size = cpu_to_be32(sizeof(struct pmcraid_config_table));
 
-- 
2.15.1
