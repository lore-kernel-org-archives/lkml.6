Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeCTOEd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:04:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753131AbeCTOCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:02:18 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v6 1/7] x86/hyper-v: move hyperv.h out of uapi
Date: Tue, 20 Mar 2018 15:02:05 +0100
Message-Id: <20180320140211.7600-2-vkuznets@redhat.com>
In-Reply-To: <20180320140211.7600-1-vkuznets@redhat.com>
References: <20180320140211.7600-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hyperv.h is not part of uapi, there are no (known) users outside of kernel.
We are making changes to this file to match current Hyper-V Hypervisor
Top-Level Functional Specification (TLFS, see:
https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs)
and we don't want to maintain backwards compatibility.

Move the file renaming to hyperv-tlfs.h to avoid confusing it with
mshyperv.h. In future, all definitions from TLFS should go to it and
all kernel objects should go to mshyperv.h or include/linux/hyperv.h.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 MAINTAINERS                                               |  2 +-
 arch/x86/hyperv/hv_init.c                                 |  2 +-
 arch/x86/include/{uapi/asm/hyperv.h => asm/hyperv-tlfs.h} | 11 +++++++++--
 arch/x86/include/asm/kvm_host.h                           |  1 +
 arch/x86/include/asm/mshyperv.h                           |  2 +-
 arch/x86/include/uapi/asm/kvm_para.h                      |  1 -
 arch/x86/kernel/cpu/mshyperv.c                            |  2 +-
 drivers/hv/connection.c                                   |  1 -
 drivers/hv/hv.c                                           |  1 -
 drivers/hv/hyperv_vmbus.h                                 |  1 +
 drivers/hv/vmbus_drv.c                                    |  1 -
 include/linux/hyperv.h                                    |  1 -
 12 files changed, 15 insertions(+), 11 deletions(-)
 rename arch/x86/include/{uapi/asm/hyperv.h => asm/hyperv-tlfs.h} (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf8d72d..80befd9f4775 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6531,7 +6531,7 @@ S:	Maintained
 F:	Documentation/networking/netvsc.txt
 F:	arch/x86/include/asm/mshyperv.h
 F:	arch/x86/include/asm/trace/hyperv.h
-F:	arch/x86/include/uapi/asm/hyperv.h
+F:	arch/x86/include/asm/hyperv-tlfs.h
 F:	arch/x86/kernel/cpu/mshyperv.c
 F:	arch/x86/hyperv
 F:	drivers/hid/hid-hyperv.c
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 2edc49e7409b..4b82bc206929 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -21,7 +21,7 @@
 #include <asm/apic.h>
 #include <asm/desc.h>
 #include <asm/hypervisor.h>
-#include <asm/hyperv.h>
+#include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 #include <linux/version.h>
 #include <linux/vmalloc.h>
diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/asm/hyperv-tlfs.h
similarity index 98%
rename from arch/x86/include/uapi/asm/hyperv.h
rename to arch/x86/include/asm/hyperv-tlfs.h
index 099414345865..795ddf10cdfb 100644
--- a/arch/x86/include/uapi/asm/hyperv.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_X86_HYPERV_H
-#define _ASM_X86_HYPERV_H
+
+/*
+ * This file contains definitions from Hyper-V Hypervisor Top-Level Functional
+ * Specification (TLFS):
+ * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
+ */
+
+#ifndef _ASM_X86_HYPERV_TLFS_H
+#define _ASM_X86_HYPERV_TLFS_H
 
 #include <linux/types.h>
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b605a5b6a30c..75bed25f1284 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -34,6 +34,7 @@
 #include <asm/msr-index.h>
 #include <asm/asm.h>
 #include <asm/kvm_page_track.h>
+#include <asm/hyperv-tlfs.h>
 
 #define KVM_MAX_VCPUS 288
 #define KVM_SOFT_MAX_VCPUS 240
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 25283f7eb299..044323a59354 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -6,7 +6,7 @@
 #include <linux/atomic.h>
 #include <linux/nmi.h>
 #include <asm/io.h>
-#include <asm/hyperv.h>
+#include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
 
 /*
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 6cfa9c8cb7d6..17f2d04a3d88 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -3,7 +3,6 @@
 #define _UAPI_ASM_X86_KVM_PARA_H
 
 #include <linux/types.h>
-#include <asm/hyperv.h>
 
 /* This CPUID returns the signature 'KVMKVMKVM' in ebx, ecx, and edx.  It
  * should be used to determine that a VM is running under KVM.
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 9340f41ce8d3..04f760432a17 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -22,7 +22,7 @@
 #include <linux/kexec.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
-#include <asm/hyperv.h>
+#include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 #include <asm/desc.h>
 #include <asm/irq_regs.h>
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 447371f4de56..72855182b191 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -31,7 +31,6 @@
 #include <linux/vmalloc.h>
 #include <linux/hyperv.h>
 #include <linux/export.h>
-#include <asm/hyperv.h>
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index fe96aab9e794..45f3694bbb76 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -29,7 +29,6 @@
 #include <linux/version.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
-#include <asm/hyperv.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 22300ec7b556..500f805a6ef2 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -27,6 +27,7 @@
 
 #include <linux/list.h>
 #include <asm/sync_bitops.h>
+#include <asm/hyperv-tlfs.h>
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc65c4d79c1f..b10fe26c4891 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -36,7 +36,6 @@
 #include <linux/cpu.h>
 #include <linux/sched/task_stack.h>
 
-#include <asm/hyperv.h>
 #include <asm/mshyperv.h>
 #include <linux/notifier.h>
 #include <linux/ptrace.h>
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 93bd6fcd6e62..eed8b33b0173 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -26,7 +26,6 @@
 #define _HYPERV_H
 
 #include <uapi/linux/hyperv.h>
-#include <uapi/asm/hyperv.h>
 
 #include <linux/types.h>
 #include <linux/scatterlist.h>
-- 
2.14.3
