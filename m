Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0144B218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497525;
	bh=4bFnIsdXg55p+eIb1TKr2naeNkOSvdw6mjz19Cju5IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YlzXHTHHCftFeOyl9lgLPwxT4o+/qWgLiLLHH/4tRclRTpsC7pfRP0qD6QByMAlcA
	 svtmhF6BkFV84fXGr/l5awvgJUgOxaYKLuWlNbuEKDwFQzxGmzg7xw3EL+iWYCJzsx
	 zANMRwrlbgE6QaEOrr61HomEmI6uzbLwIioaXCos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbfBRNpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbfBRNpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 014CF218FC;
        Mon, 18 Feb 2019 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497517;
        bh=4bFnIsdXg55p+eIb1TKr2naeNkOSvdw6mjz19Cju5IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqyFS1FBT8RHihNhJNUAKcacxClNT52/E4w8Fx9f/as+kiARQxkW7Ze0f6xXsg/nB
         Zi3GBo0lJNpNVTJ9RuPSVAcWCw8OhlRrCmSvlosEunIilDWwRu6sO5M5/97cKSbebF
         0wbo0xukXqsQNB4teIr6PQ6O69hF0CR9LyjagZqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Stecker <m19@florianstecker.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 03/92] blk-mq: fix a hung issue when fsync
Date:   Mon, 18 Feb 2019 14:42:06 +0100
Message-Id: <20190218133454.948976156@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

[ Upstream commit 85bd6e61f34dffa8ec2dc75ff3c02ee7b2f1cbce ]

Florian reported a io hung issue when fsync(). It should be
triggered by following race condition.

data + post flush         a flush

blk_flush_complete_seq
  case REQ_FSEQ_DATA
    blk_flush_queue_rq
    issued to driver      blk_mq_dispatch_rq_list
                            try to issue a flush req
                            failed due to NON-NCQ command
                            .queue_rq return BLK_STS_DEV_RESOURCE

request completion
  req->end_io // doesn't check RESTART
  mq_flush_data_end_io
    case REQ_FSEQ_POSTFLUSH
      blk_kick_flush
        do nothing because previous flush
        has not been completed
     blk_mq_run_hw_queue
                              insert rq to hctx->dispatch
                              due to RESTART is still set, do nothing

To fix this, replace the blk_mq_run_hw_queue in mq_flush_data_end_io
with blk_mq_sched_restart to check and clear the RESTART flag.

Fixes: bd166ef1 (blk-mq-sched: add framework for MQ capable IO schedulers)
Reported-by: Florian Stecker <m19@florianstecker.de>
Tested-by: Florian Stecker <m19@florianstecker.de>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 8b44b86779da..87fc49daa2b4 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -424,7 +424,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 
-	blk_mq_run_hw_queue(hctx, true);
+	blk_mq_sched_restart(hctx);
 }
 
 /**
-- 
2.19.1



