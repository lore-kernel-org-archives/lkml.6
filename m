Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8E6C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F213E20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F213E20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeILOXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:23:22 -0400
Received: from mx60.baidu.com ([61.135.168.60]:20575 "EHLO
        tc-sys-mailedm01.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727006AbeILOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:23:22 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm01.tc.baidu.com (Postfix) with ESMTP id 766832040041;
        Wed, 12 Sep 2018 17:19:20 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: [PATCH] memcg: remove congestion wait when force empty
Date:   Wed, 12 Sep 2018 17:19:20 +0800
Message-Id: <1536743960-19703-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.10.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory.force_empty is used to empty a memory cgoup memory before
rmdir it, avoid to charge those memory into parent cgroup

when try_to_free_mem_cgroup_pages returns 0, guess there maybe be
lots of writeback, so wait. but the waiting and sleep will called
in shrink_inactive_list, based on numbers of isolated page, so
remove this wait to reduce unnecessary delay

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 mm/memcontrol.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4ead5a4817de..35bd43eaa97e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2897,12 +2897,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 
 		progress = try_to_free_mem_cgroup_pages(memcg, 1,
 							GFP_KERNEL, true);
-		if (!progress) {
+		if (!progress)
 			nr_retries--;
-			/* maybe some writeback is necessary */
-			congestion_wait(BLK_RW_ASYNC, HZ/10);
-		}
-
 	}
 
 	return 0;
-- 
2.16.2

