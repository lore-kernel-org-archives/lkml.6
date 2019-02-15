Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4F22190B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394507AbfBOLr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:47:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:32692 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390895AbfBOLry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:47:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 03:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="144542205"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 15 Feb 2019 03:47:51 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 1/1] perf: Optimistically use high order allocations for AUX buffers
Date:   Fri, 15 Feb 2019 13:47:27 +0200
Message-Id: <20190215114727.62648-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215114727.62648-1-alexander.shishkin@linux.intel.com>
References: <20190215114727.62648-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the AUX buffer allocator will use high-order allocations
for PMUs that don't support hardware scatter-gather chaining to ensure
large contiguous blocks of pages, and always use an array of single
pages otherwise.

There is, however, a tangible performance benefit in using larger chunks
of contiguous memory even in the latter case, that comes from not having
to fetch the next page's address at every page boundary. In particular,
a task running under Intel PT on an Atom CPU shows 1.5%-2% less runtime
penalty with a single multi-page output region in snapshot mode (no PMI)
than with multiple single-page output regions, from ~6% down to ~4%. For
the snapshot mode it does make a difference as it is intended to run over
long periods of time.

For this reason, change the allocation policy to always optimistically
start with the highest possible order when allocating pages for the AUX
buffer, desceding until the allocation succeeds or order zero allocation
fails.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/ring_buffer.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 70ae2422cbaf..cc395475e0dd 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -598,29 +598,27 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 {
 	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
 	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
-	int ret = -ENOMEM, max_order = 0;
+	int ret = -ENOMEM, max_order;
 
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
 
-	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) {
-		/*
-		 * We need to start with the max_order that fits in nr_pages,
-		 * not the other way around, hence ilog2() and not get_order.
-		 */
-		max_order = ilog2(nr_pages);
+	/*
+	 * We need to start with the max_order that fits in nr_pages,
+	 * not the other way around, hence ilog2() and not get_order.
+	 */
+	max_order = ilog2(nr_pages);
 
-		/*
-		 * PMU requests more than one contiguous chunks of memory
-		 * for SW double buffering
-		 */
-		if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_SW_DOUBLEBUF) &&
-		    !overwrite) {
-			if (!max_order)
-				return -EINVAL;
+	/*
+	 * PMU requests more than one contiguous chunks of memory
+	 * for SW double buffering
+	 */
+	if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_SW_DOUBLEBUF) &&
+	    !overwrite) {
+		if (!max_order)
+			return -EINVAL;
 
-			max_order--;
-		}
+		max_order--;
 	}
 
 	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
-- 
2.20.1

