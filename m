Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsVAJDs5yPG8ZWZkZrxtCEpVQX+rxsfevbBk+LnSHTs65h1bzYWIL/7AGebMtVv6uOMXLlA
ARC-Seal: i=1; a=rsa-sha256; t=1521484235; cv=none;
        d=google.com; s=arc-20160816;
        b=RfQU2b5FyBBNLYZO8fQ/lAtnyZUkfQQSmtf8igHwXrvkicIRejlCJT8Ns19yK/933L
         NJbRor5LN+C1DkWd++7Qo/uvB8hWZ3qcMsQvh6cm3LYJCWPFAfI2wXkCf/D8Vhzvuxhm
         OlRoEo5Q2s6Sz2CrQ7arXbGSjLPlCgqRUp5R9UnjC/rkZrABm0Gbz828c5OWZZI8kf8w
         d4eh5yYTGZChG7DB+TwtMTwGqcQRgLTubChMVj18odoEUH7nVi2/7vl3h+GZtGr3at5U
         buDhh4hfEZLH3eGVtZuTewQiaUhw7T37M8E3oYA5cufeP2IHgry9dr43VgESUUEoDJm1
         x47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kmE9j3GNHytBVPYvsggX5jluGGSDpayk60KjF1cpozk=;
        b=gbdqLMDoIVtyzebqzHXo5UoFPONUW1UPnH6eiCtHaJKY3mTqE+WKqCjNHmFyUMu/7q
         XxIZ1KvvL26QzwC/J113Hrj4NOORnIFotJkZEIlSAE+i7Vpc9WsLvOGIByJa/sUdiUNJ
         1eziVefBRU9I46NoP6e4GwupI/+dPsD2dWE1dJdQw7lI53PtgJc5A67nbCco+jA6lUIo
         0kxjM8VtK17KPFeVRpKbqfUEzn+1+styZ+IX+wCBwuAeGcxUHUXqVKAdJimjYSPvjWsR
         onuwz7EhGV16ssPbwqA+/3gHI/6ZYq9fWTzc9LJ+zkKWVGmj37lHRqLCCHMAJk0VHZ0p
         FBfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bill Kuzeja <william.kuzeja@stratus.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 39/41] scsi: qla2xxx: Fix crashes in qla2x00_probe_one on probe failure
Date: Mon, 19 Mar 2018 19:08:39 +0100
Message-Id: <20180319180734.739409337@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391854111958575?=
X-GMAIL-MSGID: =?utf-8?q?1595391854111958575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bill Kuzeja <William.Kuzeja@stratus.com>

commit 6a2cf8d3663e13e19af636c2a8d92e766261dc45 upstream.

Because of the shifting around of code in qla2x00_probe_one recently,
failures during adapter initialization can lead to problems, i.e. NULL
pointer crashes and doubly freed data structures which cause eventual
panics.

This V2 version makes the relevant memory free routines idempotent, so
repeat calls won't cause any harm. I also removed the problematic
probe_init_failed exit point as it is not needed.

Fixes: d64d6c5671db ("scsi: qla2xxx: Fix NULL pointer crash due to probe failure")
Signed-off-by: Bill Kuzeja <william.kuzeja@stratus.com>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |   59 ++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 22 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -442,7 +442,7 @@ static int qla2x00_alloc_queues(struct q
 	ha->req_q_map[0] = req;
 	set_bit(0, ha->rsp_qid_map);
 	set_bit(0, ha->req_qid_map);
-	return 1;
+	return 0;
 
 fail_qpair_map:
 	kfree(ha->base_qpair);
@@ -459,6 +459,9 @@ fail_req_map:
 
 static void qla2x00_free_req_que(struct qla_hw_data *ha, struct req_que *req)
 {
+	if (!ha->req_q_map)
+		return;
+
 	if (IS_QLAFX00(ha)) {
 		if (req && req->ring_fx00)
 			dma_free_coherent(&ha->pdev->dev,
@@ -469,14 +472,17 @@ static void qla2x00_free_req_que(struct
 		(req->length + 1) * sizeof(request_t),
 		req->ring, req->dma);
 
-	if (req)
+	if (req) {
 		kfree(req->outstanding_cmds);
-
-	kfree(req);
+		kfree(req);
+	}
 }
 
 static void qla2x00_free_rsp_que(struct qla_hw_data *ha, struct rsp_que *rsp)
 {
+	if (!ha->rsp_q_map)
+		return;
+
 	if (IS_QLAFX00(ha)) {
 		if (rsp && rsp->ring)
 			dma_free_coherent(&ha->pdev->dev,
@@ -487,7 +493,8 @@ static void qla2x00_free_rsp_que(struct
 		(rsp->length + 1) * sizeof(response_t),
 		rsp->ring, rsp->dma);
 	}
-	kfree(rsp);
+	if (rsp)
+		kfree(rsp);
 }
 
 static void qla2x00_free_queues(struct qla_hw_data *ha)
@@ -1710,6 +1717,8 @@ qla2x00_abort_all_cmds(scsi_qla_host_t *
 	struct qla_tgt_cmd *cmd;
 	uint8_t trace = 0;
 
+	if (!ha->req_q_map)
+		return;
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	for (que = 0; que < ha->max_req_queues; que++) {
 		req = ha->req_q_map[que];
@@ -3063,14 +3072,14 @@ qla2x00_probe_one(struct pci_dev *pdev,
 	/* Set up the irqs */
 	ret = qla2x00_request_irqs(ha, rsp);
 	if (ret)
-		goto probe_hw_failed;
+		goto probe_failed;
 
 	/* Alloc arrays of request and response ring ptrs */
-	if (!qla2x00_alloc_queues(ha, req, rsp)) {
+	if (qla2x00_alloc_queues(ha, req, rsp)) {
 		ql_log(ql_log_fatal, base_vha, 0x003d,
 		    "Failed to allocate memory for queue pointers..."
 		    "aborting.\n");
-		goto probe_init_failed;
+		goto probe_failed;
 	}
 
 	if (ha->mqenable && shost_use_blk_mq(host)) {
@@ -3347,15 +3356,6 @@ skip_dpc:
 
 	return 0;
 
-probe_init_failed:
-	qla2x00_free_req_que(ha, req);
-	ha->req_q_map[0] = NULL;
-	clear_bit(0, ha->req_qid_map);
-	qla2x00_free_rsp_que(ha, rsp);
-	ha->rsp_q_map[0] = NULL;
-	clear_bit(0, ha->rsp_qid_map);
-	ha->max_req_queues = ha->max_rsp_queues = 0;
-
 probe_failed:
 	if (base_vha->timer_active)
 		qla2x00_stop_timer(base_vha);
@@ -4435,11 +4435,17 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 	if (ha->init_cb)
 		dma_free_coherent(&ha->pdev->dev, ha->init_cb_size,
 			ha->init_cb, ha->init_cb_dma);
-	vfree(ha->optrom_buffer);
-	kfree(ha->nvram);
-	kfree(ha->npiv_info);
-	kfree(ha->swl);
-	kfree(ha->loop_id_map);
+
+	if (ha->optrom_buffer)
+		vfree(ha->optrom_buffer);
+	if (ha->nvram)
+		kfree(ha->nvram);
+	if (ha->npiv_info)
+		kfree(ha->npiv_info);
+	if (ha->swl)
+		kfree(ha->swl);
+	if (ha->loop_id_map)
+		kfree(ha->loop_id_map);
 
 	ha->srb_mempool = NULL;
 	ha->ctx_mempool = NULL;
@@ -4455,6 +4461,15 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 	ha->ex_init_cb_dma = 0;
 	ha->async_pd = NULL;
 	ha->async_pd_dma = 0;
+	ha->loop_id_map = NULL;
+	ha->npiv_info = NULL;
+	ha->optrom_buffer = NULL;
+	ha->swl = NULL;
+	ha->nvram = NULL;
+	ha->mctp_dump = NULL;
+	ha->dcbx_tlv = NULL;
+	ha->xgmac_data = NULL;
+	ha->sfp_data = NULL;
 
 	ha->s_dma_pool = NULL;
 	ha->dl_dma_pool = NULL;
