Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6D5C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9E42081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9E42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbeLCIBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:01:37 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35541 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbeLCIBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:01:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TEitRAJ_1543824080;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TEitRAJ_1543824080)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 03 Dec 2018 16:01:20 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/3] mm/vmscan: Enable kswapd to reclaim low-protected memory
Date:   Mon,  3 Dec 2018 16:01:18 +0800
Message-Id: <20181203080119.18989-2-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20181203080119.18989-1-xlpang@linux.alibaba.com>
References: <20181203080119.18989-1-xlpang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be cgroup memory overcommitment, it will become
even common in the future.

Let's enable kswapd to reclaim low-protected memory in case
of memory pressure, to mitigate the global direct reclaim
pressures which could cause jitters to the response time of
lantency-sensitive groups.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/vmscan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 62ac0c488624..3d412eb91f73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3531,6 +3531,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 
 	count_vm_event(PAGEOUTRUN);
 
+retry:
 	do {
 		unsigned long nr_reclaimed = sc.nr_reclaimed;
 		bool raise_priority = true;
@@ -3622,6 +3623,13 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 			sc.priority--;
 	} while (sc.priority >= 1);
 
+	if (!sc.nr_reclaimed && sc.memcg_low_skipped) {
+		sc.priority = DEF_PRIORITY;
+		sc.memcg_low_reclaim = 1;
+		sc.memcg_low_skipped = 0;
+		goto retry;
+	}
+
 	if (!sc.nr_reclaimed)
 		pgdat->kswapd_failures++;
 
-- 
2.13.5 (Apple Git-94)

