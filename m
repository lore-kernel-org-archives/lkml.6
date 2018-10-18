Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A98ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC46C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="anDiJ96d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC46C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeJSCCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728822AbeJSCCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:02:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA298214C2;
        Thu, 18 Oct 2018 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885631;
        bh=4GO1oivVHFCo+Ct99KHH7lcrdRjNbXBj8/RIpDqkoK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anDiJ96dQqI0hlP9a/Ib5W+Hsp4YKwXGQuHGK4TivvRFXhGf7ghfuN4iXm7I2N5L1
         kk9MVxl75IezNSrEa16W5ssu/BQArm5+pLfyNvmcdDbz/hnCTFDt8rj43D9xDLHvfR
         2KbBUrYCKc+1CKuNoFHSP1PF1dvTY0SrazQvdzfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 22/41] scsi: ipr: System hung while dlpar adding primary ipr adapter back
Date:   Thu, 18 Oct 2018 19:54:37 +0200
Message-Id: <20181018175420.665737805@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

[ Upstream commit 318ddb34b2052f838aa243d07173e2badf3e630e ]

While dlpar adding primary ipr adapter back, driver goes through adapter
initialization then schedule ipr_worker_thread to start te disk scan by
dropping the host lock, calling scsi_add_device.  Then get the adapter reset
request again, so driver does scsi_block_requests, this will cause the
scsi_add_device get hung until we unblock. But we can't run ipr_worker_thread
to do the unblock because its stuck in scsi_add_device.

This patch fixes the issue.

[mkp: typo and whitespace fixes]

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
Acked-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ipr.c |  106 ++++++++++++++++++++++++++++++-----------------------
 drivers/scsi/ipr.h |    1 
 2 files changed, 62 insertions(+), 45 deletions(-)

--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3308,6 +3308,65 @@ static void ipr_release_dump(struct kref
 	LEAVE;
 }
 
+static void ipr_add_remove_thread(struct work_struct *work)
+{
+	unsigned long lock_flags;
+	struct ipr_resource_entry *res;
+	struct scsi_device *sdev;
+	struct ipr_ioa_cfg *ioa_cfg =
+		container_of(work, struct ipr_ioa_cfg, scsi_add_work_q);
+	u8 bus, target, lun;
+	int did_work;
+
+	ENTER;
+	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+
+restart:
+	do {
+		did_work = 0;
+		if (!ioa_cfg->hrrq[IPR_INIT_HRRQ].allow_cmds) {
+			spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+			return;
+		}
+
+		list_for_each_entry(res, &ioa_cfg->used_res_q, queue) {
+			if (res->del_from_ml && res->sdev) {
+				did_work = 1;
+				sdev = res->sdev;
+				if (!scsi_device_get(sdev)) {
+					if (!res->add_to_ml)
+						list_move_tail(&res->queue, &ioa_cfg->free_res_q);
+					else
+						res->del_from_ml = 0;
+					spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+					scsi_remove_device(sdev);
+					scsi_device_put(sdev);
+					spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+				}
+				break;
+			}
+		}
+	} while (did_work);
+
+	list_for_each_entry(res, &ioa_cfg->used_res_q, queue) {
+		if (res->add_to_ml) {
+			bus = res->bus;
+			target = res->target;
+			lun = res->lun;
+			res->add_to_ml = 0;
+			spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+			scsi_add_device(ioa_cfg->host, bus, target, lun);
+			spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+			goto restart;
+		}
+	}
+
+	ioa_cfg->scan_done = 1;
+	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+	kobject_uevent(&ioa_cfg->host->shost_dev.kobj, KOBJ_CHANGE);
+	LEAVE;
+}
+
 /**
  * ipr_worker_thread - Worker thread
  * @work:		ioa config struct
@@ -3322,13 +3381,9 @@ static void ipr_release_dump(struct kref
 static void ipr_worker_thread(struct work_struct *work)
 {
 	unsigned long lock_flags;
-	struct ipr_resource_entry *res;
-	struct scsi_device *sdev;
 	struct ipr_dump *dump;
 	struct ipr_ioa_cfg *ioa_cfg =
 		container_of(work, struct ipr_ioa_cfg, work_q);
-	u8 bus, target, lun;
-	int did_work;
 
 	ENTER;
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
@@ -3366,49 +3421,9 @@ static void ipr_worker_thread(struct wor
 		return;
 	}
 
-restart:
-	do {
-		did_work = 0;
-		if (!ioa_cfg->hrrq[IPR_INIT_HRRQ].allow_cmds) {
-			spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-			return;
-		}
+	schedule_work(&ioa_cfg->scsi_add_work_q);
 
-		list_for_each_entry(res, &ioa_cfg->used_res_q, queue) {
-			if (res->del_from_ml && res->sdev) {
-				did_work = 1;
-				sdev = res->sdev;
-				if (!scsi_device_get(sdev)) {
-					if (!res->add_to_ml)
-						list_move_tail(&res->queue, &ioa_cfg->free_res_q);
-					else
-						res->del_from_ml = 0;
-					spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-					scsi_remove_device(sdev);
-					scsi_device_put(sdev);
-					spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
-				}
-				break;
-			}
-		}
-	} while (did_work);
-
-	list_for_each_entry(res, &ioa_cfg->used_res_q, queue) {
-		if (res->add_to_ml) {
-			bus = res->bus;
-			target = res->target;
-			lun = res->lun;
-			res->add_to_ml = 0;
-			spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-			scsi_add_device(ioa_cfg->host, bus, target, lun);
-			spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
-			goto restart;
-		}
-	}
-
-	ioa_cfg->scan_done = 1;
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-	kobject_uevent(&ioa_cfg->host->shost_dev.kobj, KOBJ_CHANGE);
 	LEAVE;
 }
 
@@ -9937,6 +9952,7 @@ static void ipr_init_ioa_cfg(struct ipr_
 	INIT_LIST_HEAD(&ioa_cfg->free_res_q);
 	INIT_LIST_HEAD(&ioa_cfg->used_res_q);
 	INIT_WORK(&ioa_cfg->work_q, ipr_worker_thread);
+	INIT_WORK(&ioa_cfg->scsi_add_work_q, ipr_add_remove_thread);
 	init_waitqueue_head(&ioa_cfg->reset_wait_q);
 	init_waitqueue_head(&ioa_cfg->msi_wait_q);
 	init_waitqueue_head(&ioa_cfg->eeh_wait_q);
--- a/drivers/scsi/ipr.h
+++ b/drivers/scsi/ipr.h
@@ -1568,6 +1568,7 @@ struct ipr_ioa_cfg {
 	u8 saved_mode_page_len;
 
 	struct work_struct work_q;
+	struct work_struct scsi_add_work_q;
 	struct workqueue_struct *reset_work_q;
 
 	wait_queue_head_t reset_wait_q;


