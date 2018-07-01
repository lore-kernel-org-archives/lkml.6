Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8025474
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD8025474
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032529AbeGAQq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:46:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032271AbeGAQqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:46:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BA97DA73;
        Sun,  1 Jul 2018 16:46:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.17 212/220] block: Fix transfer when chunk sectors exceeds max
Date:   Sun,  1 Jul 2018 18:23:56 +0200
Message-Id: <20180701160917.011058475@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit 15bfd21fbc5d35834b9ea383dc458a1f0c9e3434 upstream.

A device may have boundary restrictions where the number of sectors
between boundaries exceeds its max transfer size. In this case, we need
to cap the max size to the smaller of the two limits.

Reported-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Tested-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/blkdev.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1124,8 +1124,8 @@ static inline unsigned int blk_max_size_
 	if (!q->limits.chunk_sectors)
 		return q->limits.max_sectors;
 
-	return q->limits.chunk_sectors -
-			(offset & (q->limits.chunk_sectors - 1));
+	return min(q->limits.max_sectors, (unsigned int)(q->limits.chunk_sectors -
+			(offset & (q->limits.chunk_sectors - 1))));
 }
 
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,


