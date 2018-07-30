Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA46AFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C12C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C12C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeG3HnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:43:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:43563 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeG3HnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:43:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2018 23:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,421,1526367600"; 
   d="scan'208";a="77080095"
Received: from unknown (HELO xiaojin.sh.intel.com) ([10.239.154.226])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2018 23:09:46 -0700
From:   xiao jin <jin.xiao@intel.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        stable@vger.kernel.org, yanmin.zhang@intel.com, jin.xiao@intel.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: blk_init_allocated_queue() set q->fq as NULL in the fail case
Date:   Mon, 30 Jul 2018 14:11:12 +0800
Message-Id: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We find the memory use-after-free issue in __blk_drain_queue()
on the kernel 4.14. After read the latest kernel 4.18-rc6 we
think it has the same problem.

Memory is allocated for q->fq in the blk_init_allocated_queue().
If the elevator init function called with error return, it will
run into the fail case to free the q->fq.

Then the __blk_drain_queue() uses the same memory after the free
of the q->fq, it will lead to the unpredictable event.

The patch is to set q->fq as NULL in the fail case of
blk_init_allocated_queue().

Fixes: commit 7c94e1c157a2 ("block: introduce blk_flush_queue to drive flush machinery")
Signed-off-by: xiao jin <jin.xiao@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: <stable@vger.kernel.org>
---
 block/blk-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index b888175..52635e2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1072,6 +1072,7 @@ int blk_init_allocated_queue(struct request_queue *q)
 		q->exit_rq_fn(q, q->fq->flush_rq);
 out_free_flush_queue:
 	blk_free_flush_queue(q->fq);
+	q->fq = NULL;
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(blk_init_allocated_queue);
-- 
1.7.9.5

