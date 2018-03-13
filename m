Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvOd/a8t5vDL5LlXfZeR6F66WqAw6K5Jm+N3Cj6oKLo4pUdE6IgqX0w8tc74cxe8gqX/Rx9
ARC-Seal: i=1; a=rsa-sha256; t=1520955373; cv=none;
        d=google.com; s=arc-20160816;
        b=VbfyovO5WHTxZEDTvbxlnp52Ld22Tpu19VAACBpY83yC6e57iJp7fUKvPi+j+kWeIf
         wtw+FtbIBUrTr62FsuLSmTQ/7Y04iMHgQ0djyIDToWSFmsKkq3XaPL/Rgf6Qe++f9tqx
         rvHgwVWg8e4/lKHdj+fDhp4vYLGjbYFTlyOiip03pPe1lAAUHyd4/thEeZ8GUuf2hnyP
         hO68xdngLr0L8d8zq5OZ6rY11EVYdn3bpRRtr70rLw3Kt0zbulK1reF/dhY6ESm0iu5P
         YoksUMb0uqm2tpcyhoVmX9k50hqdBgihs54iCiiJmcP2iVEpRgwDrp8Cyo8OkT1J1VM+
         NyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fT5YRGUsp3UQDncsiAq1LGfpJoF8FBrrF+dmUxcpD5Q=;
        b=SSpBHNekUczmGecO4Fjsfq2nO0m3ekrVvC5smk8VFnH87PkuG0UDK/asSknuIgsS+1
         zz/bnt1KY0d3+g1uJ7qrGHoDv2MCga1vrEuXQ4lBvAU81wcbOfpCO28F3IsUk23JcHyg
         GCmaXMH2iQWAqLiUqQqlSooJLARa/rWjkQA1b9FxRMrz0Z5dqVJFI11ARQnLYKL5DRf2
         VxA/gYgAKvFXUSQ0ylbmX0Q/mpf4NDww2QZxUNnVWN05DPp2m93QXxhMLlXLhSED8xw8
         FRsfFTIZY12Dve9grYWDpTKKr7EoWUL5CHJTZcIjGv4iLRlkFe3yK8whaswN5uOBC/Or
         9R9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quinn Tran <quinn.tran@cavium.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 028/140] scsi: qla2xxx: Fix re-login for Nport Handle in use
Date: Tue, 13 Mar 2018 16:23:51 +0100
Message-Id: <20180313152459.929076983@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837195630540816?=
X-GMAIL-MSGID: =?utf-8?q?1594837301707757342?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit a084fd68e1d26174c4cc1a13fbb0112f468ff7f4 upstream.

When NPort Handle is in use, driver needs to mark the handle as used and
pick another. Instead, the code clears the handle and re-pick the same
handle.

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_gs.c   |   16 ++++++++++----
 drivers/scsi/qla2xxx/qla_init.c |   44 ++++++++++++++++++++++++++++++++++++----
 drivers/scsi/qla2xxx/qla_isr.c  |    5 ----
 3 files changed, 51 insertions(+), 14 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -2833,7 +2833,7 @@ void qla24xx_handle_gidpn_event(scsi_qla
 				}
 			} else { /* fcport->d_id.b24 != ea->id.b24 */
 				fcport->d_id.b24 = ea->id.b24;
-				if (fcport->deleted == QLA_SESS_DELETED) {
+				if (fcport->deleted != QLA_SESS_DELETED) {
 					ql_dbg(ql_dbg_disc, vha, 0x2021,
 					    "%s %d %8phC post del sess\n",
 					    __func__, __LINE__, fcport->port_name);
@@ -3206,10 +3206,16 @@ static void qla2x00_async_gpnid_sp_done(
 	struct event_arg ea;
 	struct qla_work_evt *e;
 
-	ql_dbg(ql_dbg_disc, vha, 0x2066,
-	    "Async done-%s res %x ID %3phC. %8phC\n",
-	    sp->name, res, ct_req->req.port_id.port_id,
-	    ct_rsp->rsp.gpn_id.port_name);
+	if (res)
+		ql_dbg(ql_dbg_disc, vha, 0x2066,
+		    "Async done-%s fail res %x ID %3phC. %8phC\n",
+		    sp->name, res, ct_req->req.port_id.port_id,
+		    ct_rsp->rsp.gpn_id.port_name);
+	else
+		ql_dbg(ql_dbg_disc, vha, 0x2066,
+		    "Async done-%s good ID %3phC. %8phC\n",
+		    sp->name, ct_req->req.port_id.port_id,
+		    ct_rsp->rsp.gpn_id.port_name);
 
 	if (res) {
 		sp->free(sp);
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1445,6 +1445,8 @@ static void
 qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 {
 	port_id_t cid;	/* conflict Nport id */
+	u16 lid;
+	struct fc_port *conflict_fcport;
 
 	switch (ea->data[0]) {
 	case MBS_COMMAND_COMPLETE:
@@ -1460,8 +1462,12 @@ qla24xx_handle_plogi_done_event(struct s
 			qla24xx_post_prli_work(vha, ea->fcport);
 		} else {
 			ql_dbg(ql_dbg_disc, vha, 0x20ea,
-				"%s %d %8phC post gpdb\n",
-				__func__, __LINE__, ea->fcport->port_name);
+			    "%s %d %8phC LoopID 0x%x in use with %06x. post gnl\n",
+			    __func__, __LINE__, ea->fcport->port_name,
+			    ea->fcport->loop_id, ea->fcport->d_id.b24);
+
+			set_bit(ea->fcport->loop_id, vha->hw->loop_id_map);
+			ea->fcport->loop_id = FC_NO_LOOP_ID;
 			ea->fcport->chip_reset = vha->hw->base_qpair->chip_reset;
 			ea->fcport->logout_on_delete = 1;
 			ea->fcport->send_els_logo = 0;
@@ -1506,8 +1512,38 @@ qla24xx_handle_plogi_done_event(struct s
 		    ea->fcport->d_id.b.domain, ea->fcport->d_id.b.area,
 		    ea->fcport->d_id.b.al_pa);
 
-		qla2x00_clear_loop_id(ea->fcport);
-		qla24xx_post_gidpn_work(vha, ea->fcport);
+		lid = ea->iop[1] & 0xffff;
+		qlt_find_sess_invalidate_other(vha,
+		    wwn_to_u64(ea->fcport->port_name),
+		    ea->fcport->d_id, lid, &conflict_fcport);
+
+		if (conflict_fcport) {
+			/*
+			 * Another fcport share the same loop_id/nport id.
+			 * Conflict fcport needs to finish cleanup before this
+			 * fcport can proceed to login.
+			 */
+			conflict_fcport->conflict = ea->fcport;
+			ea->fcport->login_pause = 1;
+
+			ql_dbg(ql_dbg_disc, vha, 0x20ed,
+			    "%s %d %8phC NPortId %06x inuse with loopid 0x%x. post gidpn\n",
+			    __func__, __LINE__, ea->fcport->port_name,
+			    ea->fcport->d_id.b24, lid);
+			qla2x00_clear_loop_id(ea->fcport);
+			qla24xx_post_gidpn_work(vha, ea->fcport);
+		} else {
+			ql_dbg(ql_dbg_disc, vha, 0x20ed,
+			    "%s %d %8phC NPortId %06x inuse with loopid 0x%x. sched delete\n",
+			    __func__, __LINE__, ea->fcport->port_name,
+			    ea->fcport->d_id.b24, lid);
+
+			qla2x00_clear_loop_id(ea->fcport);
+			set_bit(lid, vha->hw->loop_id_map);
+			ea->fcport->loop_id = lid;
+			ea->fcport->keep_nport_handle = 0;
+			qlt_schedule_sess_for_deletion(ea->fcport, false);
+		}
 		break;
 	}
 	return;
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2341,7 +2341,6 @@ qla2x00_status_entry(scsi_qla_host_t *vh
 	int res = 0;
 	uint16_t state_flags = 0;
 	uint16_t retry_delay = 0;
-	uint8_t no_logout = 0;
 
 	sts = (sts_entry_t *) pkt;
 	sts24 = (struct sts_entry_24xx *) pkt;
@@ -2612,7 +2611,6 @@ check_scsi_status:
 		break;
 
 	case CS_PORT_LOGGED_OUT:
-		no_logout = 1;
 	case CS_PORT_CONFIG_CHG:
 	case CS_PORT_BUSY:
 	case CS_INCOMPLETE:
@@ -2643,9 +2641,6 @@ check_scsi_status:
 				port_state_str[atomic_read(&fcport->state)],
 				comp_status);
 
-			if (no_logout)
-				fcport->logout_on_delete = 0;
-
 			qla2x00_mark_device_lost(fcport->vha, fcport, 1, 1);
 			qlt_schedule_sess_for_deletion_lock(fcport);
 		}
