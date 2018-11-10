Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32204C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF35921486
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF35921486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeKKCVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:21:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeKKCVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:21:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 168A93DDB4;
        Sat, 10 Nov 2018 16:35:42 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 347F9608C2;
        Sat, 10 Nov 2018 16:35:40 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [PATCH 2/3] scsi: create an all-one filter for scanners
Date:   Sat, 10 Nov 2018 17:35:32 +0100
Message-Id: <1541867733-7836-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 10 Nov 2018 16:35:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any command is allowed for scanners when /dev/sg is used.
Reimplement this using customizable command filters, so that the
sysfs knobs will work in this case, too.

Cc: linux-scsi@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/scsi/scsi_scan.c | 13 +++++++++++++
 drivers/scsi/sg.c        |  3 ---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 78ca63dfba4a..ceb7f5535f44 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -844,6 +844,19 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 			*bflags |= BLIST_NOREPORTLUN;
 	}
 
+	if (sdev->type == TYPE_SCANNER) {
+		sdev->request_queue->cmd_filter =
+			kzalloc(sizeof(struct blk_cmd_filter), GFP_KERNEL);
+
+		if (!sdev->request_queue->cmd_filter)
+			return SCSI_SCAN_NO_RESPONSE;
+
+		memset(sdev->request_queue->cmd_filter->read_ok, 0xFF,
+		       sizeof(sdev->request_queue->cmd_filter->read_ok));
+		memset(sdev->request_queue->cmd_filter->write_ok, 0xFF,
+		       sizeof(sdev->request_queue->cmd_filter->write_ok));
+	}
+
 	/*
 	 * For a peripheral qualifier (PQ) value of 1 (001b), the SCSI
 	 * spec says: The device server is capable of supporting the
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 1b04016d3bb8..e04acf41f283 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -242,9 +242,6 @@ static int sg_allow_access(struct file *filp, unsigned char *cmd)
 	struct sg_fd *sfp = filp->private_data;
 	struct scsi_device *device = sfp->parentdp->device;
 
-	if (device->type == TYPE_SCANNER)
-		return 0;
-
 	return blk_verify_command(device->request_queue, cmd, filp->f_mode);
 }
 
-- 
1.8.3.1


