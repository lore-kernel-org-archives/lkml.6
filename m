Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeCTTUu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:20:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59762 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeCTTUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:20:36 -0400
From: Maran Wilson <maran.wilson@oracle.com>
To: x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        jgross@suse.com
Cc: boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, roger.pau@citrix.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v5 5/7] xen/pvh: Move Xen code for getting mem map via hcall out of common file
Date: Tue, 20 Mar 2018 12:19:46 -0700
Message-Id: <1521573586-17463-3-git-send-email-maran.wilson@oracle.com>
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

We need to refactor PVH entry code so that support for other hypervisors
like Qemu/KVM can be added more easily.

The original design for PVH entry in Xen guests relies on being able to
obtain the memory map from the hypervisor using a hypercall. When we
extend the PVH entry ABI to support other hypervisors like Qemu/KVM,
a new mechanism will be added that allows the guest to get the memory
map without needing to use hypercalls.

For Xen guests, the hypercall approach will still be supported. In
preparation for adding support for other hypervisors, we can move the
code that uses hypercalls into the Xen specific file. This will allow us
to compile kernels in the future without CONFIG_XEN that are still capable
of being booted as a Qemu/KVM guest via the PVH entry point.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/platform/pvh/enlighten.c | 28 ++++++++++++++--------------
 arch/x86/xen/enlighten_pvh.c      | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index b463ee30517a..347ecb1860d5 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -7,9 +7,6 @@
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
 
-#include <asm/xen/interface.h>
-#include <asm/xen/hypercall.h>
-
 #include <xen/interface/memory.h>
 #include <xen/interface/hvm/start_info.h>
 
@@ -24,21 +21,24 @@ struct boot_params pvh_bootparams __attribute__((section(".data")));
 struct hvm_start_info pvh_start_info;
 unsigned int pvh_start_info_sz = sizeof(pvh_start_info);
 
+/*
+ * Xen guests are able to obtain the memory map from the hypervisor via the
+ * HYPERVISOR_memory_op hypercall.
+ * If we are trying to boot a Xen PVH guest, it is expected that the kernel
+ * will have been configured to provide an override for this routine to do
+ * just that.
+ */
+void __init __weak mem_map_via_hcall(struct boot_params *ptr __maybe_unused)
+{
+	xen_raw_printk("Error: Could not find memory map\n");
+	BUG();
+}
+
 static void __init init_pvh_bootparams(void)
 {
-	struct xen_memory_map memmap;
-	int rc;
-
 	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
 
-	memmap.nr_entries = ARRAY_SIZE(pvh_bootparams.e820_table);
-	set_xen_guest_handle(memmap.buffer, pvh_bootparams.e820_table);
-	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
-	if (rc) {
-		xen_raw_printk("XENMEM_memory_map failed (%d)\n", rc);
-		BUG();
-	}
-	pvh_bootparams.e820_entries = memmap.nr_entries;
+	mem_map_via_hcall(&pvh_bootparams);
 
 	if (pvh_bootparams.e820_entries < E820_MAX_ENTRIES_ZEROPAGE - 1) {
 		pvh_bootparams.e820_table[pvh_bootparams.e820_entries].addr =
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 08fc63d14ae5..00658d4bc4f4 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,10 +1,15 @@
 #include <linux/acpi.h>
 
+#include <xen/hvc-console.h>
+
 #include <asm/io_apic.h>
+#include <asm/e820/api.h>
 
 #include <asm/xen/interface.h>
 #include <asm/xen/hypercall.h>
 
+#include <xen/interface/memory.h>
+
 /*
  * PVH variables.
  *
@@ -24,3 +29,18 @@ void __init xen_pvh_init(void)
 	pfn = __pa(hypercall_page);
 	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
 }
+
+void __init mem_map_via_hcall(struct boot_params *boot_params_p)
+{
+	struct xen_memory_map memmap;
+	int rc;
+
+	memmap.nr_entries = ARRAY_SIZE(boot_params_p->e820_table);
+	set_xen_guest_handle(memmap.buffer, boot_params_p->e820_table);
+	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
+	if (rc) {
+		xen_raw_printk("XENMEM_memory_map failed (%d)\n", rc);
+		BUG();
+	}
+	boot_params_p->e820_entries = memmap.nr_entries;
+}
-- 
2.16.1
