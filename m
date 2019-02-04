Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9304C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AB52082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfBDUU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:20:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbfBDUTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:19:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1490081F0E;
        Mon,  4 Feb 2019 20:19:38 +0000 (UTC)
Received: from virtlab420.virt.lab.eng.bos.redhat.com (virtlab420.virt.lab.eng.bos.redhat.com [10.19.152.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 648878924D;
        Mon,  4 Feb 2019 20:19:36 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, mst@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com
Subject: [RFC][Patch v8 1/7] KVM: Support for guest free page hinting
Date:   Mon,  4 Feb 2019 15:18:48 -0500
Message-Id: <20190204201854.2328-2-nitesh@redhat.com>
In-Reply-To: <20190204201854.2328-1-nitesh@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 04 Feb 2019 20:19:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes the following:
1. Basic skeleton for the support
2. Enablement of x86 platform to use the same

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 arch/x86/Kbuild              |  2 +-
 arch/x86/kvm/Kconfig         |  8 ++++++++
 arch/x86/kvm/Makefile        |  2 ++
 include/linux/gfp.h          |  9 +++++++++
 include/linux/page_hinting.h | 17 +++++++++++++++++
 virt/kvm/page_hinting.c      | 36 ++++++++++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/page_hinting.h
 create mode 100644 virt/kvm/page_hinting.c

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index c625f57472f7..3244df4ee311 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -2,7 +2,7 @@ obj-y += entry/
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
-obj-$(CONFIG_KVM) += kvm/
+obj-$(subst m,y,$(CONFIG_KVM)) += kvm/
 
 # Xen paravirtualization support
 obj-$(CONFIG_XEN) += xen/
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 72fa955f4a15..2fae31459706 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -96,6 +96,14 @@ config KVM_MMU_AUDIT
 	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
 	 auditing of KVM MMU events at runtime.
 
+# KVM_FREE_PAGE_HINTING will allow the guest to report the free pages to the
+# host in regular interval of time.
+config KVM_FREE_PAGE_HINTING
+       def_bool y
+       depends on KVM
+       select VIRTIO
+       select VIRTIO_BALLOON
+
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
 source "drivers/vhost/Kconfig"
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 69b3a7c30013..78640a80501e 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -16,6 +16,8 @@ kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
 			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
 			   hyperv.o page_track.o debugfs.o
 
+obj-$(CONFIG_KVM_FREE_PAGE_HINTING)    += $(KVM)/page_hinting.o
+
 kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o vmx/evmcs.o vmx/nested.o
 kvm-amd-y		+= svm.o pmu_amd.o
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 5f5e25fd6149..e596527284ba 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -7,6 +7,7 @@
 #include <linux/stddef.h>
 #include <linux/linkage.h>
 #include <linux/topology.h>
+#include <linux/page_hinting.h>
 
 struct vm_area_struct;
 
@@ -456,6 +457,14 @@ static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
 }
 
+#ifdef	CONFIG_KVM_FREE_PAGE_HINTING
+#define HAVE_ARCH_FREE_PAGE
+static inline void arch_free_page(struct page *page, int order)
+{
+	guest_free_page(page, order);
+}
+#endif
+
 #ifndef HAVE_ARCH_FREE_PAGE
 static inline void arch_free_page(struct page *page, int order) { }
 #endif
diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting.h
new file mode 100644
index 000000000000..b54f7428f348
--- /dev/null
+++ b/include/linux/page_hinting.h
@@ -0,0 +1,17 @@
+/*
+ * Size of the array which is used to store the freed pages is defined by
+ * MAX_FGPT_ENTRIES. If possible, we have to find a better way using which
+ * we can get rid of the hardcoded array size.
+ */
+#define MAX_FGPT_ENTRIES	1000
+/*
+ * hypervisor_pages - It is a dummy structure passed with the hypercall.
+ * @pfn: page frame number for the page which needs to be sent to the host.
+ * @order: order of the page needs to be reported to the host.
+ */
+struct hypervisor_pages {
+	unsigned long pfn;
+	unsigned int order;
+};
+
+void guest_free_page(struct page *page, int order);
diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
new file mode 100644
index 000000000000..818bd6b84e0c
--- /dev/null
+++ b/virt/kvm/page_hinting.c
@@ -0,0 +1,36 @@
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+
+/*
+ * struct kvm_free_pages - Tracks the pages which are freed by the guest.
+ * @pfn: page frame number for the page which is freed.
+ * @order: order corresponding to the page freed.
+ * @zonenum: zone number to which the freed page belongs.
+ */
+struct kvm_free_pages {
+	unsigned long pfn;
+	unsigned int order;
+	int zonenum;
+};
+
+/*
+ * struct page_hinting - holds array objects for the structures used to track
+ * guest free pages, along with an index variable for each of them.
+ * @kvm_pt: array object for the structure kvm_free_pages.
+ * @kvm_pt_idx: index for kvm_free_pages object.
+ * @hypervisor_pagelist: array object for the structure hypervisor_pages.
+ * @hyp_idx: index for hypervisor_pages object.
+ */
+struct page_hinting {
+	struct kvm_free_pages kvm_pt[MAX_FGPT_ENTRIES];
+	int kvm_pt_idx;
+	struct hypervisor_pages hypervisor_pagelist[MAX_FGPT_ENTRIES];
+	int hyp_idx;
+};
+
+DEFINE_PER_CPU(struct page_hinting, hinting_obj);
+
+void guest_free_page(struct page *page, int order)
+{
+}
-- 
2.17.2

