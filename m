Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754604AbeE1RdL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:33:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41736 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbeE1RdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:33:10 -0400
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2] x86/xen: Combine PV features to be disabled in xen_nopv
Date: Mon, 28 May 2018 18:32:11 +0100
Message-Id: <20180528173211.16876-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8907 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805280210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Extend 'xen_nopv' parameter to disable individual features in
the following format:

xen_nopv={ [spin,][ipi] | all }

'spin' to disable PV spinlocks
'ipi' to disable PV IPI
'all' to disable all of the above and PV drivers

'all' ideally would be the set of features that can be disabled with
xen_nopv. Albeit it is disabling PV features and drivers because it has
been the behaviour of all past kernels. Thus users should not see a
difference when specifying no value. Also, deprecate 'xen_nopvspin' as
we are making it part of 'xen_nopv'.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
Changes since RFC:
 (https://lists.xenproject.org/archives/html/xen-devel/2015-10/msg00898.html
  Comments from Boris, and new changes)
 - Improve subject and commit message
 - Fix Documentation format and deprecate 'xen_nopvspin' instead of removing it
 - Make existing 'xen_nopvspin' command line use the same masking
 helpers as xen_nopv
 - Use xen_nopv_ipi() accordingly
 - Do not create unused irqs when disabling PV IPI
---
 Documentation/admin-guide/kernel-parameters.txt | 13 ++++--
 arch/x86/xen/enlighten_hvm.c                    | 55 ++++++++++++++++++++++---
 arch/x86/xen/smp.c                              | 21 ++++++----
 arch/x86/xen/smp_hvm.c                          | 14 +++++--
 arch/x86/xen/spinlock.c                         |  9 ++--
 arch/x86/xen/xen-ops.h                          |  9 ++++
 6 files changed, 96 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2040d46f095..3f29ee4741bb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4807,12 +4807,19 @@
 			never -- do not unplug even if version check succeeds
 
 	xen_nopvspin	[X86,XEN]
+			[Deprecated - use xen_nopv=spin]
 			Disables the ticketlock slowpath using Xen PV
 			optimizations.
 
-	xen_nopv	[X86]
-			Disables the PV optimizations forcing the HVM guest to
-			run as generic HVM guest with no PV drivers.
+	xen_nopv=	[X86,XEN]
+			Disables various (or all) PV optimizations forcing the
+			HVM (or PV) guest to run without them. No value
+			specified defaults to 'all'.
+			Format: { [spin,][ipi,] | all }
+			all -- every PV feature on HVM, including PV drivers.
+			spin -- Disables the ticketlock slowpath using Xen PV
+			         optimizations (PV and HVM).
+			ipi -- Disable PV IPIs (on HVM).
 
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 19c1ff542387..c396671dadd5 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -208,17 +208,62 @@ static void __init xen_hvm_guest_init(void)
 #endif
 }
 
-static bool xen_nopv;
+static unsigned int xen_nopv_feat;
+
+static bool xen_nopv(void)
+{
+	return xen_nopv_feat == XEN_NOPV_ALL;
+}
+
+bool xen_nopv_ipi(void)
+{
+	return xen_nopv_feat & XEN_NOPV_IPI;
+}
+
+bool xen_nopv_spin(void)
+{
+	return xen_nopv_feat & XEN_NOPV_SPIN;
+}
+
+void xen_set_nopv(unsigned int mask)
+{
+	xen_nopv_feat |= mask;
+}
+
 static __init int xen_parse_nopv(char *arg)
 {
-       xen_nopv = true;
-       return 0;
+	char *p, *q;
+	int l;
+
+	xen_nopv_feat = arg ? 0 : XEN_NOPV_ALL;
+
+	for (p = arg; p; p = q) {
+		q = strchr(p, ',');
+		if (q) {
+			l = q - p;
+			q++;
+		} else {
+			l = strlen(p);
+		}
+		if (!strncmp(p, "spin", l))
+			xen_nopv_feat |= XEN_NOPV_SPIN;
+		else if (!strncmp(p, "ipi", l))
+			xen_nopv_feat |= XEN_NOPV_IPI;
+		else if (!strncmp(p, "all", l))
+			xen_nopv_feat = XEN_NOPV_ALL;
+		else
+			pr_warn("unrecognised option '%s' for 'xen_nopv'\n", p);
+	}
+
+	pr_debug("xen_nopv_feat = 0x%x\n", xen_nopv_feat);
+
+	return 0;
 }
 early_param("xen_nopv", xen_parse_nopv);
 
 bool xen_hvm_need_lapic(void)
 {
-	if (xen_nopv)
+	if (xen_nopv())
 		return false;
 	if (xen_pv_domain())
 		return false;
@@ -232,7 +277,7 @@ EXPORT_SYMBOL_GPL(xen_hvm_need_lapic);
 
 static uint32_t __init xen_platform_hvm(void)
 {
-	if (xen_pv_domain() || xen_nopv)
+	if (xen_pv_domain() || xen_nopv())
 		return 0;
 
 	return xen_cpuid_base();
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 7a43b2ae19f1..e67a941cd20f 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -64,6 +64,18 @@ int xen_smp_intr_init(unsigned int cpu)
 	int rc;
 	char *resched_name, *callfunc_name, *debug_name;
 
+	debug_name = kasprintf(GFP_KERNEL, "debug%d", cpu);
+	rc = bind_virq_to_irqhandler(VIRQ_DEBUG, cpu, xen_debug_interrupt,
+				     IRQF_PERCPU | IRQF_NOBALANCING,
+				     debug_name, NULL);
+	if (rc < 0)
+		goto fail;
+	per_cpu(xen_debug_irq, cpu).irq = rc;
+	per_cpu(xen_debug_irq, cpu).name = debug_name;
+
+	if (xen_hvm_domain() && xen_nopv_ipi())
+		return 0;
+
 	resched_name = kasprintf(GFP_KERNEL, "resched%d", cpu);
 	rc = bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
 				    cpu,
@@ -88,15 +100,6 @@ int xen_smp_intr_init(unsigned int cpu)
 	per_cpu(xen_callfunc_irq, cpu).irq = rc;
 	per_cpu(xen_callfunc_irq, cpu).name = callfunc_name;
 
-	debug_name = kasprintf(GFP_KERNEL, "debug%d", cpu);
-	rc = bind_virq_to_irqhandler(VIRQ_DEBUG, cpu, xen_debug_interrupt,
-				     IRQF_PERCPU | IRQF_NOBALANCING,
-				     debug_name, NULL);
-	if (rc < 0)
-		goto fail;
-	per_cpu(xen_debug_irq, cpu).irq = rc;
-	per_cpu(xen_debug_irq, cpu).name = debug_name;
-
 	callfunc_name = kasprintf(GFP_KERNEL, "callfuncsingle%d", cpu);
 	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_SINGLE_VECTOR,
 				    cpu,
diff --git a/arch/x86/xen/smp_hvm.c b/arch/x86/xen/smp_hvm.c
index f8d39440b292..fb550b4cd273 100644
--- a/arch/x86/xen/smp_hvm.c
+++ b/arch/x86/xen/smp_hvm.c
@@ -66,11 +66,19 @@ void __init xen_hvm_smp_init(void)
 	if (!xen_have_vector_callback)
 		return;
 
+	smp_ops.smp_cpus_done = xen_smp_cpus_done;
+	smp_ops.smp_prepare_boot_cpu = xen_hvm_smp_prepare_boot_cpu;
 	smp_ops.smp_prepare_cpus = xen_hvm_smp_prepare_cpus;
-	smp_ops.smp_send_reschedule = xen_smp_send_reschedule;
 	smp_ops.cpu_die = xen_hvm_cpu_die;
+
+	if (xen_nopv_ipi()) {
+		pr_debug("xen: PV IPI disabled\n");
+		return;
+	}
+
+	pr_debug("xen: PV IPI enabled\n");
+
+	smp_ops.smp_send_reschedule = xen_smp_send_reschedule;
 	smp_ops.send_call_func_ipi = xen_smp_send_call_function_ipi;
 	smp_ops.send_call_func_single_ipi = xen_smp_send_call_function_single_ipi;
-	smp_ops.smp_prepare_boot_cpu = xen_hvm_smp_prepare_boot_cpu;
-	smp_ops.smp_cpus_done = xen_smp_cpus_done;
 }
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index cd97a62394e7..72499a5ef06c 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -21,7 +21,6 @@
 
 static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
 static DEFINE_PER_CPU(char *, irq_name);
-static bool xen_pvspin = true;
 
 static void xen_qlock_kick(int cpu)
 {
@@ -80,7 +79,7 @@ void xen_init_lock_cpu(int cpu)
 	int irq;
 	char *name;
 
-	if (!xen_pvspin) {
+	if (xen_nopv_spin()) {
 		if (cpu == 0)
 			static_branch_disable(&virt_spin_lock_key);
 		return;
@@ -108,7 +107,7 @@ void xen_init_lock_cpu(int cpu)
 
 void xen_uninit_lock_cpu(int cpu)
 {
-	if (!xen_pvspin)
+	if (xen_nopv_spin())
 		return;
 
 	unbind_from_irqhandler(per_cpu(lock_kicker_irq, cpu), NULL);
@@ -130,7 +129,7 @@ PV_CALLEE_SAVE_REGS_THUNK(xen_vcpu_stolen);
 void __init xen_init_spinlocks(void)
 {
 
-	if (!xen_pvspin) {
+	if (xen_nopv_spin()) {
 		printk(KERN_DEBUG "xen: PV spinlocks disabled\n");
 		return;
 	}
@@ -146,7 +145,7 @@ void __init xen_init_spinlocks(void)
 
 static __init int xen_parse_nopvspin(char *arg)
 {
-	xen_pvspin = false;
+	xen_set_nopv(XEN_NOPV_SPIN);
 	return 0;
 }
 early_param("xen_nopvspin", xen_parse_nopvspin);
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 3b34745d0a52..d212cf034541 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -164,4 +164,13 @@ void xen_hvm_post_suspend(int suspend_cancelled);
 static inline void xen_hvm_post_suspend(int suspend_cancelled) {}
 #endif
 
+#define XEN_NOPV_PLATFORM (1<<0)
+#define XEN_NOPV_SPIN     (1<<1)
+#define XEN_NOPV_IPI      (1<<2)
+#define XEN_NOPV_ALL      (XEN_NOPV_PLATFORM | XEN_NOPV_SPIN | XEN_NOPV_IPI)
+
+void xen_set_nopv(unsigned int mask);
+bool xen_nopv_spin(void);
+bool xen_nopv_ipi(void);
+
 #endif /* XEN_OPS_H */
-- 
2.11.0
