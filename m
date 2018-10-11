Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14530C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDF82147C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAkxf560"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDF82147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbeJKXOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:14:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB46721470;
        Thu, 11 Oct 2018 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272789;
        bh=UQjikpZFsfwCPGn28nijvMq6aDHs2coaYwg1Yt/juZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAkxf560JvIBZ/eCuITzsfWh/uN28NiJTaes6YnJgSz0QTRsoGtxSUug03RoNsgfJ
         3wu6nFKFo5NGBvJvXJX4izkg72Oc3sxfT+GwH/xTHTWaBT42dy+h6YmYvbhVrFst2X
         9Ez9Yq64hYtQfIDwKAQViSM7YTQYtcXXw/NI2g/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 06/45] blk-mq: I/O and timer unplugs are inverted in blktrace
Date:   Thu, 11 Oct 2018 17:39:33 +0200
Message-Id: <20181011152509.127297977@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
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

From: Ilya Dryomov <idryomov@gmail.com>

commit 587562d0c7cd6861f4f90a2eb811cccb1a376f5f upstream.

trace_block_unplug() takes true for explicit unplugs and false for
implicit unplugs.  schedule() unplugs are implicit and should be
reported as timer unplugs.  While correct in the legacy code, this has
been inverted in blk-mq since 4.11.

Cc: stable@vger.kernel.org
Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO schedulers")
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1512,7 +1512,7 @@ void blk_mq_flush_plug_list(struct blk_p
 		BUG_ON(!rq->q);
 		if (rq->mq_ctx != this_ctx) {
 			if (this_ctx) {
-				trace_block_unplug(this_q, depth, from_schedule);
+				trace_block_unplug(this_q, depth, !from_schedule);
 				blk_mq_sched_insert_requests(this_q, this_ctx,
 								&ctx_list,
 								from_schedule);
@@ -1532,7 +1532,7 @@ void blk_mq_flush_plug_list(struct blk_p
 	 * on 'ctx_list'. Do those.
 	 */
 	if (this_ctx) {
-		trace_block_unplug(this_q, depth, from_schedule);
+		trace_block_unplug(this_q, depth, !from_schedule);
 		blk_mq_sched_insert_requests(this_q, this_ctx, &ctx_list,
 						from_schedule);
 	}


