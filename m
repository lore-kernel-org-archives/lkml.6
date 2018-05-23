Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933285AbeEWO2J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:28:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58486 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754329AbeEWO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:28:06 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: jgross@suse.com, JBeulich@suse.com, brgerst@gmail.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v5 1/2] xen/PVH: Set up GS segment for stack canary
Date: Wed, 23 May 2018 10:30:01 -0400
Message-Id: <20180523143002.29252-2-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523143002.29252-1-boris.ostrovsky@oracle.com>
References: <20180523143002.29252-1-boris.ostrovsky@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8901 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805230146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are making calls to C code (e.g. xen_prepare_pvh()) which may use
stack canary (stored in GS segment).

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/xen-pvh.S | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index e1a5fbe..d6a17b9 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -54,6 +54,9 @@
  * charge of setting up it's own stack, GDT and IDT.
  */
 
+#define PVH_GDT_ENTRY_CANARY	4
+#define PVH_CANARY_SEL		(PVH_GDT_ENTRY_CANARY * 8)
+
 ENTRY(pvh_start_xen)
 	cld
 
@@ -98,6 +101,12 @@ ENTRY(pvh_start_xen)
 	/* 64-bit entry point. */
 	.code64
 1:
+	/* Set base address in stack canary descriptor. */
+	mov $MSR_GS_BASE,%ecx
+	mov $_pa(canary), %rax
+	xor %rdx, %rdx
+	wrmsr
+
 	call xen_prepare_pvh
 
 	/* startup_64 expects boot_params in %rsi. */
@@ -107,6 +116,17 @@ ENTRY(pvh_start_xen)
 
 #else /* CONFIG_X86_64 */
 
+	/* Set base address in stack canary descriptor. */
+	movl $_pa(gdt_start),%eax
+	movl $_pa(canary),%ecx
+	movw %cx, (PVH_GDT_ENTRY_CANARY * 8) + 2(%eax)
+	shrl $16, %ecx
+	movb %cl, (PVH_GDT_ENTRY_CANARY * 8) + 4(%eax)
+	movb %ch, (PVH_GDT_ENTRY_CANARY * 8) + 7(%eax)
+
+	mov $PVH_CANARY_SEL,%eax
+	mov %eax,%gs
+
 	call mk_early_pgtbl_32
 
 	mov $_pa(initial_page_table), %eax
@@ -150,9 +170,13 @@ gdt_start:
 	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
 #endif
 	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* __KERNEL_DS */
+	.quad GDT_ENTRY(0x4090, 0, 0x18)    /* PVH_CANARY_SEL */
 gdt_end:
 
-	.balign 4
+	.balign 16
+canary:
+	.fill 48, 1, 0
+
 early_stack:
 	.fill 256, 1, 0
 early_stack_end:
-- 
2.9.3
