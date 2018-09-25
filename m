Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30636C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56E52086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kOOT5WCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56E52086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeIYVm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:42:57 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43162 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729353AbeIYVm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:42:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F1BA8EE23D;
        Tue, 25 Sep 2018 08:34:54 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jp6m6w0wJ_0V; Tue, 25 Sep 2018 08:34:54 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9D6158EE0ED;
        Tue, 25 Sep 2018 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1537889693;
        bh=Bh3+rVLZOWFAJMpvOYBn6YKcJ1V13pm6GTWxpq+WG7g=;
        h=Subject:From:To:Cc:Date:From;
        b=kOOT5WCVw2yCSfWCdIDnjAywSUUFD8jmcgCBI3V8z5E6SVMJBjjaNFQ+LmR2k6YWk
         2cnIzVFmHvymMqMB2t/abCEBGPgRWWlx5K8gJogadtAjOusfRlxEtV5eHZeQxVNtFd
         OyoKyz2gnhMH7ONMxeaEawim88MLMP5TO15BLm7I=
Message-ID: <1537889692.5951.2.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 4.19-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Sep 2018 08:34:52 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nine obvious bug fixes mostly in individual drivers.  The target fix is
of particular importance because it's CVE related.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Adrian Hunter (1):
      scsi: ufs: Disable blk-mq for now

James Smart (1):
      scsi: lpfc: Synchronize access to remoteport via rport

Johannes Thumshirn (1):
      scsi: sd: don't crash the host on invalid commands

Laura Abbott (2):
      scsi: ibmvscsis: Ensure partition name is properly NUL terminated
      scsi: ibmvscsis: Fix a stringop-overflow warning

Vincent Pelletier (2):
      scsi: target: iscsi: Use bin2hex instead of a re-implementation
      scsi: target: iscsi: Use hex2bin instead of a re-implementation

Wen Xiong (1):
      scsi: ipr: System hung while dlpar adding primary ipr adapter back

Xuewei Zhang (1):
      scsi: sd: Contribute to randomness when running rotational device

And the diffstat:

 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c |   5 +-
 drivers/scsi/ipr.c                       | 106 ++++++++++++++++++-------------
 drivers/scsi/ipr.h                       |   1 +
 drivers/scsi/lpfc/lpfc_attr.c            |  15 +++--
 drivers/scsi/lpfc/lpfc_debugfs.c         |  10 +--
 drivers/scsi/lpfc/lpfc_nvme.c            |  11 +++-
 drivers/scsi/sd.c                        |   6 +-
 drivers/scsi/ufs/ufshcd.c                |   7 ++
 drivers/target/iscsi/iscsi_target_auth.c |  45 +++++--------
 9 files changed, 116 insertions(+), 90 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index fac377320158..f42a619198c4 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3474,11 +3474,10 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 		vscsi->dds.window[LOCAL].liobn,
 		vscsi->dds.window[REMOTE].liobn);
 
-	strcpy(vscsi->eye, "VSCSI ");
-	strncat(vscsi->eye, vdev->name, MAX_EYE);
+	snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI %s", vdev->name);
 
 	vscsi->dds.unit_id = vdev->unit_address;
-	strncpy(vscsi->dds.partition_name, partition_name,
+	strscpy(vscsi->dds.partition_name, partition_name,
 		sizeof(vscsi->dds.partition_name));
 	vscsi->dds.partition_num = partition_number;
 
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index f2ec80b0ffc0..271990bc065b 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3335,6 +3335,65 @@ static void ipr_release_dump(struct kref *kref)
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
@@ -3349,13 +3408,9 @@ static void ipr_release_dump(struct kref *kref)
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
@@ -3393,49 +3448,9 @@ static void ipr_worker_thread(struct work_struct *work)
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
 
@@ -9933,6 +9948,7 @@ static void ipr_init_ioa_cfg(struct ipr_ioa_cfg *ioa_cfg,
 	INIT_LIST_HEAD(&ioa_cfg->free_res_q);
 	INIT_LIST_HEAD(&ioa_cfg->used_res_q);
 	INIT_WORK(&ioa_cfg->work_q, ipr_worker_thread);
+	INIT_WORK(&ioa_cfg->scsi_add_work_q, ipr_add_remove_thread);
 	init_waitqueue_head(&ioa_cfg->reset_wait_q);
 	init_waitqueue_head(&ioa_cfg->msi_wait_q);
 	init_waitqueue_head(&ioa_cfg->eeh_wait_q);
diff --git a/drivers/scsi/ipr.h b/drivers/scsi/ipr.h
index 68afbbde54d3..f6baa2351313 100644
--- a/drivers/scsi/ipr.h
+++ b/drivers/scsi/ipr.h
@@ -1575,6 +1575,7 @@ struct ipr_ioa_cfg {
 	u8 saved_mode_page_len;
 
 	struct work_struct work_q;
+	struct work_struct scsi_add_work_q;
 	struct workqueue_struct *reset_work_q;
 
 	wait_queue_head_t reset_wait_q;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 057a60abe664..1a6ed9b0a249 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -360,12 +360,12 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 		goto buffer_done;
 
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
+		nrport = NULL;
+		spin_lock(&vport->phba->hbalock);
 		rport = lpfc_ndlp_get_nrport(ndlp);
-		if (!rport)
-			continue;
-
-		/* local short-hand pointer. */
-		nrport = rport->remoteport;
+		if (rport)
+			nrport = rport->remoteport;
+		spin_unlock(&vport->phba->hbalock);
 		if (!nrport)
 			continue;
 
@@ -3386,6 +3386,7 @@ lpfc_update_rport_devloss_tmo(struct lpfc_vport *vport)
 	struct lpfc_nodelist  *ndlp;
 #if (IS_ENABLED(CONFIG_NVME_FC))
 	struct lpfc_nvme_rport *rport;
+	struct nvme_fc_remote_port *remoteport = NULL;
 #endif
 
 	shost = lpfc_shost_from_vport(vport);
@@ -3396,8 +3397,12 @@ lpfc_update_rport_devloss_tmo(struct lpfc_vport *vport)
 		if (ndlp->rport)
 			ndlp->rport->dev_loss_tmo = vport->cfg_devloss_tmo;
 #if (IS_ENABLED(CONFIG_NVME_FC))
+		spin_lock(&vport->phba->hbalock);
 		rport = lpfc_ndlp_get_nrport(ndlp);
 		if (rport)
+			remoteport = rport->remoteport;
+		spin_unlock(&vport->phba->hbalock);
+		if (remoteport)
 			nvme_fc_set_remoteport_devloss(rport->remoteport,
 						       vport->cfg_devloss_tmo);
 #endif
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 9df0c051349f..aec5b10a8c85 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -551,7 +551,7 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
 	unsigned char *statep;
 	struct nvme_fc_local_port *localport;
 	struct lpfc_nvmet_tgtport *tgtp;
-	struct nvme_fc_remote_port *nrport;
+	struct nvme_fc_remote_port *nrport = NULL;
 	struct lpfc_nvme_rport *rport;
 
 	cnt = (LPFC_NODELIST_SIZE / LPFC_NODELIST_ENTRY_SIZE);
@@ -696,11 +696,11 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
 	len += snprintf(buf + len, size - len, "\tRport List:\n");
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
 		/* local short-hand pointer. */
+		spin_lock(&phba->hbalock);
 		rport = lpfc_ndlp_get_nrport(ndlp);
-		if (!rport)
-			continue;
-
-		nrport = rport->remoteport;
+		if (rport)
+			nrport = rport->remoteport;
+		spin_unlock(&phba->hbalock);
 		if (!nrport)
 			continue;
 
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 028462e5994d..918ae18ef8a8 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2725,7 +2725,9 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	rpinfo.port_name = wwn_to_u64(ndlp->nlp_portname.u.wwn);
 	rpinfo.node_name = wwn_to_u64(ndlp->nlp_nodename.u.wwn);
 
+	spin_lock_irq(&vport->phba->hbalock);
 	oldrport = lpfc_ndlp_get_nrport(ndlp);
+	spin_unlock_irq(&vport->phba->hbalock);
 	if (!oldrport)
 		lpfc_nlp_get(ndlp);
 
@@ -2840,7 +2842,7 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	struct nvme_fc_local_port *localport;
 	struct lpfc_nvme_lport *lport;
 	struct lpfc_nvme_rport *rport;
-	struct nvme_fc_remote_port *remoteport;
+	struct nvme_fc_remote_port *remoteport = NULL;
 
 	localport = vport->localport;
 
@@ -2854,11 +2856,14 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	if (!lport)
 		goto input_err;
 
+	spin_lock_irq(&vport->phba->hbalock);
 	rport = lpfc_ndlp_get_nrport(ndlp);
-	if (!rport)
+	if (rport)
+		remoteport = rport->remoteport;
+	spin_unlock_irq(&vport->phba->hbalock);
+	if (!remoteport)
 		goto input_err;
 
-	remoteport = rport->remoteport;
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
 			 "6033 Unreg nvme remoteport %p, portname x%llx, "
 			 "port_id x%06x, portstate x%x port type x%x\n",
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b79b366a94f7..4a57ffecc7e6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1276,7 +1276,8 @@ static int sd_init_command(struct scsi_cmnd *cmd)
 	case REQ_OP_ZONE_RESET:
 		return sd_zbc_setup_reset_cmnd(cmd);
 	default:
-		BUG();
+		WARN_ON_ONCE(1);
+		return BLKPREP_KILL;
 	}
 }
 
@@ -2959,6 +2960,9 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 	if (rot == 1) {
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
+	} else {
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
 	}
 
 	if (sdkp->device->type == TYPE_ZBC) {
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 9d5d2ca7fc4f..c55f38ec391c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7940,6 +7940,13 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 		err = -ENOMEM;
 		goto out_error;
 	}
+
+	/*
+	 * Do not use blk-mq at this time because blk-mq does not support
+	 * runtime pm.
+	 */
+	host->use_blk_mq = false;
+
 	hba = shost_priv(host);
 	hba->host = host;
 	hba->dev = dev;
diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index 9518ffd8b8ba..4e680d753941 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -26,27 +26,6 @@
 #include "iscsi_target_nego.h"
 #include "iscsi_target_auth.h"
 
-static int chap_string_to_hex(unsigned char *dst, unsigned char *src, int len)
-{
-	int j = DIV_ROUND_UP(len, 2), rc;
-
-	rc = hex2bin(dst, src, j);
-	if (rc < 0)
-		pr_debug("CHAP string contains non hex digit symbols\n");
-
-	dst[j] = '\0';
-	return j;
-}
-
-static void chap_binaryhex_to_asciihex(char *dst, char *src, int src_len)
-{
-	int i;
-
-	for (i = 0; i < src_len; i++) {
-		sprintf(&dst[i*2], "%02x", (int) src[i] & 0xff);
-	}
-}
-
 static int chap_gen_challenge(
 	struct iscsi_conn *conn,
 	int caller,
@@ -62,7 +41,7 @@ static int chap_gen_challenge(
 	ret = get_random_bytes_wait(chap->challenge, CHAP_CHALLENGE_LENGTH);
 	if (unlikely(ret))
 		return ret;
-	chap_binaryhex_to_asciihex(challenge_asciihex, chap->challenge,
+	bin2hex(challenge_asciihex, chap->challenge,
 				CHAP_CHALLENGE_LENGTH);
 	/*
 	 * Set CHAP_C, and copy the generated challenge into c_str.
@@ -248,9 +227,16 @@ static int chap_server_compute_md5(
 		pr_err("Could not find CHAP_R.\n");
 		goto out;
 	}
+	if (strlen(chap_r) != MD5_SIGNATURE_SIZE * 2) {
+		pr_err("Malformed CHAP_R\n");
+		goto out;
+	}
+	if (hex2bin(client_digest, chap_r, MD5_SIGNATURE_SIZE) < 0) {
+		pr_err("Malformed CHAP_R\n");
+		goto out;
+	}
 
 	pr_debug("[server] Got CHAP_R=%s\n", chap_r);
-	chap_string_to_hex(client_digest, chap_r, strlen(chap_r));
 
 	tfm = crypto_alloc_shash("md5", 0, 0);
 	if (IS_ERR(tfm)) {
@@ -294,7 +280,7 @@ static int chap_server_compute_md5(
 		goto out;
 	}
 
-	chap_binaryhex_to_asciihex(response, server_digest, MD5_SIGNATURE_SIZE);
+	bin2hex(response, server_digest, MD5_SIGNATURE_SIZE);
 	pr_debug("[server] MD5 Server Digest: %s\n", response);
 
 	if (memcmp(server_digest, client_digest, MD5_SIGNATURE_SIZE) != 0) {
@@ -349,9 +335,7 @@ static int chap_server_compute_md5(
 		pr_err("Could not find CHAP_C.\n");
 		goto out;
 	}
-	pr_debug("[server] Got CHAP_C=%s\n", challenge);
-	challenge_len = chap_string_to_hex(challenge_binhex, challenge,
-				strlen(challenge));
+	challenge_len = DIV_ROUND_UP(strlen(challenge), 2);
 	if (!challenge_len) {
 		pr_err("Unable to convert incoming challenge\n");
 		goto out;
@@ -360,6 +344,11 @@ static int chap_server_compute_md5(
 		pr_err("CHAP_C exceeds maximum binary size of 1024 bytes\n");
 		goto out;
 	}
+	if (hex2bin(challenge_binhex, challenge, challenge_len) < 0) {
+		pr_err("Malformed CHAP_C\n");
+		goto out;
+	}
+	pr_debug("[server] Got CHAP_C=%s\n", challenge);
 	/*
 	 * During mutual authentication, the CHAP_C generated by the
 	 * initiator must not match the original CHAP_C generated by
@@ -413,7 +402,7 @@ static int chap_server_compute_md5(
 	/*
 	 * Convert response from binary hex to ascii hext.
 	 */
-	chap_binaryhex_to_asciihex(response, digest, MD5_SIGNATURE_SIZE);
+	bin2hex(response, digest, MD5_SIGNATURE_SIZE);
 	*nr_out_len += sprintf(nr_out_ptr + *nr_out_len, "CHAP_R=0x%s",
 			response);
 	*nr_out_len += 1;
