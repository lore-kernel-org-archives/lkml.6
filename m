Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeDISpT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:45:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38196 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeDISpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:45:18 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] xen/pvh: Indicate XENFEAT_linux_rsdp_unrestricted to Xen
Date: Mon,  9 Apr 2018 14:51:44 -0400
Message-Id: <1523299904-18199-1-git-send-email-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8858 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804090189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pre-4.17 kernels ignored start_info's rsdp_paddr pointer and instead
relied on finding RSDP in standard location in BIOS RO memory. This
has worked since that's where Xen used to place it.

However, with recent Xen change (commit 4a5733771e6f ("libxl: put RSDP
for PVH guest near 4GB")) it prefers to keep RSDP at a "non-standard"
address. Even though as of commit b17d9d1df3c3 ("x86/xen: Add pvh
specific rsdp address retrieval function") Linux is able to find RSDP,
for back-compatibility reasons we need to indicate to Xen that we can
handle this, an we do so by setting XENFEAT_linux_rsdp_unrestricted
flag in ELF notes.

(Also take this opportunity and sync features.h header file with Xen)

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
XENFEAT_linux_rsdp_unrestricted inly makes sense for CONFIG_XEN_PVH but
I set it uncoditionally to avoid what I think is unnecessary ifdefery.

 arch/x86/xen/xen-head.S          |  4 +++-
 include/xen/interface/features.h | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 96f26e0..5077ead 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -89,7 +89,9 @@ END(hypercall_page)
 	ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,
 		.ascii "!writable_page_tables|pae_pgdir_above_4gb")
 	ELFNOTE(Xen, XEN_ELFNOTE_SUPPORTED_FEATURES,
-		.long (1 << XENFEAT_writable_page_tables) | (1 << XENFEAT_dom0))
+		.long (1 << XENFEAT_writable_page_tables) |       \
+		      (1 << XENFEAT_dom0) |                       \
+		      (1 << XENFEAT_linux_rsdp_unrestricted))
 	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz "yes")
 	ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz "generic")
 	ELFNOTE(Xen, XEN_ELFNOTE_L1_MFN_VALID,
diff --git a/include/xen/interface/features.h b/include/xen/interface/features.h
index 9b0eb57..6d1384a 100644
--- a/include/xen/interface/features.h
+++ b/include/xen/interface/features.h
@@ -42,6 +42,9 @@
 /* x86: Does this Xen host support the MMU_PT_UPDATE_PRESERVE_AD hypercall? */
 #define XENFEAT_mmu_pt_update_preserve_ad  5
 
+/* x86: Does this Xen host support the MMU_{CLEAR,COPY}_PAGE hypercall? */
+#define XENFEAT_highmem_assist             6
+
 /*
  * If set, GNTTABOP_map_grant_ref honors flags to be placed into guest kernel
  * available pte bits.
@@ -60,6 +63,26 @@
 /* operation as Dom0 is supported */
 #define XENFEAT_dom0                      11
 
+/* Xen also maps grant references at pfn = mfn.
+ * This feature flag is deprecated and should not be used.
+#define XENFEAT_grant_map_identity        12
+ */
+
+/* Guest can use XENMEMF_vnode to specify virtual node for memory op. */
+#define XENFEAT_memory_op_vnode_supported 13
+
+/* arm: Hypervisor supports ARM SMC calling convention. */
+#define XENFEAT_ARM_SMCCC_supported       14
+
+/*
+ * x86/PVH: If set, ACPI RSDP can be placed at any address. Otherwise RSDP
+ * must be located in lower 1MB, as required by ACPI Specification for IA-PC
+ * systems.
+ * This feature flag is only consulted if XEN_ELFNOTE_GUEST_OS contains
+ * the "linux" string.
+ */
+#define XENFEAT_linux_rsdp_unrestricted   15
+
 #define XENFEAT_NR_SUBMAPS 1
 
 #endif /* __XEN_PUBLIC_FEATURES_H__ */
-- 
1.8.3.1
