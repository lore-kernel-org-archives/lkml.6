Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeDPXMb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 19:12:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34736 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeDPXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 19:12:29 -0400
From: Maran Wilson <maran.wilson@oracle.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, bp@suse.de, thomas.lendacky@amd.com,
        luto@kernel.org, dave.hansen@linux.intel.com, roger.pau@citrix.com,
        rkrcmar@redhat.com, maran.wilson@oracle.com, rdunlap@infradead.org
Subject: [PATCH v7 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and CONFIG_XEN_PVH
Date: Mon, 16 Apr 2018 16:11:13 -0700
Message-Id: <1523920273-27516-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160192
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to pave the way for hypervisors other than Xen to use the PVH
entry point for VMs, we need to factor the PVH entry code into Xen specific
and hypervisor agnostic components. The first step in doing that, is to
create a new config option for PVH entry that can be enabled
independently from CONFIG_XEN.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 arch/x86/Kconfig          | 6 ++++++
 arch/x86/kernel/head_64.S | 2 +-
 arch/x86/xen/Kconfig      | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d234cca296db..8511d419e39f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -781,6 +781,12 @@ config KVM_GUEST
 	  underlying device model, the host provides the guest with
 	  timing infrastructure such as time of day, and system time
 
+config PVH
+	bool "Support for running PVH guests"
+	---help---
+	  This option enables the PVH entry point for guest virtual machines
+	  as specified in the x86/HVM direct boot ABI.
+
 config KVM_DEBUG_FS
 	bool "Enable debug information for KVM Guests in debugfs"
 	depends on KVM_GUEST && DEBUG_FS
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 48385c1074a5..d83f2b110b47 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -385,7 +385,7 @@ NEXT_PAGE(early_dynamic_pgts)
 
 	.data
 
-#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
+#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
 NEXT_PGD_PAGE(init_top_pgt)
 	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.org    init_top_pgt + L4_PAGE_OFFSET*8, 0
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index c1f98f32c45f..5fccee76f44d 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -74,6 +74,7 @@ config XEN_DEBUG_FS
 	  Enabling this option may incur a significant performance overhead.
 
 config XEN_PVH
-	bool "Support for running as a PVH guest"
+	bool "Support for running as a Xen PVH guest"
 	depends on XEN && XEN_PVHVM && ACPI
+	select PVH
 	def_bool n
-- 
2.16.1
