Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D46C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3310B218FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeLZNhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:37:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:33944 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeLZNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="121185469"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2018 05:37:02 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005P8-Jt; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133352.012352050@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:15:02 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Fan Du <fan.du@intel.com>
cc:     Yao Yuan <yuan.yao@intel.com>
cc:     Peng Dong <dongx.peng@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>
cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [RFC][PATCH v2 16/21] mm-idle: mm_walk for normal task
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0015-page-idle-Added-mmu-idle-page-walk.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yi <yi.z.zhang@linux.intel.com>

File pages are skipped for now. They are in general not guaranteed to be
mapped. It means when become hot, there is no guarantee to find and move
them to DRAM nodes.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 arch/x86/kvm/ept_idle.c |  204 ++++++++++++++++++++++++++++++++++++++
 mm/pagewalk.c           |    1 
 2 files changed, 205 insertions(+)

--- linux.orig/arch/x86/kvm/ept_idle.c	2018-12-26 19:58:30.576894801 +0800
+++ linux/arch/x86/kvm/ept_idle.c	2018-12-26 19:58:39.840936072 +0800
@@ -510,6 +510,9 @@ static int ept_idle_walk_hva_range(struc
 	return ret;
 }
 
+static ssize_t mm_idle_read(struct file *file, char *buf,
+			    size_t count, loff_t *ppos);
+
 static ssize_t ept_idle_read(struct file *file, char *buf,
 			     size_t count, loff_t *ppos)
 {
@@ -615,6 +618,207 @@ out:
 	return ret;
 }
 
+static int mm_idle_pte_range(struct ept_idle_ctrl *eic, pmd_t *pmd,
+			     unsigned long addr, unsigned long next)
+{
+	enum ProcIdlePageType page_type;
+	pte_t *pte;
+	int err = 0;
+
+	pte = pte_offset_kernel(pmd, addr);
+	do {
+		if (!pte_present(*pte))
+			page_type = PTE_HOLE;
+		else if (!test_and_clear_bit(_PAGE_BIT_ACCESSED,
+					     (unsigned long *) &pte->pte))
+			page_type = PTE_IDLE;
+		else {
+			page_type = PTE_ACCESSED;
+		}
+
+		err = eic_add_page(eic, addr, addr + PAGE_SIZE, page_type);
+		if (err)
+			break;
+	} while (pte++, addr += PAGE_SIZE, addr != next);
+
+	return err;
+}
+
+static int mm_idle_pmd_entry(pmd_t *pmd, unsigned long addr,
+			     unsigned long next, struct mm_walk *walk)
+{
+	struct ept_idle_ctrl *eic = walk->private;
+	enum ProcIdlePageType page_type;
+	enum ProcIdlePageType pte_page_type;
+	int err;
+
+	/*
+	 * Skip duplicate PMD_IDLE_PTES: when the PMD crosses VMA boundary,
+	 * walk_page_range() can call on the same PMD twice.
+	 */
+	if ((addr & PMD_MASK) == (eic->last_va & PMD_MASK)) {
+		debug_printk("ignore duplicate addr %lx %lx\n",
+			     addr, eic->last_va);
+		return 0;
+	}
+	eic->last_va = addr;
+
+	if (eic->flags & SCAN_HUGE_PAGE)
+		pte_page_type = PMD_IDLE_PTES;
+	else
+		pte_page_type = IDLE_PAGE_TYPE_MAX;
+
+	if (!pmd_present(*pmd))
+		page_type = PMD_HOLE;
+	else if (!test_and_clear_bit(_PAGE_BIT_ACCESSED, (unsigned long *)pmd)) {
+		if (pmd_large(*pmd))
+			page_type = PMD_IDLE;
+		else if (eic->flags & SCAN_SKIM_IDLE)
+			page_type = PMD_IDLE_PTES;
+		else
+			page_type = pte_page_type;
+	} else if (pmd_large(*pmd)) {
+		page_type = PMD_ACCESSED;
+	} else
+		page_type = pte_page_type;
+
+	if (page_type != IDLE_PAGE_TYPE_MAX)
+		err = eic_add_page(eic, addr, next, page_type);
+	else
+		err = mm_idle_pte_range(eic, pmd, addr, next);
+
+	return err;
+}
+
+static int mm_idle_pud_entry(pud_t *pud, unsigned long addr,
+			     unsigned long next, struct mm_walk *walk)
+{
+	struct ept_idle_ctrl *eic = walk->private;
+
+	if ((addr & PUD_MASK) != (eic->last_va & PUD_MASK)) {
+		eic_add_page(eic, addr, next, PUD_PRESENT);
+		eic->last_va = addr;
+	}
+	return 1;
+}
+
+static int mm_idle_test_walk(unsigned long start, unsigned long end,
+			     struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	if (vma->vm_file) {
+		if ((vma->vm_flags & (VM_WRITE|VM_MAYSHARE)) == VM_WRITE)
+		    return 0;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int mm_idle_walk_range(struct ept_idle_ctrl *eic,
+			      unsigned long start,
+			      unsigned long end,
+			      struct mm_walk *walk)
+{
+	struct vm_area_struct *vma;
+	int ret;
+
+	init_ept_idle_ctrl_buffer(eic);
+
+	for (; start < end;)
+	{
+		down_read(&walk->mm->mmap_sem);
+		vma = find_vma(walk->mm, start);
+		if (vma) {
+			if (end > vma->vm_start) {
+				local_irq_disable();
+				ret = walk_page_range(start, end, walk);
+				local_irq_enable();
+			} else
+				set_restart_gpa(vma->vm_start, "VMA-HOLE");
+		} else
+			set_restart_gpa(TASK_SIZE, "EOF");
+		up_read(&walk->mm->mmap_sem);
+
+		WARN_ONCE(eic->gpa_to_hva, "non-zero gpa_to_hva");
+		start = eic->restart_gpa;
+		ret = ept_idle_copy_user(eic, start, end);
+		if (ret)
+			break;
+	}
+
+	if (eic->bytes_copied) {
+		if (ret != EPT_IDLE_BUF_FULL && eic->next_hva < end)
+			debug_printk("partial scan: next_hva=%lx end=%lx\n",
+				     eic->next_hva, end);
+		ret = 0;
+	} else
+		WARN_ONCE(1, "nothing read");
+	return ret;
+}
+
+static ssize_t mm_idle_read(struct file *file, char *buf,
+			    size_t count, loff_t *ppos)
+{
+	struct mm_struct *mm = file->private_data;
+	struct mm_walk mm_walk = {};
+	struct ept_idle_ctrl *eic;
+	unsigned long va_start = *ppos;
+	unsigned long va_end = va_start + (count << (3 + PAGE_SHIFT));
+	int ret;
+
+	if (va_end <= va_start) {
+		debug_printk("mm_idle_read past EOF: %lx %lx\n",
+			     va_start, va_end);
+		return 0;
+	}
+	if (*ppos & (PAGE_SIZE - 1)) {
+		debug_printk("mm_idle_read unaligned ppos: %lx\n",
+			     va_start);
+		return -EINVAL;
+	}
+	if (count < EPT_IDLE_BUF_MIN) {
+		debug_printk("mm_idle_read small count: %lx\n",
+			     (unsigned long)count);
+		return -EINVAL;
+	}
+
+	eic = kzalloc(sizeof(*eic), GFP_KERNEL);
+	if (!eic)
+		return -ENOMEM;
+
+	if (!mm || !mmget_not_zero(mm)) {
+		ret = -ESRCH;
+		goto out_free;
+	}
+
+	eic->buf = buf;
+	eic->buf_size = count;
+	eic->mm = mm;
+	eic->flags = file->f_flags;
+
+	mm_walk.mm = mm;
+	mm_walk.pmd_entry = mm_idle_pmd_entry;
+	mm_walk.pud_entry = mm_idle_pud_entry;
+	mm_walk.test_walk = mm_idle_test_walk;
+	mm_walk.private = eic;
+
+	ret = mm_idle_walk_range(eic, va_start, va_end, &mm_walk);
+	if (ret)
+		goto out_mm;
+
+	ret = eic->bytes_copied;
+	*ppos = eic->next_hva;
+	debug_printk("ppos=%lx bytes_copied=%d\n",
+		     eic->next_hva, ret);
+out_mm:
+	mmput(mm);
+out_free:
+	kfree(eic);
+	return ret;
+}
+
 extern struct file_operations proc_ept_idle_operations;
 
 static int ept_idle_entry(void)
--- linux.orig/mm/pagewalk.c	2018-12-26 19:58:30.576894801 +0800
+++ linux/mm/pagewalk.c	2018-12-26 19:58:30.576894801 +0800
@@ -338,6 +338,7 @@ int walk_page_range(unsigned long start,
 	} while (start = next, start < end);
 	return err;
 }
+EXPORT_SYMBOL(walk_page_range);
 
 int walk_page_vma(struct vm_area_struct *vma, struct mm_walk *walk)
 {


