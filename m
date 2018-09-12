Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87625C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1876D206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BaoIl9WF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1876D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeILQd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:33:59 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37972 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbeILQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:33:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D5A008EE171;
        Wed, 12 Sep 2018 04:29:51 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SinUHdTjeyL5; Wed, 12 Sep 2018 04:29:51 -0700 (PDT)
Received: from [192.168.101.226] (unknown [24.246.103.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E21C18EE0CF;
        Wed, 12 Sep 2018 04:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1536751791;
        bh=QPF62qsUvKRK3QjMPzitSOAWtzUJIj0Soh4oOI4W/As=;
        h=Subject:From:To:Cc:Date:From;
        b=BaoIl9WF5UzR2qiYH407jYFXIQeF6V4SFwRRiXh14hNs2jJxoVwIF25Sx8PPjPx7R
         N5HmLLkFDRomdsnQhiNobk0YxhcgifyQQH3rszjqNFbFPo6VrsD2unITPpgAkPF/CN
         nItUrnmS5VaymM6Me1zh90w14mgPldwuzcYIBR9k=
Message-ID: <1536751789.3337.5.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 4.19-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Sep 2018 07:29:49 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three fixes, all in drivers (qedi and iscsi target) so no wider impact
even if the code changes are a bit extensive.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Mike Christie (1):
      scsi: iscsi: target: Fix conn_ops double free

Nilesh Javali (1):
      scsi: qedi: Add the CRC size within iSCSI NVM image

Vincent Pelletier (1):
      scsi: iscsi: target: Set conn->sess to NULL when iscsi_login_set_conn_values fails

And the diffstat:

 drivers/scsi/qedi/qedi.h                  |   7 +-
 drivers/scsi/qedi/qedi_main.c             |  28 +++---
 drivers/target/iscsi/iscsi_target.c       |   9 +-
 drivers/target/iscsi/iscsi_target_login.c | 149 ++++++++++++++++--------------
 drivers/target/iscsi/iscsi_target_login.h |   2 +-
 5 files changed, 101 insertions(+), 94 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/qedi/qedi.h b/drivers/scsi/qedi/qedi.h
index fc3babc15fa3..a6f96b35e971 100644
--- a/drivers/scsi/qedi/qedi.h
+++ b/drivers/scsi/qedi/qedi.h
@@ -77,6 +77,11 @@ enum qedi_nvm_tgts {
 	QEDI_NVM_TGT_SEC,
 };
 
+struct qedi_nvm_iscsi_image {
+	struct nvm_iscsi_cfg iscsi_cfg;
+	u32 crc;
+};
+
 struct qedi_uio_ctrl {
 	/* meta data */
 	u32 uio_hsi_version;
@@ -294,7 +299,7 @@ struct qedi_ctx {
 	void *bdq_pbl_list;
 	dma_addr_t bdq_pbl_list_dma;
 	u8 bdq_pbl_list_num_entries;
-	struct nvm_iscsi_cfg *iscsi_cfg;
+	struct qedi_nvm_iscsi_image *iscsi_image;
 	dma_addr_t nvm_buf_dma;
 	void __iomem *bdq_primary_prod;
 	void __iomem *bdq_secondary_prod;
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index aa96bccb5a96..cc8e64dc65ad 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1346,23 +1346,26 @@ static int qedi_setup_int(struct qedi_ctx *qedi)
 
 static void qedi_free_nvm_iscsi_cfg(struct qedi_ctx *qedi)
 {
-	if (qedi->iscsi_cfg)
+	if (qedi->iscsi_image)
 		dma_free_coherent(&qedi->pdev->dev,
-				  sizeof(struct nvm_iscsi_cfg),
-				  qedi->iscsi_cfg, qedi->nvm_buf_dma);
+				  sizeof(struct qedi_nvm_iscsi_image),
+				  qedi->iscsi_image, qedi->nvm_buf_dma);
 }
 
 static int qedi_alloc_nvm_iscsi_cfg(struct qedi_ctx *qedi)
 {
-	qedi->iscsi_cfg = dma_zalloc_coherent(&qedi->pdev->dev,
-					     sizeof(struct nvm_iscsi_cfg),
-					     &qedi->nvm_buf_dma, GFP_KERNEL);
-	if (!qedi->iscsi_cfg) {
+	struct qedi_nvm_iscsi_image nvm_image;
+
+	qedi->iscsi_image = dma_zalloc_coherent(&qedi->pdev->dev,
+						sizeof(nvm_image),
+						&qedi->nvm_buf_dma,
+						GFP_KERNEL);
+	if (!qedi->iscsi_image) {
 		QEDI_ERR(&qedi->dbg_ctx, "Could not allocate NVM BUF.\n");
 		return -ENOMEM;
 	}
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
-		  "NVM BUF addr=0x%p dma=0x%llx.\n", qedi->iscsi_cfg,
+		  "NVM BUF addr=0x%p dma=0x%llx.\n", qedi->iscsi_image,
 		  qedi->nvm_buf_dma);
 
 	return 0;
@@ -1905,7 +1908,7 @@ qedi_get_nvram_block(struct qedi_ctx *qedi)
 	struct nvm_iscsi_block *block;
 
 	pf = qedi->dev_info.common.abs_pf_id;
-	block = &qedi->iscsi_cfg->block[0];
+	block = &qedi->iscsi_image->iscsi_cfg.block[0];
 	for (i = 0; i < NUM_OF_ISCSI_PF_SUPPORTED; i++, block++) {
 		flags = ((block->id) & NVM_ISCSI_CFG_BLK_CTRL_FLAG_MASK) >>
 			NVM_ISCSI_CFG_BLK_CTRL_FLAG_OFFSET;
@@ -2194,15 +2197,14 @@ static void qedi_boot_release(void *data)
 static int qedi_get_boot_info(struct qedi_ctx *qedi)
 {
 	int ret = 1;
-	u16 len;
-
-	len = sizeof(struct nvm_iscsi_cfg);
+	struct qedi_nvm_iscsi_image nvm_image;
 
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
 		  "Get NVM iSCSI CFG image\n");
 	ret = qedi_ops->common->nvm_get_image(qedi->cdev,
 					      QED_NVM_IMAGE_ISCSI_CFG,
-					      (char *)qedi->iscsi_cfg, len);
+					      (char *)qedi->iscsi_image,
+					      sizeof(nvm_image));
 	if (ret)
 		QEDI_ERR(&qedi->dbg_ctx,
 			 "Could not get NVM image. ret = %d\n", ret);
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 94bad43c41ff..9cdfccbdd06f 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4208,22 +4208,15 @@ int iscsit_close_connection(
 		crypto_free_ahash(tfm);
 	}
 
-	free_cpumask_var(conn->conn_cpumask);
-
-	kfree(conn->conn_ops);
-	conn->conn_ops = NULL;
-
 	if (conn->sock)
 		sock_release(conn->sock);
 
 	if (conn->conn_transport->iscsit_free_conn)
 		conn->conn_transport->iscsit_free_conn(conn);
 
-	iscsit_put_transport(conn->conn_transport);
-
 	pr_debug("Moving to TARG_CONN_STATE_FREE.\n");
 	conn->conn_state = TARG_CONN_STATE_FREE;
-	kfree(conn);
+	iscsit_free_conn(conn);
 
 	spin_lock_bh(&sess->conn_lock);
 	atomic_dec(&sess->nconn);
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 9e74f8bc2963..bb90c80ff388 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -67,45 +67,10 @@ static struct iscsi_login *iscsi_login_init_conn(struct iscsi_conn *conn)
 		goto out_req_buf;
 	}
 
-	conn->conn_ops = kzalloc(sizeof(struct iscsi_conn_ops), GFP_KERNEL);
-	if (!conn->conn_ops) {
-		pr_err("Unable to allocate memory for"
-			" struct iscsi_conn_ops.\n");
-		goto out_rsp_buf;
-	}
-
-	init_waitqueue_head(&conn->queues_wq);
-	INIT_LIST_HEAD(&conn->conn_list);
-	INIT_LIST_HEAD(&conn->conn_cmd_list);
-	INIT_LIST_HEAD(&conn->immed_queue_list);
-	INIT_LIST_HEAD(&conn->response_queue_list);
-	init_completion(&conn->conn_post_wait_comp);
-	init_completion(&conn->conn_wait_comp);
-	init_completion(&conn->conn_wait_rcfr_comp);
-	init_completion(&conn->conn_waiting_on_uc_comp);
-	init_completion(&conn->conn_logout_comp);
-	init_completion(&conn->rx_half_close_comp);
-	init_completion(&conn->tx_half_close_comp);
-	init_completion(&conn->rx_login_comp);
-	spin_lock_init(&conn->cmd_lock);
-	spin_lock_init(&conn->conn_usage_lock);
-	spin_lock_init(&conn->immed_queue_lock);
-	spin_lock_init(&conn->nopin_timer_lock);
-	spin_lock_init(&conn->response_queue_lock);
-	spin_lock_init(&conn->state_lock);
-
-	if (!zalloc_cpumask_var(&conn->conn_cpumask, GFP_KERNEL)) {
-		pr_err("Unable to allocate conn->conn_cpumask\n");
-		goto out_conn_ops;
-	}
 	conn->conn_login = login;
 
 	return login;
 
-out_conn_ops:
-	kfree(conn->conn_ops);
-out_rsp_buf:
-	kfree(login->rsp_buf);
 out_req_buf:
 	kfree(login->req_buf);
 out_login:
@@ -310,11 +275,9 @@ static int iscsi_login_zero_tsih_s1(
 		return -ENOMEM;
 	}
 
-	ret = iscsi_login_set_conn_values(sess, conn, pdu->cid);
-	if (unlikely(ret)) {
-		kfree(sess);
-		return ret;
-	}
+	if (iscsi_login_set_conn_values(sess, conn, pdu->cid))
+		goto free_sess;
+
 	sess->init_task_tag	= pdu->itt;
 	memcpy(&sess->isid, pdu->isid, 6);
 	sess->exp_cmd_sn	= be32_to_cpu(pdu->cmdsn);
@@ -1149,6 +1112,75 @@ iscsit_conn_set_transport(struct iscsi_conn *conn, struct iscsit_transport *t)
 	return 0;
 }
 
+static struct iscsi_conn *iscsit_alloc_conn(struct iscsi_np *np)
+{
+	struct iscsi_conn *conn;
+
+	conn = kzalloc(sizeof(struct iscsi_conn), GFP_KERNEL);
+	if (!conn) {
+		pr_err("Could not allocate memory for new connection\n");
+		return NULL;
+	}
+	pr_debug("Moving to TARG_CONN_STATE_FREE.\n");
+	conn->conn_state = TARG_CONN_STATE_FREE;
+
+	init_waitqueue_head(&conn->queues_wq);
+	INIT_LIST_HEAD(&conn->conn_list);
+	INIT_LIST_HEAD(&conn->conn_cmd_list);
+	INIT_LIST_HEAD(&conn->immed_queue_list);
+	INIT_LIST_HEAD(&conn->response_queue_list);
+	init_completion(&conn->conn_post_wait_comp);
+	init_completion(&conn->conn_wait_comp);
+	init_completion(&conn->conn_wait_rcfr_comp);
+	init_completion(&conn->conn_waiting_on_uc_comp);
+	init_completion(&conn->conn_logout_comp);
+	init_completion(&conn->rx_half_close_comp);
+	init_completion(&conn->tx_half_close_comp);
+	init_completion(&conn->rx_login_comp);
+	spin_lock_init(&conn->cmd_lock);
+	spin_lock_init(&conn->conn_usage_lock);
+	spin_lock_init(&conn->immed_queue_lock);
+	spin_lock_init(&conn->nopin_timer_lock);
+	spin_lock_init(&conn->response_queue_lock);
+	spin_lock_init(&conn->state_lock);
+
+	timer_setup(&conn->nopin_response_timer,
+		    iscsit_handle_nopin_response_timeout, 0);
+	timer_setup(&conn->nopin_timer, iscsit_handle_nopin_timeout, 0);
+
+	if (iscsit_conn_set_transport(conn, np->np_transport) < 0)
+		goto free_conn;
+
+	conn->conn_ops = kzalloc(sizeof(struct iscsi_conn_ops), GFP_KERNEL);
+	if (!conn->conn_ops) {
+		pr_err("Unable to allocate memory for struct iscsi_conn_ops.\n");
+		goto put_transport;
+	}
+
+	if (!zalloc_cpumask_var(&conn->conn_cpumask, GFP_KERNEL)) {
+		pr_err("Unable to allocate conn->conn_cpumask\n");
+		goto free_mask;
+	}
+
+	return conn;
+
+free_mask:
+	free_cpumask_var(conn->conn_cpumask);
+put_transport:
+	iscsit_put_transport(conn->conn_transport);
+free_conn:
+	kfree(conn);
+	return NULL;
+}
+
+void iscsit_free_conn(struct iscsi_conn *conn)
+{
+	free_cpumask_var(conn->conn_cpumask);
+	kfree(conn->conn_ops);
+	iscsit_put_transport(conn->conn_transport);
+	kfree(conn);
+}
+
 void iscsi_target_login_sess_out(struct iscsi_conn *conn,
 		struct iscsi_np *np, bool zero_tsih, bool new_sess)
 {
@@ -1198,10 +1230,6 @@ void iscsi_target_login_sess_out(struct iscsi_conn *conn,
 		crypto_free_ahash(tfm);
 	}
 
-	free_cpumask_var(conn->conn_cpumask);
-
-	kfree(conn->conn_ops);
-
 	if (conn->param_list) {
 		iscsi_release_param_list(conn->param_list);
 		conn->param_list = NULL;
@@ -1219,8 +1247,7 @@ void iscsi_target_login_sess_out(struct iscsi_conn *conn,
 	if (conn->conn_transport->iscsit_free_conn)
 		conn->conn_transport->iscsit_free_conn(conn);
 
-	iscsit_put_transport(conn->conn_transport);
-	kfree(conn);
+	iscsit_free_conn(conn);
 }
 
 static int __iscsi_target_login_thread(struct iscsi_np *np)
@@ -1250,31 +1277,16 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 	}
 	spin_unlock_bh(&np->np_thread_lock);
 
-	conn = kzalloc(sizeof(struct iscsi_conn), GFP_KERNEL);
+	conn = iscsit_alloc_conn(np);
 	if (!conn) {
-		pr_err("Could not allocate memory for"
-			" new connection\n");
 		/* Get another socket */
 		return 1;
 	}
-	pr_debug("Moving to TARG_CONN_STATE_FREE.\n");
-	conn->conn_state = TARG_CONN_STATE_FREE;
-
-	timer_setup(&conn->nopin_response_timer,
-		    iscsit_handle_nopin_response_timeout, 0);
-	timer_setup(&conn->nopin_timer, iscsit_handle_nopin_timeout, 0);
-
-	if (iscsit_conn_set_transport(conn, np->np_transport) < 0) {
-		kfree(conn);
-		return 1;
-	}
 
 	rc = np->np_transport->iscsit_accept_np(np, conn);
 	if (rc == -ENOSYS) {
 		complete(&np->np_restart_comp);
-		iscsit_put_transport(conn->conn_transport);
-		kfree(conn);
-		conn = NULL;
+		iscsit_free_conn(conn);
 		goto exit;
 	} else if (rc < 0) {
 		spin_lock_bh(&np->np_thread_lock);
@@ -1282,17 +1294,13 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 			np->np_thread_state = ISCSI_NP_THREAD_ACTIVE;
 			spin_unlock_bh(&np->np_thread_lock);
 			complete(&np->np_restart_comp);
-			iscsit_put_transport(conn->conn_transport);
-			kfree(conn);
-			conn = NULL;
+			iscsit_free_conn(conn);
 			/* Get another socket */
 			return 1;
 		}
 		spin_unlock_bh(&np->np_thread_lock);
-		iscsit_put_transport(conn->conn_transport);
-		kfree(conn);
-		conn = NULL;
-		goto out;
+		iscsit_free_conn(conn);
+		return 1;
 	}
 	/*
 	 * Perform the remaining iSCSI connection initialization items..
@@ -1442,7 +1450,6 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 		tpg_np = NULL;
 	}
 
-out:
 	return 1;
 
 exit:
diff --git a/drivers/target/iscsi/iscsi_target_login.h b/drivers/target/iscsi/iscsi_target_login.h
index 74ac3abc44a0..3b8e3639ff5d 100644
--- a/drivers/target/iscsi/iscsi_target_login.h
+++ b/drivers/target/iscsi/iscsi_target_login.h
@@ -19,7 +19,7 @@ extern int iscsi_target_setup_login_socket(struct iscsi_np *,
 extern int iscsit_accept_np(struct iscsi_np *, struct iscsi_conn *);
 extern int iscsit_get_login_rx(struct iscsi_conn *, struct iscsi_login *);
 extern int iscsit_put_login_tx(struct iscsi_conn *, struct iscsi_login *, u32);
-extern void iscsit_free_conn(struct iscsi_np *, struct iscsi_conn *);
+extern void iscsit_free_conn(struct iscsi_conn *);
 extern int iscsit_start_kthreads(struct iscsi_conn *);
 extern void iscsi_post_login_handler(struct iscsi_np *, struct iscsi_conn *, u8);
 extern void iscsi_target_login_sess_out(struct iscsi_conn *, struct iscsi_np *,


