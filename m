Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsmSouMI7bQc0Wl25d/WQKURvhuB3P4qUiu/lAoIjPvKllg31PsCtxy8S2FxynKXxrlzMY6
ARC-Seal: i=1; a=rsa-sha256; t=1520955379; cv=none;
        d=google.com; s=arc-20160816;
        b=rhJ7Gf3auO49/voHo83yYJOMPUdR0atBCEl5j+pR763qu6Ifk/0UjCotNvg2i2+7gs
         qStX2dZCxVygqQcuzMnnB/B+NPEnST1xGo5zg5/Mf3egwo6K0IZy/Ka/wJv0Kc3svKSL
         HndC1R4DrblGw3dEa3t1lpNoMli0ksNzFVIpTTqmSynna/BNjvmIc/zlW0QOu7K+SzDw
         J4Tc7W5WO2g5mOjoeazXvUBlOrYUMyOpUkNyehJHM8YMy1f1DLXZvr8KX4D4RM+XDnby
         e5dy/MS4eECwduNHRWLD34kJLWA0JFoFO95VGuaoCXyVXJaRmY0oXG9mPMwWMp4LBoeO
         Y0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Fv0jtHECIzveoyDenDDor5yvvPZ3KrrJSzkIsjIw0Jg=;
        b=b+39P7rJAQrkwXiO+ycgmXmztv0aqyrXbSJGnBf/ctrIxW1DTc8AxQK2z3ld+snFFN
         UWRVHb/hJwndNw0unwD0GauPgHcPi0kt/RaPt4NWnqC53U2o54iiWslz3vCu2DechbNf
         DgjJCj9kfiAgaBsj6VedhfcD6kRbj+xJoH/vZPRw/Xeb4MAoSvt1ub146oOJIGioH142
         XT79qCpARLw7rFda8WBikGV8bw46rWKUWCgXbRItAEJfRUFnThd3aBgXBpt4+2lVpEdq
         I3hJ3QLqX3HVAm2AeFLlV8E/Cr94xgK57pq+TRFYHxzeIB3d1x9nHXGoIiv0oCkG3jtT
         njtg==
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
Subject: [PATCH 4.14 026/140] scsi: qla2xxx: Move session delete to driver work queue
Date: Tue, 13 Mar 2018 16:23:49 +0100
Message-Id: <20180313152459.771533935@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837153104620653?=
X-GMAIL-MSGID: =?utf-8?q?1594837307825574162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3177,10 +3177,11 @@ qla2x00_probe_one(struct pci_dev *pdev,
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
