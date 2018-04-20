Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755102AbeDTNUg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:20:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754811AbeDTNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:19:00 -0400
Message-Id: <20180420131631.926098428@infradead.org>
User-Agent: quilt/0.63-1
Date: Fri, 20 Apr 2018 15:14:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org, mingo@kernel.org
Cc: tglx@linutronix.de, dan.j.williams@intel.com,
        torvalds@linux-foundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: [PATCH 5/7] perf,x86/cstate: Fix possible Spectre-v1 for pkg_msr
References: <20180420131407.721875616@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-spectre1-5.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> arch/x86/events/intel/cstate.c:307 cstate_pmu_event_init() warn: potential spectre issue 'pkg_msr' (local cap)

Userspace controls @attr, sanitize cfg (attr->config) before using it
to index an array.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/events/intel/cstate.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -302,6 +302,7 @@ static int cstate_pmu_event_init(struct
 	} else if (event->pmu == &cstate_pkg_pmu) {
 		if (cfg >= PERF_CSTATE_PKG_EVENT_MAX)
 			return -EINVAL;
+		cfg = array_index_nospec(cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!pkg_msr[cfg].attr)
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
