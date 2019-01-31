Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097BBC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D775D21939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfAaU2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:28:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:4802 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbfAaU2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:28:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 12:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="143176545"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2019 12:28:48 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, luto@amacapital.net,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Date:   Thu, 31 Jan 2019 12:27:54 -0800
Message-Id: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current perf can report both virtual address and physical address, but
it doesn't report page size. Users have no idea how large the utilized
page is. They cannot promote/demote large pages to optimize memory use.

Add a new sample type for data page size.

Current perf already has a facility to collect data virtual address.
A __weak function, aim to retrieve page size via a given virtual
address, is introduced in the generic code. Now, it always returns 0.
The function must be IRQ-safe.
This patch only implements a x86 specific version, which do full
page-table walk of a given virtual address to retrieve page size.
For x86, disabling IRQs over the walk is sufficient to prevent any
tear down of the page tables.
Other architectures can implement their own functions later separately.

The new sample type requires collecting the virtual address. The
virtual address will not be output unless SAMPLE_ADDR is applied.

A u64 type is claimed for page_size. Because struct perf_sample_data
requires cacheline_aligned.

The large PEBS will be disabled with this sample type. Because we need
to track munmap to flush the PEBS buffer for large PEBS. Perf doesn't
support munmap tracking yet. The large PEBS can be enabled later
separately when munmap tracking is supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V3
- Use the real page size to replace enum.
- Modify the changelog to mention the generic support of
  __weak perf_get_page_size()

 arch/x86/events/core.c          | 31 +++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c      |  3 ++-
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  4 +++-
 kernel/events/core.c            | 15 +++++++++++++++
 5 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 374a197..229a73b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2578,3 +2578,34 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 }
 EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
+
+u64 perf_get_page_size(u64 virt)
+{
+	unsigned long flags;
+	unsigned int level;
+	pte_t *pte;
+
+	if (!virt)
+		return 0;
+
+	/*
+	 * Interrupts are disabled, so it prevents any tear down
+	 * of the page tables.
+	 * See the comment near struct mmu_table_batch.
+	 */
+	local_irq_save(flags);
+	if (virt >= TASK_SIZE)
+		pte = lookup_address(virt, &level);
+	else {
+		if (current->mm) {
+			pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
+						    virt, &level);
+		} else
+			level = PG_LEVEL_NUM;
+	}
+	local_irq_restore(flags);
+	if (level >= PG_LEVEL_NUM)
+		return 0;
+
+	return (u64)page_level_size(level);
+}
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e9acf1d..720dc9e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1274,7 +1274,8 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	}
 
 
-	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
+	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR
+			    | PERF_SAMPLE_DATA_PAGE_SIZE)) &&
 	    x86_pmu.intel_cap.pebs_format >= 1)
 		data->addr = pebs->dla;
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a79e59f..0e048ab 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -937,6 +937,7 @@ struct perf_sample_data {
 	u64				stack_user_size;
 
 	u64				phys_addr;
+	u64				data_page_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7198ddd..0e8d222 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -141,8 +141,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_TRANSACTION			= 1U << 17,
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
+	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 20,
 
-	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -863,6 +864,7 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
+	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 236bb8d..d233f45 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1753,6 +1753,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		size += sizeof(data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		size += sizeof(data->data_page_size);
+
 	event->header_size = size;
 }
 
@@ -6305,6 +6308,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		perf_output_put(handle, data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		perf_output_put(handle, data->data_page_size);
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -6352,6 +6358,12 @@ static u64 perf_virt_to_phys(u64 virt)
 	return phys_addr;
 }
 
+/* Return page size of given virtual address. IRQ-safe required. */
+u64 __weak perf_get_page_size(u64 virt)
+{
+	return 0;
+}
+
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
 struct perf_callchain_entry *
@@ -6493,6 +6505,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		data->phys_addr = perf_virt_to_phys(data->addr);
+
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		data->data_page_size = perf_get_page_size(data->addr);
 }
 
 static __always_inline int
-- 
2.7.4

