Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeCTTUh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:20:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59312 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeCTTUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:20:35 -0400
From: Maran Wilson <maran.wilson@oracle.com>
To: x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        jgross@suse.com
Cc: boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, roger.pau@citrix.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v5 3/7] xen/pvh: Create a new file for Xen specific PVH code
Date: Tue, 20 Mar 2018 12:19:44 -0700
Message-Id: <1521573586-17463-1-git-send-email-maran.wilson@oracle.com>
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

The first step in that direction is to create a new file that will
eventually hold the Xen specific routines.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 arch/x86/platform/pvh/enlighten.c |  5 ++---
 arch/x86/xen/Makefile             |  1 +
 arch/x86/xen/enlighten_pvh.c      | 10 ++++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/xen/enlighten_pvh.c

diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 436c4f003e17..74c0a711ebe7 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -16,10 +16,9 @@
 /*
  * PVH variables.
  *
- * xen_pvh and pvh_bootparams need to live in data segment since they
- * are used after startup_{32|64}, which clear .bss, are invoked.
+ * pvh_bootparams needs to live in the data segment since it is
+ * used after startup_{32|64}, which clear .bss, are invoked.
  */
-bool xen_pvh __attribute__((section(".data"))) = 0;
 struct boot_params pvh_bootparams __attribute__((section(".data")));
 
 struct hvm_start_info pvh_start_info;
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index f1b850607212..ae5c6f1f0fe0 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -20,6 +20,7 @@ obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
 obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
 obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
 						p2m.o enlighten_pv.o mmu_pv.o
+obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
 
 obj-$(CONFIG_EVENT_TRACING) += trace.o
 
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
new file mode 100644
index 000000000000..c5409c1f259f
--- /dev/null
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -0,0 +1,10 @@
+#include <linux/types.h>
+
+/*
+ * PVH variables.
+ *
+ * The variable xen_pvh needs to live in the data segment since it is used
+ * after startup_{32|64} is invoked, which will clear the .bss segment.
+ */
+bool xen_pvh __attribute__((section(".data"))) = 0;
+
-- 
2.16.1
