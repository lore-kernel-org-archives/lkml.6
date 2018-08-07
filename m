Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA358C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679722172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679722172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403768AbeHGVIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:08:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGVIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:08:23 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63CE03EE;
        Tue,  7 Aug 2018 18:52:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 02/18] scsi: qla2xxx: Fix NPIV deletion by calling wait_for_sess_deletion
Date:   Tue,  7 Aug 2018 20:51:05 +0200
Message-Id: <20180807172313.050738798@linuxfoundation.org>
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

commit efa93f48fa9d423fda166bc3b6c0cbb09682492e upstream.

Add wait for session deletion to finish before freeing an NPIV scsi host.

Fixes: 726b85487067 ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_attr.c |    1 +
 drivers/scsi/qla2xxx/qla_gbl.h  |    1 +
 drivers/scsi/qla2xxx/qla_mid.c  |    5 +++++
 drivers/scsi/qla2xxx/qla_os.c   |    2 +-
 4 files changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2141,6 +2141,7 @@ qla24xx_vport_delete(struct fc_vport *fc
 		msleep(1000);
 
 	qla24xx_disable_vp(vha);
+	qla2x00_wait_for_sess_deletion(vha);
 
 	vha->flags.delete_progress = 1;
 
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -213,6 +213,7 @@ void qla2x00_handle_login_done_event(str
 int qla24xx_post_gnl_work(struct scsi_qla_host *, fc_port_t *);
 int qla24xx_async_abort_cmd(srb_t *);
 int qla24xx_post_relogin_work(struct scsi_qla_host *vha);
+void qla2x00_wait_for_sess_deletion(scsi_qla_host_t *);
 
 /*
  * Global Functions in qla_mid.c source file.
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -153,10 +153,15 @@ qla24xx_disable_vp(scsi_qla_host_t *vha)
 {
 	unsigned long flags;
 	int ret;
+	fc_port_t *fcport;
 
 	ret = qla24xx_control_vp(vha, VCE_COMMAND_DISABLE_VPS_LOGO_ALL);
 	atomic_set(&vha->loop_state, LOOP_DOWN);
 	atomic_set(&vha->loop_down_timer, LOOP_DOWN_TIME);
+	list_for_each_entry(fcport, &vha->vp_fcports, list)
+		fcport->logout_on_delete = 0;
+
+	qla2x00_mark_all_devices_lost(vha, 0);
 
 	/* Remove port id from vp target map */
 	spin_lock_irqsave(&vha->hw->hardware_lock, flags);
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1147,7 +1147,7 @@ static inline int test_fcport_count(scsi
  * qla2x00_wait_for_sess_deletion can only be called from remove_one.
  * it has dependency on UNLOADING flag to stop device discovery
  */
-static void
+void
 qla2x00_wait_for_sess_deletion(scsi_qla_host_t *vha)
 {
 	qla2x00_mark_all_devices_lost(vha, 0);


