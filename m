Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3815DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B2820874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B2820874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967161AbeFRIbc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:31:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967124AbeFRIbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:31:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E80FC8A;
        Mon, 18 Jun 2018 08:31:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiang Biao <jiang.biao2@zte.com.cn>,
        Wen Yang <wen.yang99@zte.com.cn>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 028/189] blkcg: dont hold blkcg lock when deactivating policy
Date:   Mon, 18 Jun 2018 10:12:04 +0200
Message-Id: <20180618081210.419522594@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiang Biao <jiang.biao2@zte.com.cn>

[ Upstream commit 946b81da114b8ba5c74bb01e57c0c6eca2bdc801 ]

As described in the comment of blkcg_activate_policy(),
*Update of each blkg is protected by both queue and blkcg locks so
that holding either lock and testing blkcg_policy_enabled() is
always enough for dereferencing policy data.*
with queue lock held, there is no need to hold blkcg lock in
blkcg_deactivate_policy(). Similar case is in
blkcg_activate_policy(), which has removed holding of blkcg lock in
commit 4c55f4f9ad3001ac1fefdd8d8ca7641d18558e23.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Tejun Heo <tj@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-cgroup.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1374,17 +1374,12 @@ void blkcg_deactivate_policy(struct requ
 	__clear_bit(pol->plid, q->blkcg_pols);
 
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
-		/* grab blkcg lock too while removing @pd from @blkg */
-		spin_lock(&blkg->blkcg->lock);
-
 		if (blkg->pd[pol->plid]) {
 			if (pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
 		}
-
-		spin_unlock(&blkg->blkcg->lock);
 	}
 
 	spin_unlock_irq(q->queue_lock);


