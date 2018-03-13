Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuhO74H0i/kdCQMc6tBuKtbgoWpO7kcfNmvAm3dmGbi37hU4dI7lA7moUC9Fsz8p/ndW74n
ARC-Seal: i=1; a=rsa-sha256; t=1520955258; cv=none;
        d=google.com; s=arc-20160816;
        b=BrlDMygPdR/E/1mhW4BobuzDkKDJOL2HoPRso7me6pd0eBiNCgGGmg9h8nTccoqzvl
         6VCmGixkxH+g7fK0FfKBUrnmaA3ztXK7Tp/bHUPwMNKcqk7zQCnLoH6u5Hs8BsC4BhOa
         uyAa6ylF/VJzOFBNqMvW2cpIEnGLEIfN2YCFLMCwR2QbXGGIHcFISFYsVDhgQP4nHOUv
         ljuzSR6m7yp5icbdiT7wJd6l4mq7OObLUgPDjLNH1OeCU+7jAD9c8BR4SlSvQRu/rdiH
         zOL9C39UlAoPdoGTJYAcaaz974AlypcVtzMnQc4eoNZmPgjibMocpD6hh31jS76UVbZQ
         9Vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E3zmn20R/5PlTT0hH1Xba/hRrvi7dEfMrQhJC7u8NgU=;
        b=YjQ34PRGnFqtU7elcJJSjQ7gj2NtjVb/QvIVMgTqsRF6bbcyc7cY71V38LQS4ctH1F
         KU112bzTQo2EQTwcAMpApFhgAxMX6NPup07vd0SVQ200A8ApLPDmeJBfHj28xJ925Ad2
         Bp3du0vyIM1xHjZ63DJpXtTg6KQzskySYO6O2UA2W0aPIj45iGL/8L/cr/qP4KP20QM3
         a7UmClqv4nUXSA3o2eAml6LPptJsGZdeUKSA4Nzxn2GroI59B+2+U7FrZueFwwJ+SPXG
         5pz4QcSz/zyhKAjZA40uQLDNLmUbrPYfhgZ/cvRdsZ1aOKFY3cJR8SBKXJ5+DbfLZSoa
         WTMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 143/146] scsi: qla2xxx: Fix memory leak in dual/target mode
Date: Tue, 13 Mar 2018 16:25:10 +0100
Message-Id: <20180313152331.118606115@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837180805822140?=
X-GMAIL-MSGID: =?utf-8?q?1594837180805822140?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>

commit 7867b98dceb7741065c9c1b645136facad5c2e93 upstream.

When driver is loaded in Target/Dual mode, it creates QPair to support
MQ and allocates resources for each QPair. This Qpair initialization is
delayed until the FW personality is changed to Dual/Target mode by
issuing chip reset. At the time of chip reset firmware is re-initilized
in correct personality all the QPairs are initialized by sending
MBC_INITIALIZE_MULTIQ (001Fh).

This patch fixes memory leak by adding check to issue
MBC_INITIALIZE_MULTIQ command only while deleting rsp/req queue when the
flag is set for initiator mode, and clean up QPair resources correctly
during the driver unload. This MBX does not need to be issued for
Target/Dual mode because chip reset will reset ISP.

Fixes: d65237c7f0860 ("scsi: qla2xxx: Fix mailbox failure while deleting Queue pairs")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    4 +---
 drivers/scsi/qla2xxx/qla_mid.c  |   18 ++++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -8221,9 +8221,6 @@ int qla2xxx_delete_qpair(struct scsi_qla
 	int ret = QLA_FUNCTION_FAILED;
 	struct qla_hw_data *ha = qpair->hw;
 
-	if (!vha->flags.qpairs_req_created && !vha->flags.qpairs_rsp_created)
-		goto fail;
-
 	qpair->delete_in_progress = 1;
 	while (atomic_read(&qpair->ref_count))
 		msleep(500);
@@ -8231,6 +8228,7 @@ int qla2xxx_delete_qpair(struct scsi_qla
 	ret = qla25xx_delete_req_que(vha, qpair->req);
 	if (ret != QLA_SUCCESS)
 		goto fail;
+
 	ret = qla25xx_delete_rsp_que(vha, qpair->rsp);
 	if (ret != QLA_SUCCESS)
 		goto fail;
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -575,14 +575,15 @@ qla25xx_free_rsp_que(struct scsi_qla_hos
 int
 qla25xx_delete_req_que(struct scsi_qla_host *vha, struct req_que *req)
 {
-	int ret = -1;
+	int ret = QLA_SUCCESS;
 
-	if (req) {
+	if (req && vha->flags.qpairs_req_created) {
 		req->options |= BIT_0;
 		ret = qla25xx_init_req_que(vha, req);
+		if (ret != QLA_SUCCESS)
+			return QLA_FUNCTION_FAILED;
 	}
-	if (ret == QLA_SUCCESS)
-		qla25xx_free_req_que(vha, req);
+	qla25xx_free_req_que(vha, req);
 
 	return ret;
 }
@@ -590,14 +591,15 @@ qla25xx_delete_req_que(struct scsi_qla_h
 int
 qla25xx_delete_rsp_que(struct scsi_qla_host *vha, struct rsp_que *rsp)
 {
-	int ret = -1;
+	int ret = QLA_SUCCESS;
 
-	if (rsp) {
+	if (rsp && vha->flags.qpairs_rsp_created) {
 		rsp->options |= BIT_0;
 		ret = qla25xx_init_rsp_que(vha, rsp);
+		if (ret != QLA_SUCCESS)
+			return QLA_FUNCTION_FAILED;
 	}
-	if (ret == QLA_SUCCESS)
-		qla25xx_free_rsp_que(vha, rsp);
+	qla25xx_free_rsp_que(vha, rsp);
 
 	return ret;
 }
