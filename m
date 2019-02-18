Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A4620842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497824;
	bh=Nfp8itQML3nhuciw5bv+UBBuddkWx4jj51JWbJhMtEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNuPGZIMb0cKRIQ3sQlFJoR7/Q2YKihKMsB8hkTzE7yzYuLbQTWLlvrF0r5pixnm6
	 JyPq0koWguv05qslQCphBxSyTYN3sf8ThTVauZvJDSS2ydYM5vfg3DjzdLWHky19QM
	 onjaQlpXUSIn7M42Lckl8Pz2cEIRt+vSEEC8B8ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfBRNuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfBRNuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:50:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B1520449;
        Mon, 18 Feb 2019 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497819;
        bh=Nfp8itQML3nhuciw5bv+UBBuddkWx4jj51JWbJhMtEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwqFpcYDZm2IlHVsJfox3B/Bc1VjbF2Ocz8b1RoC3nBuq8TEZxEhbCTP7lfWOVoXi
         44aqEQ6LUD/rrZ4XcMUoWC6OHfICHAL8Rb52qRLAGgCDdJoODjrnIHH9Mp0r0DjkH2
         nA/yqZFjlpj0H/uqOoN/HgO7EoWGe9iP+rpxmY+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Stecker <m19@florianstecker.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 03/85] blk-mq: fix a hung issue when fsync
Date:   Mon, 18 Feb 2019 14:42:29 +0100
Message-Id: <20190218133500.143117787@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index ce41f666de3e..76487948a27f 100644
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



