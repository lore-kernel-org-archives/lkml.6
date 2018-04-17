Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49VhfCfQ/eTEgK5iHxPQmPOIql+2SPkAZRsPrWhPZfWk2A+a7YeNgKZmvs1weKfcCTl/FKE
ARC-Seal: i=1; a=rsa-sha256; t=1523981183; cv=none;
        d=google.com; s=arc-20160816;
        b=idptj2gddtGVup++p140siimZxt21tmXiVB6jf0OOvTdklKdSgLueUNpOLCzofszzf
         1oAVroRmH6RqNXBMkTBrbSP29506L+x+AquCnl3/HYlGKPXv8EngtY1b0I3PATueI5mQ
         QWRDZKjhseQXyxKUo70Rcwved9Iiv6Sx6xy88hxIIIekIdC49CNbyM3zvBA9V0FZq+58
         1JFWK642Oo3aVviob+cmSGbuT1xW35ATqyRm7YZhOICsmFflkJ8l75LZPMgUE0HqJTMo
         Aw03H2SiBX1BTljjRIImslMdZVAlXnlV0gQ2IEfMGZKonvCRY0rElarm4U8eM0k/h9Wc
         AKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gwHJ77iYTf84pkzZXyL6rMaxx7HrvrGWyc4biunxzMQ=;
        b=wSGfDVfl4aSFr7lyU0ozla61YD5PrMtmaTZJybqhIsOn8S6wn+wQqkZDPhwudtlYRt
         TaP8fpSPpu0LA2O5JVIdqJF+VJBdkXFF5v47F2+cMKxFfirxTD7QqoxEHVYub22FNkN/
         VQyD7g6rFpPA5IW3kwb7tDlROiZdy8eHjZyNdHzofWwmlgkuEj+przu/w9WG8q4F0bv5
         kas9n74OyNj3ELDPH4gIpdq7mr/TfDNhqMzvRD6TPcLqjaXwR0XX3SE8Z9NfGCPG46lP
         96cMPks7WJhI3cXWgDli7h8s8ex7fohG6oMozeq+SoqGNv9sJKdaOV2J1hMkEe/EOvk4
         breA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bill Kuzeja <william.kuzeja@stratus.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 22/49] scsi: qla2xxx: Fix small memory leak in qla2x00_probe_one on probe failure
Date: Tue, 17 Apr 2018 17:59:01 +0200
Message-Id: <20180417155716.085291645@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009819441657999?=
X-GMAIL-MSGID: =?utf-8?q?1598010093251216362?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bill Kuzeja <William.Kuzeja@stratus.com>

commit 6d6340672ba3a99c4cf7af79c2edf7aa25595c84 upstream.

The code that fixes the crashes in the following commit introduced a small
memory leak:

commit 6a2cf8d3663e ("scsi: qla2xxx: Fix crashes in qla2x00_probe_one on probe failure")

Fixing this requires a bit of reworking, which I've explained. Also provide
some code cleanup.

There is a small window in qla2x00_probe_one where if qla2x00_alloc_queues
fails, we end up never freeing req and rsp and leak 0xc0 and 0xc8 bytes
respectively (the sizes of req and rsp).

I originally put in checks to test for this condition which were based on
the incorrect assumption that if ha->rsp_q_map and ha->req_q_map were
allocated, then rsp and req were allocated as well. This is incorrect.
There is a window between these allocations:

       ret = qla2x00_mem_alloc(ha, req_length, rsp_length, &req, &rsp);
                goto probe_hw_failed;

[if successful, both rsp and req allocated]

       base_vha = qla2x00_create_host(sht, ha);
                goto probe_hw_failed;

       ret = qla2x00_request_irqs(ha, rsp);
                goto probe_failed;

       if (qla2x00_alloc_queues(ha, req, rsp)) {
                goto probe_failed;

[if successful, now ha->rsp_q_map and ha->req_q_map allocated]

To simplify this, we should just set req and rsp to NULL after we free
them. Sounds simple enough? The problem is that req and rsp are pointers
defined in the qla2x00_probe_one and they are not always passed by reference
to the routines that free them.

Here are paths which can free req and rsp:

PATH 1:
qla2x00_probe_one
   ret = qla2x00_mem_alloc(ha, req_length, rsp_length, &req, &rsp);
   [req and rsp are passed by reference, but if this fails, we currently
    do not NULL out req and rsp. Easily fixed]

PATH 2:
qla2x00_probe_one
   failing in qla2x00_request_irqs or qla2x00_alloc_queues
      probe_failed:
         qla2x00_free_device(base_vha);
            qla2x00_free_req_que(ha, req)
            qla2x00_free_rsp_que(ha, rsp)

PATH 3:
qla2x00_probe_one:
   failing in qla2x00_mem_alloc or qla2x00_create_host
      probe_hw_failed:
         qla2x00_free_req_que(ha, req)
         qla2x00_free_rsp_que(ha, rsp)

PATH 1: This should currently work, but it doesn't because rsp and rsp are
not set to NULL in qla2x00_mem_alloc. Easily remedied.

PATH 2: req and rsp aren't passed in at all to qla2x00_free_device but are
derived from ha->req_q_map[0] and ha->rsp_q_map[0]. These are only set up if
qla2x00_alloc_queues succeeds.

In qla2x00_free_queues, we are protected from crashing if these don't exist
because req_qid_map and rsp_qid_map are only set on their allocation. We are
guarded in this way:

        for (cnt = 0; cnt < ha->max_req_queues; cnt++) {
                if (!test_bit(cnt, ha->req_qid_map))
                        continue;

PATH 3: This works. We haven't freed req or rsp yet (or they were never
allocated if qla2x00_mem_alloc failed), so we'll attempt to free them here.

To summarize, there are a few small changes to make this work correctly and
(and for some cleanup):

1) (For PATH 1) Set *rsp and *req to NULL in case of failure in
qla2x00_mem_alloc so these are correctly set to NULL back in
qla2x00_probe_one

2) After jumping to probe_failed: and calling qla2x00_free_device,
explicitly set rsp and req to NULL so further calls with these pointers do
not crash, i.e. the free queue calls in the probe_hw_failed section we fall
through to.

3) Fix return code check in the call to qla2x00_alloc_queues. We currently
drop the return code on the floor. The probe fails but the caller of the
probe doesn't have an error code, so it attaches to pci. This can result in
a crash on module shutdown.

4) Remove unnecessary NULL checks in qla2x00_free_req_que,
qla2x00_free_rsp_que, and the egregious NULL checks before kfrees and vfrees
in qla2x00_mem_free.

I tested this out running a scenario where the card breaks at various times
during initialization. I made sure I forced every error exit path in
qla2x00_probe_one.

Cc: <stable@vger.kernel.org> # v4.16
Fixes: 6a2cf8d3663e ("scsi: qla2xxx: Fix crashes in qla2x00_probe_one on probe failure")
Signed-off-by: Bill Kuzeja <william.kuzeja@stratus.com>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |   44 ++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -459,9 +459,6 @@ fail_req_map:
 
 static void qla2x00_free_req_que(struct qla_hw_data *ha, struct req_que *req)
 {
-	if (!ha->req_q_map)
-		return;
-
 	if (IS_QLAFX00(ha)) {
 		if (req && req->ring_fx00)
 			dma_free_coherent(&ha->pdev->dev,
@@ -472,17 +469,14 @@ static void qla2x00_free_req_que(struct
 		(req->length + 1) * sizeof(request_t),
 		req->ring, req->dma);
 
-	if (req) {
+	if (req)
 		kfree(req->outstanding_cmds);
-		kfree(req);
-	}
+
+	kfree(req);
 }
 
 static void qla2x00_free_rsp_que(struct qla_hw_data *ha, struct rsp_que *rsp)
 {
-	if (!ha->rsp_q_map)
-		return;
-
 	if (IS_QLAFX00(ha)) {
 		if (rsp && rsp->ring)
 			dma_free_coherent(&ha->pdev->dev,
@@ -493,8 +487,7 @@ static void qla2x00_free_rsp_que(struct
 		(rsp->length + 1) * sizeof(response_t),
 		rsp->ring, rsp->dma);
 	}
-	if (rsp)
-		kfree(rsp);
+	kfree(rsp);
 }
 
 static void qla2x00_free_queues(struct qla_hw_data *ha)
@@ -3075,7 +3068,8 @@ qla2x00_probe_one(struct pci_dev *pdev,
 		goto probe_failed;
 
 	/* Alloc arrays of request and response ring ptrs */
-	if (qla2x00_alloc_queues(ha, req, rsp)) {
+	ret = qla2x00_alloc_queues(ha, req, rsp);
+	if (ret) {
 		ql_log(ql_log_fatal, base_vha, 0x003d,
 		    "Failed to allocate memory for queue pointers..."
 		    "aborting.\n");
@@ -3368,8 +3362,15 @@ probe_failed:
 	}
 
 	qla2x00_free_device(base_vha);
-
 	scsi_host_put(base_vha->host);
+	/*
+	 * Need to NULL out local req/rsp after
+	 * qla2x00_free_device => qla2x00_free_queues frees
+	 * what these are pointing to. Or else we'll
+	 * fall over below in qla2x00_free_req/rsp_que.
+	 */
+	req = NULL;
+	rsp = NULL;
 
 probe_hw_failed:
 	qla2x00_mem_free(ha);
@@ -4062,6 +4063,7 @@ fail_npiv_info:
 	(*rsp)->dma = 0;
 fail_rsp_ring:
 	kfree(*rsp);
+	*rsp = NULL;
 fail_rsp:
 	dma_free_coherent(&ha->pdev->dev, ((*req)->length + 1) *
 		sizeof(request_t), (*req)->ring, (*req)->dma);
@@ -4069,6 +4071,7 @@ fail_rsp:
 	(*req)->dma = 0;
 fail_req_ring:
 	kfree(*req);
+	*req = NULL;
 fail_req:
 	dma_free_coherent(&ha->pdev->dev, sizeof(struct ct_sns_pkt),
 		ha->ct_sns, ha->ct_sns_dma);
@@ -4436,16 +4439,11 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 		dma_free_coherent(&ha->pdev->dev, ha->init_cb_size,
 			ha->init_cb, ha->init_cb_dma);
 
-	if (ha->optrom_buffer)
-		vfree(ha->optrom_buffer);
-	if (ha->nvram)
-		kfree(ha->nvram);
-	if (ha->npiv_info)
-		kfree(ha->npiv_info);
-	if (ha->swl)
-		kfree(ha->swl);
-	if (ha->loop_id_map)
-		kfree(ha->loop_id_map);
+	vfree(ha->optrom_buffer);
+	kfree(ha->nvram);
+	kfree(ha->npiv_info);
+	kfree(ha->swl);
+	kfree(ha->loop_id_map);
 
 	ha->srb_mempool = NULL;
 	ha->ctx_mempool = NULL;
