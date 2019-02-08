Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86746C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6318220863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfBHR4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:56:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:40705 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbfBHR4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:56:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 09:56:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="142716477"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2019 09:56:33 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, luto@amacapital.net, vbabka@suse.cz,
        will.deacon@arm.com, kirill@shutemov.name,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 02/14] perf/x86: Add perf_get_page_size support
Date:   Fri,  8 Feb 2019 09:54:57 -0800
Message-Id: <1549648509-12704-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549648509-12704-1-git-send-email-kan.liang@linux.intel.com>
References: <1549648509-12704-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Implement a x86 specific version of perf_get_page_size(), which do full
page-table walk of a given virtual address to retrieve page size.
For x86, disabling IRQs over the walk is sufficient to prevent any tear
down of the page tables.

The new sample type requires collecting the virtual address. The virtual
address will not be output unless SAMPLE_ADDR is applied.

The large PEBS will be disabled with this sample type. Because we need
to track munmap to flush the PEBS buffer for large PEBS. Perf doesn't
support munmap tracking yet. The large PEBS can be enabled later
separately when munmap tracking is supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V4
- Split patch 1 of V4 into two patches.
  This patch add the x86 implementation

 arch/x86/events/core.c     | 31 +++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c |  3 ++-
 2 files changed, 33 insertions(+), 1 deletion(-)

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
 
-- 
2.7.4

