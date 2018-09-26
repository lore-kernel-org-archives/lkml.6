Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE81C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22563214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22563214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIZV0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:26:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48350 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbeIZV0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:26:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89BF518A;
        Wed, 26 Sep 2018 08:13:17 -0700 (PDT)
Received: from e113632-lin.Cambridge.Arm.com (e113632-lin.emea.arm.com [10.4.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27D7A3F5BD;
        Wed, 26 Sep 2018 08:13:16 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, patrick.bellasi@arm.com
Subject: [PATCH v2 1/2] sched/fair: Cleanup load_balance() condition
Date:   Wed, 26 Sep 2018 16:12:06 +0100
Message-Id: <1537974727-30788-1-git-send-email-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alignment of the condition is off, clean that up.

Also, logical operators have lower precedence than bitwise/relational
operators, so remove one layer of parentheses to make the condition a
bit simpler to follow.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6bd142d..9cf93ba 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8783,9 +8783,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 
 out_one_pinned:
 	/* tune up the balancing interval */
-	if (((env.flags & LBF_ALL_PINNED) &&
-			sd->balance_interval < MAX_PINNED_INTERVAL) ||
-			(sd->balance_interval < sd->max_interval))
+	if ((env.flags & LBF_ALL_PINNED &&
+	     sd->balance_interval < MAX_PINNED_INTERVAL) ||
+	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
 
 	ld_moved = 0;
-- 
2.7.4

