Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtlY8WtB0uCptVUESQE/wZnD3lAon5iGpsQAOOBxZo6DAio0sHxgMxF75f8KNfsGBlRcq50
ARC-Seal: i=1; a=rsa-sha256; t=1520955387; cv=none;
        d=google.com; s=arc-20160816;
        b=p97onR78G7aji6ksJMSCL+KyiuS7nt7BqwFp5hWGzJEJEqkWamwDuZ1LJ/up0A/bR6
         6Vstrd3GDXtfUL/Jekg2YHXXfz0gvVsAkSD80/t1IbXXikIdCzzq8OCY6ew3bYL8PyWp
         AF2TDF8ylk3BK7kkYMJ9n9uEfHiemIywskMKLEb+lgrfArafw3Pb/oAAF9mlJhTwcfS2
         SYFz5p6NJx0RPSd4eQTPYREWG0QofCqcoYiciBsR31Hk3RvZvpkmY0JqlTYNI0fcHkdN
         /iQWgqJY0p0dcea6WGs4/9yQM1AeaR/mRHr593DindeoBpobumaJFlrlIEKSY4oteYb9
         JKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wi8+yV5m+UL/yCNSfuLOabFnic8aOITCOPDe56OrgrQ=;
        b=sJOiaupUNbNDlpfZGIsAU1TJOLdYBdbUI52K8KF7iYNtM6c6B+C9SHz6ROYpE9ytTn
         EcanUiaEy5Q53miPhD2ERvENyRtv+/91M05YYyTvXC1yM2EMW6NIvOGAeo1mMb8eOJED
         Ka5mVWqqay+yAsySBvpq8n84GPnhIXF1Cxq7OcUijBjM7xUjvelyGYJgghPmBJ0KDMKI
         3+QysBT0ZHcj0oP+i3li1/TW/eRncY+R3I7YZ+9GLU90X5KPehT5JAEX3IiGdV9Ir3IM
         yT1ss4uRc0h99JEcY5NHb5DdUuRmqrmfn6IN6hrXBHJgTM4bse8ZZ5LZZGjS6XY2FI4t
         nd6w==
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
Subject: [PATCH 4.14 033/140] scsi: qla2xxx: Fix Relogin being triggered too fast
Date: Tue, 13 Mar 2018 16:23:56 +0100
Message-Id: <20180313152500.325491368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837213711423428?=
X-GMAIL-MSGID: =?utf-8?q?1594837316837098318?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4085,6 +4085,7 @@ typedef struct scsi_qla_host {
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
@@ -4860,7 +4860,7 @@ void qla2x00_relogin(struct scsi_qla_hos
 	 */
 		if (atomic_read(&fcport->state) != FCS_ONLINE &&
 		    fcport->login_retry && !(fcport->flags & FCF_ASYNC_SENT)) {
-			fcport->login_retry--;
+
 			if (fcport->flags & FCF_FABRIC_DEVICE) {
 				ql_dbg(ql_dbg_disc, fcport->vha, 0x2108,
 				    "%s %8phC DS %d LS %d\n", __func__,
@@ -4871,6 +4871,7 @@ void qla2x00_relogin(struct scsi_qla_hos
 				ea.fcport = fcport;
 				qla2x00_fcport_event_handler(vha, &ea);
 			} else {
+				fcport->login_retry--;
 				status = qla2x00_local_device_login(vha,
 								fcport);
 				if (status == QLA_SUCCESS) {
@@ -5853,16 +5854,21 @@ qla2x00_do_dpc(void *data)
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
