Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49hhp7mCoBo9A2wy/Hpz0sShzXNOhhZkL0XIOiwmxsIOYKDE2kqB4i4rvULzvBRWPeQ2PNK
ARC-Seal: i=1; a=rsa-sha256; t=1523399745; cv=none;
        d=google.com; s=arc-20160816;
        b=EPOjj8y3X/XHLkMqrdjNjiucPAZ1hVbvJWTqaXqc1Y9vBtPefClmUDO0A8E5Cr52h/
         bc6x+VB+WJDoxyGT8+tc4qfs4A3/M3N1PSifk6VZU+oBJH9lVQRbvd+YiEddTYOB7pcY
         J6w4nUIJXA4DHLYddJecIVsMif9bpukjUjxWZoCKK6zX6mRdMlSXqSUvIKLS5G58A0eN
         ZkmTPV1qltGurntHYxWVLdfCmrLpQOXUxYpiW4mn/nuJhtWhMW3tHwTkd5MNv7hPWn6B
         C1VvSoNI6gyWg5ep+zZAlfZGIrEJYF3fczzy55Yldy8ny1Om39KzwH6rb0+sK0WYpc05
         14PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4cFHlIafkfskBO79d+nbtcJmm4BitimTjkuMMqFKgWY=;
        b=K0MiesnmHyTl4xzamfHWm/aDSIHAaDd2esaYvlDS9Jab5vaCiTxa+VqdGll3ykkNxm
         yFzBzP6hdPcXsB82wJsycJtoYAdQnWOh4JfkIjAzerkpLPNxavNGsgLy1OzxTzBexKdp
         Rlad3V8Ye7AYIQPRvHjcPub/JNJdplAA9LnHspaRWUreT2T3wNtuCN4KNDKI/Z5uBj/D
         yAwXY3m6m+E8xsScIrBel8iqFV7V/B9OnPEGfmHW8JlPEcQapETB8kuR9aWwqbjsVnG+
         0y7ZwTy1+JGCTkfS9DAl0t+lzA2qs004xzMlg5dKHR03l1R+e+4+bDllQujzjKipzTMJ
         5GBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chaitra P B <chaitra.basappa@broadcom.com>,
	Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 031/138] scsi: mpt3sas: Proper handling of set/clear of "ATA command pending" flag.
Date: Wed, 11 Apr 2018 00:23:41 +0200
Message-Id: <20180410212905.731904871@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399893403341474?=
X-GMAIL-MSGID: =?utf-8?q?1597400411939408827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chaitra P B <chaitra.basappa@broadcom.com>


[ Upstream commit f49d4aed1315a7b766d855f1367142e682b0cc87 ]

1. In IO path, setting of "ATA command pending" flag early before device
   removal, invalid device handle etc., checks causes any new commands
   to be always returned with SAM_STAT_BUSY and when the driver removes
   the drive the SML issues SYNC Cache command and that command is
   always returned with SAM_STAT_BUSY and thus making SYNC Cache command
   to requeued.

2. If the driver gets an ATA PT command for a SATA drive then the driver
   set "ATA command pending" flag in device specific data structure not
   to allow any further commands until the ATA PT command is completed.
   However, after setting the flag if the driver decides to return the
   command back to upper layers without actually issuing to the firmware
   (i.e., returns from qcmd failure return paths) then the corresponding
   flag is not cleared and this prevents the driver from sending any new
   commands to the drive.

This patch fixes above two issues by setting of "ATA command pending"
flag after checking for whether device deleted, invalid device handle,
device busy with task management. And by setting "ATA command pending"
flag to false in all of the qcmd failure return paths after setting the
flag.

Signed-off-by: Chaitra P B <chaitra.basappa@broadcom.com>
Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -4106,19 +4106,6 @@ scsih_qcmd(struct Scsi_Host *shost, stru
 		return 0;
 	}
 
-	/*
-	 * Bug work around for firmware SATL handling.  The loop
-	 * is based on atomic operations and ensures consistency
-	 * since we're lockless at this point
-	 */
-	do {
-		if (test_bit(0, &sas_device_priv_data->ata_command_pending)) {
-			scmd->result = SAM_STAT_BUSY;
-			scmd->scsi_done(scmd);
-			return 0;
-		}
-	} while (_scsih_set_satl_pending(scmd, true));
-
 	sas_target_priv_data = sas_device_priv_data->sas_target;
 
 	/* invalid device handle */
@@ -4144,6 +4131,19 @@ scsih_qcmd(struct Scsi_Host *shost, stru
 	    sas_device_priv_data->block)
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 
+	/*
+	 * Bug work around for firmware SATL handling.  The loop
+	 * is based on atomic operations and ensures consistency
+	 * since we're lockless at this point
+	 */
+	do {
+		if (test_bit(0, &sas_device_priv_data->ata_command_pending)) {
+			scmd->result = SAM_STAT_BUSY;
+			scmd->scsi_done(scmd);
+			return 0;
+		}
+	} while (_scsih_set_satl_pending(scmd, true));
+
 	if (scmd->sc_data_direction == DMA_FROM_DEVICE)
 		mpi_control = MPI2_SCSIIO_CONTROL_READ;
 	else if (scmd->sc_data_direction == DMA_TO_DEVICE)
@@ -4170,6 +4170,7 @@ scsih_qcmd(struct Scsi_Host *shost, stru
 	if (!smid) {
 		pr_err(MPT3SAS_FMT "%s: failed obtaining a smid\n",
 		    ioc->name, __func__);
+		_scsih_set_satl_pending(scmd, false);
 		goto out;
 	}
 	mpi_request = mpt3sas_base_get_msg_frame(ioc, smid);
@@ -4200,6 +4201,7 @@ scsih_qcmd(struct Scsi_Host *shost, stru
 	if (mpi_request->DataLength) {
 		if (ioc->build_sg_scmd(ioc, scmd, smid)) {
 			mpt3sas_base_free_smid(ioc, smid);
+			_scsih_set_satl_pending(scmd, false);
 			goto out;
 		}
 	} else
