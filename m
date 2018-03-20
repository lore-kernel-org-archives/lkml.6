Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeCTTUD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:20:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58850 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeCTTT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:19:58 -0400
From: Maran Wilson <maran.wilson@oracle.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, bp@suse.de, thomas.lendacky@amd.com,
        luto@kernel.org, dave.hansen@linux.intel.com, roger.pau@citrix.com,
        rkrcmar@redhat.com, maran.wilson@oracle.com
Subject: [PATCH v5 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and CONFIG_XEN_PVH
Date: Tue, 20 Mar 2018 12:18:06 -0700
Message-Id: <1521573486-17304-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521573369-17216-1-git-send-email-maran.wilson@oracle.com>
References: <1521573369-17216-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8838 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to pave the way for hypervisors other then Xen to use the PVH
entry point for VMs, we need to factor the PVH entry code into Xen specific
and hypervisor agnostic components. The first step in doing that, is to
create a new config option for PVH entry that can be enabled
independently from CONFIG_XEN.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 arch/x86/Kconfig          | 7 +++++++
 arch/x86/kernel/head_64.S | 4 ++--
 arch/x86/xen/Kconfig      | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eb7f43f23521..58831320b5d2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -791,6 +791,13 @@ config KVM_GUEST
 	  underlying device model, the host provides the guest with
 	  timing infrastructure such as time of day, and system time
 
+config PVH
+	bool "Support for running PVH guests"
+	def_bool n
+	---help---
+	  This option enables the PVH entry point for guest virtual machines
+	  as specified in the x86/HVM direct boot ABI.
+
 config KVM_DEBUG_FS
 	bool "Enable debug information for KVM Guests in debugfs"
 	depends on KVM_GUEST && DEBUG_FS
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 0f545b3cf926..fc9f678c6413 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -41,7 +41,7 @@
 
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 
-#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
+#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
 PGD_PAGE_OFFSET = pgd_index(__PAGE_OFFSET_BASE)
 PGD_START_KERNEL = pgd_index(__START_KERNEL_map)
 #endif
@@ -387,7 +387,7 @@ NEXT_PAGE(early_dynamic_pgts)
 
 	.data
 
-#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
+#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
 NEXT_PGD_PAGE(init_top_pgt)
 	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.org    init_top_pgt + PGD_PAGE_OFFSET*8, 0
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index f605825a04ab..021c8591c3c0 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -77,8 +77,9 @@ config XEN_DEBUG_FS
 	  Enabling this option may incur a significant performance overhead.
 
 config XEN_PVH
-	bool "Support for running as a PVH guest"
+	bool "Support for running as a Xen PVH guest"
 	depends on XEN && XEN_PVHVM && ACPI
 	# Pre-built page tables are not ready to handle 5-level paging.
 	depends on !X86_5LEVEL
+	select PVH
 	def_bool n
-- 
2.16.1
