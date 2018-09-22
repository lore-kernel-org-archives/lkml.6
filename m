Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A17C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D76620684
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D76620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392238AbeIVGLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:11:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44339 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392075AbeIVGKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:52 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Ve1-0008BS-1M; Sat, 22 Sep 2018 01:19:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000rS-Ps; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Xiaofei Tan" <tanxiaofei@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "John Garry" <john.garry@huawei.com>,
        "Jason Yan" <yanaijie@huawei.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.218539845@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 22/63] scsi: libsas: defer ata device eh commands to
 libata
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Yan <yanaijie@huawei.com>

commit 318aaf34f1179b39fa9c30fa0f3288b645beee39 upstream.

When ata device doing EH, some commands still attached with tasks are
not passed to libata when abort failed or recover failed, so libata did
not handle these commands. After these commands done, sas task is freed,
but ata qc is not freed. This will cause ata qc leak and trigger a
warning like below:

WARNING: CPU: 0 PID: 28512 at drivers/ata/libata-eh.c:4037
ata_eh_finish+0xb4/0xcc
CPU: 0 PID: 28512 Comm: kworker/u32:2 Tainted: G     W  OE 4.14.0#1
......
Call trace:
[<ffff0000088b7bd0>] ata_eh_finish+0xb4/0xcc
[<ffff0000088b8420>] ata_do_eh+0xc4/0xd8
[<ffff0000088b8478>] ata_std_error_handler+0x44/0x8c
[<ffff0000088b8068>] ata_scsi_port_error_handler+0x480/0x694
[<ffff000008875fc4>] async_sas_ata_eh+0x4c/0x80
[<ffff0000080f6be8>] async_run_entry_fn+0x4c/0x170
[<ffff0000080ebd70>] process_one_work+0x144/0x390
[<ffff0000080ec100>] worker_thread+0x144/0x418
[<ffff0000080f2c98>] kthread+0x10c/0x138
[<ffff0000080855dc>] ret_from_fork+0x10/0x18

If ata qc leaked too many, ata tag allocation will fail and io blocked
for ever.

As suggested by Dan Williams, defer ata device commands to libata and
merge sas_eh_finish_cmd() with sas_eh_defer_cmd(). libata will handle
ata qcs correctly after this.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: Xiaofei Tan <tanxiaofei@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/libsas/sas_scsi_host.c | 33 ++++++++++++-----------------
 1 file changed, 13 insertions(+), 20 deletions(-)

--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -250,6 +250,7 @@ out_done:
 static void sas_eh_finish_cmd(struct scsi_cmnd *cmd)
 {
 	struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(cmd->device->host);
+	struct domain_device *dev = cmd_to_domain_dev(cmd);
 	struct sas_task *task = TO_SAS_TASK(cmd);
 
 	/* At this point, we only get called following an actual abort
@@ -258,6 +259,14 @@ static void sas_eh_finish_cmd(struct scs
 	 */
 	sas_end_task(cmd, task);
 
+	if (dev_is_sata(dev)) {
+		/* defer commands to libata so that libata EH can
+		 * handle ata qcs correctly
+		 */
+		list_move_tail(&cmd->eh_entry, &sas_ha->eh_ata_q);
+		return;
+	}
+
 	/* now finish the command and move it on to the error
 	 * handler done list, this also takes it off the
 	 * error handler pending list.
@@ -265,22 +274,6 @@ static void sas_eh_finish_cmd(struct scs
 	scsi_eh_finish_cmd(cmd, &sas_ha->eh_done_q);
 }
 
-static void sas_eh_defer_cmd(struct scsi_cmnd *cmd)
-{
-	struct domain_device *dev = cmd_to_domain_dev(cmd);
-	struct sas_ha_struct *ha = dev->port->ha;
-	struct sas_task *task = TO_SAS_TASK(cmd);
-
-	if (!dev_is_sata(dev)) {
-		sas_eh_finish_cmd(cmd);
-		return;
-	}
-
-	/* report the timeout to libata */
-	sas_end_task(cmd, task);
-	list_move_tail(&cmd->eh_entry, &ha->eh_ata_q);
-}
-
 static void sas_scsi_clear_queue_lu(struct list_head *error_q, struct scsi_cmnd *my_cmd)
 {
 	struct scsi_cmnd *cmd, *n;
@@ -288,7 +281,7 @@ static void sas_scsi_clear_queue_lu(stru
 	list_for_each_entry_safe(cmd, n, error_q, eh_entry) {
 		if (cmd->device->sdev_target == my_cmd->device->sdev_target &&
 		    cmd->device->lun == my_cmd->device->lun)
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 	}
 }
 
@@ -677,12 +670,12 @@ static void sas_eh_handle_sas_errors(str
 		case TASK_IS_DONE:
 			SAS_DPRINTK("%s: task 0x%p is done\n", __func__,
 				    task);
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 			continue;
 		case TASK_IS_ABORTED:
 			SAS_DPRINTK("%s: task 0x%p is aborted\n",
 				    __func__, task);
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 			continue;
 		case TASK_IS_AT_LU:
 			SAS_DPRINTK("task 0x%p is at LU: lu recover\n", task);
@@ -693,7 +686,7 @@ static void sas_eh_handle_sas_errors(str
 					    "recovered\n",
 					    SAS_ADDR(task->dev),
 					    cmd->device->lun);
-				sas_eh_defer_cmd(cmd);
+				sas_eh_finish_cmd(cmd);
 				sas_scsi_clear_queue_lu(work_q, cmd);
 				goto Again;
 			}

