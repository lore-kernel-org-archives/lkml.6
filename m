Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtc6iMzIpRL0R7Q96V3r2r9pQuGx6bxIktorXxUXmA8lD/V8d5dmbaiHvquk8GLEQ2Guq15
ARC-Seal: i=1; a=rsa-sha256; t=1520955286; cv=none;
        d=google.com; s=arc-20160816;
        b=LsjqyetIkHL5JYRzYr9Vr2Ql3GBWiW5GWp8PUEh95vtYWHKIRri31AdnbnATnB7Y2n
         t6M68hiVDJw/q0y3dYFAEcr0W+3138sIcvbnHY88VRoIplhrcFh/IonRX1UdLZ+/qKR4
         StlZFB5EYdow44lJrAwW0Pdl26bMu0PwHyP3dyJn4T4S1OqSCvWwTRplwVvE6kmv0WFq
         mw3XLPEAfzrLPPuqMr4vGSVUYeNrdIK8emC48TndajAOaFrbljpm6BAhw4KBWegJ5zYo
         BW9ZM9knI+YvJQDhh/grsMQ2K3erHV2ezBQUGCeW4VGq4lushS8XT/mfNAEV1dDrt6aY
         dgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jr0aH38fQUb5Crd72Nj0eAL7aUVFL1aSto/HHnkoa9E=;
        b=QChw4ZFjpnibYLSgQz+yHmN9P8eACAKU4PJI870Z6PBJBDpYWz1Ftq5rdgblYg9oeW
         vx9EVtu+aLhDZpYoSu+jKxhIwS4ZAeEVxUKMJb1JVDg5nxAwqoRoz746e38SU1BzGikL
         Z7b2SztajE2OCmuyCtnn1s62nYpZuwTh0QA+xmrg5kYmtmxD8R+8lMT9AfxJHYhEkyvP
         LY1ZTz2PUXj33+HA6kp+/3xPFtYf0Qo0s+XIpzpDTwce8yCQf2poFbsa5XukSUOrXv7X
         YYY+CgXKNuJf2b1QLlzsA2MZsNtpScEnj2heeY0rh7eBxaWnM9HgD5Tln6/i4g5cESOX
         VEXw==
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
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 133/146] scsi: qla2xxx: Relogin to target port on a cable swap
Date: Tue, 13 Mar 2018 16:25:00 +0100
Message-Id: <20180313152330.400128363@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837210975368799?=
X-GMAIL-MSGID: =?utf-8?q?1594837210975368799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 5ef696aa9f3ccf999552d924c4e21a348f2bbea9 upstream.

If user swaps one target port for another target port for same switch
port, the new target port is not being recognized by the driver. Current
code assumes that old Target port has recovered from link down. The fix
will ask switch what is the WWPN of a specific NportID (GPNID) rather
than assuming it's the same Target port which has came back.

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_gs.c     |  170 +++++++++++++++++++++++++++++---------
 drivers/scsi/qla2xxx/qla_init.c   |    6 -
 drivers/scsi/qla2xxx/qla_os.c     |   35 +++++++
 drivers/scsi/qla2xxx/qla_target.c |   35 ++++++-
 4 files changed, 197 insertions(+), 49 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3171,43 +3171,136 @@ void qla24xx_async_gpnid_done(scsi_qla_h
 
 void qla24xx_handle_gpnid_event(scsi_qla_host_t *vha, struct event_arg *ea)
 {
-	fc_port_t *fcport;
-	unsigned long flags;
+	fc_port_t *fcport, *conflict, *t;
 
-	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
-	fcport = qla2x00_find_fcport_by_wwpn(vha, ea->port_name, 1);
-	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
-
-	if (fcport) {
-		/* cable moved. just plugged in */
-		fcport->rscn_gen++;
-		fcport->d_id = ea->id;
-		fcport->scan_state = QLA_FCPORT_FOUND;
-		fcport->flags |= FCF_FABRIC_DEVICE;
-
-		switch (fcport->disc_state) {
-		case DSC_DELETED:
-			ql_dbg(ql_dbg_disc, vha, 0x210d,
-			    "%s %d %8phC login\n", __func__, __LINE__,
-			    fcport->port_name);
-			qla24xx_fcport_handle_login(vha, fcport);
-			break;
-		case DSC_DELETE_PEND:
-			break;
-		default:
-			ql_dbg(ql_dbg_disc, vha, 0x2064,
-			    "%s %d %8phC post del sess\n",
-			    __func__, __LINE__, fcport->port_name);
-			qlt_schedule_sess_for_deletion_lock(fcport);
-			break;
+	ql_dbg(ql_dbg_disc, vha, 0xffff,
+	    "%s %d port_id: %06x\n",
+	    __func__, __LINE__, ea->id.b24);
+
+	if (ea->rc) {
+		/* cable is disconnected */
+		list_for_each_entry_safe(fcport, t, &vha->vp_fcports, list) {
+			if (fcport->d_id.b24 == ea->id.b24) {
+				ql_dbg(ql_dbg_disc, vha, 0xffff,
+				    "%s %d %8phC DS %d\n",
+				    __func__, __LINE__,
+				    fcport->port_name,
+				    fcport->disc_state);
+				fcport->scan_state = QLA_FCPORT_SCAN;
+				switch (fcport->disc_state) {
+				case DSC_DELETED:
+				case DSC_DELETE_PEND:
+					break;
+				default:
+					ql_dbg(ql_dbg_disc, vha, 0xffff,
+					    "%s %d %8phC post del sess\n",
+					    __func__, __LINE__,
+					    fcport->port_name);
+					qlt_schedule_sess_for_deletion_lock
+						(fcport);
+					break;
+				}
+			}
 		}
 	} else {
-		/* create new fcport */
-		ql_dbg(ql_dbg_disc, vha, 0x2065,
-		    "%s %d %8phC post new sess\n",
-		    __func__, __LINE__, ea->port_name);
-
-		qla24xx_post_newsess_work(vha, &ea->id, ea->port_name, NULL);
+		/* cable is connected */
+		fcport = qla2x00_find_fcport_by_wwpn(vha, ea->port_name, 1);
+		if (fcport) {
+			list_for_each_entry_safe(conflict, t, &vha->vp_fcports,
+			    list) {
+				if ((conflict->d_id.b24 == ea->id.b24) &&
+				    (fcport != conflict)) {
+					/* 2 fcports with conflict Nport ID or
+					 * an existing fcport is having nport ID
+					 * conflict with new fcport.
+					 */
+
+					ql_dbg(ql_dbg_disc, vha, 0xffff,
+					    "%s %d %8phC DS %d\n",
+					    __func__, __LINE__,
+					    conflict->port_name,
+					    conflict->disc_state);
+					conflict->scan_state = QLA_FCPORT_SCAN;
+					switch (conflict->disc_state) {
+					case DSC_DELETED:
+					case DSC_DELETE_PEND:
+						break;
+					default:
+						ql_dbg(ql_dbg_disc, vha, 0xffff,
+						    "%s %d %8phC post del sess\n",
+						    __func__, __LINE__,
+						    conflict->port_name);
+						qlt_schedule_sess_for_deletion_lock
+							(conflict);
+						break;
+					}
+				}
+			}
+
+			fcport->rscn_gen++;
+			fcport->scan_state = QLA_FCPORT_FOUND;
+			fcport->flags |= FCF_FABRIC_DEVICE;
+			switch (fcport->disc_state) {
+			case DSC_LOGIN_COMPLETE:
+				/* recheck session is still intact. */
+				ql_dbg(ql_dbg_disc, vha, 0x210d,
+				    "%s %d %8phC revalidate session with ADISC\n",
+				    __func__, __LINE__, fcport->port_name);
+				qla24xx_post_gpdb_work(vha, fcport,
+				    PDO_FORCE_ADISC);
+				break;
+			case DSC_DELETED:
+				ql_dbg(ql_dbg_disc, vha, 0x210d,
+				    "%s %d %8phC login\n", __func__, __LINE__,
+				    fcport->port_name);
+				fcport->d_id = ea->id;
+				qla24xx_fcport_handle_login(vha, fcport);
+				break;
+			case DSC_DELETE_PEND:
+				fcport->d_id = ea->id;
+				break;
+			default:
+				fcport->d_id = ea->id;
+				break;
+			}
+		} else {
+			list_for_each_entry_safe(conflict, t, &vha->vp_fcports,
+			    list) {
+				if (conflict->d_id.b24 == ea->id.b24) {
+					/* 2 fcports with conflict Nport ID or
+					 * an existing fcport is having nport ID
+					 * conflict with new fcport.
+					 */
+					ql_dbg(ql_dbg_disc, vha, 0xffff,
+					    "%s %d %8phC DS %d\n",
+					    __func__, __LINE__,
+					    conflict->port_name,
+					    conflict->disc_state);
+
+					conflict->scan_state = QLA_FCPORT_SCAN;
+					switch (conflict->disc_state) {
+					case DSC_DELETED:
+					case DSC_DELETE_PEND:
+						break;
+					default:
+						ql_dbg(ql_dbg_disc, vha, 0xffff,
+						    "%s %d %8phC post del sess\n",
+						    __func__, __LINE__,
+						    conflict->port_name);
+						qlt_schedule_sess_for_deletion_lock
+							(conflict);
+						break;
+					}
+				}
+			}
+
+			/* create new fcport */
+			ql_dbg(ql_dbg_disc, vha, 0x2065,
+			    "%s %d %8phC post new sess\n",
+			    __func__, __LINE__, ea->port_name);
+			qla24xx_post_newsess_work(vha, &ea->id,
+			    ea->port_name, NULL);
+		}
 	}
 }
 
@@ -3248,12 +3341,13 @@ static void qla2x00_async_gpnid_sp_done(
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 
 	if (res) {
-		if (res == QLA_FUNCTION_TIMEOUT)
+		if (res == QLA_FUNCTION_TIMEOUT) {
 			qla24xx_post_gpnid_work(sp->vha, &ea.id);
-		sp->free(sp);
-		return;
+			sp->free(sp);
+			return;
+		}
 	} else if (sp->gen1) {
-		/* There was anoter RSNC for this Nport ID */
+		/* There was another RSCN for this Nport ID */
 		qla24xx_post_gpnid_work(sp->vha, &ea.id);
 		sp->free(sp);
 		return;
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -925,6 +925,9 @@ void qla24xx_handle_gpdb_event(scsi_qla_
 		 * must have triggered the session to be re-validate.
 		 * session is still valid.
 		 */
+		ql_dbg(ql_dbg_disc, vha, 0x20d6,
+		    "%s %d %8phC session revalidate success\n",
+		    __func__, __LINE__, fcport->port_name);
 		fcport->disc_state = DSC_LOGIN_COMPLETE;
 	}
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
@@ -1049,9 +1052,8 @@ void qla24xx_handle_rscn_event(fc_port_t
 	switch (fcport->disc_state) {
 	case DSC_DELETED:
 	case DSC_LOGIN_COMPLETE:
-		qla24xx_post_gidpn_work(fcport->vha, fcport);
+		qla24xx_post_gpnid_work(fcport->vha, &ea->id);
 		break;
-
 	default:
 		break;
 	}
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4760,10 +4760,39 @@ void qla24xx_create_new_sess(struct scsi
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 
 	if (fcport) {
-		if (pla)
+		if (pla) {
 			qlt_plogi_ack_unref(vha, pla);
-		else
-			qla24xx_async_gffid(vha, fcport);
+		} else {
+			spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
+			tfcp = qla2x00_find_fcport_by_nportid(vha,
+			    &e->u.new_sess.id, 1);
+			if (tfcp && (tfcp != fcport)) {
+				/*
+				 * We have a conflict fcport with same NportID.
+				 */
+				ql_dbg(ql_dbg_disc, vha, 0xffff,
+				    "%s %8phC found conflict b4 add. DS %d LS %d\n",
+				    __func__, tfcp->port_name, tfcp->disc_state,
+				    tfcp->fw_login_state);
+
+				switch (tfcp->disc_state) {
+				case DSC_DELETED:
+					break;
+				case DSC_DELETE_PEND:
+					fcport->login_pause = 1;
+					tfcp->conflict = fcport;
+					break;
+				default:
+					fcport->login_pause = 1;
+					tfcp->conflict = fcport;
+					qlt_schedule_sess_for_deletion_lock
+						(tfcp);
+					break;
+				}
+			}
+			spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
+			qla24xx_async_gnl(vha, fcport);
+		}
 	}
 
 	if (free_fcport) {
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -890,6 +890,17 @@ qlt_plogi_ack_link(struct scsi_qla_host
 		iocb->u.isp24.port_id[1], iocb->u.isp24.port_id[0],
 		pla->ref_count, pla, link);
 
+	if (link == QLT_PLOGI_LINK_CONFLICT) {
+		switch (sess->disc_state) {
+		case DSC_DELETED:
+		case DSC_DELETE_PEND:
+			pla->ref_count--;
+			return;
+		default:
+			break;
+		}
+	}
+
 	if (sess->plogi_link[link])
 		qlt_plogi_ack_unref(vha, sess->plogi_link[link]);
 
@@ -4737,6 +4748,10 @@ static int qlt_24xx_handle_els(struct sc
 		sess->d_id = port_id;
 		sess->login_gen++;
 
+		ql_dbg(ql_dbg_disc, vha, 0x20f9,
+		    "%s %d %8phC  DS %d\n",
+		    __func__, __LINE__, sess->port_name, sess->disc_state);
+
 		switch (sess->disc_state) {
 		case DSC_DELETED:
 			qlt_plogi_ack_unref(vha, pla);
@@ -4786,12 +4801,20 @@ static int qlt_24xx_handle_els(struct sc
 		}
 
 		if (conflict_sess) {
-			ql_dbg(ql_dbg_tgt_mgt, vha, 0xf09b,
-			    "PRLI with conflicting sess %p port %8phC\n",
-			    conflict_sess, conflict_sess->port_name);
-			qlt_send_term_imm_notif(vha, iocb, 1);
-			res = 0;
-			break;
+			switch (conflict_sess->disc_state) {
+			case DSC_DELETED:
+			case DSC_DELETE_PEND:
+				break;
+			default:
+				ql_dbg(ql_dbg_tgt_mgt, vha, 0xf09b,
+				    "PRLI with conflicting sess %p port %8phC\n",
+				    conflict_sess, conflict_sess->port_name);
+				conflict_sess->fw_login_state =
+				    DSC_LS_PORT_UNAVAIL;
+				qlt_send_term_imm_notif(vha, iocb, 1);
+				res = 0;
+				break;
+			}
 		}
 
 		if (sess != NULL) {
