Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvW6bMxp/qv/FsuZx8frZXfQVpmvvshZ5WNYNXXNeykNpjSGDbvZ0CuXf5SKqTd1G2uE92q
ARC-Seal: i=1; a=rsa-sha256; t=1520955275; cv=none;
        d=google.com; s=arc-20160816;
        b=BXHsblymImAqUzGyIa/oPSl8z5q5XnKoY6Pov5xYrQ4KjH1uy6PIzV34beUeEWVBr1
         1EkKk780QYo2DMc2JgAL7cDT7qrVSYi8fGBJKtTfO6GPHzGro4Q0JYHIZsNZqf+n1G15
         szt0vSAPvCGhZEC3nyHFgOGuMmcOciBDPTfVRn+jFs50tm0bleAWAWN8u+5hYqxGDqaA
         H7hcHy/QcLVhy3aFJ4Ffm1HpuEv6q6pWkZRN/bWIkGmfRvBOMz6KvVMSQsWT8WDKvcOy
         uqqwLI6i99u/t0WZhCWPwSuke/MoeMDsw5Jbe3bfYADAH2ayHplY2yv3xhR4vSrrS+TY
         HCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BYMkOgtg2AhxFOH235tf1Ea8+vFbU6MFq4434g3f1vc=;
        b=LLIrSwAGrSGamucsPJWnNlG7QftTtwPedsfI1KmjOSgVEJ51EtFCoQzrg4LJhRAYe2
         n7cb3upxZNQVmDvwKcb7PNYvR642GnDHKCPqBnQqiJDTDn4faMz5TZfR/sVTJ3QOGTiO
         125Lx3aZn4tI/J8zQJON/iV3tOb9VxUPx2HAauXkmTi+fGAedH921J5FbZnvSWS527/5
         aM6tg7o4PZ9EqbHRnYQu72N2uZnmrlznoKnF3v1I87dHabQpypt4lVm52iE43ho8tggf
         jXo2aIf+DObxfsid6cg8QhOkhT5cuHpzLWE+ofFiD3a/oBDafqlpawEaDt3VNTX7Uq1E
         Serw==
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
Subject: [PATCH 4.15 129/146] scsi: qla2xxx: Retry switch command on time out
Date: Tue, 13 Mar 2018 16:24:56 +0100
Message-Id: <20180313152330.147327688@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837199077345038?=
X-GMAIL-MSGID: =?utf-8?q?1594837199077345038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 25ad76b703d9ad536f3411b15b1070aeb059ab55 upstream.

Retry GID_PN & GPN_ID switch commands for time out case.

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_gs.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -175,6 +175,9 @@ qla2x00_chk_ms_status(scsi_qla_host_t *v
 				set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
 			}
 			break;
+		case CS_TIMEOUT:
+			rval = QLA_FUNCTION_TIMEOUT;
+			/* drop through */
 		default:
 			ql_dbg(ql_dbg_disc, vha, 0x2033,
 			    "%s failed, completion status (%x) on port_id: "
@@ -2889,9 +2892,22 @@ static void qla2x00_async_gidpn_sp_done(
 	ea.rc = res;
 	ea.event = FCME_GIDPN_DONE;
 
-	ql_dbg(ql_dbg_disc, vha, 0x204f,
-	    "Async done-%s res %x, WWPN %8phC ID %3phC \n",
-	    sp->name, res, fcport->port_name, id);
+	if (res == QLA_FUNCTION_TIMEOUT) {
+		ql_dbg(ql_dbg_disc, sp->vha, 0xffff,
+		    "Async done-%s WWPN %8phC timed out.\n",
+		    sp->name, fcport->port_name);
+		qla24xx_post_gidpn_work(sp->vha, fcport);
+		sp->free(sp);
+		return;
+	} else if (res) {
+		ql_dbg(ql_dbg_disc, sp->vha, 0xffff,
+		    "Async done-%s fail res %x, WWPN %8phC\n",
+		    sp->name, res, fcport->port_name);
+	} else {
+		ql_dbg(ql_dbg_disc, vha, 0x204f,
+		    "Async done-%s good WWPN %8phC ID %3phC\n",
+		    sp->name, fcport->port_name, id);
+	}
 
 	qla2x00_fcport_event_handler(vha, &ea);
 
@@ -3217,11 +3233,6 @@ static void qla2x00_async_gpnid_sp_done(
 		    sp->name, ct_req->req.port_id.port_id,
 		    ct_rsp->rsp.gpn_id.port_name);
 
-	if (res) {
-		sp->free(sp);
-		return;
-	}
-
 	memset(&ea, 0, sizeof(ea));
 	memcpy(ea.port_name, ct_rsp->rsp.gpn_id.port_name, WWN_SIZE);
 	ea.sp = sp;
@@ -3231,6 +3242,13 @@ static void qla2x00_async_gpnid_sp_done(
 	ea.rc = res;
 	ea.event = FCME_GPNID_DONE;
 
+	if (res) {
+		if (res == QLA_FUNCTION_TIMEOUT)
+			qla24xx_post_gpnid_work(sp->vha, &ea.id);
+		sp->free(sp);
+		return;
+	}
+
 	qla2x00_fcport_event_handler(vha, &ea);
 
 	e = qla2x00_alloc_work(vha, QLA_EVT_GPNID_DONE);
