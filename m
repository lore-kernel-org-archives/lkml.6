Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC18C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB91F222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403995AbfBMLr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:47:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:61125 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfBMLrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:47:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 03:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="146480027"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2019 03:47:52 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v0 1/2] perf: Add an option to ask for high order allocations for AUX buffers
Date:   Wed, 13 Feb 2019 13:47:15 +0200
Message-Id: <20190213114716.63972-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213114716.63972-1-alexander.shishkin@linux.intel.com>
References: <20190213114716.63972-1-alexander.shishkin@linux.intel.com>
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

Following the above justification, add an attribute bit to ask for a
high-order AUX allocation. To prevent an unprivileged user from using up
the higher orders of the page allocator, require CAP_SYS_ADMIN for this
option.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 include/uapi/linux/perf_event.h | 3 ++-
 kernel/events/core.c            | 3 +++
 kernel/events/ring_buffer.c     | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..04726b5729c8 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -374,7 +374,8 @@ struct perf_event_attr {
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
-				__reserved_1   : 33;
+				aux_highorder  :  1, /* use high order allocations for AUX data */
+				__reserved_1   : 32;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5aeb4c74fb99..ba95398505c5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10688,6 +10688,9 @@ SYSCALL_DEFINE5(perf_event_open,
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
+	if (attr.aux_highorder && !capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
 	 * opened to the cgroup directory in cgroupfs. The cpu argument
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 70ae2422cbaf..72b7380deb0a 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -603,7 +603,8 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
 
-	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) {
+	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG ||
+	    event->attr.aux_highorder) {
 		/*
 		 * We need to start with the max_order that fits in nr_pages,
 		 * not the other way around, hence ilog2() and not get_order.
-- 
2.20.1

