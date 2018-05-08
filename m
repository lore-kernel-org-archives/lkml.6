Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525765673; cv=none;
        d=google.com; s=arc-20160816;
        b=vl0bXZkzj6K2rysrSjRhLe9sYW8Kwm93f8QzCybqMX/zrTq7tAyOqLtryN3SpetagG
         LOpKpWmIFI0Jua980GPkKCUTIgSxWz5FRsrNLXaXXwUeQ8RezzL0cuHr8LZT6YR6QQYe
         HPZbDxPd2jB72eAFQq6gxWkTFOA1lkhbzK/afPx1UOnqrWVhpLwL+OXiT0fGZ28FzMQS
         0+g+dcCuIS1y/pB37btWS9PsFl20QsnQU19yiHsfMW2ydkq38SvPIe2oDe+u696uiG2Z
         Mo/D1tpN/LFKrBoljl0inow+CDgU0G1stnm/cvx9gG2M67MxXvkUqBj57wN+8OQwO4BO
         dB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=JX8TuzwizVhrsXxc7mfj/nXgIIPmiWejEiAHmzYkrGo=;
        b=yOPPLZS9lghG43TKrV2K+6bSzKDpmel9z7ErZQK7JfMBUX3RdcC4M91VWHBhNn3J5c
         2kX65lb/zTBLLJCyVjVZ1QklchkDnXGpjAdQ1oLx5qTJ5DATUaFsSpCPItlhxzfzn5jA
         HDACenwUWmcfwh+gCco4+w6QGCb3UvttaYQtXTSOZentbPct7uENYNAyefgsCAAcZtPz
         8NpQRDlpSF8VGWNQxlCul27FrOyTL2vvPh9uOWdxB1z4HftVNI8RZf/dAyE26MdxF1g0
         xGNWUfY6gid424P/4x1EOdLrEGDLfjoZbnyBeHXQ9jSWM0BJLXeUDKAJ8yd+He8ibY6Y
         kjlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Zu8I9BjS;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Zu8I9BjS;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpVq6R4TQsrpiemqIygGX9Zq5TY0l4ln6T41eAzzJ4AYZ4UuYX+eHhWFPWOqkpaXyiQGCywtg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: oneukum@suse.com,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: storage: Fix a possible data race in uas_queuecommand_lck
Date: Tue,  8 May 2018 15:47:43 +0800
Message-Id: <20180508074743.13622-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599881266623115421?=
X-GMAIL-MSGID: =?utf-8?q?1599881266623115421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The write operations to "cmnd->result" and "cmnd->scsi_done" 
are protected by the lock on line 642-643, but the write operations 
to these data on line 634-635 are not protected by the lock.
Thus, there may exist a data race for "cmnd->result" 
and "cmnd->scsi_done".

To fix this data race, the write operations on line 634-635 
should be also protected by the lock.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/storage/uas.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 6034c39b67d1..dde7a43ad491 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -627,17 +627,18 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd,
 	if (cmnd->device->host->host_self_blocked)
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 
+	spin_lock_irqsave(&devinfo->lock, flags);
+
 	if ((devinfo->flags & US_FL_NO_ATA_1X) &&
 			(cmnd->cmnd[0] == ATA_12 || cmnd->cmnd[0] == ATA_16)) {
 		memcpy(cmnd->sense_buffer, usb_stor_sense_invalidCDB,
 		       sizeof(usb_stor_sense_invalidCDB));
 		cmnd->result = SAM_STAT_CHECK_CONDITION;
 		cmnd->scsi_done(cmnd);
+		spin_unlock_irqrestore(&devinfo->lock, flags);
 		return 0;
 	}
 
-	spin_lock_irqsave(&devinfo->lock, flags);
-
 	if (devinfo->resetting) {
 		cmnd->result = DID_ERROR << 16;
 		cmnd->scsi_done(cmnd);
-- 
2.17.0
