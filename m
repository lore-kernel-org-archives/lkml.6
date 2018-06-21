Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BBBC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDC5223D9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDC5223D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933626AbeFUVT4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:19:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:27241 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754012AbeFUVSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:18:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 14:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="48912108"
Received: from hanvin-mobl2.amr.corp.intel.com ([10.254.42.214])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2018 14:18:02 -0700
From:   "H. Peter Anvin, Intel" <h.peter.anvin@intel.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "H. Peter Anvin" <hpa@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        "Markus T . Metzger" <markus.t.metzger@intel.com>
Subject: [PATCH v3 1/7] x86/ldt: refresh %fs and %gs in refresh_ldt_segments()
Date:   Thu, 21 Jun 2018 14:17:48 -0700
Message-Id: <20180621211754.12757-2-h.peter.anvin@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180621211754.12757-1-h.peter.anvin@intel.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@linux.intel.com>

It is not only %ds and %es which contain cached user descriptor
information, %fs and %gs do as well.

To make sure we don't do something stupid that will affect processes
which wouldn't want this requalification, be more restrictive about
which selector numbers will be requalified: they need to be LDT
selectors (which by definition are never null), have an RPL of 3
(always the case in user space unless null), and match the updated
descriptor.

The infrastructure is set up to allow a range of descriptors; this
will be used in a subsequent patch.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Markus T. Metzger <markus.t.metzger@intel.com>
---
 arch/x86/kernel/ldt.c | 70 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index c9b14020f4dd..18e9f4c0633d 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -29,36 +29,68 @@
 #include <asm/mmu_context.h>
 #include <asm/syscalls.h>
 
-static void refresh_ldt_segments(void)
-{
+struct flush_ldt_info {
+	struct mm_struct *mm;
+	unsigned short first_desc;
+	unsigned short last_desc;
+};
+
 #ifdef CONFIG_X86_64
+
+static inline bool
+need_requalify(unsigned short sel, const struct flush_ldt_info *info)
+{
+	/* Must be an LDT segment descriptor with an RPL of 3 */
+	if ((sel & (SEGMENT_TI_MASK|SEGMENT_RPL_MASK)) != (SEGMENT_LDT|3))
+		return false;
+
+	return sel >= info->first_desc && sel <= info->last_desc;
+}
+
+static void refresh_ldt_segments(const struct flush_ldt_info *info)
+{
 	unsigned short sel;
 
 	/*
-	 * Make sure that the cached DS and ES descriptors match the updated
-	 * LDT.
+	 * Make sure that the cached DS/ES/FS/GS descriptors
+	 * match the updated LDT, if the specific selectors point
+	 * to LDT entries that have changed.
 	 */
 	savesegment(ds, sel);
-	if ((sel & SEGMENT_TI_MASK) == SEGMENT_LDT)
+	if (need_requalify(sel, info))
 		loadsegment(ds, sel);
 
 	savesegment(es, sel);
-	if ((sel & SEGMENT_TI_MASK) == SEGMENT_LDT)
+	if (need_requalify(sel, info))
 		loadsegment(es, sel);
-#endif
+
+	savesegment(fs, sel);
+	if (need_requalify(sel, info))
+		loadsegment(fs, sel);
+
+	savesegment(gs, sel);
+	if (need_requalify(sel, info))
+		load_gs_index(sel);
 }
 
+#else
+/* On 32 bits, entry_32.S takes care of this on kernel exit */
+static void refresh_ldt_segments(const struct flush_ldt_info *info)
+{
+	(void)info;
+}
+#endif
+
 /* context.lock is held by the task which issued the smp function call */
-static void flush_ldt(void *__mm)
+static void flush_ldt(void *_info)
 {
-	struct mm_struct *mm = __mm;
+	const struct flush_ldt_info *info = _info;
 
-	if (this_cpu_read(cpu_tlbstate.loaded_mm) != mm)
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) != info->mm)
 		return;
 
-	load_mm_ldt(mm);
-
-	refresh_ldt_segments();
+	load_mm_ldt(info->mm);
+	refresh_ldt_segments(info);
 }
 
 /* The caller must call finalize_ldt_struct on the result. LDT starts zeroed. */
@@ -223,15 +255,21 @@ static void finalize_ldt_struct(struct ldt_struct *ldt)
 	paravirt_alloc_ldt(ldt->entries, ldt->nr_entries);
 }
 
-static void install_ldt(struct mm_struct *mm, struct ldt_struct *ldt)
+static void install_ldt(struct mm_struct *mm, struct ldt_struct *ldt,
+			unsigned short first_index, unsigned short last_index)
 {
+	struct flush_ldt_info info;
+
 	mutex_lock(&mm->context.lock);
 
 	/* Synchronizes with READ_ONCE in load_mm_ldt. */
 	smp_store_release(&mm->context.ldt, ldt);
 
 	/* Activate the LDT for all CPUs using currents mm. */
-	on_each_cpu_mask(mm_cpumask(mm), flush_ldt, mm, true);
+	info.mm = mm;
+	info.first_desc = (first_index << 3)|SEGMENT_LDT|3;
+	info.last_desc  = (last_index << 3)|SEGMENT_LDT|3;
+	on_each_cpu_mask(mm_cpumask(mm), flush_ldt, &info, true);
 
 	mutex_unlock(&mm->context.lock);
 }
@@ -436,7 +474,7 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 		goto out_unlock;
 	}
 
-	install_ldt(mm, new_ldt);
+	install_ldt(mm, new_ldt, ldt_info.entry_number, ldt_info.entry_number);
 	free_ldt_struct(old_ldt);
 	error = 0;
 
-- 
2.14.4

