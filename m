Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5ECC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1090120843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1090120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeIBGfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 02:35:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:24782 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbeIBGfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 02:35:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 19:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,318,1531810800"; 
   d="scan'208";a="77329555"
Received: from dbxu-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.218])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Sep 2018 19:20:58 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fwI0X-0003Ze-5w; Sun, 02 Sep 2018 10:20:57 +0800
Message-Id: <20180901124811.530300789@intel.com>
User-Agent: quilt/0.63-1
Date:   Sat, 01 Sep 2018 19:28:20 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Huang Ying <ying.huang@intel.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     Peng DongX <dongx.peng@intel.com>
cc:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
CC:     Dave Hansen <dave.hansen@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 2/5] [PATCH 2/5] proc: introduce /proc/PID/idle_bitmap
References: <20180901112818.126790961@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0002-proc-introduce-proc-PID-idle_bitmap.patch
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
 fs/proc/base.c     |  2 ++
 fs/proc/internal.h |  1 +
 fs/proc/task_mmu.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index aaffc0c30216..d81322b5b8d2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2942,6 +2942,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("smaps",      S_IRUGO, proc_pid_smaps_operations),
 	REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
 	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
+	REG("idle_bitmap", S_IRUSR|S_IWUSR, proc_mm_idle_operations),
 #endif
 #ifdef CONFIG_SECURITY
 	DIR("attr",       S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
@@ -3327,6 +3328,7 @@ static const struct pid_entry tid_base_stuff[] = {
 	REG("smaps",     S_IRUGO, proc_tid_smaps_operations),
 	REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
 	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
+	REG("idle_bitmap", S_IRUSR|S_IWUSR, proc_mm_idle_operations),
 #endif
 #ifdef CONFIG_SECURITY
 	DIR("attr",      S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index da3dbfa09e79..732a502acc27 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -305,6 +305,7 @@ extern const struct file_operations proc_pid_smaps_rollup_operations;
 extern const struct file_operations proc_tid_smaps_operations;
 extern const struct file_operations proc_clear_refs_operations;
 extern const struct file_operations proc_pagemap_operations;
+extern const struct file_operations proc_mm_idle_operations;
 
 extern unsigned long task_vsize(struct mm_struct *);
 extern unsigned long task_statm(struct mm_struct *,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index dfd73a4616ce..376406a9cf45 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1564,6 +1564,69 @@ const struct file_operations proc_pagemap_operations = {
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
+	struct task_struct *task = file->private_data;
+	ssize_t ret = -ESRCH;
+
+	// TODO: implement mm_walk for normal tasks
+
+	if (task_kvm(task)) {
+		if (proc_ept_idle_operations.read)
+			return proc_ept_idle_operations.read(file, buf, count, ppos);
+	}
+
+	return ret;
+}
+
+
+static int mm_idle_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *task = get_proc_task(inode);
+
+	if (!task)
+		return -ESRCH;
+
+	file->private_data = task;
+
+	if (task_kvm(task)) {
+		if (proc_ept_idle_operations.open)
+			return proc_ept_idle_operations.open(inode, file);
+	}
+
+	return 0;
+}
+
+static int mm_idle_release(struct inode *inode, struct file *file)
+{
+	struct task_struct *task = file->private_data;
+
+	if (!task)
+		return 0;
+
+	if (task_kvm(task)) {
+		if (proc_ept_idle_operations.release)
+			return proc_ept_idle_operations.release(inode, file);
+	}
+
+	put_task_struct(task);
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
-- 
2.15.0



