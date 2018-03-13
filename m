Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtPAn/x4PQbl9t7iYfAEJquX4XLJtn/k6G/UJWj56MLcI3aQ/MXULZMmfxHRu5AmVKHi0gr
ARC-Seal: i=1; a=rsa-sha256; t=1520955232; cv=none;
        d=google.com; s=arc-20160816;
        b=wKdIKepxF2+4RRh8ouRUX62X9XU5u4xZT0m0L+DN+U+XIW0DEo2DUWe/nFOYxoqoA0
         qzU7likoSRYgVrssEYfDhQ+HL7AeuTqC/AxZ0nVrNa+KPh2uaFzoczIzJQyl0mYY5bIs
         wwuOe+XJfsXI9kGvXZrVvFpcjwl+o2i1bAiW/YA7Gav9d71kjnN8kaXIGR/OscDKirNG
         SIPsM1rr0uqAwL5NuF4htc+XShdKlZ3CCHCAi+QgTP8pgyapTNa6G7As9X89FQl/qit8
         kH57/jgPeeaPPZW/FDq1qbzhx7tPZHJMt7wPg6TxgVQ1Dd5YEknylp9rrFiDmG0XzI46
         F11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PQWBLImWdY/RPIZC6Fbp9fvUxOhIqxrkhpOiBel+Y6A=;
        b=KXSORUqMhQEwUGfUiQeRbS+mzfzNFa+unfync+9QBMX+i/QT3iBxNU4Xco3poMKorL
         AsXlr9ieB4JUlif7qUstL0C+epjT0+RDAQLHe4oUI8hdpF4JGzPPZVDhdKky83f67+Ur
         Uvc+Y6RLJEHJojvPp0xTEpntugS/9nadxMOKe9CisgBzBZLGKFUqbQBpWNNUkeoXWdsR
         ivlYVU/K20vRUEVGXRny2p+cxvxmvSfONMopsdWFWvwcJuZZBkIUsGYT+gJXG7s7gOlg
         mMba7l6AKfYbpHUvStvtNDL2xFwr/hHbPKyMTdjkI/ES50vQJwnvnouKKRlzR7tRXCBH
         Gd+Q==
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
Subject: [PATCH 4.15 126/146] scsi: qla2xxx: Move session delete to driver work queue
Date: Tue, 13 Mar 2018 16:24:53 +0100
Message-Id: <20180313152329.929849171@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837153104620653?=
X-GMAIL-MSGID: =?utf-8?q?1594837153104620653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit a01c77d2cbc45ba527e884e5c30363a1200a4130 upstream.

Move session delete from system work queue to driver's work queue for in
time processing.

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c     |    3 ++-
 drivers/scsi/qla2xxx/qla_target.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3190,10 +3190,11 @@ qla2x00_probe_one(struct pci_dev *pdev,
 	    host->can_queue, base_vha->req,
 	    base_vha->mgmt_svr_loop_id, host->sg_tablesize);
 
+	ha->wq = alloc_workqueue("qla2xxx_wq", WQ_MEM_RECLAIM, 0);
+
 	if (ha->mqenable) {
 		bool mq = false;
 		bool startit = false;
-		ha->wq = alloc_workqueue("qla2xxx_wq", WQ_MEM_RECLAIM, 0);
 
 		if (QLA_TGT_MODE_ENABLED()) {
 			mq = true;
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1205,7 +1205,8 @@ void qlt_schedule_sess_for_deletion(stru
 	ql_dbg(ql_dbg_tgt, sess->vha, 0xe001,
 	    "Scheduling sess %p for deletion\n", sess);
 
-	schedule_work(&sess->del_work);
+	INIT_WORK(&sess->del_work, qla24xx_delete_sess_fn);
+	queue_work(sess->vha->hw->wq, &sess->del_work);
 }
 
 void qlt_schedule_sess_for_deletion_lock(struct fc_port *sess)
