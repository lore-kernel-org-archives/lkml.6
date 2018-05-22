Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeEVDxC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:53:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37710 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeEVDw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:52:57 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: jgross@suse.com, JBeulich@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v4 1/2] xen/PVH: Set up GS segment for stack canary
Date: Mon, 21 May 2018 23:54:44 -0400
Message-Id: <20180522035445.16911-2-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180522035445.16911-1-boris.ostrovsky@oracle.com>
References: <20180522035445.16911-1-boris.ostrovsky@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8900 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805220044
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are making calls to C code (e.g. xen_prepare_pvh()) which may use
stack canary (stored in GS segment).

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/xen/xen-pvh.S | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index e1a5fbe..0169374 100644
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
+	mov $canary, %rax
+	cdq
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
