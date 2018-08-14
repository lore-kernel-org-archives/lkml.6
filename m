Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDE2C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E94B214DC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E94B214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390282AbeHNUaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390186AbeHNUaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:13 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 86B33DB6;
        Tue, 14 Aug 2018 17:32:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 53/97] x86/KVM/VMX: Add module argument for L1TF mitigation
Date:   Tue, 14 Aug 2018 19:17:05 +0200
Message-Id: <20180814171435.171024870@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit a399477e52c17e148746d3ce9a483f681c2aa9a0 upstream

Add a mitigation mode parameter "vmentry_l1d_flush" for CVE-2018-3620, aka
L1 terminal fault. The valid arguments are:

 - "always" 	L1D cache flush on every VMENTER.
 - "cond"	Conditional L1D cache flush, explained below
 - "never"	Disable the L1D cache flush mitigation

"cond" is trying to avoid L1D cache flushes on VMENTER if the code executed
between VMEXIT and VMENTER is considered safe, i.e. is not bringing any
interesting information into L1D which might exploited.

[ tglx: Split out from a larger patch ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   12 ++++
 arch/x86/kvm/vmx.c                              |   59 ++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1964,6 +1964,18 @@
 			(virtualized real and unpaged mode) on capable
 			Intel chips. Default is 1 (enabled)
 
+	kvm-intel.vmentry_l1d_flush=[KVM,Intel] Mitigation for L1 Terminal Fault
+			CVE-2018-3620.
+
+			Valid arguments: never, cond, always
+
+			always: L1D cache flush on every VMENTER.
+			cond:	Flush L1D on VMENTER only when the code between
+				VMEXIT and VMENTER can leak host memory.
+			never:	Disables the mitigation
+
+			Default is cond (do L1 cache flush in specific instances)
+
 	kvm-intel.vpid=	[KVM,Intel] Disable Virtual Processor Identification
 			feature (tagged TLBs) on capable Intel chips.
 			Default is 1 (enabled)
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -191,6 +191,54 @@ module_param(ple_window_max, uint, 0444)
 
 extern const ulong vmx_return;
 
+static DEFINE_STATIC_KEY_FALSE(vmx_l1d_should_flush);
+
+/* These MUST be in sync with vmentry_l1d_param order. */
+enum vmx_l1d_flush_state {
+	VMENTER_L1D_FLUSH_NEVER,
+	VMENTER_L1D_FLUSH_COND,
+	VMENTER_L1D_FLUSH_ALWAYS,
+};
+
+static enum vmx_l1d_flush_state __read_mostly vmentry_l1d_flush = VMENTER_L1D_FLUSH_COND;
+
+static const struct {
+	const char *option;
+	enum vmx_l1d_flush_state cmd;
+} vmentry_l1d_param[] = {
+	{"never",	VMENTER_L1D_FLUSH_NEVER},
+	{"cond",	VMENTER_L1D_FLUSH_COND},
+	{"always",	VMENTER_L1D_FLUSH_ALWAYS},
+};
+
+static int vmentry_l1d_flush_set(const char *s, const struct kernel_param *kp)
+{
+	unsigned int i;
+
+	if (!s)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(vmentry_l1d_param); i++) {
+		if (!strcmp(s, vmentry_l1d_param[i].option)) {
+			vmentry_l1d_flush = vmentry_l1d_param[i].cmd;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
+{
+	return sprintf(s, "%s\n", vmentry_l1d_param[vmentry_l1d_flush].option);
+}
+
+static const struct kernel_param_ops vmentry_l1d_flush_ops = {
+	.set = vmentry_l1d_flush_set,
+	.get = vmentry_l1d_flush_get,
+};
+module_param_cb(vmentry_l1d_flush, &vmentry_l1d_flush_ops, &vmentry_l1d_flush, S_IRUGO);
+
 struct kvm_vmx {
 	struct kvm kvm;
 
@@ -12881,6 +12929,15 @@ static struct kvm_x86_ops vmx_x86_ops __
 	.enable_smi_window = enable_smi_window,
 };
 
+static void __init vmx_setup_l1d_flush(void)
+{
+	if (vmentry_l1d_flush == VMENTER_L1D_FLUSH_NEVER ||
+	    !boot_cpu_has_bug(X86_BUG_L1TF))
+		return;
+
+	static_branch_enable(&vmx_l1d_should_flush);
+}
+
 static int __init vmx_init(void)
 {
 	int r;
@@ -12914,6 +12971,8 @@ static int __init vmx_init(void)
 	}
 #endif
 
+	vmx_setup_l1d_flush();
+
 	r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
                      __alignof__(struct vcpu_vmx), THIS_MODULE);
 	if (r)


