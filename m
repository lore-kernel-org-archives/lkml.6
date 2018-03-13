Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtx8Emjtxxr/dEvG/CtSeHupQGMlFdMkmkletDprQh7pS8w9ML0iANFYEkvZ8iq8UJpJd35
ARC-Seal: i=1; a=rsa-sha256; t=1520955370; cv=none;
        d=google.com; s=arc-20160816;
        b=ux3MVb+/CxHDa+58wrx5BejFkoQ4AADq+T26hFeqC+Ps+AMNsrxHGmqVRtKGKM0ITs
         S/JjCrFWDJPKAx7yWqQD3RX/j27uSdgDbsuWDMzs7W2KqwkdACvjSRJ/XkTogWAQTXPm
         dtiW4vLqjiIPsI94gKhmKbrsX1tUDvnvqlQZO47ysAEMJMJlMHZ64lMrq6JAp0ikH8Bz
         MSv+/pKKXvu9FSviIg+M5tR4+Tdewat+i/zPuZUGJYPj57RL++AS79ZzkXuU0VD9ZpR1
         AJxt7ucSZfk6n0f3EKdjB5D25aDQNZOVaK53d5MWiltq3ieF1mtrSZmnLC/eKIluvQEV
         jj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ssgE8BzjIyKwWAheXpn+PWqx5Ziaq/cQeNIE6s9IY5k=;
        b=Q2pxIM226//jGFP2CZSUPvQeKFOX7MWL24LWbPr/2gZaxGTtQCfbux5pIEl5wZ5+Tw
         Z6X3tUBs2udP3bT66ZKR2YmlABEZrdSOjBtjYhWjgUZ2j+pcY7hf4OvrkhdajnRwgSWh
         Z9IwL6KpTwkmeRzEUSX24HGd5kOOHpCSYM5fQDZaMZ6KlXY7Pe+0DZYCW8y1wr0HW1mi
         tp3ku2EZkRBGvR6yNQw5m9fRfnZZI3LvCXJpYE8/5CIwAU+++zMIihYMZKcS6BGqM3j0
         rw/eGwy/5Me9XA4r7GenBzDymn44ECPPMdiHShkOocvplP5nEYiyOmB6buMCW5qP0M63
         cOxQ==
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
Subject: [PATCH 4.14 027/140] scsi: qla2xxx: Skip IRQ affinity for Target QPairs
Date: Tue, 13 Mar 2018 16:23:50 +0100
Message-Id: <20180313152459.847294951@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837186728182201?=
X-GMAIL-MSGID: =?utf-8?q?1594837298866061749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit d68b850e1bfb9afb24b888a946165a186a710195 upstream.

Fix co-existence between Block MQ and Target Mode. Block MQ and
initiator mode requires midlayer queue mapping to check for IRQ to be
affinitized. For target mode, it's not the case.

Fixes: 09620eeb62c41 ("scsi: qla2xxx: Add debug knob for user control workload")
Cc: <stable@vger.kernel.org> # 4.12+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6592,9 +6592,14 @@ qla83xx_disable_laser(scsi_qla_host_t *v
 
 static int qla2xxx_map_queues(struct Scsi_Host *shost)
 {
+	int rc;
 	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
 
-	return blk_mq_pci_map_queues(&shost->tag_set, vha->hw->pdev);
+	if (USER_CTRL_IRQ(vha->hw))
+		rc = blk_mq_map_queues(&shost->tag_set);
+	else
+		rc = blk_mq_pci_map_queues(&shost->tag_set, vha->hw->pdev);
+	return rc;
 }
 
 static const struct pci_error_handlers qla2xxx_err_handler = {
