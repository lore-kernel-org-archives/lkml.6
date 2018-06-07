Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id s1qRO2hFGVt5HwAAmS7hNA
	; Thu, 07 Jun 2018 14:48:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 47A1F608BA; Thu,  7 Jun 2018 14:48:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F2595602FC;
	Thu,  7 Jun 2018 14:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2595602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935037AbeFGOrw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:47:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40821 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933094AbeFGOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:47:47 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbr-0005Zj-VQ; Thu, 07 Jun 2018 15:09:52 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002pl-Kv; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Dave Young" <dyoung@redhat.com>,
        "Toshi Kani" <toshi.kani@hpe.com>, yinghai@kernel.org,
        "Jiri Bohac" <jbohac@suse.cz>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "David Airlie" <airlied@linux.ie>, kexec@lists.infradead.org,
        joro@8bytes.org, "Borislav Petkov" <bp@alien8.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Baoquan He" <bhe@redhat.com>, "Vivek Goyal" <vgoyal@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.116027276@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 106/410] x86/gart: Exclude GART aperture from vmcore
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Bohac <jbohac@suse.cz>

commit 2a3e83c6f96c513f43ce5a8c9034608ea584a255 upstream.

On machines where the GART aperture is mapped over physical RAM
/proc/vmcore contains the remapped range and reading it may cause hangs or
reboots.

In the past, the GART region was added into the resource map, implemented
by commit 56dd669a138c ("[PATCH] Insert GART region into resource map")

However, inserting the iomem_resource from the early GART code caused
resource conflicts with some AGP drivers (bko#72201), which got avoided by
reverting the patch in commit 707d4eefbdb3 ("Revert [PATCH] Insert GART
region into resource map"). This revert introduced the /proc/vmcore bug.

The vmcore ELF header is either prepared by the kernel (when using the
kexec_file_load syscall) or by the kexec userspace (when using the kexec_load
syscall). Since we no longer have the GART iomem resource, the userspace
kexec has no way of knowing which region to exclude from the ELF header.

Changes from v1 of this patch:
Instead of excluding the aperture from the ELF header, this patch
makes /proc/vmcore return zeroes in the second kernel when attempting to
read the aperture region. This is done by reusing the
gart_oldmem_pfn_is_ram infrastructure originally intended to exclude XEN
balooned memory. This works for both, the kexec_file_load and kexec_load
syscalls.

[Note that the GART region is the same in the first and second kernels:
regardless whether the first kernel fixed up the northbridge/bios setting
and mapped the aperture over physical memory, the second kernel finds the
northbridge properly configured by the first kernel and the aperture
never overlaps with e820 memory because the second kernel has a fake e820
map created from the crashkernel memory regions. Thus, the second kernel
keeps the aperture address/size as configured by the first kernel.]

register_oldmem_pfn_is_ram can only register one callback and returns an error
if the callback has been registered already. Since XEN used to be the only user
of this function, it never checks the return value. Now that we have more than
one user, I added a WARN_ON just in case agp, XEN, or any other future user of
register_oldmem_pfn_is_ram were to step on each other's toes.

Fixes: 707d4eefbdb3 ("Revert [PATCH] Insert GART region into resource map")
Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: David Airlie <airlied@linux.ie>
Cc: yinghai@kernel.org
Cc: joro@8bytes.org
Cc: kexec@lists.infradead.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Link: https://lkml.kernel.org/r/20180106010013.73suskgxm7lox7g6@dwarf.suse.cz
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/aperture_64.c | 46 ++++++++++++++++++++++++++++++++++-
 arch/x86/xen/mmu.c            |  2 +-
 2 files changed, 46 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -29,6 +29,7 @@
 #include <asm/dma.h>
 #include <asm/amd_nb.h>
 #include <asm/x86_init.h>
+#include <linux/crash_dump.h>
 
 /*
  * Using 512M as goal, in case kexec will load kernel_big
@@ -55,6 +56,33 @@ int fallback_aper_force __initdata;
 
 int fix_aperture __initdata = 1;
 
+#ifdef CONFIG_PROC_VMCORE
+/*
+ * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
+ * use the same range because it will remain configured in the northbridge.
+ * Trying to dump this area via /proc/vmcore may crash the machine, so exclude
+ * it from vmcore.
+ */
+static unsigned long aperture_pfn_start, aperture_page_count;
+
+static int gart_oldmem_pfn_is_ram(unsigned long pfn)
+{
+	return likely((pfn < aperture_pfn_start) ||
+		      (pfn >= aperture_pfn_start + aperture_page_count));
+}
+
+static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+{
+	aperture_pfn_start = aper_base >> PAGE_SHIFT;
+	aperture_page_count = (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
+	WARN_ON(register_oldmem_pfn_is_ram(&gart_oldmem_pfn_is_ram));
+}
+#else
+static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+{
+}
+#endif
+
 /* This code runs before the PCI subsystem is initialized, so just
    access the northbridge directly. */
 
@@ -436,8 +464,16 @@ int __init gart_iommu_hole_init(void)
 
 out:
 	if (!fix && !fallback_aper_force) {
-		if (last_aper_base)
+		if (last_aper_base) {
+			/*
+			 * If this is the kdump kernel, the first kernel
+			 * may have allocated the range over its e820 RAM
+			 * and fixed up the northbridge
+			 */
+			exclude_from_vmcore(last_aper_base, last_aper_order);
+
 			return 1;
+		}
 		return 0;
 	}
 
@@ -474,6 +510,14 @@ out:
 		return 0;
 	}
 
+	/*
+	 * If this is the kdump kernel _and_ the first kernel did not
+	 * configure the aperture in the northbridge, this range may
+	 * overlap with the first kernel's memory. We can't access the
+	 * range through vmcore even though it should be part of the dump.
+	 */
+	exclude_from_vmcore(aper_alloc, aper_order);
+
 	/* Fix up the north bridges */
 	for (i = 0; i < amd_nb_bus_dev_ranges[i].dev_limit; i++) {
 		int bus, dev_base, dev_limit;
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -2500,7 +2500,7 @@ void __init xen_hvm_init_mmu_ops(void)
 	if (is_pagetable_dying_supported())
 		pv_mmu_ops.exit_mmap = xen_hvm_exit_mmap;
 #ifdef CONFIG_PROC_VMCORE
-	register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram);
+	WARN_ON(register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram));
 #endif
 }
 #endif
