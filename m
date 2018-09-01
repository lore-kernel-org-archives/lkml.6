Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB28C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8392720843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8392720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeIBGfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 02:35:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:13095 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeIBGfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 02:35:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 19:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,318,1531810800"; 
   d="scan'208";a="80211550"
Received: from dbxu-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.218])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2018 19:20:58 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fwI0X-0003Zi-6a; Sun, 02 Sep 2018 10:20:57 +0800
Message-Id: <20180901124811.591511876@intel.com>
User-Agent: quilt/0.63-1
Date:   Sat, 01 Sep 2018 19:28:21 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Peng DongX <dongx.peng@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
CC:     Dave Hansen <dave.hansen@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Brendan Gregg <bgregg@netflix.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 3/5] [PATCH 3/5] kvm-ept-idle: HVA indexed EPT read
References: <20180901112818.126790961@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0003-kvm-ept-idle-HVA-indexed-EPT-read.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For virtual machines, "accessed" bits will be set in guest page tables
and EPT/NPT. So for qemu-kvm process, convert HVA to GFN to GPA, then do
EPT/NPT walks. Thanks to the in-memslot linear HVA-GPA mapping, the conversion
can be done efficiently, outside of the loops for page table walks.

In this manner, we provide uniform interface for both virtual machines and
normal processes.

The use scenario would be per task/VM working set tracking and migration.
Very convenient for applying task/vma and VM granularity policies.

Signed-off-by: Peng DongX <dongx.peng@intel.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 arch/x86/kvm/ept_idle.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/ept_idle.h |  24 ++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 arch/x86/kvm/ept_idle.c
 create mode 100644 arch/x86/kvm/ept_idle.h

diff --git a/arch/x86/kvm/ept_idle.c b/arch/x86/kvm/ept_idle.c
new file mode 100644
index 000000000000..5b97dd01011b
--- /dev/null
+++ b/arch/x86/kvm/ept_idle.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <linux/bitmap.h>
+
+#include "ept_idle.h"
+
+
+// mindless copy from kvm_handle_hva_range().
+// TODO: handle order and hole.
+static int ept_idle_walk_hva_range(struct ept_idle_ctrl *eic,
+				   unsigned long start,
+				   unsigned long end)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+	int ret = 0;
+
+	slots = kvm_memslots(eic->kvm);
+	kvm_for_each_memslot(memslot, slots) {
+		unsigned long hva_start, hva_end;
+		gfn_t gfn_start, gfn_end;
+
+		hva_start = max(start, memslot->userspace_addr);
+		hva_end = min(end, memslot->userspace_addr +
+			      (memslot->npages << PAGE_SHIFT));
+		if (hva_start >= hva_end)
+			continue;
+		/*
+		 * {gfn(page) | page intersects with [hva_start, hva_end)} =
+		 * {gfn_start, gfn_start+1, ..., gfn_end-1}.
+		 */
+		gfn_start = hva_to_gfn_memslot(hva_start, memslot);
+		gfn_end = hva_to_gfn_memslot(hva_end + PAGE_SIZE - 1, memslot);
+
+		ret = ept_idle_walk_gfn_range(eic, gfn_start, gfn_end);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static ssize_t ept_idle_read(struct file *file, char *buf,
+			     size_t count, loff_t *ppos)
+{
+	struct task_struct *task = file->private_data;
+	struct ept_idle_ctrl *eic;
+	unsigned long hva_start = *ppos << BITMAP_BYTE2PVA_SHIFT;
+	unsigned long hva_end = hva_start + (count << BITMAP_BYTE2PVA_SHIFT);
+	int ret;
+
+	if (*ppos % IDLE_BITMAP_CHUNK_SIZE ||
+	    count % IDLE_BITMAP_CHUNK_SIZE)
+		return -EINVAL;
+
+	eic = kzalloc(sizeof(*eic), GFP_KERNEL);
+	if (!eic)
+		return -EBUSY;
+
+	eic->buf = buf;
+	eic->buf_size = count;
+	eic->kvm = task_kvm(task);
+	if (!eic->kvm) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	ret = ept_idle_walk_hva_range(eic, hva_start, hva_end);
+	if (ret)
+		goto out_free;
+
+	ret = eic->bytes_copied;
+	*ppos += ret;
+out_free:
+	kfree(eic);
+
+	return ret;
+}
+
+static int ept_idle_open(struct inode *inode, struct file *file)
+{
+	if (!try_module_get(THIS_MODULE))
+		return -EBUSY;
+
+	return 0;
+}
+
+static int ept_idle_release(struct inode *inode, struct file *file)
+{
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+extern struct file_operations proc_ept_idle_operations;
+
+static int ept_idle_entry(void)
+{
+	proc_ept_idle_operations.owner = THIS_MODULE;
+	proc_ept_idle_operations.read = ept_idle_read;
+	proc_ept_idle_operations.open = ept_idle_open;
+	proc_ept_idle_operations.release = ept_idle_release;
+
+	return 0;
+}
+
+static void ept_idle_exit(void)
+{
+	memset(&proc_ept_idle_operations, 0, sizeof(proc_ept_idle_operations));
+}
+
+MODULE_LICENSE("GPL");
+module_init(ept_idle_entry);
+module_exit(ept_idle_exit);
diff --git a/arch/x86/kvm/ept_idle.h b/arch/x86/kvm/ept_idle.h
new file mode 100644
index 000000000000..e0b9dcecf50b
--- /dev/null
+++ b/arch/x86/kvm/ept_idle.h
@@ -0,0 +1,24 @@
+#ifndef _EPT_IDLE_H
+#define _EPT_IDLE_H
+
+#define IDLE_BITMAP_CHUNK_SIZE	sizeof(u64)
+#define IDLE_BITMAP_CHUNK_BITS	(IDLE_BITMAP_CHUNK_SIZE * BITS_PER_BYTE)
+
+#define BITMAP_BYTE2PVA_SHIFT  (3 + PAGE_SHIFT)
+
+#define EPT_IDLE_KBUF_FULL 1
+#define EPT_IDLE_KBUF_BYTES 8000
+#define EPT_IDLE_KBUF_BITS  (EPT_IDLE_KBUF_BYTES * 8)
+
+struct ept_idle_ctrl {
+	struct kvm *kvm;
+
+	u64 kbuf[EPT_IDLE_KBUF_BITS / IDLE_BITMAP_CHUNK_BITS];
+	int bits_read;
+
+	void __user *buf;
+	int buf_size;
+	int bytes_copied;
+};
+
+#endif
-- 
2.15.0



