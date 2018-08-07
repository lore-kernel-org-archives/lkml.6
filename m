Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C105AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851322151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851322151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404132AbeHGVJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:09:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33282 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbeHGVJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:09:23 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B58C6D07;
        Tue,  7 Aug 2018 18:53:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 02/21] scsi: qla2xxx: Fix NPIV deletion by calling wait_for_sess_deletion
Date:   Tue,  7 Aug 2018 20:51:16 +0200
Message-Id: <20180807172331.054007735@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172330.953888701@linuxfoundation.org>
References: <20180807172330.953888701@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2142,6 +2142,7 @@ qla24xx_vport_delete(struct fc_vport *fc
 		msleep(1000);
 
 	qla24xx_disable_vp(vha);
+	qla2x00_wait_for_sess_deletion(vha);
 
 	vha->flags.delete_progress = 1;
 
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -200,6 +200,7 @@ void qla2x00_handle_login_done_event(str
 	uint16_t *);
 int qla24xx_post_gnl_work(struct scsi_qla_host *, fc_port_t *);
 int qla24xx_async_abort_cmd(srb_t *);
+void qla2x00_wait_for_sess_deletion(scsi_qla_host_t *);
 
 /*
  * Global Functions in qla_mid.c source file.
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -152,10 +152,15 @@ qla24xx_disable_vp(scsi_qla_host_t *vha)
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
 	spin_lock_irqsave(&vha->hw->vport_slock, flags);
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1136,7 +1136,7 @@ static inline int test_fcport_count(scsi
  * qla2x00_wait_for_sess_deletion can only be called from remove_one.
  * it has dependency on UNLOADING flag to stop device discovery
  */
-static void
+void
 qla2x00_wait_for_sess_deletion(scsi_qla_host_t *vha)
 {
 	qla2x00_mark_all_devices_lost(vha, 0);


