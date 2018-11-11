Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9150C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BDE2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BDE2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbeKLGEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:04:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52982 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729602AbeKLGEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:04:50 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsw-0000l5-EZ; Sun, 11 Nov 2018 19:59:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001dx-L0; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jens Axboe" <axboe@kernel.dk>,
        "Jitendra Bhivare" <jitendra.bhivare@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Keith Busch" <keith.busch@intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.400639117@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 203/366] block: Fix transfer when chunk sectors
 exceeds max
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit 15bfd21fbc5d35834b9ea383dc458a1f0c9e3434 upstream.

A device may have boundary restrictions where the number of sectors
between boundaries exceeds its max transfer size. In this case, we need
to cap the max size to the smaller of the two limits.

Reported-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Tested-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/blkdev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -929,8 +929,8 @@ static inline unsigned int blk_max_size_
 	if (!q->limits.chunk_sectors)
 		return q->limits.max_sectors;
 
-	return q->limits.chunk_sectors -
-			(offset & (q->limits.chunk_sectors - 1));
+	return min(q->limits.max_sectors, (unsigned int)(q->limits.chunk_sectors -
+			(offset & (q->limits.chunk_sectors - 1))));
 }
 
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq)

