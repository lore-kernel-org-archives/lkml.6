Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388DFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0F121653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0F121653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbeHNUlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:41:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389859AbeHNUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:15 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78E86DB4;
        Tue, 14 Aug 2018 17:32:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 52/97] x86/KVM: Warn user if KVM is loaded SMT and L1TF CPU bug being present
Date:   Tue, 14 Aug 2018 19:17:04 +0200
Message-Id: <20180814171435.136260973@linuxfoundation.org>
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

commit 26acfb666a473d960f0fd971fe68f3e3ad16c70b upstream

If the L1TF CPU bug is present we allow the KVM module to be loaded as the
major of users that use Linux and KVM have trusted guests and do not want a
broken setup.

Cloud vendors are the ones that are uncomfortable with CVE 2018-3620 and as
such they are the ones that should set nosmt to one.

Setting 'nosmt' means that the system administrator also needs to disable
SMT (Hyper-threading) in the BIOS, or via the 'nosmt' command line
parameter, or via the /sys/devices/system/cpu/smt/control. See commit
05736e4ac13c ("cpu/hotplug: Provide knobs to control SMT").

Other mitigations are to use task affinity, cpu sets, interrupt binding,
etc - anything to make sure that _only_ the same guests vCPUs are running
on sibling threads.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |    6 ++++++
 arch/x86/kvm/vmx.c                              |   13 +++++++++++++
 kernel/cpu.c                                    |    1 +
 3 files changed, 20 insertions(+)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1937,6 +1937,12 @@
 			[KVM,ARM] Allow use of GICv4 for direct injection of
 			LPIs.
 
+	kvm-intel.nosmt=[KVM,Intel] If the L1TF CPU bug is present (CVE-2018-3620)
+			and the system has SMT (aka Hyper-Threading) enabled then
+			don't allow guests to be created.
+
+			Default is 0 (allow guests to be created).
+
 	kvm-intel.ept=	[KVM,Intel] Disable extended page tables
 			(virtualized MMU) support on capable Intel chips.
 			Default is 1 (enabled)
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -71,6 +71,9 @@ static const struct x86_cpu_id vmx_cpu_i
 };
 MODULE_DEVICE_TABLE(x86cpu, vmx_cpu_id);
 
+static bool __read_mostly nosmt;
+module_param(nosmt, bool, S_IRUGO);
+
 static bool __read_mostly enable_vpid = 1;
 module_param_named(vpid, enable_vpid, bool, 0444);
 
@@ -10142,10 +10145,20 @@ free_vcpu:
 	return ERR_PTR(err);
 }
 
+#define L1TF_MSG "SMT enabled with L1TF CPU bug present. Refer to CVE-2018-3620 for details.\n"
+
 static int vmx_vm_init(struct kvm *kvm)
 {
 	if (!ple_gap)
 		kvm->arch.pause_in_guest = true;
+
+	if (boot_cpu_has(X86_BUG_L1TF) && cpu_smt_control == CPU_SMT_ENABLED) {
+		if (nosmt) {
+			pr_err(L1TF_MSG);
+			return -EOPNOTSUPP;
+		}
+		pr_warn(L1TF_MSG);
+	}
 	return 0;
 }
 
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -345,6 +345,7 @@ EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
 
 #ifdef CONFIG_HOTPLUG_SMT
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
+EXPORT_SYMBOL_GPL(cpu_smt_control);
 
 static int __init smt_cmdline_disable(char *str)
 {


