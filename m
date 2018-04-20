Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755071AbeDTNUG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:20:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50202 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754920AbeDTNTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:19:11 -0400
Message-Id: <20180420131631.772098990@infradead.org>
User-Agent: quilt/0.63-1
Date: Fri, 20 Apr 2018 15:14:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: tglx@linutronix.de, dan.j.williams@intel.com,
        torvalds@linux-foundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: [PATCH 2/7] perf,x86: Fix possible Spectre-v1 for hw_perf_event
References: <20180420131407.721875616@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-spectre1-2.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> arch/x86/events/core.c:319 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_event_ids[cache_type]' (local cap)
> arch/x86/events/core.c:319 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_event_ids' (local cap)
> arch/x86/events/core.c:328 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_extra_regs[cache_type]' (local cap)
> arch/x86/events/core.c:328 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_extra_regs' (local cap)

Userspace controls @config which contains 3 (byte) fields used for a 3
dimensional array deref.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/events/core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -304,17 +304,20 @@ set_ext_hw_attr(struct hw_perf_event *hw
 
 	config = attr->config;
 
-	cache_type = (config >>  0) & 0xff;
+	cache_type = (config >> 0) & 0xff;
 	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
 		return -EINVAL;
+	cache_type = array_index_nospec(cache_type, PERF_COUNT_HW_CACHE_MAX);
 
 	cache_op = (config >>  8) & 0xff;
 	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
 		return -EINVAL;
+	cache_op = array_index_nospec(cache_op, PERF_COUNT_HW_CACHE_OP_MAX);
 
 	cache_result = (config >> 16) & 0xff;
 	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
 		return -EINVAL;
+	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
 
 	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
 
