Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E076C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681172075B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393660AbfBOJwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:52:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfBOJwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:52:38 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1guaAa-0001mj-DE; Fri, 15 Feb 2019 09:52:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     qla2xxx-upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] scsi: qla2xxx: remove redundant null check on pointer sess
Date:   Fri, 15 Feb 2019 09:52:32 +0000
Message-Id: <20190215095232.28852-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The null check on pointer sess and the subsequent call is redundant
as sess is null on all the the paths that lead to the out_term2 label.
Hence the null check and the call can be removed.  Also remove the
redundant setting of sess to NULL as this is not required now.

Detected by CoverityScan, CID#1420663 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Remove the redundant settings of sess to NULL, thanks to
Dan Carpenter for spotting this.

---
 drivers/scsi/qla2xxx/qla_target.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 6b8c655d9eb4..33131446b327 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6343,7 +6343,7 @@ static void qlt_tmr_work(struct qla_tgt *tgt,
 	struct atio_from_isp *a = &prm->tm_iocb2;
 	struct scsi_qla_host *vha = tgt->vha;
 	struct qla_hw_data *ha = vha->hw;
-	struct fc_port *sess = NULL;
+	struct fc_port *sess;
 	unsigned long flags;
 	uint8_t *s_id = NULL; /* to hide compiler warnings */
 	int rc;
@@ -6369,7 +6369,6 @@ static void qlt_tmr_work(struct qla_tgt *tgt,
 			goto out_term2;
 	} else {
 		if (sess->deleted) {
-			sess = NULL;
 			goto out_term2;
 		}
 
@@ -6377,7 +6376,6 @@ static void qlt_tmr_work(struct qla_tgt *tgt,
 			ql_dbg(ql_dbg_tgt_tmr, vha, 0xf020,
 			    "%s: kref_get fail %8phC\n",
 			     __func__, sess->port_name);
-			sess = NULL;
 			goto out_term2;
 		}
 	}
@@ -6396,8 +6394,6 @@ static void qlt_tmr_work(struct qla_tgt *tgt,
 	return;
 
 out_term2:
-	if (sess)
-		ha->tgt.tgt_ops->put_sess(sess);
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 out_term:
 	qlt_send_term_exchange(ha->base_qpair, NULL, &prm->tm_iocb2, 1, 0);
-- 
2.20.1

