Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB76C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F89320862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F89320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404962AbeHATVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:21:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436612AbeHATSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 723E9F49;
        Wed,  1 Aug 2018 16:56:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Filippo Muzzini <filippo.muzzini@outlook.it>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 076/336] block, bfq: remove wrong lock in bfq_requests_merged
Date:   Wed,  1 Aug 2018 18:46:51 +0200
Message-Id: <20180801165032.039582885@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Filippo Muzzini <filippo.muzzini@outlook.it>

[ Upstream commit a12bffebc0c9d6a5851f062aaea3aa7c4adc6042 ]

In bfq_requests_merged(), there is a deadlock because the lock on
bfqq->bfqd->lock is held by the calling function, but the code of
this function tries to grab the lock again.

This deadlock is currently hidden by another bug (fixed by next commit
for this source file), which causes the body of bfq_requests_merged()
to be never executed.

This commit removes the deadlock by removing the lock/unlock pair.

Signed-off-by: Filippo Muzzini <filippo.muzzini@outlook.it>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bfq-iosched.c |    2 --
 1 file changed, 2 deletions(-)

--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1898,7 +1898,6 @@ static void bfq_requests_merged(struct r
 
 	if (!RB_EMPTY_NODE(&rq->rb_node))
 		goto end;
-	spin_lock_irq(&bfqq->bfqd->lock);
 
 	/*
 	 * If next and rq belong to the same bfq_queue and next is older
@@ -1923,7 +1922,6 @@ static void bfq_requests_merged(struct r
 	bfq_remove_request(q, next);
 	bfqg_stats_update_io_remove(bfqq_group(bfqq), next->cmd_flags);
 
-	spin_unlock_irq(&bfqq->bfqd->lock);
 end:
 	bfqg_stats_update_io_merged(bfqq_group(bfqq), next->cmd_flags);
 }


