Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C614C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E30254F6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E30254F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeGAREF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:04:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37714 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032244AbeGAQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:42:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BF73BACC;
        Sun,  1 Jul 2018 16:42:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikhail Malygin <m.malygin@yadro.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 137/220] scsi: qla2xxx: Spinlock recursion in qla_target
Date:   Sun,  1 Jul 2018 18:22:41 +0200
Message-Id: <20180701160914.029216622@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Mikhail Malygin <m.malygin@yadro.com>

commit 49d7bd36813ea8e6b4c97b640d24e7fbd44c84f0 upstream.

The patch reverts changes done in qlt_schedule_sess_for_deletion() to
avoid spinlock recursion sess->vha->work_lock should be used instead
of ha->tgt.sess_lock, that can be locked in callers: qlt_reset() or
qlt_handle_login()

[mkp: roll in build warning reported by sfr]

Fixes: 1c6cacf4ea6c04 ("scsi: qla2xxx: Fixup locking for session deletion")
Cc: <stable@vger.kernel.org> #v4.17
Signed-off-by: Mikhail Malygin <m.malygin@yadro.com>
Reported-by: Mikhail Malygin <m.malygin@yadro.com>
Tested-by: Mikhail Malygin <m.malygin@yadro.com>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1230,7 +1230,6 @@ static void qla24xx_chk_fcp_state(struct
 void qlt_schedule_sess_for_deletion(struct fc_port *sess)
 {
 	struct qla_tgt *tgt = sess->tgt;
-	struct qla_hw_data *ha = sess->vha->hw;
 	unsigned long flags;
 
 	if (sess->disc_state == DSC_DELETE_PEND)
@@ -1247,16 +1246,16 @@ void qlt_schedule_sess_for_deletion(stru
 			return;
 	}
 
-	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
 	if (sess->deleted == QLA_SESS_DELETED)
 		sess->logout_on_delete = 0;
 
+	spin_lock_irqsave(&sess->vha->work_lock, flags);
 	if (sess->deleted == QLA_SESS_DELETION_IN_PROGRESS) {
-		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+		spin_unlock_irqrestore(&sess->vha->work_lock, flags);
 		return;
 	}
 	sess->deleted = QLA_SESS_DELETION_IN_PROGRESS;
-	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+	spin_unlock_irqrestore(&sess->vha->work_lock, flags);
 
 	sess->disc_state = DSC_DELETE_PEND;
 


