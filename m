Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61E32081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61E32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbeLCIB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:01:26 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51269 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbeLCIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:01:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TEiqOm6_1543824079;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TEiqOm6_1543824079)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 03 Dec 2018 16:01:20 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/3] mm/memcg: Fix min/low usage in propagate_protected_usage()
Date:   Mon,  3 Dec 2018 16:01:17 +0800
Message-Id: <20181203080119.18989-1-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When usage exceeds min, min usage should be min other than 0.
Apply the same for low.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/page_counter.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index de31470655f6..75d53f15f040 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -23,11 +23,7 @@ static void propagate_protected_usage(struct page_counter *c,
 		return;
 
 	if (c->min || atomic_long_read(&c->min_usage)) {
-		if (usage <= c->min)
-			protected = usage;
-		else
-			protected = 0;
-
+		protected = min(usage, c->min);
 		old_protected = atomic_long_xchg(&c->min_usage, protected);
 		delta = protected - old_protected;
 		if (delta)
@@ -35,11 +31,7 @@ static void propagate_protected_usage(struct page_counter *c,
 	}
 
 	if (c->low || atomic_long_read(&c->low_usage)) {
-		if (usage <= c->low)
-			protected = usage;
-		else
-			protected = 0;
-
+		protected = min(usage, c->low);
 		old_protected = atomic_long_xchg(&c->low_usage, protected);
 		delta = protected - old_protected;
 		if (delta)
-- 
2.13.5 (Apple Git-94)

