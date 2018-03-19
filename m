Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs6bd1Mw+e2WIuiVqs3bzSzAHuJz3J1FEIKbemgKLK+oehuZuJJy7RasTfwfURe9+TyLaW5
ARC-Seal: i=1; a=rsa-sha256; t=1521483621; cv=none;
        d=google.com; s=arc-20160816;
        b=ccM0LwsB1upyhShbo2QPdjStzuWS8ddCXNDRn6+tyPYCG/Hxffj9nVhk+gbb4wAPiW
         Vs1K+DUsE+WyLHTcIHOTgm6ChLrt6c1rvjUQqnXT5hiIcbInRgA+fJJbXjnwGh6wtkxI
         aI3Qu9krQS6WWydMu1d9xT/91iQRkWqe9MF+jWMALD6XUnE99fiP4RqzbeyaeppoExeu
         edJCU/bUGkhLgxgyYFZ8lWFlHbMke7hjc1fdWvH1lWYyEEAmuVI+206pDPoQf/PVBAuj
         DmtnWJpaLDy0x8y37jPp2QOEgBqpSbxQdOnobt2hbvkGixDQjrz4BkFT9FYTshaY2O8b
         fK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rHfX90v/YxQgp8Al8wOKoq9ZLBb8NY+iF2xKnBUXxBw=;
        b=M4KrWWoEqvI0HLtQzDjfgCGR118cEMkmoV0ytSsEbHbgn4iRZG/9vVaWg7y6wr4nXr
         1mrnR+NjbyaQ0x8GNN+UbAqLGwjFCvzmDgXO5vaJynA2lfDW9AAEWddwgUI83y+wbGQ+
         eoWPP76nnXYxmY4byfjPOBdMKByiWhk1M7ZVa+VYZWX6eiHD9oS0l95t1YFw0mTRsbUt
         YKfc+R/NqBf1Xeht/WCLRDefK9s3kRyO2KKcDe8xG8Io4FAk0JhDCzb9moVOV5CGu4uf
         36R/ORUSAcQ78A27dxQx3Cp9NsWumlhjl2k3ZKGU3/p+95gle9NipTxInZMmX6CZ9Q2W
         ro6w==
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
Subject: [PATCH 4.9 054/241] scsi: ipr: Fix missed EH wakeup
Date: Mon, 19 Mar 2018 19:05:19 +0100
Message-Id: <20180319180753.455784092@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390511066260812?=
X-GMAIL-MSGID: =?utf-8?q?1595391209745387383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -836,8 +836,10 @@ static void ipr_sata_eh_done(struct ipr_
 
 	qc->err_mask |= AC_ERR_OTHER;
 	sata_port->ioasa.status |= ATA_BUSY;
-	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	ata_qc_complete(qc);
+	if (ipr_cmd->eh_comp)
+		complete(ipr_cmd->eh_comp);
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 }
 
 /**
@@ -5947,8 +5949,10 @@ static void ipr_erp_done(struct ipr_cmnd
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
@@ -6338,8 +6342,10 @@ static void ipr_erp_start(struct ipr_ioa
 	}
 
 	scsi_dma_unmap(ipr_cmd->scsi_cmd);
-	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	scsi_cmd->scsi_done(scsi_cmd);
+	if (ipr_cmd->eh_comp)
+		complete(ipr_cmd->eh_comp);
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 }
 
 /**
@@ -6365,8 +6371,10 @@ static void ipr_scsi_done(struct ipr_cmn
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
