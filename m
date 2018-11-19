Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2C8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A9C208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMib9Kou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A9C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733261AbeKTDFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:05:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732502AbeKTDFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:05:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAA9206BA;
        Mon, 19 Nov 2018 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645681;
        bh=Ht8S27yUQuhRUXhwqMT9XWF0RYJ63co+tp+C48XLqJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMib9KouA313dhEw6a4CyIgZhhYPUgTytFjsoE7S/n7Sd/MGTXv2jI1JuJ+eWUMVn
         u5IWMsS5X22ifHqmErwpwU1R5hnvIT4Fw7g0Vi6SQ9sWvULtjlqkqIKi74wAzP1+da
         Gcu+OWSSv3YAY3ASou5jNYdy/2xC7iTE2OC1iWGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Himanshu Madhani <hmadhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.18 050/171] scsi: qla2xxx: Fix re-using LoopID when handle is in use
Date:   Mon, 19 Nov 2018 17:27:26 +0100
Message-Id: <20181119162628.009809671@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 5c6400536481d9ef44ef94e7bf2c7b8e81534db7 upstream.

This patch fixes issue where driver clears NPort ID map instead of marking
handle in use. Once driver clears NPort ID from the database, it can reuse
the same NPort ID resulting in a PLOGI failure.

[mkp: fixed Himanshu's SoB]

Fixes: a084fd68e1d2 ("scsi: qla2xxx: Fix re-login for Nport Handle in use")
Cc: <stable@vger.kernel.org>
Signed-of-by: Quinn Tran <quinn.tran@cavium.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Himanshu Madhani <hmadhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c   |   18 ++++--------------
 drivers/scsi/qla2xxx/qla_target.c |    3 ++-
 2 files changed, 6 insertions(+), 15 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1742,25 +1742,15 @@ qla24xx_handle_plogi_done_event(struct s
 		cid.b.rsvd_1 = 0;
 
 		ql_dbg(ql_dbg_disc, vha, 0x20ec,
-		    "%s %d %8phC LoopID 0x%x in use post gnl\n",
+		    "%s %d %8phC lid %#x in use with pid %06x post gnl\n",
 		    __func__, __LINE__, ea->fcport->port_name,
-		    ea->fcport->loop_id);
+		    ea->fcport->loop_id, cid.b24);
 
-		if (IS_SW_RESV_ADDR(cid)) {
-			set_bit(ea->fcport->loop_id, vha->hw->loop_id_map);
-			ea->fcport->loop_id = FC_NO_LOOP_ID;
-		} else {
-			qla2x00_clear_loop_id(ea->fcport);
-		}
+		set_bit(ea->fcport->loop_id, vha->hw->loop_id_map);
+		ea->fcport->loop_id = FC_NO_LOOP_ID;
 		qla24xx_post_gnl_work(vha, ea->fcport);
 		break;
 	case MBS_PORT_ID_USED:
-		ql_dbg(ql_dbg_disc, vha, 0x20ed,
-		    "%s %d %8phC NPortId %02x%02x%02x inuse post gidpn\n",
-		    __func__, __LINE__, ea->fcport->port_name,
-		    ea->fcport->d_id.b.domain, ea->fcport->d_id.b.area,
-		    ea->fcport->d_id.b.al_pa);
-
 		lid = ea->iop[1] & 0xffff;
 		qlt_find_sess_invalidate_other(vha,
 		    wwn_to_u64(ea->fcport->port_name),
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1257,7 +1257,8 @@ void qlt_schedule_sess_for_deletion(stru
 	qla24xx_chk_fcp_state(sess);
 
 	ql_dbg(ql_dbg_tgt, sess->vha, 0xe001,
-	    "Scheduling sess %p for deletion\n", sess);
+	    "Scheduling sess %p for deletion %8phC\n",
+	    sess, sess->port_name);
 
 	INIT_WORK(&sess->del_work, qla24xx_delete_sess_fn);
 	WARN_ON(!queue_work(sess->vha->hw->wq, &sess->del_work));


