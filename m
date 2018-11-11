Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D18CC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F73A20811
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n9U7Ex7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F73A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeKKXVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:21:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeKKXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zHDWdAZbuQtcCRm453aK/6yWe3DE5bBvTxqzTERubLU=; b=n9U7Ex7LiqGiVe7w24a0VLjMfm
        LU2R3m6RYl9XDALjObYcbSL0HKn75trG1mwsTmAEAq6qQTq92uTFb7I5y11STWaM+EY6qXrIbQM+p
        fHDDsQ30iW4IPUky898C+d+4bejBv58M3DdOgjQ84DmU8MSQqYXRWvAe21IFYnRcG9BJYkrVUh141
        vRsg/ohkSFKK30iSRwTNQGWbICnBsmLV2zprVZdDOF1IPt6sA3poEWcWahwaxsmo7dA6URaFl5dyv
        ZzXogDi0bQP8xBO5QptfIFNEI/8g6Xx0LUpjKMP9fkMzW4xLD+5Pdpedsfr3OEUPOMk4JJxFNUeZD
        qTTIl+0g==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLpqs-0007a1-DJ; Sun, 11 Nov 2018 13:32:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] block: remove req->special
Date:   Sun, 11 Nov 2018 14:32:10 +0100
Message-Id: <20181111133211.13926-8-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111133211.13926-1-hch@lst.de>
References: <20181111133211.13926-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 1 -
 include/linux/blkdev.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 411be60d0cb6..c1bb0c0b2ad8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -322,7 +322,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments = 0;
 #endif
-	rq->special = NULL;
 	/* tag was already set */
 	rq->extra_len = 0;
 	rq->__deadline = 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e67ad2dd025e..adafeb1e0c2b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -216,8 +216,6 @@ struct request {
 	unsigned short write_hint;
 	unsigned short ioprio;
 
-	void *special;		/* opaque pointer available for LLD use */
-
 	unsigned int extra_len;	/* length of alignment and padding */
 
 	enum mq_rq_state state;
-- 
2.19.1

