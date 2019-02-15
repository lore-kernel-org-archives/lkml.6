Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64918C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204F0222D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436838AbfBOL5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:57:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:25055 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436815AbfBOL5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:57:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 03:57:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="134556859"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2019 03:57:10 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v0 2/2] perf, pt, coresight: Fix address filters for vmas with non-zero offset
Date:   Fri, 15 Feb 2019 13:56:55 +0200
Message-Id: <20190215115655.63469-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215115655.63469-1-alexander.shishkin@linux.intel.com>
References: <20190215115655.63469-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the address range calculation for file-based filters works as
long as the vma that maps the matching part of the object file starts from
offset zero into the file (vm_pgoff==0). Otherwise, the resulting filter
range would be off by vm_pgoff pages. Another related problem is that in
case of a partially matching vma, that is, a vma that matches part of a
filter region, the filter range size wouldn't be adjusted.

Fix the arithmetics around address filter range calculations, taking into
account vma offset, so that the entire calculation is done before the
filter configuration is passed to the PMU drivers instead of having those
drivers do the final bit of arithmetics.

Based on the patch by Adrian Hunter <adrian.hunter.intel.com>.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
Reported-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c                    |  9 ++-
 .../hwtracing/coresight/coresight-etm-perf.c  |  7 +-
 include/linux/perf_event.h                    |  7 +-
 kernel/events/core.c                          | 81 +++++++++++--------
 4 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index cb4c10fdf793..c0c44c055eaa 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1223,7 +1223,8 @@ static int pt_event_addr_filters_validate(struct list_head *filters)
 static void pt_event_addr_filters_sync(struct perf_event *event)
 {
 	struct perf_addr_filters_head *head = perf_event_addr_filters(event);
-	unsigned long msr_a, msr_b, *offs = event->addr_filters_offs;
+	unsigned long msr_a, msr_b;
+	struct perf_addr_filter_range *fr = event->addr_filter_ranges;
 	struct pt_filters *filters = event->hw.addr_filters;
 	struct perf_addr_filter *filter;
 	int range = 0;
@@ -1232,12 +1233,12 @@ static void pt_event_addr_filters_sync(struct perf_event *event)
 		return;
 
 	list_for_each_entry(filter, &head->list, entry) {
-		if (filter->path.dentry && !offs[range]) {
+		if (filter->path.dentry && !fr[range].start) {
 			msr_a = msr_b = 0;
 		} else {
 			/* apply the offset */
-			msr_a = filter->offset + offs[range];
-			msr_b = filter->size + msr_a - 1;
+			msr_a = fr[range].start;
+			msr_b = msr_a + fr[range].size - 1;
 		}
 
 		filters->filter[range].msr_a  = msr_a;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 8c88bf0a1e5f..4d5a2b9f9d6a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -433,15 +433,16 @@ static int etm_addr_filters_validate(struct list_head *filters)
 static void etm_addr_filters_sync(struct perf_event *event)
 {
 	struct perf_addr_filters_head *head = perf_event_addr_filters(event);
-	unsigned long start, stop, *offs = event->addr_filters_offs;
+	unsigned long start, stop;
+	struct perf_addr_filter_range *fr = event->addr_filter_ranges;
 	struct etm_filters *filters = event->hw.addr_filters;
 	struct etm_filter *etm_filter;
 	struct perf_addr_filter *filter;
 	int i = 0;
 
 	list_for_each_entry(filter, &head->list, entry) {
-		start = filter->offset + offs[i];
-		stop = start + filter->size;
+		start = fr[i].start;
+		stop = start + fr[i].size;
 		etm_filter = &filters->etm_filter[i];
 
 		switch (filter->action) {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d9c3610e0e25..6ebc72f65017 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -490,6 +490,11 @@ struct perf_addr_filters_head {
 	unsigned int		nr_file_filters;
 };
 
+struct perf_addr_filter_range {
+	unsigned long		start;
+	unsigned long		size;
+};
+
 /**
  * enum perf_event_state - the states of an event:
  */
@@ -666,7 +671,7 @@ struct perf_event {
 	/* address range filters */
 	struct perf_addr_filters_head	addr_filters;
 	/* vma address array for file-based filders */
-	unsigned long			*addr_filters_offs;
+	struct perf_addr_filter_range	*addr_filter_ranges;
 	unsigned long			addr_filters_gen;
 
 	void (*destroy)(struct perf_event *);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2d89efc0a3e0..16609f6737da 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2799,7 +2799,7 @@ static int perf_event_stop(struct perf_event *event, int restart)
  *
  * (p1) when userspace mappings change as a result of (1) or (2) or (3) below,
  *      we update the addresses of corresponding vmas in
- *	event::addr_filters_offs array and bump the event::addr_filters_gen;
+ *	event::addr_filter_ranges array and bump the event::addr_filters_gen;
  * (p2) when an event is scheduled in (pmu::add), it calls
  *      perf_event_addr_filters_sync() which calls pmu::addr_filters_sync()
  *      if the generation has changed since the previous call.
@@ -4446,7 +4446,7 @@ static void _free_event(struct perf_event *event)
 
 	perf_event_free_bpf_prog(event);
 	perf_addr_filters_splice(event, NULL);
-	kfree(event->addr_filters_offs);
+	kfree(event->addr_filter_ranges);
 
 	if (event->destroy)
 		event->destroy(event);
@@ -6687,7 +6687,8 @@ static void perf_event_addr_filters_exec(struct perf_event *event, void *data)
 	raw_spin_lock_irqsave(&ifh->lock, flags);
 	list_for_each_entry(filter, &ifh->list, entry) {
 		if (filter->path.dentry) {
-			event->addr_filters_offs[count] = 0;
+			event->addr_filter_ranges[count].start = 0;
+			event->addr_filter_ranges[count].size = 0;
 			restart++;
 		}
 
@@ -7367,28 +7368,47 @@ static bool perf_addr_filter_match(struct perf_addr_filter *filter,
 	return true;
 }
 
+static bool perf_addr_filter_vma_adjust(struct perf_addr_filter *filter,
+					struct vm_area_struct *vma,
+					struct perf_addr_filter_range *fr)
+{
+	unsigned long vma_size = vma->vm_end - vma->vm_start;
+	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
+	struct file *file = vma->vm_file;
+
+	if (!perf_addr_filter_match(filter, file, off, vma_size))
+		return false;
+
+	if (filter->offset < off) {
+		fr->start = vma->vm_start;
+		fr->size = min(vma_size, filter->size - (off - filter->offset));
+	} else {
+		fr->start = vma->vm_start + filter->offset - off;
+		fr->size = min(vma->vm_end - fr->start, filter->size);
+	}
+
+	return true;
+}
+
 static void __perf_addr_filters_adjust(struct perf_event *event, void *data)
 {
 	struct perf_addr_filters_head *ifh = perf_event_addr_filters(event);
 	struct vm_area_struct *vma = data;
-	unsigned long off = vma->vm_pgoff << PAGE_SHIFT, flags;
-	struct file *file = vma->vm_file;
 	struct perf_addr_filter *filter;
 	unsigned int restart = 0, count = 0;
+	unsigned long flags;
 
 	if (!has_addr_filter(event))
 		return;
 
-	if (!file)
+	if (!vma->vm_file)
 		return;
 
 	raw_spin_lock_irqsave(&ifh->lock, flags);
 	list_for_each_entry(filter, &ifh->list, entry) {
-		if (perf_addr_filter_match(filter, file, off,
-					     vma->vm_end - vma->vm_start)) {
-			event->addr_filters_offs[count] = vma->vm_start;
+		if (perf_addr_filter_vma_adjust(filter, vma,
+						&event->addr_filter_ranges[count]))
 			restart++;
-		}
 
 		count++;
 	}
@@ -8978,26 +8998,19 @@ static void perf_addr_filters_splice(struct perf_event *event,
  * @filter; if so, adjust filter's address range.
  * Called with mm::mmap_sem down for reading.
  */
-static unsigned long perf_addr_filter_apply(struct perf_addr_filter *filter,
-					    struct mm_struct *mm)
+static void perf_addr_filter_apply(struct perf_addr_filter *filter,
+				   struct mm_struct *mm,
+				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
 
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		struct file *file = vma->vm_file;
-		unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
-		unsigned long vma_size = vma->vm_end - vma->vm_start;
-
-		if (!file)
+		if (!vma->vm_file)
 			continue;
 
-		if (!perf_addr_filter_match(filter, file, off, vma_size))
-			continue;
-
-		return vma->vm_start;
+		if (perf_addr_filter_vma_adjust(filter, vma, fr))
+			return;
 	}
-
-	return 0;
 }
 
 /*
@@ -9031,15 +9044,15 @@ static void perf_event_addr_filters_apply(struct perf_event *event)
 
 	raw_spin_lock_irqsave(&ifh->lock, flags);
 	list_for_each_entry(filter, &ifh->list, entry) {
-		event->addr_filters_offs[count] = 0;
+		event->addr_filter_ranges[count].start = 0;
+		event->addr_filter_ranges[count].size = 0;
 
 		/*
 		 * Adjust base offset if the filter is associated to a binary
 		 * that needs to be mapped:
 		 */
 		if (filter->path.dentry)
-			event->addr_filters_offs[count] =
-				perf_addr_filter_apply(filter, mm);
+			perf_addr_filter_apply(filter, mm, &event->addr_filter_ranges[count]);
 
 		count++;
 	}
@@ -10305,10 +10318,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		goto err_pmu;
 
 	if (has_addr_filter(event)) {
-		event->addr_filters_offs = kcalloc(pmu->nr_addr_filters,
-						   sizeof(unsigned long),
-						   GFP_KERNEL);
-		if (!event->addr_filters_offs) {
+		event->addr_filter_ranges = kcalloc(pmu->nr_addr_filters,
+						    sizeof(struct perf_addr_filter_range),
+						    GFP_KERNEL);
+		if (!event->addr_filter_ranges) {
 			err = -ENOMEM;
 			goto err_per_task;
 		}
@@ -10321,9 +10334,9 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 			struct perf_addr_filters_head *ifh = perf_event_addr_filters(event);
 
 			raw_spin_lock_irq(&ifh->lock);
-			memcpy(event->addr_filters_offs,
-			       event->parent->addr_filters_offs,
-			       pmu->nr_addr_filters * sizeof(unsigned long));
+			memcpy(event->addr_filter_ranges,
+			       event->parent->addr_filter_ranges,
+			       pmu->nr_addr_filters * sizeof(struct perf_addr_filter_range));
 			raw_spin_unlock_irq(&ifh->lock);
 		}
 
@@ -10345,7 +10358,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	return event;
 
 err_addr_filters:
-	kfree(event->addr_filters_offs);
+	kfree(event->addr_filter_ranges);
 
 err_per_task:
 	exclusive_event_destroy(event);
-- 
2.20.1

