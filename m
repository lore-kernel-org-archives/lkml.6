Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EAAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0482520647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0482520647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeH3C7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:59:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:60439 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbeH3C7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:59:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 15:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,305,1531810800"; 
   d="scan'208";a="85609402"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.168])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2018 15:59:42 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v4 3/3] vmalloc: Add debugfs modfraginfo
Date:   Wed, 29 Aug 2018 15:59:39 -0700
Message-Id: <1535583579-6138-4-git-send-email-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535583579-6138-1-git-send-email-rick.p.edgecombe@intel.com>
References: <1535583579-6138-1-git-send-email-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs file "modfraginfo" for providing info on module space fragmentation.
This can be used for determining if loadable module randomization is causing any
problems for extreme module loading situations, like huge numbers of modules or
extremely large modules.

Sample output when KASLR is enabled and X86_64 is configured:
	Largest free space:	897912 kB
	  Total free space:	1025424 kB
Allocations in backup area:	0

Sample output when just X86_64:
	Largest free space:	897912 kB
	  Total free space:	1025424 kB

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 mm/vmalloc.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1954458..a44b902 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/debugfs.h>
 #include <linux/debugobjects.h>
 #include <linux/kallsyms.h>
 #include <linux/list.h>
@@ -33,6 +34,7 @@
 #include <linux/bitops.h>
 
 #include <linux/uaccess.h>
+#include <asm/setup.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
@@ -2919,7 +2921,105 @@ static int __init proc_vmalloc_init(void)
 		proc_create_seq("vmallocinfo", 0400, NULL, &vmalloc_op);
 	return 0;
 }
-module_init(proc_vmalloc_init);
+#else
+static int __init proc_vmalloc_init(void)
+{
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_X86_64)
+static inline unsigned long is_in_backup(unsigned long addr)
+{
+	return addr >= MODULES_VADDR + MODULES_RAND_LEN;
+}
+#else
+static inline unsigned long is_in_backup(unsigned long addr)
+{
+	return 0;
+}
 
+inline bool kaslr_enabled(void);
 #endif
 
+
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_X86_64)
+static int modulefraginfo_debug_show(struct seq_file *m, void *v)
+{
+	unsigned long last_end = MODULES_VADDR;
+	unsigned long total_free = 0;
+	unsigned long largest_free = 0;
+	unsigned long backup_cnt = 0;
+	unsigned long gap;
+	struct vmap_area *prev, *cur = NULL;
+
+	spin_lock(&vmap_area_lock);
+
+	if (!pvm_find_next_prev(MODULES_VADDR, &cur, &prev) || !cur)
+		goto done;
+
+	for (; cur->va_end <= MODULES_END; cur = list_next_entry(cur, list)) {
+		/* Don't count areas that are marked to be lazily freed */
+		if (!(cur->flags & VM_LAZY_FREE)) {
+			backup_cnt += is_in_backup(cur->va_start);
+			gap = cur->va_start - last_end;
+			if (gap > largest_free)
+				largest_free = gap;
+			total_free += gap;
+			last_end = cur->va_end;
+		}
+
+		if (list_is_last(&cur->list, &vmap_area_list))
+			break;
+	}
+
+done:
+	gap = (MODULES_END - last_end);
+	if (gap > largest_free)
+		largest_free = gap;
+	total_free += gap;
+
+	spin_unlock(&vmap_area_lock);
+
+	seq_printf(m, "\tLargest free space:\t%lu kB\n", largest_free / 1024);
+	seq_printf(m, "\t  Total free space:\t%lu kB\n", total_free / 1024);
+
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
+		seq_printf(m, "Allocations in backup area:\t%lu\n", backup_cnt);
+
+	return 0;
+}
+
+static int proc_module_frag_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, modulefraginfo_debug_show, NULL);
+}
+
+static const struct file_operations debug_module_frag_operations = {
+	.open       = proc_module_frag_debug_open,
+	.read       = seq_read,
+	.llseek     = seq_lseek,
+	.release    = single_release,
+};
+
+static void __init debug_modfrag_init(void)
+{
+	debugfs_create_file("modfraginfo", 0400, NULL, NULL,
+			&debug_module_frag_operations);
+}
+#else /* defined(CONFIG_DEBUG_FS) && defined(CONFIG_X86_64) */
+static void __init debug_modfrag_init(void)
+{
+}
+#endif
+
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_PROC_FS)
+static int __init info_vmalloc_init(void)
+{
+	proc_vmalloc_init();
+	debug_modfrag_init();
+	return 0;
+}
+
+module_init(info_vmalloc_init);
+#endif
-- 
2.7.4

