Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2652C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B1A208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B1A208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933682AbeFTWJm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:09:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:19370 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933642AbeFTWJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:09:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 15:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="66312721"
Received: from linksys13920.jf.intel.com (HELO rpedgeco-HP-Z240-Tower-Workstation.jf.intel.com) ([10.7.197.56])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2018 15:09:33 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Cc:     kristen.c.accardi@intel.com, dave.hansen@intel.com,
        arjan.van.de.ven@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 3/3] vmalloc: Add debugfs modfraginfo
Date:   Wed, 20 Jun 2018 15:09:30 -0700
Message-Id: <1529532570-21765-4-git-send-email-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs file "modfraginfo" for providing info on module space
fragmentation.  This can be used for determining if loadable module
randomization is causing any problems for extreme module loading situations,
like huge numbers of modules or extremely large modules.

Sample output when RANDOMIZE_BASE and X86_64 is configured:
Largest free space:		847253504
External Memory Fragementation:	20%
Allocations in backup area:	0

Sample output otherwise:
Largest free space:		847253504
External Memory Fragementation:	20%

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 mm/vmalloc.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9e0820c9..afb8fe9 100644
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
 
@@ -2785,7 +2787,113 @@ static int __init proc_vmalloc_init(void)
 		proc_create_seq("vmallocinfo", 0400, NULL, &vmalloc_op);
 	return 0;
 }
-module_init(proc_vmalloc_init);
+#else
+static int proc_vmalloc_init(void)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_DEBUG_FS
+#if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_X86_64)
+static void print_backup_area(struct seq_file *m, unsigned long backup_cnt)
+{
+	if (kaslr_enabled())
+		seq_printf(m, "Allocations in backup area:\t%lu\n", backup_cnt);
+}
+static unsigned long get_backup_start(void)
+{
+	return MODULES_VADDR + MODULES_RAND_LEN;
+}
+#else
+static void print_backup_area(struct seq_file *m, unsigned long backup_cnt)
+{
+}
+static unsigned long get_backup_start(void)
+{
+	return 0;
+}
+#endif
+
+static int modulefraginfo_debug_show(struct seq_file *m, void *v)
+{
+	struct list_head *i;
+	unsigned long last_end = MODULES_VADDR;
+	unsigned long total_free = 0;
+	unsigned long largest_free = 0;
+	unsigned long backup_cnt = 0;
+	unsigned long gap;
+
+	spin_lock(&vmap_area_lock);
+
+	list_for_each(i, &vmap_area_list) {
+		struct vmap_area *obj = list_entry(i, struct vmap_area, list);
+
+		if (!(obj->flags & VM_LAZY_FREE)
+			&& obj->va_start >= MODULES_VADDR
+			&& obj->va_end <= MODULES_END) {
+
+			if (obj->va_start >= get_backup_start())
+				backup_cnt++;
+
+			gap = (obj->va_start - last_end);
+			if (gap > largest_free)
+				largest_free = gap;
+			total_free += gap;
+
+			last_end = obj->va_end;
+		}
+	}
+
+	gap = (MODULES_END - last_end);
+	if (gap > largest_free)
+		largest_free = gap;
+	total_free += gap;
+
+	spin_unlock(&vmap_area_lock);
+
+	seq_printf(m, "Largest free space:\t\t%lu\n", largest_free);
+	if (total_free)
+		seq_printf(m, "External Memory Fragementation:\t%lu%%\n",
+			100-(100*largest_free/total_free));
+	else
+		seq_puts(m, "External Memory Fragementation:\t0%%\n");
+
+	print_backup_area(m, backup_cnt);
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
 
+static void debug_modfrag_init(void)
+{
+	debugfs_create_file("modfraginfo", 0x0400, NULL, NULL,
+			&debug_module_frag_operations);
+}
+#else
+static void debug_modfrag_init(void)
+{
+}
 #endif
 
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

