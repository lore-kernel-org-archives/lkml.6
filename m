Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C45CC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CCD2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CCD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeJXXlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:41:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:38292 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJXXlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:41:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 08:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="80581149"
Received: from otc-cfl-s-03.jf.intel.com ([10.54.55.152])
  by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2018 08:12:36 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf: Add munmap callback
Date:   Wed, 24 Oct 2018 08:11:15 -0700
Message-Id: <20181024151116.30935-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To calculate the physical address, perf needs to walk the pages tables.
The related mapping may has already been removed from pages table in
some cases (e.g. large PEBS). The virtual address recorded in the first
PEBS records may already be unmapped before draining PEBS buffers.

Add a munmap callback to notify the PMU of any unmapping, which only be
invoked when the munmap is implemented.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 25 +++++++++++++++++++++++++
 mm/mmap.c                  |  1 +
 3 files changed, 29 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..7f0a9258ce1f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -400,6 +400,7 @@ struct pmu {
 	 */
 	void (*sched_task)		(struct perf_event_context *ctx,
 					bool sched_in);
+	void (*munmap)			(void);
 	/*
 	 * PMU specific data size
 	 */
@@ -1113,6 +1114,7 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
 }
 
 extern void perf_event_mmap(struct vm_area_struct *vma);
+extern void perf_event_munmap(void);
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
 extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1333,6 +1335,7 @@ static inline int perf_unregister_guest_info_callbacks
 (struct perf_guest_info_callbacks *callbacks)				{ return 0; }
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
+static inline void perf_event_munmap(void)				{ }
 static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a97f34bc14c..00338d6fbed7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3184,6 +3184,31 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 	}
 }
 
+void perf_event_munmap(void)
+{
+	struct perf_cpu_context *cpuctx;
+	unsigned long flags;
+	struct pmu *pmu;
+
+	local_irq_save(flags);
+	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
+		pmu = cpuctx->ctx.pmu;
+
+		if (!pmu->munmap)
+			continue;
+
+		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+		perf_pmu_disable(pmu);
+
+		pmu->munmap();
+
+		perf_pmu_enable(pmu);
+
+		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
+	}
+	local_irq_restore(flags);
+}
+
 static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 5f2b2b184c60..61978ad8c480 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2777,6 +2777,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/*
 	 * Remove the vma's, and unmap the actual pages
 	 */
+	perf_event_munmap();
 	detach_vmas_to_be_unmapped(mm, vma, prev, end);
 	unmap_region(mm, vma, prev, start, end);
 
-- 
2.17.1

