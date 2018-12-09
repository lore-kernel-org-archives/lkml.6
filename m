Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55687C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F02320831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F02320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeLIWGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:06:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37080 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727511AbeLIWGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:06:31 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002ik-EV; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003IJ-TJ; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Greg Edwards" <gedwards@ddn.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.380026601@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 077/328] scsi: virtio_scsi: fix pi_bytes{out,in} on 4
 KiB block size devices
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Edwards <gedwards@ddn.com>

commit cdcdcaae8450a975e7d07e1bfec21f9b8c016d0c upstream.

When the underlying device is a 4 KiB logical block size device with a
protection interval exponent of 0, i.e. 4096 bytes data + 8 bytes PI, the
driver miscalculates the pi_bytes{out,in} by a factor of 8x (64 bytes).

This leads to errors on all reads and writes on 4 KiB logical block size
devices when CONFIG_BLK_DEV_INTEGRITY is enabled and the
VIRTIO_SCSI_F_T10_PI feature bit has been negotiated.

Fixes: e6dc783a38ec0 ("virtio-scsi: Enable DIF/DIX modes in SCSI host LLD")
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Edwards <gedwards@ddn.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -500,9 +500,11 @@ static void virtio_scsi_init_hdr_pi(stru
 	bi = blk_get_integrity(rq->rq_disk);
 
 	if (sc->sc_data_direction == DMA_TO_DEVICE)
-		cmd_pi->pi_bytesout = blk_rq_sectors(rq) * bi->tuple_size;
+		cmd_pi->pi_bytesout = bio_integrity_bytes(bi,
+							blk_rq_sectors(rq));
 	else if (sc->sc_data_direction == DMA_FROM_DEVICE)
-		cmd_pi->pi_bytesin = blk_rq_sectors(rq) * bi->tuple_size;
+		cmd_pi->pi_bytesin = bio_integrity_bytes(bi,
+							blk_rq_sectors(rq));
 }
 
 static int virtscsi_queuecommand(struct virtio_scsi *vscsi,

