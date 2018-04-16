Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDPXOl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 19:14:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41106 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPXOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 19:14:40 -0400
From: Maran Wilson <maran.wilson@oracle.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        roger.pau@citrix.com, boris.ostrovsky@oracle.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v7 7/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
Date: Mon, 16 Apr 2018 16:13:50 -0700
Message-Id: <1523920430-27952-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=7 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160192
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain applications it is desirable to rapidly boot a KVM virtual
machine. In cases where legacy hardware and software support within the
guest is not needed, Qemu should be able to boot directly into the
uncompressed Linux kernel binary without the need to run firmware.

There already exists an ABI to allow this for Xen PVH guests and the ABI
is supported by Linux and FreeBSD:

   https://xenbits.xen.org/docs/unstable/misc/pvh.html

This patch enables Qemu to use that same entry point for booting KVM
guests.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Tested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/Kbuild                   |  2 +-
 arch/x86/Kconfig                  |  8 ++++++++
 arch/x86/platform/pvh/Makefile    |  4 ++--
 arch/x86/platform/pvh/enlighten.c | 42 +++++++++++++++++++++++++++++----------
 4 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index 2089e4414300..c625f57472f7 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -7,7 +7,7 @@ obj-$(CONFIG_KVM) += kvm/
 # Xen paravirtualization support
 obj-$(CONFIG_XEN) += xen/
 
-obj-$(CONFIG_XEN_PVH) += platform/pvh/
+obj-$(CONFIG_PVH) += platform/pvh/
 
 # Hyper-V paravirtualization support
 obj-$(subst m,y,$(CONFIG_HYPERV)) += hyperv/
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8511d419e39f..26fef538d3ef 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -787,6 +787,14 @@ config PVH
 	  This option enables the PVH entry point for guest virtual machines
 	  as specified in the x86/HVM direct boot ABI.
 
+config KVM_GUEST_PVH
+	bool "Support for running as a KVM PVH guest"
+	depends on KVM_GUEST
+	select PVH
+	---help---
+	  This option enables starting KVM guests via the PVH entry point as
+	  specified in the x86/HVM direct boot ABI.
+
 config KVM_DEBUG_FS
 	bool "Enable debug information for KVM Guests in debugfs"
 	depends on KVM_GUEST && DEBUG_FS
diff --git a/arch/x86/platform/pvh/Makefile b/arch/x86/platform/pvh/Makefile
index 9fd25efcd2a3..5dec5067c9fb 100644
--- a/arch/x86/platform/pvh/Makefile
+++ b/arch/x86/platform/pvh/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_head.o := y
 
-obj-$(CONFIG_XEN_PVH) += enlighten.o
-obj-$(CONFIG_XEN_PVH) += head.o
+obj-$(CONFIG_PVH) += enlighten.o
+obj-$(CONFIG_PVH) += head.o
diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index c42a9f36ee9c..0c7f570d3c16 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -8,6 +8,8 @@
 #include <asm/e820/api.h>
 #include <asm/x86_init.h>
 
+#include <asm/xen/interface.h>
+
 #include <xen/interface/hvm/start_info.h>
 
 /*
@@ -39,11 +41,28 @@ void __init __weak mem_map_via_hcall(struct boot_params *ptr __maybe_unused)
 	BUG();
 }
 
-static void __init init_pvh_bootparams(void)
+static void __init init_pvh_bootparams(bool xen_guest)
 {
 	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
 
-	mem_map_via_hcall(&pvh_bootparams);
+	if ((pvh_start_info.version > 0) && (pvh_start_info.memmap_entries)) {
+		struct hvm_memmap_table_entry *ep;
+		int i;
+
+		ep = __va(pvh_start_info.memmap_paddr);
+		pvh_bootparams.e820_entries = pvh_start_info.memmap_entries;
+
+		for (i = 0; i < pvh_bootparams.e820_entries ; i++, ep++) {
+			pvh_bootparams.e820_table[i].addr = ep->addr;
+			pvh_bootparams.e820_table[i].size = ep->size;
+			pvh_bootparams.e820_table[i].type = ep->type;
+		}
+	} else if (xen_guest) {
+		mem_map_via_hcall(&pvh_bootparams);
+	} else {
+		/* Non-xen guests are not supported by version 0 */
+		BUG();
+	}
 
 	if (pvh_bootparams.e820_entries < E820_MAX_ENTRIES_ZEROPAGE - 1) {
 		pvh_bootparams.e820_table[pvh_bootparams.e820_entries].addr =
@@ -74,7 +93,7 @@ static void __init init_pvh_bootparams(void)
 	 * environment (i.e. hardware_subarch 0).
 	 */
 	pvh_bootparams.hdr.version = 0x212;
-	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
+	pvh_bootparams.hdr.type_of_loader = ((xen_guest ? 0x9 : 0xb) << 4) | 0;
 
 	x86_init.acpi.get_root_pointer = pvh_get_root_pointer;
 }
@@ -89,13 +108,10 @@ void __init __weak xen_pvh_init(void)
 	BUG();
 }
 
-/*
- * When we add support for other hypervisors like Qemu/KVM, this routine can
- * selectively invoke the appropriate initialization based on guest type.
- */
-static void hypervisor_specific_init(void)
+static void hypervisor_specific_init(bool xen_guest)
 {
-	xen_pvh_init();
+	if (xen_guest)
+		xen_pvh_init();
 }
 
 /*
@@ -104,13 +120,17 @@ static void hypervisor_specific_init(void)
  */
 void __init xen_prepare_pvh(void)
 {
+
+	u32 msr = xen_cpuid_base();
+	bool xen_guest = !!msr;
+
 	if (pvh_start_info.magic != XEN_HVM_START_MAGIC_VALUE) {
 		xen_raw_printk("Error: Unexpected magic value (0x%08x)\n",
 				pvh_start_info.magic);
 		BUG();
 	}
 
-	hypervisor_specific_init();
+	hypervisor_specific_init(xen_guest);
 
-	init_pvh_bootparams();
+	init_pvh_bootparams(xen_guest);
 }
-- 
2.16.1
