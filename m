Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408BDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1419B218D0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfABKyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:54:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbfABKyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:54:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D0D688E57;
        Wed,  2 Jan 2019 10:54:18 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED86B60123;
        Wed,  2 Jan 2019 10:54:10 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@redhat.com, hpa@zytor.com,
        jbohac@suse.cz, adobriyan@gmail.com, akpm@linux-foundation.org,
        osandov@fb.com, bhsharma@redhat.com, kasong@redhat.com,
        bhe@redhat.com, dyoung@redhat.com
Subject: [PATCH v2] x86/gart/kcore: Exclude GART aperture from kcore
Date:   Wed,  2 Jan 2019 18:54:07 +0800
Message-Id: <20190102105408.7124-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 02 Jan 2019 10:54:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On machines where the GART aperture is mapped over physical RAM,
/proc/kcore contains the GART aperture range and reading it may lead
to kernel panic.

In 'commit 2a3e83c6f96c ("x86/gart: Exclude GART aperture from vmcore")',
a special workaround is applied for vmcore to let /proc/vmcore return
zeroes when attempting to read the aperture region, as vmcore and kcore
have the same issue, and after 'commit 707d4eefbdb3 ("Revert "[PATCH]
Insert GART region into resource map"")', userspace tools can't detect and
exclude GART region.

This patch applies the same workaround for kcore. Let /proc/kcore return
zeroes too when trying to read the aperture region to fix the issue that
reading GART region may raise unexpected exceptions.

This applies to both first and second kernels as GART may get
initialized in the first and second kernels.

To get the same workaround work for kcore, this patch implement a hook
infrastructure for kcore which is same as the hook infrastructure for
vmcore introduced in 'commit 997c136f518c ("fs/proc/vmcore.c: add hook
to read_from_oldmem() to check for non-ram pages")'', and reuses the
checking function gart_oldmem_pfn_is_ram introduced in
'commit 2a3e83c6f96c ("x86/gart: Exclude GART aperture from vmcore"),'
as the hook function, but rename to gart_mem_pfn_is_ram as now it's
for a more generic use.

Suggested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
---
Update from V1:
- Fix a complie error when CONFIG_PROC_KCORE is not set

 arch/x86/kernel/aperture_64.c | 12 +++++++++---
 fs/proc/kcore.c               | 34 ++++++++++++++++++++++++++++++++++
 include/linux/kcore.h         |  3 +++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 58176b56354e..c8a56f083419 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) "AGP: " fmt
 
 #include <linux/kernel.h>
+#include <linux/kcore.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
@@ -57,7 +58,7 @@ int fallback_aper_force __initdata;
 
 int fix_aperture __initdata = 1;
 
-#ifdef CONFIG_PROC_VMCORE
+#if defined(CONFIG_PROC_VMCORE) || defined(CONFIG_PROC_KCORE)
 /*
  * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
  * use the same range because it will remain configured in the northbridge.
@@ -66,7 +67,7 @@ int fix_aperture __initdata = 1;
  */
 static unsigned long aperture_pfn_start, aperture_page_count;
 
-static int gart_oldmem_pfn_is_ram(unsigned long pfn)
+static int gart_mem_pfn_is_ram(unsigned long pfn)
 {
 	return likely((pfn < aperture_pfn_start) ||
 		      (pfn >= aperture_pfn_start + aperture_page_count));
@@ -76,7 +77,12 @@ static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
 {
 	aperture_pfn_start = aper_base >> PAGE_SHIFT;
 	aperture_page_count = (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
-	WARN_ON(register_oldmem_pfn_is_ram(&gart_oldmem_pfn_is_ram));
+#ifdef CONFIG_PROC_VMCORE
+	WARN_ON(register_oldmem_pfn_is_ram(&gart_mem_pfn_is_ram));
+#endif
+#ifdef CONFIG_PROC_KCORE
+	WARN_ON(register_mem_pfn_is_ram(&gart_mem_pfn_is_ram));
+#endif
 }
 #else
 static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index bbcc185062bb..24e13fcc31ea 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -54,6 +54,35 @@ static LIST_HEAD(kclist_head);
 static DECLARE_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
 
+static int (*mem_pfn_is_ram)(unsigned long pfn);
+
+int register_mem_pfn_is_ram(int (*fn)(unsigned long pfn))
+{
+	if (mem_pfn_is_ram)
+		return -EBUSY;
+	mem_pfn_is_ram = fn;
+	return 0;
+}
+
+void unregister_mem_pfn_is_ram(void)
+{
+	mem_pfn_is_ram = NULL;
+	wmb();
+}
+
+static int pfn_is_ram(unsigned long pfn)
+{
+	int (*fn)(unsigned long pfn);
+	/* pfn is ram unless fn() checks pagetype */
+	int ret = 1;
+
+	fn = mem_pfn_is_ram;
+	if (fn)
+		ret = fn(pfn);
+
+	return ret;
+}
+
 /* This doesn't grab kclist_lock, so it should only be used at init time. */
 void __init kclist_add(struct kcore_list *new, void *addr, size_t size,
 		       int type)
@@ -465,6 +494,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				goto out;
 			}
 			m = NULL;	/* skip the list anchor */
+		} else if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
+			if (clear_user(buffer, tsz)) {
+				ret = -EFAULT;
+				goto out;
+			}
 		} else if (m->type == KCORE_VMALLOC) {
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 8c3f8c14eeaa..2130a35f883b 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -44,6 +44,9 @@ void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
 	m->vaddr = (unsigned long)vaddr;
 	kclist_add(m, addr, sz, KCORE_REMAP);
 }
+
+extern int register_mem_pfn_is_ram(int (*fn)(unsigned long pfn));
+extern void unregister_mem_pfn_is_ram(void);
 #else
 static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
-- 
2.20.1

