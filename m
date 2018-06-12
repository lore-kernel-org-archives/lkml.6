Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9875DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F24B20660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uzGnMsfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F24B20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934381AbeFLTH3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:07:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933321AbeFLTFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QDYBaXSZD3DE9qAWvEFRrZU+wXiSKmoqNtRllHYqjEE=; b=uzGnMsfxbFDTEAjsfyzd8jS/N
        77ym7m5pifK6Mig27z8Cv2h3BBCDWLB+EHcoSbE06XUEr7xQ42gmi2f58kuYPGbSRz8D0vG5lrAmg
        85i+xdP3XndU7mGtYUvU01ecRP9SC7Gsbg/l9LzZlZG4tH9OnNdKRvFCal3eeZ5C7iLOtO3pofoJr
        3gKySfEVfjoyH3W3jmdqDfRCfk7USw0KIni4R6gW7BrK/owjDCJTwNxLyRq4Cn3EbP+FPQps/xfjp
        UD/bHeRXxFaeN7fsiuhIBhAouRTIvajznUxaOR6PKSqPEni4t7KA6nxtUEozPVVxvXUZRbpyiCR0l
        jIx1iGxmQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSoc2-0002ui-CB; Tue, 12 Jun 2018 19:05:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/3] target: Abstract tag freeing
Date:   Tue, 12 Jun 2018 12:05:43 -0700
Message-Id: <20180612190545.10781-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180612190545.10781-1-willy@infradead.org>
References: <20180612190545.10781-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce target_free_tag() and convert all drivers to use it.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/scsi/qla2xxx/qla_target.c        | 4 ++--
 drivers/target/iscsi/iscsi_target_util.c | 2 +-
 drivers/target/sbp/sbp_target.c          | 2 +-
 drivers/target/tcm_fc/tfc_cmd.c          | 4 ++--
 drivers/usb/gadget/function/f_tcm.c      | 2 +-
 drivers/vhost/scsi.c                     | 2 +-
 drivers/xen/xen-scsiback.c               | 4 +---
 include/target/target_core_base.h        | 5 +++++
 8 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index b85c833099ff..05290966e630 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3783,7 +3783,7 @@ void qlt_free_cmd(struct qla_tgt_cmd *cmd)
 		return;
 	}
 	cmd->jiffies_at_free = get_jiffies_64();
-	percpu_ida_free(&sess->se_sess->sess_tag_pool, cmd->se_cmd.map_tag);
+	target_free_tag(sess->se_sess, &cmd->se_cmd);
 }
 EXPORT_SYMBOL(qlt_free_cmd);
 
@@ -4146,7 +4146,7 @@ static void __qlt_do_work(struct qla_tgt_cmd *cmd)
 	qlt_send_term_exchange(qpair, NULL, &cmd->atio, 1, 0);
 
 	qlt_decr_num_pend_cmds(vha);
-	percpu_ida_free(&sess->se_sess->sess_tag_pool, cmd->se_cmd.map_tag);
+	target_free_tag(sess->se_sess, &cmd->se_cmd);
 	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 4435bf374d2d..7e98697cfb8e 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -711,7 +711,7 @@ void iscsit_release_cmd(struct iscsi_cmd *cmd)
 	kfree(cmd->iov_data);
 	kfree(cmd->text_in_ptr);
 
-	percpu_ida_free(&sess->se_sess->sess_tag_pool, se_cmd->map_tag);
+	target_free_tag(sess->se_sess, se_cmd);
 }
 EXPORT_SYMBOL(iscsit_release_cmd);
 
diff --git a/drivers/target/sbp/sbp_target.c b/drivers/target/sbp/sbp_target.c
index fb1003921d85..679ae29d25ab 100644
--- a/drivers/target/sbp/sbp_target.c
+++ b/drivers/target/sbp/sbp_target.c
@@ -1460,7 +1460,7 @@ static void sbp_free_request(struct sbp_target_request *req)
 	kfree(req->pg_tbl);
 	kfree(req->cmd_buf);
 
-	percpu_ida_free(&se_sess->sess_tag_pool, se_cmd->map_tag);
+	target_free_tag(se_sess, se_cmd);
 }
 
 static void sbp_mgt_agent_process(struct work_struct *work)
diff --git a/drivers/target/tcm_fc/tfc_cmd.c b/drivers/target/tcm_fc/tfc_cmd.c
index ec372860106f..13e4efbe1ce7 100644
--- a/drivers/target/tcm_fc/tfc_cmd.c
+++ b/drivers/target/tcm_fc/tfc_cmd.c
@@ -92,7 +92,7 @@ static void ft_free_cmd(struct ft_cmd *cmd)
 	if (fr_seq(fp))
 		fc_seq_release(fr_seq(fp));
 	fc_frame_free(fp);
-	percpu_ida_free(&sess->se_sess->sess_tag_pool, cmd->se_cmd.map_tag);
+	target_free_tag(sess->se_sess, &cmd->se_cmd);
 	ft_sess_put(sess);	/* undo get from lookup at recv */
 }
 
@@ -461,7 +461,7 @@ static void ft_recv_cmd(struct ft_sess *sess, struct fc_frame *fp)
 	cmd->sess = sess;
 	cmd->seq = fc_seq_assign(lport, fp);
 	if (!cmd->seq) {
-		percpu_ida_free(&se_sess->sess_tag_pool, tag);
+		target_free_tag(se_sess, &cmd->se_cmd);
 		goto busy;
 	}
 	cmd->req_frame = fp;		/* hold frame during cmd */
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index d78dbb73bde8..9f670d9224b9 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1288,7 +1288,7 @@ static void usbg_release_cmd(struct se_cmd *se_cmd)
 	struct se_session *se_sess = se_cmd->se_sess;
 
 	kfree(cmd->data_buf);
-	percpu_ida_free(&se_sess->sess_tag_pool, se_cmd->map_tag);
+	target_free_tag(se_sess, se_cmd);
 }
 
 static u32 usbg_sess_get_index(struct se_session *se_sess)
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7ad57094d736..70d35e696533 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -324,7 +324,7 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 	}
 
 	vhost_scsi_put_inflight(tv_cmd->inflight);
-	percpu_ida_free(&se_sess->sess_tag_pool, se_cmd->map_tag);
+	target_free_tag(se_sess, se_cmd);
 }
 
 static u32 vhost_scsi_sess_get_index(struct se_session *se_sess)
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 7bc88fd43cfc..ec6635258ed8 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1377,9 +1377,7 @@ static int scsiback_check_stop_free(struct se_cmd *se_cmd)
 
 static void scsiback_release_cmd(struct se_cmd *se_cmd)
 {
-	struct se_session *se_sess = se_cmd->se_sess;
-
-	percpu_ida_free(&se_sess->sess_tag_pool, se_cmd->map_tag);
+	target_free_tag(se_cmd->se_sess, se_cmd);
 }
 
 static u32 scsiback_sess_get_index(struct se_session *se_sess)
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 922a39f45abc..260c2f3e9460 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -934,4 +934,9 @@ static inline void atomic_dec_mb(atomic_t *v)
 	smp_mb__after_atomic();
 }
 
+static inline void target_free_tag(struct se_session *sess, struct se_cmd *cmd)
+{
+	percpu_ida_free(&sess->sess_tag_pool, cmd->map_tag);
+}
+
 #endif /* TARGET_CORE_BASE_H */
-- 
2.17.1

