Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934624AbeEILpT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:45:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934376AbeEILpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:45:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54445882"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH RFC 04/19] x86: kcore: Give entry trampolines all the same offset in kcore
Date: Wed,  9 May 2018 14:43:33 +0300
Message-Id: <1525866228-30321-5-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entry trampolines all map to the same page.  Represent that by giving the
corresponding program headers in kcore the same offset.

This has the benefit that, when perf tools uses /proc/kcore as a source for
kernel object code, samples from different CPU trampolines are aggregated
together.  Note, such aggregation is normal for profiling i.e. people want
to profile the object code, not every different virtual address the object
code might be mapped to (across different processes for example).

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/mm/cpu_entry_area.c |  6 +++---
 fs/proc/kcore.c              |  7 +++++--
 include/linux/kcore.h        | 13 +++++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index fb1fbc8538fa..faea80e9bbd2 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -149,9 +149,9 @@ static void __init setup_cpu_entry_area(int cpu)
 
 	cea_set_pte(&get_cpu_entry_area(cpu)->entry_trampoline,
 		     __pa_symbol(_entry_trampoline), PAGE_KERNEL_RX);
-	kclist_add(&per_cpu(kcore_entry_trampoline, cpu),
-		   &get_cpu_entry_area(cpu)->entry_trampoline, PAGE_SIZE,
-		   KCORE_TEXT);
+	kclist_add_remap(&per_cpu(kcore_entry_trampoline, cpu),
+			 _entry_trampoline,
+			 &get_cpu_entry_area(cpu)->entry_trampoline, PAGE_SIZE);
 #endif
 	percpu_setup_debug_store(cpu);
 }
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index d1e82761de81..b5e02b0379ca 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -374,8 +374,11 @@ static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
 		phdr->p_type	= PT_LOAD;
 		phdr->p_flags	= PF_R|PF_W|PF_X;
 		phdr->p_offset	= kc_vaddr_to_offset(m->addr) + dataoff;
-		phdr->p_vaddr	= (size_t)m->addr;
-		if (m->type == KCORE_RAM || m->type == KCORE_TEXT)
+		if (m->type == KCORE_REMAP)
+			phdr->p_vaddr	= (size_t)m->vaddr;
+		else
+			phdr->p_vaddr	= (size_t)m->addr;
+		if (m->type == KCORE_RAM || m->type == KCORE_TEXT || m->type == KCORE_REMAP)
 			phdr->p_paddr	= __pa(m->addr);
 		else
 			phdr->p_paddr	= (elf_addr_t)-1;
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 80db19d3a505..3a11ce51e137 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -12,11 +12,13 @@ enum kcore_type {
 	KCORE_VMEMMAP,
 	KCORE_USER,
 	KCORE_OTHER,
+	KCORE_REMAP,
 };
 
 struct kcore_list {
 	struct list_head list;
 	unsigned long addr;
+	unsigned long vaddr;
 	size_t size;
 	int type;
 };
@@ -30,11 +32,22 @@ struct vmcore {
 
 #ifdef CONFIG_PROC_KCORE
 extern void kclist_add(struct kcore_list *, void *, size_t, int type);
+static inline
+void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
+{
+	m->vaddr = (unsigned long)vaddr;
+	kclist_add(m, addr, sz, KCORE_REMAP);
+}
 #else
 static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 {
 }
+
+static inline
+void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
+{
+}
 #endif
 
 #endif /* _LINUX_KCORE_H */
-- 
1.9.1
