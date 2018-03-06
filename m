Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELvb1tbKEyTq6Vt23qn9bX96k1h3xAN+Cj/ejeEoLd0bRp2/CdcFVU0IjbUZjoziNR+Glos3
ARC-Seal: i=1; a=rsa-sha256; t=1520295990; cv=none;
        d=google.com; s=arc-20160816;
        b=U4fUFXE3sb0WTY2GNhdlKTgNBn5ySYHvowky2ULixJN3LC3oI8Mycyv1ZJ5gmGRlNK
         EYhGtUoTxvH3fzOtzvvX6rSZMNe51c5C2ReVpKS6lox616717KGc2ZU2ILrIcobbGDNp
         E/L6QUCPv7oRbB0HIN44iXHpjaEigShVHnLAxhAv2lXebTk4hj9y2+vu04uw+6INgn8b
         IUjLTELhsDhihMrOJ8dN8nFicL4uJgN/zrzW099AyzDZ7iWzg1ccIswl+nDSmf4G7wCk
         yqTzbqyJMFitaCq2JUHqS5Ks43KQOZUKHjJYqarRXygFp1V64UmOYvXjtnKdDbvHXRj0
         M1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=+jNj5dPcyp9GnEobcMFqRbimfPH/MIVzibsZ8/rhCZU=;
        b=0XlfZOhE//Eb6pkkzLtw94tzoMeBMxnW/IgMibbZVSn7SnvLpe6gKLv5+n6W7pPn1n
         ggqmuEWNyt343SJn93ocdyPP6iN/jDHT64IvEqqHoOn/NNrPPg6/bk386nz/K0r7ncj7
         QXYko5FllydFBqyKkz/rNVsG/aYK6lFo/Af0LKWU9PK18WoE0EjFZGKPQ6G6gnfor5T4
         GudVy8oviIgT594SpZkV8ve3XtVckw3tGaQ0V9FsNsfRUKafOyTEeFsApd+cAAjmtTsk
         0vBXbCnttmz1/fKhig7Mk6As9xSIbgcT814FZYU19bMYwA/ldx3/V52bR7vaYZvu2xIm
         5Dxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=QCJnSFLf;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=QCJnSFLf;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 33/65] kaiser: fix perf crashes
Date: Mon,  5 Mar 2018 19:25:06 -0500
Message-Id: <20180306002538.1761-34-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145888310989363?=
X-GMAIL-MSGID: =?utf-8?q?1594145888310989363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Avoid perf crashes: place debug_store in the user-mapped per-cpu area
instead of allocating, and use page allocator plus kaiser_add_mapping()
to keep the BTS and PEBS buffers user-mapped (that is, present in the
user mapping, though visible only to kernel and hardware).  The PEBS
fixup buffer does not need this treatment.

The need for a user-mapped struct debug_store showed up before doing
any conscious perf testing: in a couple of kernel paging oopses on
Westmere, implicating the debug_store offset of the per-cpu area.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 20cbe9a3aa2e341824da57ce0ac6d52cbffaa570)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/kernel/cpu/perf_event_intel_ds.c
---
 arch/x86/kernel/cpu/perf_event_intel_ds.c | 57 ++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_intel_ds.c b/arch/x86/kernel/cpu/perf_event_intel_ds.c
index 7f73b3553e2e..e4f109a7ed9a 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_ds.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_ds.c
@@ -2,11 +2,15 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
+#include <asm/kaiser.h>
 #include <asm/perf_event.h>
 #include <asm/insn.h>
 
 #include "perf_event.h"
 
+static
+DEFINE_PER_CPU_SHARED_ALIGNED_USER_MAPPED(struct debug_store, cpu_debug_store);
+
 /* The size of a BTS record in bytes: */
 #define BTS_RECORD_SIZE		24
 
@@ -246,6 +250,39 @@ void fini_debug_store_on_cpu(int cpu)
 
 static DEFINE_PER_CPU(void *, insn_buffer);
 
+static void *dsalloc(size_t size, gfp_t flags, int node)
+{
+#ifdef CONFIG_KAISER
+	unsigned int order = get_order(size);
+	struct page *page;
+	unsigned long addr;
+
+	page = alloc_pages_node(node, flags | __GFP_ZERO, order);
+	if (!page)
+		return NULL;
+	addr = (unsigned long)page_address(page);
+	if (kaiser_add_mapping(addr, size, __PAGE_KERNEL) < 0) {
+		__free_pages(page, order);
+		addr = 0;
+	}
+	return (void *)addr;
+#else
+	return kmalloc_node(size, flags | __GFP_ZERO, node);
+#endif
+}
+
+static void dsfree(const void *buffer, size_t size)
+{
+#ifdef CONFIG_KAISER
+	if (!buffer)
+		return;
+	kaiser_remove_mapping((unsigned long)buffer, size);
+	free_pages((unsigned long)buffer, get_order(size));
+#else
+	kfree(buffer);
+#endif
+}
+
 static int alloc_pebs_buffer(int cpu)
 {
 	struct debug_store *ds = per_cpu(cpu_hw_events, cpu).ds;
@@ -256,7 +293,7 @@ static int alloc_pebs_buffer(int cpu)
 	if (!x86_pmu.pebs)
 		return 0;
 
-	buffer = kzalloc_node(PEBS_BUFFER_SIZE, GFP_KERNEL, node);
+	buffer = dsalloc(PEBS_BUFFER_SIZE, GFP_KERNEL, node);
 	if (unlikely(!buffer))
 		return -ENOMEM;
 
@@ -267,7 +304,7 @@ static int alloc_pebs_buffer(int cpu)
 	if (x86_pmu.intel_cap.pebs_format < 2) {
 		ibuffer = kzalloc_node(PEBS_FIXUP_SIZE, GFP_KERNEL, node);
 		if (!ibuffer) {
-			kfree(buffer);
+			dsfree(buffer, PEBS_BUFFER_SIZE);
 			return -ENOMEM;
 		}
 		per_cpu(insn_buffer, cpu) = ibuffer;
@@ -296,7 +333,8 @@ static void release_pebs_buffer(int cpu)
 	kfree(per_cpu(insn_buffer, cpu));
 	per_cpu(insn_buffer, cpu) = NULL;
 
-	kfree((void *)(unsigned long)ds->pebs_buffer_base);
+	dsfree((void *)(unsigned long)ds->pebs_buffer_base,
+			PEBS_BUFFER_SIZE);
 	ds->pebs_buffer_base = 0;
 }
 
@@ -310,7 +348,7 @@ static int alloc_bts_buffer(int cpu)
 	if (!x86_pmu.bts)
 		return 0;
 
-	buffer = kzalloc_node(BTS_BUFFER_SIZE, GFP_KERNEL | __GFP_NOWARN, node);
+	buffer = dsalloc(BTS_BUFFER_SIZE, GFP_KERNEL | __GFP_NOWARN, node);
 	if (unlikely(!buffer)) {
 		WARN_ONCE(1, "%s: BTS buffer allocation failure\n", __func__);
 		return -ENOMEM;
@@ -336,19 +374,15 @@ static void release_bts_buffer(int cpu)
 	if (!ds || !x86_pmu.bts)
 		return;
 
-	kfree((void *)(unsigned long)ds->bts_buffer_base);
+	dsfree((void *)(unsigned long)ds->bts_buffer_base, BTS_BUFFER_SIZE);
 	ds->bts_buffer_base = 0;
 }
 
 static int alloc_ds_buffer(int cpu)
 {
-	int node = cpu_to_node(cpu);
-	struct debug_store *ds;
-
-	ds = kzalloc_node(sizeof(*ds), GFP_KERNEL, node);
-	if (unlikely(!ds))
-		return -ENOMEM;
+	struct debug_store *ds = per_cpu_ptr(&cpu_debug_store, cpu);
 
+	memset(ds, 0, sizeof(*ds));
 	per_cpu(cpu_hw_events, cpu).ds = ds;
 
 	return 0;
@@ -362,7 +396,6 @@ static void release_ds_buffer(int cpu)
 		return;
 
 	per_cpu(cpu_hw_events, cpu).ds = NULL;
-	kfree(ds);
 }
 
 void release_ds_buffers(void)
-- 
2.16.2
