Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE05CC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD6020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078484;
	bh=eds9A/Knpr+KEntucTxFMau1OOHnah6UX5m/RzLPp8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O7vpIIBcXybEOShHGVV0lm4aVY9rYqAEONgtFENEFKN9opzt59Nm9l+xbVMyMvs8k
	 Rv/wAoyC69hwA9OrFd6jNom00uGC6FWQbOUDERlXSmyQc6YFlngxkRb+QXUDAgQdmM
	 vRrYxPEJuUK4OUD0r0882Zo8cZHUKxIdWukGUHKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfAUNsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbfAUNr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8935D20861;
        Mon, 21 Jan 2019 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078476;
        bh=eds9A/Knpr+KEntucTxFMau1OOHnah6UX5m/RzLPp8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJJTadpel3X4pYLqxhzGKxcx8p5XLJ54RLQmiiSrOPTfYx+A5qciwZ5KqJWEAy1lm
         h8rZigJzp/eEV7CjcEAFT93E/ouqwv1dtOy+PqOBN5rIdNr5hO9sUjVQ8n5qTmQwjt
         DJRoSM1oRgPXICSVX8LDG4TJnt2E8h1n6ohoi6zI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanley Chu <stanley.chu@mediatek.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.20 044/111] scsi: core: Synchronize request queue PM status only on successful resume
Date:   Mon, 21 Jan 2019 14:42:38 +0100
Message-Id: <20190121122500.730526969@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanley Chu <stanley.chu@mediatek.com>

commit 3f7e62bba0003f9c68f599f5997c4647ef5b4f4e upstream.

The commit 356fd2663cff ("scsi: Set request queue runtime PM status back to
active on resume") fixed up the inconsistent RPM status between request
queue and device. However changing request queue RPM status shall be done
only on successful resume, otherwise status may be still inconsistent as
below,

Request queue: RPM_ACTIVE
Device: RPM_SUSPENDED

This ends up soft lockup because requests can be submitted to underlying
devices but those devices and their required resource are not resumed.

For example,

After above inconsistent status happens, IO request can be submitted to UFS
device driver but required resource (like clock) is not resumed yet thus
lead to warning as below call stack,

WARN_ON(hba->clk_gating.state != CLKS_ON);
ufshcd_queuecommand
scsi_dispatch_cmd
scsi_request_fn
__blk_run_queue
cfq_insert_request
__elv_add_request
blk_flush_plug_list
blk_finish_plug
jbd2_journal_commit_transaction
kjournald2

We may see all behind IO requests hang because of no response from storage
host or device and then soft lockup happens in system. In the end, system
may crash in many ways.

Fixes: 356fd2663cff (scsi: Set request queue runtime PM status back to active on resume)
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/scsi_pm.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -80,8 +80,22 @@ static int scsi_dev_type_resume(struct d
 
 	if (err == 0) {
 		pm_runtime_disable(dev);
-		pm_runtime_set_active(dev);
+		err = pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
+
+		/*
+		 * Forcibly set runtime PM status of request queue to "active"
+		 * to make sure we can again get requests from the queue
+		 * (see also blk_pm_peek_request()).
+		 *
+		 * The resume hook will correct runtime PM status of the disk.
+		 */
+		if (!err && scsi_is_sdev_device(dev)) {
+			struct scsi_device *sdev = to_scsi_device(dev);
+
+			if (sdev->request_queue->dev)
+				blk_set_runtime_active(sdev->request_queue);
+		}
 	}
 
 	return err;
@@ -140,16 +154,6 @@ static int scsi_bus_resume_common(struct
 	else
 		fn = NULL;
 
-	/*
-	 * Forcibly set runtime PM status of request queue to "active" to
-	 * make sure we can again get requests from the queue (see also
-	 * blk_pm_peek_request()).
-	 *
-	 * The resume hook will correct runtime PM status of the disk.
-	 */
-	if (scsi_is_sdev_device(dev) && pm_runtime_suspended(dev))
-		blk_set_runtime_active(to_scsi_device(dev)->request_queue);
-
 	if (fn) {
 		async_schedule_domain(fn, dev, &scsi_sd_pm_domain);
 


