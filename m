Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132FEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01372087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfA2WL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:11:27 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:35383 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbfA2WL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:11:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TJEMIga_1548799877;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TJEMIga_1548799877)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Jan 2019 06:11:24 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 PATCH] mm: vmscan: do not iterate all mem cgroups for global direct reclaim
Date:   Wed, 30 Jan 2019 06:11:17 +0800
Message-Id: <1548799877-10949-1-git-send-email-yang.shi@linux.alibaba.com>
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

A simple test with pref shows it may take around 220ms to iterate 8K memcgs
in direct reclaim:
             dd 13873 [011]   578.542919: vmscan:mm_vmscan_direct_reclaim_begin
             dd 13873 [011]   578.758689: vmscan:mm_vmscan_direct_reclaim_end
So for 400K, it may take around 11 seconds to iterate all memcgs.

Here just break the iteration once it reclaims enough pages as what
memcg direct reclaim does.  This may hurt the fairness among memcgs.  But
the cached iterator cookie could help to achieve the fairness more or
less.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v2: Added some test data in the commit log
    Updated commit log about iterator cookie could maintain fairness
    Dropped !global_reclaim() since !current_is_kswapd() is good enough

 mm/vmscan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a714c4f..5e35796 100644
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
+			if (!current_is_kswapd() &&
 					sc->nr_reclaimed >= sc->nr_to_reclaim) {
 				mem_cgroup_iter_break(root, memcg);
 				break;
-- 
1.8.3.1

