Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755089AbeDTNUf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:20:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754826AbeDTNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:19:00 -0400
Message-Id: <20180420131631.977597863@infradead.org>
User-Agent: quilt/0.63-1
Date: Fri, 20 Apr 2018 15:14:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: tglx@linutronix.de, dan.j.williams@intel.com,
        torvalds@linux-foundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: [PATCH 6/7] sched: Fix possible Spectre-v1 for sched_prio_to_weight[]
References: <20180420131407.721875616@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-spectre1-6.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel/sched/core.c:6921 cpu_weight_nice_write_s64() warn: potential spectre issue 'sched_prio_to_weight'

Userspace controls @nice, so sanitize the value before using it to
index an array.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6928,11 +6928,14 @@ static int cpu_weight_nice_write_s64(str
 				     struct cftype *cft, s64 nice)
 {
 	unsigned long weight;
+	int idx;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -ERANGE;
 
-	weight = sched_prio_to_weight[NICE_TO_PRIO(nice) - MAX_RT_PRIO];
+	idx = array_index_nospec(NICE_TO_PRIO(nice) - MAX_RT_PRIO, 40);
+	weight = sched_prio_to_weight[idx];
+
 	return sched_group_set_shares(css_tg(css), scale_load(weight));
 }
 #endif
