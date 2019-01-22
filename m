Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B606C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0035621726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAVUJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:09:54 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40510 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbfAVUJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:09:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TInKYlb_1548187782;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TInKYlb_1548187782)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Jan 2019 04:09:51 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: vmscan: do not iterate all mem cgroups for global direct reclaim
Date:   Wed, 23 Jan 2019 04:09:42 +0800
Message-Id: <1548187782-108454-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current implementation, both kswapd and direct reclaim has to iterate
all mem cgroups.  It is not a problem before offline mem cgroups could
be iterated.  But, currently with iterating offline mem cgroups, it
could be very time consuming.  In our workloads, we saw over 400K mem
cgroups accumulated in some cases, only a few hundred are online memcgs.
Although kswapd could help out to reduce the number of memcgs, direct
reclaim still get hit with iterating a number of offline memcgs in some
cases.  We experienced the responsiveness problems due to this
occassionally.

Here just break the iteration once it reclaims enough pages as what
memcg direct reclaim does.  This may hurt the fairness among memcgs
since direct reclaim may awlays do reclaim from same memcgs.  But, it
sounds ok since direct reclaim just tries to reclaim SWAP_CLUSTER_MAX
pages and memcgs can be protected by min/low.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/vmscan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a714c4f..ced5a16 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2764,16 +2764,15 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 				   sc->nr_reclaimed - reclaimed);
 
 			/*
-			 * Direct reclaim and kswapd have to scan all memory
-			 * cgroups to fulfill the overall scan target for the
-			 * node.
+			 * Kswapd have to scan all memory cgroups to fulfill
+			 * the overall scan target for the node.
 			 *
 			 * Limit reclaim, on the other hand, only cares about
 			 * nr_to_reclaim pages to be reclaimed and it will
 			 * retry with decreasing priority if one round over the
 			 * whole hierarchy is not sufficient.
 			 */
-			if (!global_reclaim(sc) &&
+			if ((!global_reclaim(sc) || !current_is_kswapd()) &&
 					sc->nr_reclaimed >= sc->nr_to_reclaim) {
 				mem_cgroup_iter_break(root, memcg);
 				break;
-- 
1.8.3.1

