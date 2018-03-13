Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs533IaQLvR2e4/k9ZHqz0njw3/43irJlOnbpir5j+VIBlDvgThgrg/OEtZc83+4uLPXtON
ARC-Seal: i=1; a=rsa-sha256; t=1520955405; cv=none;
        d=google.com; s=arc-20160816;
        b=zSrOWH+yW47n+0RfhuRw/UarolRzzpdqVe1uy+7H/X90GrgSlMa5N6hQreevb9OUww
         V5elwZdbFxdjJRs+kGRy4PhV4S9Ysx4zZJhJ7hzLAQ9TTMao5bTethvmkHJQbRCBz2Xt
         m6WAcPuWKvvnZnEIw0d1hrjENE7uPet6AnXr7Crx4lSSUbhI4EnaPflY1SCFcNRdlMOr
         axIp6YBAsncmTDBf+74fIfqVUOPMIItnlZIs4FaRoKDjPTgykgYkRuP9LZQkVqzrFnzQ
         tXPRg4avMEGqGM6gh8J77k6rnf5M9AIiP/UXLJbd7ycw1ahyuQ41SIPsifiS8T5YB4jf
         YTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=18isc3DHP5tf/ToO+eLXV/InokEKttd86HsOWnfmop8=;
        b=Jyq1L7dvakDNJxj1hJ4z1jiLgZUD5U+7OtOzYBvect+OhlezkeeOria6DmBRm3dSlu
         WUgBOBqeDAhgxlpDh2gjUS0y9MRQLEEXqVMj7FGBk8dguM6Jlnm25QvnAMgnpEfngyTa
         vbY4dOQ6cw8eRxh+OcfNsvx1RAGQuoBz94Ydi6lYpAoFuNFPLXoRQRvdUm+DIxrKVEfH
         M2uo+u6kn7k/SMxFILvIQuZ3ddt0GnaqMlb0VTsc8a7xTvJNasQaz+BXtNqF9NBXRMOv
         aLS6WEvcqLCxz8ZDojrPRJa59PYnAcMDDc3V+LuG4/CbD4Gveka9i6BZt6HeqEnxxXL3
         AhiQ==
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
Subject: [PATCH 4.14 035/140] scsi: qla2xxx: Fix abort command deadlock due to spinlock
Date: Tue, 13 Mar 2018 16:23:58 +0100
Message-Id: <20180313152500.479425073@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837159270569546?=
X-GMAIL-MSGID: =?utf-8?q?1594837334784955605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit b0dcce746b32ac573343ad39cb3dc485030de95e upstream.

Original code acquires hardware_lock to add Abort IOCB onto driver
request queue for processing. However, abort_command() will also acquire
hardware lock to look up sp pointer before issuing abort IOCB command
resulting into a deadlock. This patch safely removes the possible
deadlock scenario by removing extra spinlock.

Fixes: 6eb54715b54bb ("qla2xxx: Added interface to send explicit LOGO.")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_iocb.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2394,7 +2394,6 @@ qla2x00_els_dcmd_iocb_timeout(void *data
 	struct scsi_qla_host *vha = sp->vha;
 	struct qla_hw_data *ha = vha->hw;
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
-	unsigned long flags = 0;
 
 	ql_dbg(ql_dbg_io, vha, 0x3069,
 	    "%s Timeout, hdl=%x, portid=%02x%02x%02x\n",
@@ -2402,7 +2401,6 @@ qla2x00_els_dcmd_iocb_timeout(void *data
 	    fcport->d_id.b.al_pa);
 
 	/* Abort the exchange */
-	spin_lock_irqsave(&ha->hardware_lock, flags);
 	if (ha->isp_ops->abort_command(sp)) {
 		ql_dbg(ql_dbg_io, vha, 0x3070,
 		    "mbx abort_command failed.\n");
@@ -2410,7 +2408,6 @@ qla2x00_els_dcmd_iocb_timeout(void *data
 		ql_dbg(ql_dbg_io, vha, 0x3071,
 		    "mbx abort_command success.\n");
 	}
-	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 	complete(&lio->u.els_logo.comp);
 }
