Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtQeJvWq5sECE8liMxO+aPSgfHu+jQlb6OfJtbmhGK/j3eNO5IWJ+DWefIs75t6qrtEjCni
ARC-Seal: i=1; a=rsa-sha256; t=1520955272; cv=none;
        d=google.com; s=arc-20160816;
        b=ZlW3Txqap6POTqxewdS5LmbMS1darrv4LS0SOLJNArD/JU76hT3RmmxwuADgmAaPhj
         LUKxc9ERGy3a5aVglSrQtlj7UljsZnvQu1hwOktnNw2Nd+f5mJLXYsLle/fN0ojimiRh
         r7ZNHKNdbuP/D6wzwGcW/NMQKFrzEttAMA6MQGZo0MoTA7KMPaaOjpuRijLvpK1WG92F
         yscdL0LPj0U0vp5k3Fm0sDqSz/svSxYy0t9YNRsND6CxjkqPNMEAN9B5r71dQq+96Y2M
         84zo+yKgF595nVsjXpdXrZrr7k/GUfR8vzv/LyLNtNsLTi4gC7X1KrQ+6d5WXRoYPoQd
         5n3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j6HtJ6Fa3sjVTMtqs60lk2XEI1WMF3jXXh/LdsJc/mU=;
        b=AHkiKVKkFD4bmeceJVL4gY61ovur6+AoFXLM04wXGr/F5l1iQ0LDXKib1x7pC2JkAa
         OqX15UHNWRmidxbWf/oSzbw1VHgkSYQzBZF1e2X5P3Gro3hASQES5G/PBbtznhtwxg8p
         dww7MtiUTeQ1A7a+/bGFfqEe6+jDJxdT7EhQyJ9llgHWqvrClzhDWVrYvZsZn+OPFecK
         URmZFargOl+2KRLYQYM8irA5zGW146npmAOLJpp8PydbqzzDrnj4unGCgrtedd/kObjL
         RWtmrdAsEzIoWu2eX9+qNqgqgNnd6MAmU3L6a8N8JGSKDmwD5weuBtPSQGd8YFzQ23io
         xKAA==
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
Subject: [PATCH 4.15 128/146] scsi: qla2xxx: Fix re-login for Nport Handle in use
Date: Tue, 13 Mar 2018 16:24:55 +0100
Message-Id: <20180313152330.069113806@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837195630540816?=
X-GMAIL-MSGID: =?utf-8?q?1594837195630540816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1453,6 +1453,8 @@ static void
 qla24xx_handle_plogi_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 {
 	port_id_t cid;	/* conflict Nport id */
+	u16 lid;
+	struct fc_port *conflict_fcport;
 
 	switch (ea->data[0]) {
 	case MBS_COMMAND_COMPLETE:
@@ -1468,8 +1470,12 @@ qla24xx_handle_plogi_done_event(struct s
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
@@ -1514,8 +1520,38 @@ qla24xx_handle_plogi_done_event(struct s
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
@@ -2369,7 +2369,6 @@ qla2x00_status_entry(scsi_qla_host_t *vh
 	int res = 0;
 	uint16_t state_flags = 0;
 	uint16_t retry_delay = 0;
-	uint8_t no_logout = 0;
 
 	sts = (sts_entry_t *) pkt;
 	sts24 = (struct sts_entry_24xx *) pkt;
@@ -2640,7 +2639,6 @@ check_scsi_status:
 		break;
 
 	case CS_PORT_LOGGED_OUT:
-		no_logout = 1;
 	case CS_PORT_CONFIG_CHG:
 	case CS_PORT_BUSY:
 	case CS_INCOMPLETE:
@@ -2671,9 +2669,6 @@ check_scsi_status:
 				port_state_str[atomic_read(&fcport->state)],
 				comp_status);
 
-			if (no_logout)
-				fcport->logout_on_delete = 0;
-
 			qla2x00_mark_device_lost(fcport->vha, fcport, 1, 1);
 			qlt_schedule_sess_for_deletion_lock(fcport);
 		}
