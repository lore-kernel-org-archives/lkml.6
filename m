Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EBEC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6835221728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6835221728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbeHNUON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:14:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbeHNUON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:14:13 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26031C5C;
        Tue, 14 Aug 2018 17:26:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 4.18 46/79] x86/litf: Introduce vmx status variable
Date:   Tue, 14 Aug 2018 19:17:05 +0200
Message-Id: <20180814171338.719707018@linuxfoundation.org>
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

Store the effective mitigation of VMX in a status variable and use it to
report the VMX state in the l1tf sysfs file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20180713142322.433098358@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/vmx.h |    9 +++++++++
 arch/x86/kernel/cpu/bugs.c |   36 ++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/vmx.c         |   22 +++++++++++-----------
 3 files changed, 54 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -576,4 +576,13 @@ enum vm_instruction_error_number {
 	VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID = 28,
 };
 
+enum vmx_l1d_flush_state {
+	VMENTER_L1D_FLUSH_AUTO,
+	VMENTER_L1D_FLUSH_NEVER,
+	VMENTER_L1D_FLUSH_COND,
+	VMENTER_L1D_FLUSH_ALWAYS,
+};
+
+extern enum vmx_l1d_flush_state l1tf_vmx_mitigation;
+
 #endif
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -22,6 +22,7 @@
 #include <asm/processor-flags.h>
 #include <asm/fpu/internal.h>
 #include <asm/msr.h>
+#include <asm/vmx.h>
 #include <asm/paravirt.h>
 #include <asm/alternative.h>
 #include <asm/pgtable.h>
@@ -636,6 +637,12 @@ void x86_spec_ctrl_setup_ap(void)
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"L1TF: " fmt
+
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+enum vmx_l1d_flush_state l1tf_vmx_mitigation __ro_after_init = VMENTER_L1D_FLUSH_AUTO;
+EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
+#endif
+
 static void __init l1tf_select_mitigation(void)
 {
 	u64 half_pa;
@@ -665,6 +672,32 @@ static void __init l1tf_select_mitigatio
 
 #ifdef CONFIG_SYSFS
 
+#define L1TF_DEFAULT_MSG "Mitigation: PTE Inversion"
+
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+static const char *l1tf_vmx_states[] = {
+	[VMENTER_L1D_FLUSH_AUTO]	= "auto",
+	[VMENTER_L1D_FLUSH_NEVER]	= "vulnerable",
+	[VMENTER_L1D_FLUSH_COND]	= "conditional cache flushes",
+	[VMENTER_L1D_FLUSH_ALWAYS]	= "cache flushes",
+};
+
+static ssize_t l1tf_show_state(char *buf)
+{
+	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_AUTO)
+		return sprintf(buf, "%s\n", L1TF_DEFAULT_MSG);
+
+	return sprintf(buf, "%s; VMX: SMT %s, L1D %s\n", L1TF_DEFAULT_MSG,
+		       cpu_smt_control == CPU_SMT_ENABLED ? "vulnerable" : "disabled",
+		       l1tf_vmx_states[l1tf_vmx_mitigation]);
+}
+#else
+static ssize_t l1tf_show_state(char *buf)
+{
+	return sprintf(buf, "%s\n", L1TF_DEFAULT_MSG);
+}
+#endif
+
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
@@ -695,9 +728,8 @@ static ssize_t cpu_show_common(struct de
 
 	case X86_BUG_L1TF:
 		if (boot_cpu_has(X86_FEATURE_L1TF_PTEINV))
-			return sprintf(buf, "Mitigation: Page Table Inversion\n");
+			return l1tf_show_state(buf);
 		break;
-
 	default:
 		break;
 	}
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -193,19 +193,13 @@ extern const ulong vmx_return;
 
 static DEFINE_STATIC_KEY_FALSE(vmx_l1d_should_flush);
 
-/* These MUST be in sync with vmentry_l1d_param order. */
-enum vmx_l1d_flush_state {
-	VMENTER_L1D_FLUSH_NEVER,
-	VMENTER_L1D_FLUSH_COND,
-	VMENTER_L1D_FLUSH_ALWAYS,
-};
-
 static enum vmx_l1d_flush_state __read_mostly vmentry_l1d_flush = VMENTER_L1D_FLUSH_COND;
 
 static const struct {
 	const char *option;
 	enum vmx_l1d_flush_state cmd;
 } vmentry_l1d_param[] = {
+	{"auto",	VMENTER_L1D_FLUSH_AUTO},
 	{"never",	VMENTER_L1D_FLUSH_NEVER},
 	{"cond",	VMENTER_L1D_FLUSH_COND},
 	{"always",	VMENTER_L1D_FLUSH_ALWAYS},
@@ -13323,8 +13317,12 @@ static int __init vmx_setup_l1d_flush(vo
 {
 	struct page *page;
 
+	if (!boot_cpu_has_bug(X86_BUG_L1TF))
+		return 0;
+
+	l1tf_vmx_mitigation = vmentry_l1d_flush;
+
 	if (vmentry_l1d_flush == VMENTER_L1D_FLUSH_NEVER ||
-	    !boot_cpu_has_bug(X86_BUG_L1TF) ||
 	    vmx_l1d_use_msr_save_list())
 		return 0;
 
@@ -13339,12 +13337,14 @@ static int __init vmx_setup_l1d_flush(vo
 	return 0;
 }
 
-static void vmx_free_l1d_flush_pages(void)
+static void vmx_cleanup_l1d_flush(void)
 {
 	if (vmx_l1d_flush_pages) {
 		free_pages((unsigned long)vmx_l1d_flush_pages, L1D_CACHE_ORDER);
 		vmx_l1d_flush_pages = NULL;
 	}
+	/* Restore state so sysfs ignores VMX */
+	l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 }
 
 static int __init vmx_init(void)
@@ -13387,7 +13387,7 @@ static int __init vmx_init(void)
 	r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
 		     __alignof__(struct vcpu_vmx), THIS_MODULE);
 	if (r) {
-		vmx_free_l1d_flush_pages();
+		vmx_cleanup_l1d_flush();
 		return r;
 	}
 
@@ -13431,7 +13431,7 @@ static void __exit vmx_exit(void)
 		static_branch_disable(&enable_evmcs);
 	}
 #endif
-	vmx_free_l1d_flush_pages();
+	vmx_cleanup_l1d_flush();
 }
 
 module_init(vmx_init)


