Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5647DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D2A21730
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D2A21730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbeHNUOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:14:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbeHNUOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:14:19 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 55AC7D1D;
        Tue, 14 Aug 2018 17:26:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 4.18 48/79] x86/l1tf: Handle EPT disabled state proper
Date:   Tue, 14 Aug 2018 19:17:07 +0200
Message-Id: <20180814171338.944469263@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

If Extended Page Tables (EPT) are disabled or not supported, no L1D
flushing is required. The setup function can just avoid setting up the L1D
flush for the EPT=n case.

Invoke it after the hardware setup has be done and enable_ept has the
correct state and expose the EPT disabled state in the mitigation status as
well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20180713142322.612160168@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/vmx.h |    1 
 arch/x86/kernel/cpu/bugs.c |    9 ++--
 arch/x86/kvm/vmx.c         |   89 ++++++++++++++++++++++++---------------------
 3 files changed, 54 insertions(+), 45 deletions(-)

--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -581,6 +581,7 @@ enum vmx_l1d_flush_state {
 	VMENTER_L1D_FLUSH_NEVER,
 	VMENTER_L1D_FLUSH_COND,
 	VMENTER_L1D_FLUSH_ALWAYS,
+	VMENTER_L1D_FLUSH_EPT_DISABLED,
 };
 
 extern enum vmx_l1d_flush_state l1tf_vmx_mitigation;
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -676,10 +676,11 @@ static void __init l1tf_select_mitigatio
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 static const char *l1tf_vmx_states[] = {
-	[VMENTER_L1D_FLUSH_AUTO]	= "auto",
-	[VMENTER_L1D_FLUSH_NEVER]	= "vulnerable",
-	[VMENTER_L1D_FLUSH_COND]	= "conditional cache flushes",
-	[VMENTER_L1D_FLUSH_ALWAYS]	= "cache flushes",
+	[VMENTER_L1D_FLUSH_AUTO]		= "auto",
+	[VMENTER_L1D_FLUSH_NEVER]		= "vulnerable",
+	[VMENTER_L1D_FLUSH_COND]		= "conditional cache flushes",
+	[VMENTER_L1D_FLUSH_ALWAYS]		= "cache flushes",
+	[VMENTER_L1D_FLUSH_EPT_DISABLED]	= "EPT disabled",
 };
 
 static ssize_t l1tf_show_state(char *buf)
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -13292,6 +13292,11 @@ static int __init vmx_setup_l1d_flush(vo
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return 0;
 
+	if (!enable_ept) {
+		l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_EPT_DISABLED;
+		return 0;
+	}
+
 	l1tf_vmx_mitigation = vmentry_l1d_flush;
 
 	if (vmentry_l1d_flush == VMENTER_L1D_FLUSH_NEVER)
@@ -13318,6 +13323,41 @@ static void vmx_cleanup_l1d_flush(void)
 	l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 }
 
+static void vmx_exit(void)
+{
+#ifdef CONFIG_KEXEC_CORE
+	RCU_INIT_POINTER(crash_vmclear_loaded_vmcss, NULL);
+	synchronize_rcu();
+#endif
+
+	kvm_exit();
+
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (static_branch_unlikely(&enable_evmcs)) {
+		int cpu;
+		struct hv_vp_assist_page *vp_ap;
+		/*
+		 * Reset everything to support using non-enlightened VMCS
+		 * access later (e.g. when we reload the module with
+		 * enlightened_vmcs=0)
+		 */
+		for_each_online_cpu(cpu) {
+			vp_ap =	hv_get_vp_assist_page(cpu);
+
+			if (!vp_ap)
+				continue;
+
+			vp_ap->current_nested_vmcs = 0;
+			vp_ap->enlighten_vmentry = 0;
+		}
+
+		static_branch_disable(&enable_evmcs);
+	}
+#endif
+	vmx_cleanup_l1d_flush();
+}
+module_exit(vmx_exit);
+
 static int __init vmx_init(void)
 {
 	int r;
@@ -13351,14 +13391,17 @@ static int __init vmx_init(void)
 	}
 #endif
 
-	r = vmx_setup_l1d_flush();
+	r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
+		     __alignof__(struct vcpu_vmx), THIS_MODULE);
 	if (r)
 		return r;
 
-	r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
-		     __alignof__(struct vcpu_vmx), THIS_MODULE);
+	/*
+	 * Must be called after kvm_init() so enable_ept is properly set up
+	 */
+	r = vmx_setup_l1d_flush();
 	if (r) {
-		vmx_cleanup_l1d_flush();
+		vmx_exit();
 		return r;
 	}
 
@@ -13370,40 +13413,4 @@ static int __init vmx_init(void)
 
 	return 0;
 }
-
-static void __exit vmx_exit(void)
-{
-#ifdef CONFIG_KEXEC_CORE
-	RCU_INIT_POINTER(crash_vmclear_loaded_vmcss, NULL);
-	synchronize_rcu();
-#endif
-
-	kvm_exit();
-
-#if IS_ENABLED(CONFIG_HYPERV)
-	if (static_branch_unlikely(&enable_evmcs)) {
-		int cpu;
-		struct hv_vp_assist_page *vp_ap;
-		/*
-		 * Reset everything to support using non-enlightened VMCS
-		 * access later (e.g. when we reload the module with
-		 * enlightened_vmcs=0)
-		 */
-		for_each_online_cpu(cpu) {
-			vp_ap =	hv_get_vp_assist_page(cpu);
-
-			if (!vp_ap)
-				continue;
-
-			vp_ap->current_nested_vmcs = 0;
-			vp_ap->enlighten_vmentry = 0;
-		}
-
-		static_branch_disable(&enable_evmcs);
-	}
-#endif
-	vmx_cleanup_l1d_flush();
-}
-
-module_init(vmx_init)
-module_exit(vmx_exit)
+module_init(vmx_init);


