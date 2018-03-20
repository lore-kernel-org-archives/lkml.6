Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeCTTVN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:21:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59764 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCTTUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:20:36 -0400
From: Maran Wilson <maran.wilson@oracle.com>
To: x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        jgross@suse.com
Cc: boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, roger.pau@citrix.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v5 4/7] xen/pvh: Move Xen specific PVH VM initialization out of common file
Date: Tue, 20 Mar 2018 12:19:45 -0700
Message-Id: <1521573586-17463-2-git-send-email-maran.wilson@oracle.com>
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

This patch moves the small block of code used for initializing Xen PVH
virtual machines into the Xen specific file. This initialization is not
going to be needed for Qemu/KVM guests. Moving it out of the common file
is going to allow us to compile kernels in the future without CONFIG_XEN
that are still capable of being booted as a Qemu/KVM guest via the PVH
entry point.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/platform/pvh/enlighten.c | 28 ++++++++++++++++++++--------
 arch/x86/xen/enlighten_pvh.c      | 18 +++++++++++++++++-
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 74c0a711ebe7..b463ee30517a 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -72,26 +72,38 @@ static void __init init_pvh_bootparams(void)
 	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
 }
 
+/*
+ * If we are trying to boot a Xen PVH guest, it is expected that the kernel
+ * will have been configured to provide the required override for this routine.
+ */
+void __init __weak xen_pvh_init(void)
+{
+	xen_raw_printk("Error: Missing xen PVH initialization\n");
+	BUG();
+}
+
+/*
+ * When we add support for other hypervisors like Qemu/KVM, this routine can
+ * selectively invoke the appropriate initialization based on guest type.
+ */
+static void hypervisor_specific_init(void)
+{
+	xen_pvh_init();
+}
+
 /*
  * This routine (and those that it might call) should not use
  * anything that lives in .bss since that segment will be cleared later.
  */
 void __init xen_prepare_pvh(void)
 {
-	u32 msr;
-	u64 pfn;
-
 	if (pvh_start_info.magic != XEN_HVM_START_MAGIC_VALUE) {
 		xen_raw_printk("Error: Unexpected magic value (0x%08x)\n",
 				pvh_start_info.magic);
 		BUG();
 	}
 
-	xen_pvh = 1;
-
-	msr = cpuid_ebx(xen_cpuid_base() + 2);
-	pfn = __pa(hypercall_page);
-	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+	hypervisor_specific_init();
 
 	init_pvh_bootparams();
 }
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index c5409c1f259f..08fc63d14ae5 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,4 +1,9 @@
-#include <linux/types.h>
+#include <linux/acpi.h>
+
+#include <asm/io_apic.h>
+
+#include <asm/xen/interface.h>
+#include <asm/xen/hypercall.h>
 
 /*
  * PVH variables.
@@ -8,3 +13,14 @@
  */
 bool xen_pvh __attribute__((section(".data"))) = 0;
 
+void __init xen_pvh_init(void)
+{
+	u32 msr;
+	u64 pfn;
+
+	xen_pvh = 1;
+
+	msr = cpuid_ebx(xen_cpuid_base() + 2);
+	pfn = __pa(hypercall_page);
+	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+}
-- 
2.16.1
