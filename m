Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A11C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B316A279AF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B316A279AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965495AbeF1U5f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:57:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:31846 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935840AbeF1U5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:57:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 13:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="50702319"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2018 13:56:56 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/5] blk-mq: add API to get hctx index from request
Date:   Thu, 28 Jun 2018 14:55:57 -0600
Message-Id: <20180628205601.13742-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c         | 6 ++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b429d515b568..c6478833464d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -466,6 +466,12 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
+unsigned int blk_mq_request_hctx_idx(struct request *rq)
+{
+	return blk_mq_map_queue(rq->q, rq->mq_ctx->cpu)->queue_num;
+}
+EXPORT_SYMBOL_GPL(blk_mq_request_hctx_idx);
+
 static void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb74222..af91b2d31a04 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -248,6 +248,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 }
 
 
+unsigned int blk_mq_request_hctx_idx(struct request *rq);
 int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
-- 
2.14.3

