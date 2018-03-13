Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvG/9TWPIMy4yK4QFWkqC9313qnUmkhPLUY58vCdtHvtwq3fAWLXMlMTNbiPwY8PRnd7Qjk
ARC-Seal: i=1; a=rsa-sha256; t=1520955237; cv=none;
        d=google.com; s=arc-20160816;
        b=f+8SQFVYcnt7FKJ4fQ/If6ilr4eIep2anJPnPjgj2xPJJ+HpLH4HWPZ3bQFlrV+zug
         3dFqaKqA8idfXoRhMZdccNAk5b06zuuXs5ioO2ELpNcE5l8G9RlNVRAJMLbeIx/gJu8y
         Igj/NtxOqZwEDwroY9gEP6zlDN8I9OEmSGTLLY5Y8TnCYTrCgRhIs+Pta4hrAbZlhX0k
         smLNTr6v8h/ejDdk1JUT9/8mKglEKX4fkFRvYQ8DhHSZMVQPLC/U8Psg5D2Gtv+TIPXF
         GwlSwle1d9v7ZVaV7UR/Toe08J6AS3rdZjnwz16kVQgNTiguyUweSNMA44lZo2Xqfwf2
         Rkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+lJnF7hjEEzgC9z1MvAxKEuRmxtMvWOIlZzqsEDGllQ=;
        b=zsxX+bsaeA44ChRDVKmRbtr6ZeHIs2Zlg9u2h0QvVDMP+eEdNpDqk8rMEN78YIvIxp
         x4MD+NisPvduE0Ag8pT0aBvXY6VcVuTWLSk2ktRWHZ9jWxeO07IS6jhRf8WjW4xPoE5r
         KAeZDeI4AnyPNZmvf16D0Jfz8tFE2oI6Iao+H/X6TPWAEbpyO212rmzjaxFGLwwMz3jC
         VjeuMdS3s1vMSKDkdyIA7ciIbyBtc56RmRenJXh6uZzO4be/8tFl3e+VvBQ7N9/KoRY9
         2+lsvQYX24gunx7ZMvxKYRRPu30Ggcaas+pR2ibRbQVG/+Z+N0Lvy/grOKdckp8ZZpey
         htlQ==
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
Subject: [PATCH 4.15 136/146] scsi: qla2xxx: Fix abort command deadlock due to spinlock
Date: Tue, 13 Mar 2018 16:25:03 +0100
Message-Id: <20180313152330.597726883@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837159270569546?=
X-GMAIL-MSGID: =?utf-8?q?1594837159270569546?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
