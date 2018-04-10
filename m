Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5ndFaVaNMmRNKTrc6CzpQTidJb/nPk6prYqZk8hyiH2s8/iGItg2JyKTAb+uUXyVIt96q
ARC-Seal: i=1; a=rsa-sha256; t=1523399863; cv=none;
        d=google.com; s=arc-20160816;
        b=CJwQNLvRUyCcmdr0MVC5awHvfuleQuP8vXRhrTft7mufduG+nYEOl2qSyZUv5D8Nij
         JbLTNKGdBiCZxCoHhFsdcmcl4MHtaNHC/RvYrvcGPv+HVbmoXDkrP2MMzlk3LV4QUZoA
         iA5oSY3NV9bDuUGWJ8LMKlQk0yPx2ngx6dRrSa2GVUTG8EOmxrIn567/Vmn1QH0E5wt4
         NKk0BkdAMPutZvGE8Ypyte9vJAvOSuN0VWD1pXZXjUvGiFi1+E32EGooYXNVTbgYPsQt
         mk0N1mTCTMIMUkGJ74vYH91wMOdmGIJzijoK0hR28xME2DdtYmj8XF9U35MWBQ55wNYK
         nm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RNbE8OXkW0vlVkJFGaPGbumjiNFH0cvYQSUIUe4lLc0=;
        b=DTj23+Y2EPw87PJ5piMW6lUHYinrflmkiN/5awq4qMv6EQzanr2lXHq616nax+i3u5
         WJEgEYFG/04tf/FXxSq6kmmGcE4bvucyHLLgK3HbZmx3fJTjxE0CTIOAK0cqQ8ib+ysf
         J2GBPa85YNl3U6FVc2uH50+8QlsPVND7T0DEehNEYBbTAXtz9yo/7EtLbxBwK/FvlSUG
         hujgCiEonz4u9Zsh7K9/tuOiAXPODpvKuYwx61Hbut5O8kU/ohkF7UyIjOEtQ2miuxTM
         1mPT745+UlsFmf+pVHGjh+a7HgxXD7ctc1EjokCCXT3qjH5xdzosGtwTg7RhJdZMEg1l
         l+kg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Bohac <jbohac@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Baoquan He <bhe@redhat.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	David Airlie <airlied@linux.ie>,
	yinghai@kernel.org,
	joro@8bytes.org,
	kexec@lists.infradead.org,
	Borislav Petkov <bp@alien8.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Young <dyoung@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 074/138] x86/gart: Exclude GART aperture from vmcore
Date: Wed, 11 Apr 2018 00:24:24 +0200
Message-Id: <20180410212910.724767926@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400114579784934?=
X-GMAIL-MSGID: =?utf-8?q?1597400535708510967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Bohac <jbohac@suse.cz>


[ Upstream commit 2a3e83c6f96c513f43ce5a8c9034608ea584a255 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/aperture_64.c |   46 +++++++++++++++++++++++++++++++++++++++++-
 arch/x86/xen/mmu_hvm.c        |    2 -
 2 files changed, 46 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -30,6 +30,7 @@
 #include <asm/dma.h>
 #include <asm/amd_nb.h>
 #include <asm/x86_init.h>
+#include <linux/crash_dump.h>
 
 /*
  * Using 512M as goal, in case kexec will load kernel_big
@@ -56,6 +57,33 @@ int fallback_aper_force __initdata;
 
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
 
@@ -435,8 +463,16 @@ int __init gart_iommu_hole_init(void)
 
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
 
@@ -473,6 +509,14 @@ out:
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
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -75,6 +75,6 @@ void __init xen_hvm_init_mmu_ops(void)
 	if (is_pagetable_dying_supported())
 		pv_mmu_ops.exit_mmap = xen_hvm_exit_mmap;
 #ifdef CONFIG_PROC_VMCORE
-	register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram);
+	WARN_ON(register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram));
 #endif
 }
