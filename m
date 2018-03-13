Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvdp7vGwwjNsGcGeHus1MHdMZCL5q3uSQUxowwsDcaJgyz32UunE0dwqBhnYNO7hjV0usbU
ARC-Seal: i=1; a=rsa-sha256; t=1520955278; cv=none;
        d=google.com; s=arc-20160816;
        b=tx7zK+hiIGThtOpgH08U1MweMIJpCGu//ksPjmX+/RQaXpaXNofm5GcAA7mQKS1wNh
         IPgRIT5xAZhaNpGW4N37xvONC44+nl3MP0sFiRmDxavsweLfVthgakzRNdu6H7LwPYX+
         2PBcxc9k/hcKMUaTZ4U1wnpKqOiTXefjp+Uqy8nIg0pRHnm4w1AvyOpUcfY7mjg/EweJ
         ReFN0D4x3f/jb6nQhT4PQw81eYG8O+Bgdk3bmC8YBUXUf5zOeeD3ULDKpVz84uDQ45iZ
         KfiTwOYnbL9Pm3NqgB8noc88ikQ/BuOrVnjjVtZyKw2zQdSX0cQbxHzB3PeD8ZqNZ7da
         K2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RBmvqHd1zbxQQ25CZ8GRNQMnATdwmnCjW8d3tKtvbPo=;
        b=G5OW2I3n6oXrIehSb4ENi6CbPWCEaOTMI7gYB49dJknGROlq2BgtwVqwsyOxTFpcbe
         KZlVWfxZDF64TlaOl5VwqI8AOre5tAVR7YkJaoyTQY832FyVG7Yb/0OWmtt2tpprcSHS
         iQAmJ1SfIT2eKIri7tUkByuoiFiOZD4UPeZ0wvXFaatJjGOi3eGeRO+fZjXxT15Y02cE
         3CuL8RjNTIr9J04hUdN2dQ/+xE4rfo93/q1WhQl8FLSJPtvvEEXhfyJvEFFJNIZn267H
         u5KQ19J29veLgne373lohrrkh2ZdLBeyVB1ReFxgOHQLc8tglJw5VqQQQfsIgSDNGx40
         HCcg==
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
Subject: [PATCH 4.15 130/146] scsi: qla2xxx: Serialize GPNID for multiple RSCN
Date: Tue, 13 Mar 2018 16:24:57 +0100
Message-Id: <20180313152330.214496804@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837201848440892?=
X-GMAIL-MSGID: =?utf-8?q?1594837201848440892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 2d73ac6102d943c4be4945735a338005359c6abc upstream.

GPNID is triggered by RSCN. For multiple RSCNs of the same affected
NPORT ID, serialize the GPNID to prevent confusion.

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_def.h |   48 ++++++++++++++++++++++-------------------
 drivers/scsi/qla2xxx/qla_gs.c  |   35 +++++++++++++++++++++++++----
 drivers/scsi/qla2xxx/qla_isr.c |    2 -
 drivers/scsi/qla2xxx/qla_os.c  |    1 
 4 files changed, 58 insertions(+), 28 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -315,6 +315,29 @@ struct srb_cmd {
 /* To identify if a srb is of T10-CRC type. @sp => srb_t pointer */
 #define IS_PROT_IO(sp)	(sp->flags & SRB_CRC_CTX_DSD_VALID)
 
+/*
+ * 24 bit port ID type definition.
+ */
+typedef union {
+	uint32_t b24 : 24;
+
+	struct {
+#ifdef __BIG_ENDIAN
+		uint8_t domain;
+		uint8_t area;
+		uint8_t al_pa;
+#elif defined(__LITTLE_ENDIAN)
+		uint8_t al_pa;
+		uint8_t area;
+		uint8_t domain;
+#else
+#error "__BIG_ENDIAN or __LITTLE_ENDIAN must be defined!"
+#endif
+		uint8_t rsvd_1;
+	} b;
+} port_id_t;
+#define INVALID_PORT_ID	0xFFFFFF
+
 struct els_logo_payload {
 	uint8_t opcode;
 	uint8_t rsvd[3];
@@ -338,6 +361,7 @@ struct ct_arg {
 	u32		rsp_size;
 	void		*req;
 	void		*rsp;
+	port_id_t	id;
 };
 
 /*
@@ -499,6 +523,7 @@ typedef struct srb {
 	const char *name;
 	int iocbs;
 	struct qla_qpair *qpair;
+	struct list_head elem;
 	u32 gen1;	/* scratch */
 	u32 gen2;	/* scratch */
 	union {
@@ -2164,28 +2189,6 @@ struct imm_ntfy_from_isp {
 #define REQUEST_ENTRY_SIZE	(sizeof(request_t))
 
 
-/*
- * 24 bit port ID type definition.
- */
-typedef union {
-	uint32_t b24 : 24;
-
-	struct {
-#ifdef __BIG_ENDIAN
-		uint8_t domain;
-		uint8_t area;
-		uint8_t al_pa;
-#elif defined(__LITTLE_ENDIAN)
-		uint8_t al_pa;
-		uint8_t area;
-		uint8_t domain;
-#else
-#error "__BIG_ENDIAN or __LITTLE_ENDIAN must be defined!"
-#endif
-		uint8_t rsvd_1;
-	} b;
-} port_id_t;
-#define INVALID_PORT_ID	0xFFFFFF
 
 /*
  * Switch info gathering structure.
@@ -4252,6 +4255,7 @@ typedef struct scsi_qla_host {
 	uint8_t n2n_node_name[WWN_SIZE];
 	uint8_t n2n_port_name[WWN_SIZE];
 	uint16_t	n2n_id;
+	struct list_head gpnid_list;
 } scsi_qla_host_t;
 
 struct qla27xx_image_status {
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3221,16 +3221,17 @@ static void qla2x00_async_gpnid_sp_done(
 	    (struct ct_sns_rsp *)sp->u.iocb_cmd.u.ctarg.rsp;
 	struct event_arg ea;
 	struct qla_work_evt *e;
+	unsigned long flags;
 
 	if (res)
 		ql_dbg(ql_dbg_disc, vha, 0x2066,
-		    "Async done-%s fail res %x ID %3phC. %8phC\n",
-		    sp->name, res, ct_req->req.port_id.port_id,
+		    "Async done-%s fail res %x rscn gen %d ID %3phC. %8phC\n",
+		    sp->name, res, sp->gen1, ct_req->req.port_id.port_id,
 		    ct_rsp->rsp.gpn_id.port_name);
 	else
 		ql_dbg(ql_dbg_disc, vha, 0x2066,
-		    "Async done-%s good ID %3phC. %8phC\n",
-		    sp->name, ct_req->req.port_id.port_id,
+		    "Async done-%s good rscn gen %d ID %3phC. %8phC\n",
+		    sp->name, sp->gen1, ct_req->req.port_id.port_id,
 		    ct_rsp->rsp.gpn_id.port_name);
 
 	memset(&ea, 0, sizeof(ea));
@@ -3242,11 +3243,20 @@ static void qla2x00_async_gpnid_sp_done(
 	ea.rc = res;
 	ea.event = FCME_GPNID_DONE;
 
+	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
+	list_del(&sp->elem);
+	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
+
 	if (res) {
 		if (res == QLA_FUNCTION_TIMEOUT)
 			qla24xx_post_gpnid_work(sp->vha, &ea.id);
 		sp->free(sp);
 		return;
+	} else if (sp->gen1) {
+		/* There was anoter RSNC for this Nport ID */
+		qla24xx_post_gpnid_work(sp->vha, &ea.id);
+		sp->free(sp);
+		return;
 	}
 
 	qla2x00_fcport_event_handler(vha, &ea);
@@ -3282,8 +3292,9 @@ int qla24xx_async_gpnid(scsi_qla_host_t
 {
 	int rval = QLA_FUNCTION_FAILED;
 	struct ct_sns_req       *ct_req;
-	srb_t *sp;
+	srb_t *sp, *tsp;
 	struct ct_sns_pkt *ct_sns;
+	unsigned long flags;
 
 	if (!vha->flags.online)
 		goto done;
@@ -3294,8 +3305,22 @@ int qla24xx_async_gpnid(scsi_qla_host_t
 
 	sp->type = SRB_CT_PTHRU_CMD;
 	sp->name = "gpnid";
+	sp->u.iocb_cmd.u.ctarg.id = *id;
+	sp->gen1 = 0;
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
 
+	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
+	list_for_each_entry(tsp, &vha->gpnid_list, elem) {
+		if (tsp->u.iocb_cmd.u.ctarg.id.b24 == id->b24) {
+			tsp->gen1++;
+			spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
+			sp->free(sp);
+			goto done;
+		}
+	}
+	list_add_tail(&sp->elem, &vha->gpnid_list);
+	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
+
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 		sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
 		GFP_KERNEL);
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1574,7 +1574,7 @@ qla24xx_els_ct_entry(scsi_qla_host_t *vh
 		/* borrowing sts_entry_24xx.comp_status.
 		   same location as ct_entry_24xx.comp_status
 		 */
-		res = qla2x00_chk_ms_status(vha, (ms_iocb_entry_t *)pkt,
+		res = qla2x00_chk_ms_status(sp->vha, (ms_iocb_entry_t *)pkt,
 			(struct ct_sns_rsp *)sp->u.iocb_cmd.u.ctarg.rsp,
 			sp->name);
 		sp->done(sp, res);
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4515,6 +4515,7 @@ struct scsi_qla_host *qla2x00_create_hos
 	INIT_LIST_HEAD(&vha->qp_list);
 	INIT_LIST_HEAD(&vha->gnl.fcports);
 	INIT_LIST_HEAD(&vha->nvme_rport_list);
+	INIT_LIST_HEAD(&vha->gpnid_list);
 
 	spin_lock_init(&vha->work_lock);
 	spin_lock_init(&vha->cmd_list_lock);
