Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbeDTNTB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:19:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:18:59 -0400
Message-Id: <20180420131631.875020804@infradead.org>
User-Agent: quilt/0.63-1
Date: Fri, 20 Apr 2018 15:14:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: tglx@linutronix.de, dan.j.williams@intel.com,
        torvalds@linux-foundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: [PATCH 4/7] perf,x86/msr: Fix possible Spectre-v1 for msr
References: <20180420131407.721875616@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-spectre1-4.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> arch/x86/events/msr.c:178 msr_event_init() warn: potential spectre issue 'msr' (local cap)

Userspace controls @attr, sanitize cfg (attr->config) before using it
to index an array.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/events/msr.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -158,9 +158,6 @@ static int msr_event_init(struct perf_ev
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (cfg >= PERF_MSR_EVENT_MAX)
-		return -EINVAL;
-
 	/* unsupported modes and filters */
 	if (event->attr.exclude_user   ||
 	    event->attr.exclude_kernel ||
@@ -171,6 +168,11 @@ static int msr_event_init(struct perf_ev
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
+	if (cfg >= PERF_MSR_EVENT_MAX)
+		return -EINVAL;
+
+	cfg = array_index_nospec(cfg, PERF_MSR_EVENT_MAX);
+
 	if (!msr[cfg].attr)
 		return -EINVAL;
 
