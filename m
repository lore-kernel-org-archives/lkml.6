Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6709B208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6709B208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbeHWMUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:20:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732203AbeHWMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:19:59 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 43328BE0;
        Thu, 23 Aug 2018 08:51:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 148/324] blk-mq: dont queue more if we get a busy return
Date:   Thu, 23 Aug 2018 09:53:34 +0200
Message-Id: <20180823075003.380471083@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 1f57f8d442f8017587eeebd8617913bfc3661d3d ]

Some devices have different queue limits depending on the type of IO. A
classic case is SATA NCQ, where some commands can queue, but others
cannot. If we have NCQ commands inflight and encounter a non-queueable
command, the driver returns busy. Currently we attempt to dispatch more
from the scheduler, if we were able to queue some commands. But for the
case where we ended up stopping due to BUSY, we should not attempt to
retrieve more from the scheduler. If we do, we can get into a situation
where we attempt to queue a non-queueable command, get BUSY, then
successfully retrieve more commands from that scheduler and queue those.
This can repeat forever, starving the non-queuable command indefinitely.

Fix this by NOT attempting to pull more commands from the scheduler, if
we get a BUSY return. This should also be more optimal in terms of
letting requests stay in the scheduler for as long as possible, if we
get a BUSY due to the regular out-of-tags condition.

Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1174,6 +1174,9 @@ static bool blk_mq_mark_tag_wait(struct
 
 #define BLK_MQ_RESOURCE_DELAY	3		/* ms units */
 
+/*
+ * Returns true if we did some work AND can potentially do more.
+ */
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			     bool got_budget)
 {
@@ -1304,8 +1307,17 @@ bool blk_mq_dispatch_rq_list(struct requ
 			blk_mq_run_hw_queue(hctx, true);
 		else if (needs_restart && (ret == BLK_STS_RESOURCE))
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
+
+		return false;
 	}
 
+	/*
+	 * If the host/device is unable to accept more work, inform the
+	 * caller of that.
+	 */
+	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
+		return false;
+
 	return (queued + errors) != 0;
 }
 


