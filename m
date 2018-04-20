Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754902AbeDTNTE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:19:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754762AbeDTNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:18:59 -0400
Message-Id: <20180420131631.823785261@infradead.org>
User-Agent: quilt/0.63-1
Date: Fri, 20 Apr 2018 15:14:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: tglx@linutronix.de, dan.j.williams@intel.com,
        torvalds@linux-foundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: [PATCH 3/7] perf,x86: Fix possible Spectre-v1 for x86_pmu::event_map()
References: <20180420131407.721875616@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-spectre1-3.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> arch/x86/events/intel/core.c:337 intel_pmu_event_map() warn: potential spectre issue 'intel_perfmon_event_map'
> arch/x86/events/intel/knc.c:122 knc_pmu_event_map() warn: potential spectre issue 'knc_perfmon_event_map'
> arch/x86/events/intel/p4.c:722 p4_pmu_event_map() warn: potential spectre issue 'p4_general_events'
> arch/x86/events/intel/p6.c:116 p6_pmu_event_map() warn: potential spectre issue 'p6_perfmon_event_map'
> arch/x86/events/amd/core.c:132 amd_pmu_event_map() warn: potential spectre issue 'amd_perfmon_event_map'

Userspace controls @attr, sanitize @attr->config before passing it on
to x86_pmu::event_map().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/events/core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -424,6 +424,8 @@ int x86_setup_perfctr(struct perf_event
 	if (attr->config >= x86_pmu.max_events)
 		return -EINVAL;
 
+	attr->config = array_index_nospec(attr->config, x86_pmu.max_events);
+
 	/*
 	 * The generic map:
 	 */
