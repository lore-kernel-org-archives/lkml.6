Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33694C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027B1218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeLZNhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:37:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:21292 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbeLZNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:07 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="113358947"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by orsmga003.jf.intel.com with ESMTP; 26 Dec 2018 05:37:02 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005PD-Kb; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133352.076749877@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:15:03 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Huang Ying <ying.huang@intel.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Fan Du <fan.du@intel.com>
cc:     Yao Yuan <yuan.yao@intel.com>
cc:     Peng Dong <dongx.peng@intel.com>
CC:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>
cc:     Zhang Yi <yi.z.zhang@linux.intel.com>
cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [RFC][PATCH v2 17/21] proc: introduce /proc/PID/idle_pages
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0008-proc-introduce-proc-PID-idle_pages.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be similar to /sys/kernel/mm/page_idle/bitmap documented in
Documentation/admin-guide/mm/idle_page_tracking.rst, however indexed
by process virtual address.

When using the global PFN indexed idle bitmap, we find 2 kind of
overheads:

- to track a task's working set, Brendan Gregg end up writing wss-v1
  for small tasks and wss-v2 for large tasks:

  https://github.com/brendangregg/wss

  That's because VAs may point to random PAs throughout the physical
  address space. So we either query /proc/pid/pagemap first and access
  the lots of random PFNs (with lots of syscalls) in the bitmap, or
  write+read the whole system idle bitmap beforehand.

- page table walking by PFN has much more overheads than to walk a
  page table in its natural order:
  - rmap queries
  - more locking
  - random memory reads/writes

This interface provides a cheap path for the majority non-shared mapping
pages. To walk 1TB memory of 4k active pages, it costs 2s vs 15s system
time to scan the per-task/global idle bitmaps. Which means ~7x speedup.
The gap will be enlarged if consider

- the extra /proc/pid/pagemap walk
- natural page table walks can skip the whole 512 PTEs if PMD is idle

OTOH, the per-task idle bitmap is not suitable in some situations:

- not accurate for shared pages
- don't work with non-mapped file pages
- don't perform well for sparse page tables (pointed out by Huang Ying)

So it's more about complementing the existing global idle bitmap.

CC: Huang Ying <ying.huang@intel.com>
CC: Brendan Gregg <bgregg@netflix.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 fs/proc/base.c     |    2 +
 fs/proc/internal.h |    1 
 fs/proc/task_mmu.c |   54 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

--- linux.orig/fs/proc/base.c	2018-12-23 20:08:14.228919325 +0800
+++ linux/fs/proc/base.c	2018-12-23 20:08:14.224919327 +0800
@@ -2969,6 +2969,7 @@ static const struct pid_entry tgid_base_
 	REG("smaps",      S_IRUGO, proc_pid_smaps_operations),
 	REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
 	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
+	REG("idle_pages", S_IRUSR|S_IWUSR, proc_mm_idle_operations),
 #endif
 #ifdef CONFIG_SECURITY
 	DIR("attr",       S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
@@ -3357,6 +3358,7 @@ static const struct pid_entry tid_base_s
 	REG("smaps",     S_IRUGO, proc_pid_smaps_operations),
 	REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
 	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
+	REG("idle_pages", S_IRUSR|S_IWUSR, proc_mm_idle_operations),
 #endif
 #ifdef CONFIG_SECURITY
 	DIR("attr",      S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
--- linux.orig/fs/proc/internal.h	2018-12-23 20:08:14.228919325 +0800
+++ linux/fs/proc/internal.h	2018-12-23 20:08:14.224919327 +0800
@@ -298,6 +298,7 @@ extern const struct file_operations proc
 extern const struct file_operations proc_pid_smaps_rollup_operations;
 extern const struct file_operations proc_clear_refs_operations;
 extern const struct file_operations proc_pagemap_operations;
+extern const struct file_operations proc_mm_idle_operations;
 
 extern unsigned long task_vsize(struct mm_struct *);
 extern unsigned long task_statm(struct mm_struct *,
--- linux.orig/fs/proc/task_mmu.c	2018-12-23 20:08:14.228919325 +0800
+++ linux/fs/proc/task_mmu.c	2018-12-23 20:08:14.224919327 +0800
@@ -1559,6 +1559,60 @@ const struct file_operations proc_pagema
 	.open		= pagemap_open,
 	.release	= pagemap_release,
 };
+
+/* will be filled when kvm_ept_idle module loads */
+struct file_operations proc_ept_idle_operations = {
+};
+EXPORT_SYMBOL_GPL(proc_ept_idle_operations);
+
+static ssize_t mm_idle_read(struct file *file, char __user *buf,
+			    size_t count, loff_t *ppos)
+{
+	if (proc_ept_idle_operations.read)
+		return proc_ept_idle_operations.read(file, buf, count, ppos);
+
+	return 0;
+}
+
+
+static int mm_idle_open(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm = proc_mem_open(inode, PTRACE_MODE_READ);
+
+	if (IS_ERR(mm))
+		return PTR_ERR(mm);
+
+	file->private_data = mm;
+
+	if (proc_ept_idle_operations.open)
+		return proc_ept_idle_operations.open(inode, file);
+
+	return 0;
+}
+
+static int mm_idle_release(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm = file->private_data;
+
+	if (mm) {
+		if (!mm_kvm(mm))
+			flush_tlb_mm(mm);
+		mmdrop(mm);
+	}
+
+	if (proc_ept_idle_operations.release)
+		return proc_ept_idle_operations.release(inode, file);
+
+	return 0;
+}
+
+const struct file_operations proc_mm_idle_operations = {
+	.llseek		= mem_lseek, /* borrow this */
+	.read		= mm_idle_read,
+	.open		= mm_idle_open,
+	.release	= mm_idle_release,
+};
+
 #endif /* CONFIG_PROC_PAGE_MONITOR */
 
 #ifdef CONFIG_NUMA


