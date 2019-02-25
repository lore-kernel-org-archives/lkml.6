Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFFCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D060B21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130635;
	bh=fMB1TRwHQTi8rdkIn6i1myVE8hUE7moblHeTr8be//4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gt9GlvFEP270S9897poVWCn4dBhJZCaJCrSncXa/D5SZfzN4lyiY10/qyifL00ily
	 WAlpR11cCfJjxVRSbGOZgBEZkMLyd/kUPrQVuVLIdrZHTV0fFu8rk6BgxWtDdpinv2
	 9wTDnYPPT/B0aq0dC/5wSWYQXEgMyvp0WlNIYLu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbfBYVhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731280AbfBYVhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850ED20578;
        Mon, 25 Feb 2019 21:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130631;
        bh=fMB1TRwHQTi8rdkIn6i1myVE8hUE7moblHeTr8be//4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDZ755YOpdOv+zZq7N8xZsqOnQArm64lHzlNzwDBXG3zRm+Sh0YRcYHYYfuBmorjV
         Ll/oaF9TcRc+OazVcv1iZeYeba7gJ4L7IEpWQujyws6TzaJ/ZZgARcR5zkV4OiwXqv
         5s0ztNlMuog5R+0DVsdJa6B0OFqY7GjkweIPXqmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.20 145/183] scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation
Date:   Mon, 25 Feb 2019 22:11:58 +0100
Message-Id: <20190225195119.364160442@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Masato Suzuki <masato.suzuki@wdc.com>

commit 515ce60613128be7a176a8b82b20c7624f3b440d upstream.

The function sd_zbc_do_report_zones() issues a REPORT ZONES command with a
buffer size calculated based on the number of zones requested by the
caller. This value should however not exceed the capabilities of the
hardware maximum command size, that is, should not exceed the
max_hw_sectors limit of the device. This problem leads to failures of
report zones commands when re-validating disks with some SAS HBAs.

Fix this by limiting a report zone command buffer size to the minimum of
the device max_hw_sectors and calculated value based on the requested
number of zones. This does not change the semantic of the report_zones file
operation as report zones can always return less zone reports than
requested. Short reports are handled using a loop execution of the
report_zones file operation in the function blk_report_zones().

[Damien]
Before patch 'e76239a3748c ("block: add a report_zones method")', report
zones buffer allocation was limited to max_sectors when allocated in
blk_report_zones(). This however does not consider the actual format of the
device reply which is interface dependent.  Limiting the allocation based
on the size of the expected reply format rather than the size of the array
of generic sturct blkzone passed by blk_report_zones() makes more sense.

Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd_zbc.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -142,10 +142,12 @@ int sd_zbc_report_zones(struct gendisk *
 		return -EOPNOTSUPP;
 
 	/*
-	 * Get a reply buffer for the number of requested zones plus a header.
-	 * For ATA, buffers must be aligned to 512B.
+	 * Get a reply buffer for the number of requested zones plus a header,
+	 * without exceeding the device maximum command size. For ATA disks,
+	 * buffers must be aligned to 512B.
 	 */
-	buflen = roundup((nrz + 1) * 64, 512);
+	buflen = min(queue_max_hw_sectors(disk->queue) << 9,
+		     roundup((nrz + 1) * 64, 512));
 	buf = kmalloc(buflen, gfp_mask);
 	if (!buf)
 		return -ENOMEM;


