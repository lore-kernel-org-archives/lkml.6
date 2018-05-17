Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeEQOpa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:45:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60724 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeEQOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:45:06 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: jgross@suse.com, JBeulich@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v3 2/2] xen/PVH: Make GDT selectors PVH-specific
Date: Thu, 17 May 2018 10:47:23 -0400
Message-Id: <20180517144723.21585-3-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180517144723.21585-1-boris.ostrovsky@oracle.com>
References: <20180517144723.21585-1-boris.ostrovsky@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8895 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=617
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805170136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to share PVH GDT layout with other GDTs, especially
since we now have a PVH-speciific entry (for stack canary segment).

Define PVH's own selectors.

(As a side effect of this change we are also fixing improper
reference to __KERNEL_CS)

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/xen/xen-pvh.S | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index 0db540c..f09350a 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -54,7 +54,11 @@
  * charge of setting up it's own stack, GDT and IDT.
  */
 
-#define PVH_GDT_ENTRY_CANARY	4
+#define PVH_GDT_ENTRY_CS	1
+#define PVH_GDT_ENTRY_DS	2
+#define PVH_GDT_ENTRY_CANARY	3
+#define PVH_CS_SEL		(PVH_GDT_ENTRY_CS * 8)
+#define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
 #define PVH_CANARY_SEL		(PVH_GDT_ENTRY_CANARY * 8)
 
 ENTRY(pvh_start_xen)
@@ -62,7 +66,7 @@ ENTRY(pvh_start_xen)
 
 	lgdt (_pa(gdt))
 
-	mov $(__BOOT_DS),%eax
+	mov $PVH_DS_SEL,%eax
 	mov %eax,%ds
 	mov %eax,%es
 	mov %eax,%ss
@@ -99,7 +103,7 @@ ENTRY(pvh_start_xen)
 	mov %eax, %cr0
 
 	/* Jump to 64-bit mode. */
-	ljmp $__KERNEL_CS, $_pa(1f)
+	ljmp $PVH_CS_SEL, $_pa(1f)
 
 	/* 64-bit entry point. */
 	.code64
@@ -136,13 +140,13 @@ ENTRY(pvh_start_xen)
 	or $(X86_CR0_PG | X86_CR0_PE), %eax
 	mov %eax, %cr0
 
-	ljmp $__BOOT_CS, $1f
+	ljmp $PVH_CS_SEL, $1f
 1:
 	call xen_prepare_pvh
 	mov $_pa(pvh_bootparams), %esi
 
 	/* startup_32 doesn't expect paging and PAE to be on. */
-	ljmp $__BOOT_CS, $_pa(2f)
+	ljmp $PVH_CS_SEL, $_pa(2f)
 2:
 	mov %cr0, %eax
 	and $~X86_CR0_PG, %eax
@@ -151,7 +155,7 @@ ENTRY(pvh_start_xen)
 	and $~X86_CR4_PAE, %eax
 	mov %eax, %cr4
 
-	ljmp $__BOOT_CS, $_pa(startup_32)
+	ljmp $PVH_CS_SEL, $_pa(startup_32)
 #endif
 END(pvh_start_xen)
 
@@ -163,13 +167,12 @@ gdt:
 	.word 0
 gdt_start:
 	.quad 0x0000000000000000            /* NULL descriptor */
-	.quad 0x0000000000000000            /* reserved */
 #ifdef CONFIG_X86_64
-	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* __KERNEL_CS */
+	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* PVH_CS_SEL */
 #else
-	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
+	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* PVH_CS_SEL */
 #endif
-	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* __KERNEL_DS */
+	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* PVH_DS_SEL */
 	.quad GDT_ENTRY(0x4090, 0, 0x18)    /* PVH_CANARY_SEL */
 gdt_end:
 
-- 
2.9.3
