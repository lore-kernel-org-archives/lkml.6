Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5E3C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4308A2170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4308A2170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403793AbeHGVI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:08:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGVI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:08:26 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61E303EE;
        Tue,  7 Aug 2018 18:52:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 03/18] scsi: qla2xxx: Fix driver unload by shutting down chip
Date:   Tue,  7 Aug 2018 20:51:06 +0200
Message-Id: <20180807172313.088409564@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172312.964272530@linuxfoundation.org>
References: <20180807172312.964272530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 45235022da9925b2b070c0139629233173e50089 upstream.

Use chip shutdown at the start of unload to stop all DMA + traffic and
bring down the laser. This prevents any link activities from triggering the
driver to be re-engaged.

Fixes: 4b60c82736d0 ("scsi: qla2xxx: Add fw_started flags to qpair")
Cc: <stable@vger.kernel.org> #4.16
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_isr.c |    3 ++
 drivers/scsi/qla2xxx/qla_mbx.c |    6 +++++
 drivers/scsi/qla2xxx/qla_mid.c |    6 +++--
 drivers/scsi/qla2xxx/qla_os.c  |   44 ++++++++++++++++-------------------------
 drivers/scsi/qla2xxx/qla_sup.c |    3 ++
 5 files changed, 34 insertions(+), 28 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -631,6 +631,9 @@ qla2x00_async_event(scsi_qla_host_t *vha
 	unsigned long	flags;
 	fc_port_t	*fcport = NULL;
 
+	if (!vha->hw->flags.fw_started)
+		return;
+
 	/* Setup to process RIO completion. */
 	handle_cnt = 0;
 	if (IS_CNA_CAPABLE(ha))
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -4212,6 +4212,9 @@ qla25xx_init_req_que(struct scsi_qla_hos
 	mbx_cmd_t *mcp = &mc;
 	struct qla_hw_data *ha = vha->hw;
 
+	if (!ha->flags.fw_started)
+		return QLA_SUCCESS;
+
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x10d3,
 	    "Entered %s.\n", __func__);
 
@@ -4281,6 +4284,9 @@ qla25xx_init_rsp_que(struct scsi_qla_hos
 	mbx_cmd_t *mcp = &mc;
 	struct qla_hw_data *ha = vha->hw;
 
+	if (!ha->flags.fw_started)
+		return QLA_SUCCESS;
+
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x10d6,
 	    "Entered %s.\n", __func__);
 
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -152,10 +152,12 @@ int
 qla24xx_disable_vp(scsi_qla_host_t *vha)
 {
 	unsigned long flags;
-	int ret;
+	int ret = QLA_SUCCESS;
 	fc_port_t *fcport;
 
-	ret = qla24xx_control_vp(vha, VCE_COMMAND_DISABLE_VPS_LOGO_ALL);
+	if (vha->hw->flags.fw_started)
+		ret = qla24xx_control_vp(vha, VCE_COMMAND_DISABLE_VPS_LOGO_ALL);
+
 	atomic_set(&vha->loop_state, LOOP_DOWN);
 	atomic_set(&vha->loop_down_timer, LOOP_DOWN_TIME);
 	list_for_each_entry(fcport, &vha->vp_fcports, list)
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -303,6 +303,7 @@ static void qla2x00_free_device(scsi_qla
 static int qla2xxx_map_queues(struct Scsi_Host *shost);
 static void qla2x00_destroy_deferred_work(struct qla_hw_data *);
 
+
 struct scsi_host_template qla2xxx_driver_template = {
 	.module			= THIS_MODULE,
 	.name			= QLA2XXX_DRIVER_NAME,
@@ -3603,6 +3604,8 @@ qla2x00_remove_one(struct pci_dev *pdev)
 
 	base_vha = pci_get_drvdata(pdev);
 	ha = base_vha->hw;
+	ql_log(ql_log_info, base_vha, 0xb079,
+	    "Removing driver\n");
 
 	/* Indicate device removal to prevent future board_disable and wait
 	 * until any pending board_disable has completed. */
@@ -3625,6 +3628,21 @@ qla2x00_remove_one(struct pci_dev *pdev)
 	}
 	qla2x00_wait_for_hba_ready(base_vha);
 
+	if (IS_QLA25XX(ha) || IS_QLA2031(ha) || IS_QLA27XX(ha)) {
+		if (ha->flags.fw_started)
+			qla2x00_abort_isp_cleanup(base_vha);
+	} else if (!IS_QLAFX00(ha)) {
+		if (IS_QLA8031(ha)) {
+			ql_dbg(ql_dbg_p3p, base_vha, 0xb07e,
+			    "Clearing fcoe driver presence.\n");
+			if (qla83xx_clear_drv_presence(base_vha) != QLA_SUCCESS)
+				ql_dbg(ql_dbg_p3p, base_vha, 0xb079,
+				    "Error while clearing DRV-Presence.\n");
+		}
+
+		qla2x00_try_to_stop_firmware(base_vha);
+	}
+
 	qla2x00_wait_for_sess_deletion(base_vha);
 
 	/*
@@ -3648,14 +3666,6 @@ qla2x00_remove_one(struct pci_dev *pdev)
 
 	qla2x00_delete_all_vps(ha, base_vha);
 
-	if (IS_QLA8031(ha)) {
-		ql_dbg(ql_dbg_p3p, base_vha, 0xb07e,
-		    "Clearing fcoe driver presence.\n");
-		if (qla83xx_clear_drv_presence(base_vha) != QLA_SUCCESS)
-			ql_dbg(ql_dbg_p3p, base_vha, 0xb079,
-			    "Error while clearing DRV-Presence.\n");
-	}
-
 	qla2x00_abort_all_cmds(base_vha, DID_NO_CONNECT << 16);
 
 	qla2x00_dfs_remove(base_vha);
@@ -3715,24 +3725,6 @@ qla2x00_free_device(scsi_qla_host_t *vha
 		qla2x00_stop_timer(vha);
 
 	qla25xx_delete_queues(vha);
-
-	if (ha->flags.fce_enabled)
-		qla2x00_disable_fce_trace(vha, NULL, NULL);
-
-	if (ha->eft)
-		qla2x00_disable_eft_trace(vha);
-
-	if (IS_QLA25XX(ha) ||  IS_QLA2031(ha) || IS_QLA27XX(ha)) {
-		if (ha->flags.fw_started)
-			qla2x00_abort_isp_cleanup(vha);
-	} else {
-		if (ha->flags.fw_started) {
-			/* Stop currently executing firmware. */
-			qla2x00_try_to_stop_firmware(vha);
-			ha->flags.fw_started = 0;
-		}
-	}
-
 	vha->flags.online = 0;
 
 	/* turn-off interrupts on the card */
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -1880,6 +1880,9 @@ qla24xx_beacon_off(struct scsi_qla_host
 	if (IS_P3P_TYPE(ha))
 		return QLA_SUCCESS;
 
+	if (!ha->flags.fw_started)
+		return QLA_SUCCESS;
+
 	ha->beacon_blink_led = 0;
 
 	if (IS_QLA2031(ha) || IS_QLA27XX(ha))


