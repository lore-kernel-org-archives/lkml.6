Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753739AbeFERGq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753702AbeFERGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:06:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "dwmw@amazon.co.uk, boris.ostrovsky@oracle.com, Juergen Gross"
        <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.9 16/61] xen: set cpu capabilities from xen_start_kernel()
Date: Tue,  5 Jun 2018 19:01:37 +0200
Message-Id: <20180605170118.637543435@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

Upstream commit: 0808e80cb760de2733c0527d2090ed2205a1eef8 ("xen: set
cpu capabilities from xen_start_kernel()")

There is no need to set the same capabilities for each cpu
individually. This can easily be done for all cpus when starting the
kernel.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/xen/enlighten.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -472,6 +472,14 @@ static void __init xen_init_cpuid_mask(v
 		cpuid_leaf1_ecx_set_mask = (1 << (X86_FEATURE_MWAIT % 32));
 }
 
+static void __init xen_init_capabilities(void)
+{
+	if (xen_pv_domain()) {
+		setup_clear_cpu_cap(X86_BUG_SYSRET_SS_ATTRS);
+		setup_force_cpu_cap(X86_FEATURE_XENPV);
+	}
+}
+
 static void xen_set_debugreg(int reg, unsigned long val)
 {
 	HYPERVISOR_set_debugreg(reg, val);
@@ -1634,6 +1642,7 @@ asmlinkage __visible void __init xen_sta
 
 	xen_init_irq_ops();
 	xen_init_cpuid_mask();
+	xen_init_capabilities();
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
@@ -1978,14 +1987,6 @@ bool xen_hvm_need_lapic(void)
 }
 EXPORT_SYMBOL_GPL(xen_hvm_need_lapic);
 
-static void xen_set_cpu_features(struct cpuinfo_x86 *c)
-{
-	if (xen_pv_domain()) {
-		clear_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
-		set_cpu_cap(c, X86_FEATURE_XENPV);
-	}
-}
-
 static void xen_pin_vcpu(int cpu)
 {
 	static bool disable_pinning;
@@ -2032,7 +2033,6 @@ const struct hypervisor_x86 x86_hyper_xe
 	.init_platform		= xen_hvm_guest_init,
 #endif
 	.x2apic_available	= xen_x2apic_para_available,
-	.set_cpu_features       = xen_set_cpu_features,
 	.pin_vcpu               = xen_pin_vcpu,
 };
 EXPORT_SYMBOL(x86_hyper_xen);
