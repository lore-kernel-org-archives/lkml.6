Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtqGqa+L619DrGaf2d6P7FdEHqpAiOcmCakMnUTEa8wVL2PQjhaUeFjQ5zKAgKoK4nQhY7P
ARC-Seal: i=1; a=rsa-sha256; t=1521482955; cv=none;
        d=google.com; s=arc-20160816;
        b=tJ75iuFm4CX1GRYnl8KkMncXFjAE67oQDpsp6vSq74wPi8iRGObAyy72yxJaVQIWoP
         W0R39NZfyOcHDbNNF9y+Tx2GLck80Ry9oAWlMCqlFVMjD3Cndv3ni36Z+fCIP1/vudq6
         NU5JcdJLHsy7Rz0kI5WoeB1jYsFXtzTo+SAoL2JUjh4MWpZSqh5XKtcuiBsikCIpIEYx
         KSVpS9yTh2sQS/mq+DomtPUQ4+Rb3z3Gm0gQQttx0ntfpM+9j0WYuUuvWPG44elWMKyE
         jKdAJiyVGlNszIudb2wod40aWRn5QL5tz0lyLiERThan4EOetyd1PQ0tsg0YDL9WfjSX
         +IXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M0vfqLwGzJSJodaq4DyL+uyIf3s6jw+Rro1G3DCgQLE=;
        b=QhaK7l1DGxwRTVoijwyuPjF2CT0iA+bcTpD0p1b0D3iCm8b4mCNuK3hYAcT9jDM503
         E7RVnJUFKsKFaOl8rEjfXAqrNXjY944PPuWMa1B5q4z1CLVS8CxTk+n6XQBJg5guWp1i
         Xtutii1qQHENh4pDh4x1ADAbel3GmhwANHRIf8PNI45Rj60JP3CO+17vdVEZxlZ1eU4G
         Ce0PNDzAdJXLHvwXxWFv4xP8Bqk7M3P0J/SePCl7jLDpMNYM8ujmg2er2U3EL0ePmcYt
         EDt+WgjFj3RrTPpQ5qnx4X3Cgl88trwKNhy4gc5xNi9nE2SO/ZnoR9fw1xrSsl7Go2vx
         nkZQ==
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
Subject: [PATCH 3.18 14/68] scsi: ipr: Fix missed EH wakeup
Date: Mon, 19 Mar 2018 19:05:52 +0100
Message-Id: <20180319171829.858947760@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390511066260812?=
X-GMAIL-MSGID: =?utf-8?q?1595390511066260812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -828,8 +828,10 @@ static void ipr_sata_eh_done(struct ipr_
 
 	qc->err_mask |= AC_ERR_OTHER;
 	sata_port->ioasa.status |= ATA_BUSY;
-	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	ata_qc_complete(qc);
+	if (ipr_cmd->eh_comp)
+		complete(ipr_cmd->eh_comp);
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 }
 
 /**
@@ -5830,8 +5832,10 @@ static void ipr_erp_done(struct ipr_cmnd
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
@@ -6214,8 +6218,10 @@ static void ipr_erp_start(struct ipr_ioa
 	}
 
 	scsi_dma_unmap(ipr_cmd->scsi_cmd);
-	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	scsi_cmd->scsi_done(scsi_cmd);
+	if (ipr_cmd->eh_comp)
+		complete(ipr_cmd->eh_comp);
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 }
 
 /**
@@ -6241,8 +6247,10 @@ static void ipr_scsi_done(struct ipr_cmn
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
