Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsdtnWnOHyF6g2OCvdJWvVFiQrX0xo2LvzBYm23rXi07zGbAhXTGNztfGUYoAmm96gQ5Bqp
ARC-Seal: i=1; a=rsa-sha256; t=1521483172; cv=none;
        d=google.com; s=arc-20160816;
        b=s1BEI2k70Ez2wnA4ivXPfc0MWyHExJ/78ArPWHqAF5QAZSKUyTwKAZqx29k83+1PUd
         uO0Vy6ehPaHAfAKrPs43SLEPB0eFg2RXKNTtrvsFccDCpOVEGCNgOyCZDsoZfXQT3q12
         niwqjvRw7bXln/GEyIpXx/t+rLn8yVEneRGwaCXD5SfaWgCf0FyPcelRdjo13N9L61wS
         dvYZUW12KzGtkDJSdw7igLcMmlZd4VwUYg6RcWSbFWoNQ4OyIKy3e+vVg5XyrizOYc1H
         0asz0ztShGxH5m3eN2nj5cC8oQ+auDTRmLtwbeMT9o6u5wqfUQz1C+/7EU59gz+BLGiw
         CatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rKTgKyNmVwLjN8Gto5SLhjjHF5btsSTH872RkDRVh6U=;
        b=qYVnpkryEYY6QjGqxa0CGzGKqSm6ojgBo6vrp0wqGR8Iez6U40/+crtf+wTHZ1KYtl
         TOwoKIDImWFJ9Io88JZmNHPaq1Wr+t21860N7UfXyvv2f7fX1Y3oPE+moy3S2TNcAYYX
         7cj5MqgiE6SeX4WP/8NDxQhCMJz7zEUEGWPQsVZw4oYGNYtex5tVRrubfoyFPTccHY39
         fAVIoFTR1RrW+CYAA41+jEaLD0+gtv3rjObKYJcbl6xQNA32B/uG8XCpvM0V1My+9qcX
         YJq6539yjKprgILaZCGncMfuCyRFOHIY0Wi/P7/30HUJLBD4mykPG4xfPqCqKM2O4r+a
         ZWeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brian King <brking@linux.vnet.ibm.com>,
	Wendy Xiong <wenxiong@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 025/134] scsi: ipr: Fix missed EH wakeup
Date: Mon, 19 Mar 2018 19:05:08 +0100
Message-Id: <20180319171852.848050844@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390511066260812?=
X-GMAIL-MSGID: =?utf-8?q?1595390738449707764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian King <brking@linux.vnet.ibm.com>


[ Upstream commit 66a0d59cdd12546ddf01d229de28b07ccf6d637f ]

Following a command abort or device reset, ipr's EH handlers wait for
the commands getting aborted to get sent back from the adapter prior to
returning from the EH handler. This fixes up some cases where the
completion handler was not getting called, which would have resulted in
the EH thread waiting until it timed out, greatly extending EH time.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Reviewed-by: Wendy Xiong <wenxiong@linux.vnet.ibm.com>
Tested-by: Wendy Xiong <wenxiong@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ipr.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -835,8 +835,10 @@ static void ipr_sata_eh_done(struct ipr_
 
 	qc->err_mask |= AC_ERR_OTHER;
 	sata_port->ioasa.status |= ATA_BUSY;
-	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	ata_qc_complete(qc);
+	if (ipr_cmd->eh_comp)
+		complete(ipr_cmd->eh_comp);
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 }
 
 /**
@@ -5864,8 +5866,10 @@ static void ipr_erp_done(struct ipr_cmnd
 		res->in_erp = 0;
 	}
 	scsi_dma_unmap(ipr_cmd->scsi_cmd);
-	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	scsi_cmd->scsi_done(scsi_cmd);
+	if (ipr_cmd->eh_comp)
+		complete(ipr_cmd->eh_comp);
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 }
 
 /**
@@ -6255,8 +6259,10 @@ static void ipr_erp_start(struct ipr_ioa
 	}
 
 	scsi_dma_unmap(ipr_cmd->scsi_cmd);
-	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	scsi_cmd->scsi_done(scsi_cmd);
+	if (ipr_cmd->eh_comp)
+		complete(ipr_cmd->eh_comp);
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 }
 
 /**
@@ -6282,8 +6288,10 @@ static void ipr_scsi_done(struct ipr_cmn
 		scsi_dma_unmap(scsi_cmd);
 
 		spin_lock_irqsave(ipr_cmd->hrrq->lock, lock_flags);
-		list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 		scsi_cmd->scsi_done(scsi_cmd);
+		if (ipr_cmd->eh_comp)
+			complete(ipr_cmd->eh_comp);
+		list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 		spin_unlock_irqrestore(ipr_cmd->hrrq->lock, lock_flags);
 	} else {
 		spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
