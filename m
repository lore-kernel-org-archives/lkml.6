Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs7whrCuuuJz0AR4fYVPV2tQJvrqhybz7whqLjjzQbFRXEjgUEGo6GfFbWoPM5JWjjXWkyV
ARC-Seal: i=1; a=rsa-sha256; t=1520955289; cv=none;
        d=google.com; s=arc-20160816;
        b=nxTC9QJyZE+ZgT/rEHGoljJli6HA4mHtNdP9WTPXlPPPmZ0ByFAoHulnp0kIMNlVTJ
         RYguzjp7eqIEcB1ek00V0AcoWFga46BrCLo9l6K6lrEhuHaZgoMoQ8yftoNlkVjXoeHM
         S0/MaZFqn788lwhOfs0tNUcsatX9qb5fA2T2h3T8X/NrvONZpeBgD+W4uIvYmbmT+Wlg
         0FfGgfoOW9JDBfenwvbmOzzVaAtaJkHzoR9hrapXIobyuBxEPY+2690LqRbbNdfYd4dj
         iUrGIxXru+A2S/Iij0B7chkAYaexpbfOqfnf/BppmPTxm/tt7T6UHh5Z2QoHl91rPRC/
         ydaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LxB5U9ZcSNAXQm0q2lqvYqMIRtuPx2zF5byzlCkKHuw=;
        b=MCxFE0LXCUfQha++tCerY0LlTp+JA4jkvhqulOMXi/d7UM57tC1d3DZ9Za9BV9m9SP
         re2X2xz4wg7aqgSq4bP7/zFN+RddusrhhT7WDD6/CGo8M2s9865avAMrTwlzmaSRaCEX
         bjBBLJ5u46b6vabA6NpWE88MzFdFqK7WL8uAuOrCSNcC09cAZgBLL4KZT9H9oHOmcqah
         93+EVOFP+q+52j/t1glTKfuAiy9T4E/IL0St35iNykdX23fuAOlhZIG+cg9xUv67A42n
         9pn7JAQMvS4s7zhhAy34nc2PgUcj2l93rIk7SQs5a0Rlqm76CjiL0Ciykh4cBPLPXJ+X
         4uGw==
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
Subject: [PATCH 4.15 134/146] scsi: qla2xxx: Fix Relogin being triggered too fast
Date: Tue, 13 Mar 2018 16:25:01 +0100
Message-Id: <20180313152330.476610621@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837213711423428?=
X-GMAIL-MSGID: =?utf-8?q?1594837213711423428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 4005a995668b8fd58f4cf1460dd4cf63efa18363 upstream.

Current driver design schedules relogin process via DPC thread every 1
second. In a large fabric, this DPC thread tries to schedule too many
jobs and might get overloaded. As a result of this processing of DPC
thread, it can schedule relogin earlier than 1 second.

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_def.h |    1 +
 drivers/scsi/qla2xxx/qla_mid.c |   22 ++++++++++++++--------
 drivers/scsi/qla2xxx/qla_os.c  |   22 ++++++++++++++--------
 3 files changed, 29 insertions(+), 16 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4110,6 +4110,7 @@ typedef struct scsi_qla_host {
 #define LOOP_READY	5
 #define LOOP_DEAD	6
 
+	unsigned long   relogin_jif;
 	unsigned long   dpc_flags;
 #define RESET_MARKER_NEEDED	0	/* Send marker to ISP. */
 #define RESET_ACTIVE		1
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -343,15 +343,21 @@ qla2x00_do_dpc_vp(scsi_qla_host_t *vha)
 		    "FCPort update end.\n");
 	}
 
-	if ((test_and_clear_bit(RELOGIN_NEEDED, &vha->dpc_flags)) &&
-		!test_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags) &&
-		atomic_read(&vha->loop_state) != LOOP_DOWN) {
+	if (test_bit(RELOGIN_NEEDED, &vha->dpc_flags) &&
+	    !test_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags) &&
+	    atomic_read(&vha->loop_state) != LOOP_DOWN) {
 
-		ql_dbg(ql_dbg_dpc, vha, 0x4018,
-		    "Relogin needed scheduled.\n");
-		qla2x00_relogin(vha);
-		ql_dbg(ql_dbg_dpc, vha, 0x4019,
-		    "Relogin needed end.\n");
+		if (!vha->relogin_jif ||
+		    time_after_eq(jiffies, vha->relogin_jif)) {
+			vha->relogin_jif = jiffies + HZ;
+			clear_bit(RELOGIN_NEEDED, &vha->dpc_flags);
+
+			ql_dbg(ql_dbg_dpc, vha, 0x4018,
+			    "Relogin needed scheduled.\n");
+			qla2x00_relogin(vha);
+			ql_dbg(ql_dbg_dpc, vha, 0x4019,
+			    "Relogin needed end.\n");
+		}
 	}
 
 	if (test_and_clear_bit(RESET_MARKER_NEEDED, &vha->dpc_flags) &&
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4905,7 +4905,7 @@ void qla2x00_relogin(struct scsi_qla_hos
 	 */
 		if (atomic_read(&fcport->state) != FCS_ONLINE &&
 		    fcport->login_retry && !(fcport->flags & FCF_ASYNC_SENT)) {
-			fcport->login_retry--;
+
 			if (fcport->flags & FCF_FABRIC_DEVICE) {
 				ql_dbg(ql_dbg_disc, fcport->vha, 0x2108,
 				    "%s %8phC DS %d LS %d\n", __func__,
@@ -4916,6 +4916,7 @@ void qla2x00_relogin(struct scsi_qla_hos
 				ea.fcport = fcport;
 				qla2x00_fcport_event_handler(vha, &ea);
 			} else {
+				fcport->login_retry--;
 				status = qla2x00_local_device_login(vha,
 								fcport);
 				if (status == QLA_SUCCESS) {
@@ -5898,16 +5899,21 @@ qla2x00_do_dpc(void *data)
 		}
 
 		/* Retry each device up to login retry count */
-		if ((test_and_clear_bit(RELOGIN_NEEDED,
-						&base_vha->dpc_flags)) &&
+		if (test_bit(RELOGIN_NEEDED, &base_vha->dpc_flags) &&
 		    !test_bit(LOOP_RESYNC_NEEDED, &base_vha->dpc_flags) &&
 		    atomic_read(&base_vha->loop_state) != LOOP_DOWN) {
 
-			ql_dbg(ql_dbg_dpc, base_vha, 0x400d,
-			    "Relogin scheduled.\n");
-			qla2x00_relogin(base_vha);
-			ql_dbg(ql_dbg_dpc, base_vha, 0x400e,
-			    "Relogin end.\n");
+			if (!base_vha->relogin_jif ||
+			    time_after_eq(jiffies, base_vha->relogin_jif)) {
+				base_vha->relogin_jif = jiffies + HZ;
+				clear_bit(RELOGIN_NEEDED, &base_vha->dpc_flags);
+
+				ql_dbg(ql_dbg_dpc, base_vha, 0x400d,
+				    "Relogin scheduled.\n");
+				qla2x00_relogin(base_vha);
+				ql_dbg(ql_dbg_dpc, base_vha, 0x400e,
+				    "Relogin end.\n");
+			}
 		}
 loop_resync_check:
 		if (test_and_clear_bit(LOOP_RESYNC_NEEDED,
