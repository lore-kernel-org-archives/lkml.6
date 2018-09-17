Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE556ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794AF20883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794AF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeIQU3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:29:31 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:51470 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbeIQU3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:29:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 966C518224D75;
        Mon, 17 Sep 2018 15:01:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dogs19_494d9e823224e
X-Filterd-Recvd-Size: 7280
Received: from joe-laptop.perches.com (mb42736d0.tmodns.net [208.54.39.180])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Sep 2018 15:01:43 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] mpt3sas: Convert mlsleading uses of pr_<level> with MPT3SAS_FMT
Date:   Mon, 17 Sep 2018 08:01:10 -0700
Message-Id: <71b9656aa46ec31a9991587d7ff204e0877a336e.1537183088.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1537183087.git.joe@perches.com>
References: <cover.1537183087.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These have misordered uses of __func__ and ioc->name that could
mismatch MPT3SAS_FMT and "%s: ".

Convert them to ioc_<level>.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 50 +++++++++++++++-----------------
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 18 ++++--------
 2 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 3331eba4b78d..8089be381c72 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2627,15 +2627,13 @@ mpt3sas_scsih_issue_tm(struct MPT3SAS_ADAPTER *ioc, u16 handle, u64 lun,
 	lockdep_assert_held(&ioc->tm_cmds.mutex);
 
 	if (ioc->tm_cmds.status != MPT3_CMD_NOT_USED) {
-		pr_info(MPT3SAS_FMT "%s: tm_cmd busy!!!\n",
-		    __func__, ioc->name);
+		ioc_info(ioc, "%s: tm_cmd busy!!!\n", __func__);
 		return FAILED;
 	}
 
 	if (ioc->shost_recovery || ioc->remove_host ||
 	    ioc->pci_error_recovery) {
-		pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
-		    __func__, ioc->name);
+		ioc_info(ioc, "%s: host reset in progress!\n", __func__);
 		return FAILED;
 	}
 
@@ -3550,18 +3548,16 @@ _scsih_tm_tr_send(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 	u8 tr_method = 0;
 
 	if (ioc->pci_error_recovery) {
-		dewtprintk(ioc, pr_info(MPT3SAS_FMT
-			"%s: host in pci error recovery: handle(0x%04x)\n",
-			__func__, ioc->name,
-		    handle));
+		dewtprintk(ioc,
+			   ioc_info(ioc, "%s: host in pci error recovery: handle(0x%04x)\n",
+				    __func__, handle));
 		return;
 	}
 	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
 	if (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		dewtprintk(ioc, pr_info(MPT3SAS_FMT
-			"%s: host is not operational: handle(0x%04x)\n",
-			__func__, ioc->name,
-		   handle));
+		dewtprintk(ioc,
+			   ioc_info(ioc, "%s: host is not operational: handle(0x%04x)\n",
+				    __func__, handle));
 		return;
 	}
 
@@ -3811,9 +3807,9 @@ _scsih_tm_tr_volume_send(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 	struct _tr_list *delayed_tr;
 
 	if (ioc->pci_error_recovery) {
-		dewtprintk(ioc, pr_info(MPT3SAS_FMT
-			"%s: host reset in progress!\n",
-			__func__, ioc->name));
+		dewtprintk(ioc,
+			   ioc_info(ioc, "%s: host reset in progress!\n",
+				    __func__));
 		return;
 	}
 
@@ -3863,9 +3859,9 @@ _scsih_tm_volume_tr_complete(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	    mpt3sas_base_get_reply_virt_addr(ioc, reply);
 
 	if (ioc->shost_recovery || ioc->pci_error_recovery) {
-		dewtprintk(ioc, pr_info(MPT3SAS_FMT
-			"%s: host reset in progress!\n",
-			__func__, ioc->name));
+		dewtprintk(ioc,
+			   ioc_info(ioc, "%s: host reset in progress!\n",
+				    __func__));
 		return 1;
 	}
 	if (unlikely(!mpi_reply)) {
@@ -3950,21 +3946,21 @@ _scsih_issue_delayed_sas_io_unit_ctrl(struct MPT3SAS_ADAPTER *ioc,
 	unsigned long flags;
 
 	if (ioc->remove_host) {
-		dewtprintk(ioc, pr_info(MPT3SAS_FMT
-			    "%s: host has been removed\n",
-			     __func__, ioc->name));
+		dewtprintk(ioc,
+			   ioc_info(ioc, "%s: host has been removed\n",
+				    __func__));
 		return;
 	} else if (ioc->pci_error_recovery) {
-		dewtprintk(ioc, pr_info(MPT3SAS_FMT
-			    "%s: host in pci error recovery\n",
-			    __func__, ioc->name));
+		dewtprintk(ioc,
+			   ioc_info(ioc, "%s: host in pci error recovery\n",
+				    __func__));
 		return;
 	}
 	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
 	if (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		dewtprintk(ioc, pr_info(MPT3SAS_FMT
-		    "%s: host is not operational\n",
-		    __func__, ioc->name));
+		dewtprintk(ioc,
+			   ioc_info(ioc, "%s: host is not operational\n",
+				    __func__));
 		return;
 	}
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index d4bf4d5e576e..09034a3fba2c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -146,8 +146,7 @@ _transport_set_identify(struct MPT3SAS_ADAPTER *ioc, u16 handle,
 	u32 ioc_status;
 
 	if (ioc->shost_recovery || ioc->pci_error_recovery) {
-		pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
-		    __func__, ioc->name);
+		ioc_info(ioc, "%s: host reset in progress!\n", __func__);
 		return -EFAULT;
 	}
 
@@ -308,8 +307,7 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 	u16 wait_state_count;
 
 	if (ioc->shost_recovery || ioc->pci_error_recovery) {
-		pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
-		    __func__, ioc->name);
+		ioc_info(ioc, "%s: host reset in progress!\n", __func__);
 		return -EFAULT;
 	}
 
@@ -1088,8 +1086,7 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
 	u16 wait_state_count;
 
 	if (ioc->shost_recovery || ioc->pci_error_recovery) {
-		pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
-		    __func__, ioc->name);
+		ioc_info(ioc, "%s: host reset in progress!\n", __func__);
 		return -EFAULT;
 	}
 
@@ -1393,8 +1390,7 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
 	u16 wait_state_count;
 
 	if (ioc->shost_recovery || ioc->pci_error_recovery) {
-		pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
-		    __func__, ioc->name);
+		ioc_info(ioc, "%s: host reset in progress!\n", __func__);
 		return -EFAULT;
 	}
 
@@ -1894,8 +1890,7 @@ _transport_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 	unsigned int reslen = 0;
 
 	if (ioc->shost_recovery || ioc->pci_error_recovery) {
-		pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
-		    __func__, ioc->name);
+		ioc_info(ioc, "%s: host reset in progress!\n", __func__);
 		rc = -EFAULT;
 		goto job_done;
 	}
@@ -1975,8 +1970,7 @@ _transport_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 	wait_for_completion_timeout(&ioc->transport_cmds.done, 10*HZ);
 
 	if (!(ioc->transport_cmds.status & MPT3_CMD_COMPLETE)) {
-		pr_err(MPT3SAS_FMT "%s : timeout\n",
-		    __func__, ioc->name);
+		ioc_err(ioc, "%s: timeout\n", __func__);
 		_debug_dump_mf(mpi_request,
 		    sizeof(Mpi2SmpPassthroughRequest_t)/4);
 		if (!(ioc->transport_cmds.status & MPT3_CMD_RESET)) {
-- 
2.15.0

