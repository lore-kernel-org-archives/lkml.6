Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2E3ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4962C2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4962C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbeIREam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:30:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbeIREal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:30:41 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 601F1C7D;
        Mon, 17 Sep 2018 23:01:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 032/126] blk-mq: fix updating tags depth
Date:   Tue, 18 Sep 2018 00:41:20 +0200
Message-Id: <20180917211706.886465300@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 75d6e175fc511e95ae3eb8f708680133bc211ed3 ]

The passed 'nr' from userspace represents the total depth, meantime
inside 'struct blk_mq_tags', 'nr_tags' stores the total tag depth,
and 'nr_reserved_tags' stores the reserved part.

There are two issues in blk_mq_tag_update_depth() now:

1) for growing tags, we should have used the passed 'nr', and keep the
number of reserved tags not changed.

2) the passed 'nr' should have been used for checking against
'tags->nr_tags', instead of number of the normal part.

This patch fixes the above two cases, and avoids kernel crash caused
by wrong resizing sbitmap queue.

Cc: "Ewan D. Milne" <emilne@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Tested by: Marco Patalano <mpatalan@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq-tag.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -416,8 +416,6 @@ int blk_mq_tag_update_depth(struct blk_m
 	if (tdepth <= tags->nr_reserved_tags)
 		return -EINVAL;
 
-	tdepth -= tags->nr_reserved_tags;
-
 	/*
 	 * If we are allowed to grow beyond the original size, allocate
 	 * a new set of tags before freeing the old one.
@@ -437,7 +435,8 @@ int blk_mq_tag_update_depth(struct blk_m
 		if (tdepth > 16 * BLKDEV_MAX_RQ)
 			return -EINVAL;
 
-		new = blk_mq_alloc_rq_map(set, hctx->queue_num, tdepth, 0);
+		new = blk_mq_alloc_rq_map(set, hctx->queue_num, tdepth,
+				tags->nr_reserved_tags);
 		if (!new)
 			return -ENOMEM;
 		ret = blk_mq_alloc_rqs(set, new, hctx->queue_num, tdepth);
@@ -454,7 +453,8 @@ int blk_mq_tag_update_depth(struct blk_m
 		 * Don't need (or can't) update reserved tags here, they
 		 * remain static and should never need resizing.
 		 */
-		sbitmap_queue_resize(&tags->bitmap_tags, tdepth);
+		sbitmap_queue_resize(&tags->bitmap_tags,
+				tdepth - tags->nr_reserved_tags);
 	}
 
 	return 0;


