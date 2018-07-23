Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FE1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C2220856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C2220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbeGWNxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:53:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388511AbeGWNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:45 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F5D6C75;
        Mon, 23 Jul 2018 12:45:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 061/107] x86/speculation: Create spec-ctrl.h to avoid include hell
Date:   Mon, 23 Jul 2018 14:41:55 +0200
Message-Id: <20180723122416.105905171@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 28a2775217b17208811fa43a9e96bd1fdf417b86 upstream

Having everything in nospec-branch.h creates a hell of dependencies when
adding the prctl based switching mechanism. Move everything which is not
required in nospec-branch.h to spec-ctrl.h and fix up the includes in the
relevant files.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/nospec-branch.h |   14 --------------
 arch/x86/include/asm/spec-ctrl.h     |   21 +++++++++++++++++++++
 arch/x86/kernel/cpu/amd.c            |    2 +-
 arch/x86/kernel/cpu/bugs.c           |    2 +-
 arch/x86/kvm/svm.c                   |    2 +-
 arch/x86/kvm/vmx.c                   |    2 +-
 6 files changed, 25 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/include/asm/spec-ctrl.h

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -183,26 +183,12 @@ enum spectre_v2_mitigation {
 extern void x86_spec_ctrl_set(u64);
 extern u64 x86_spec_ctrl_get_default(void);
 
-/*
- * On VMENTER we must preserve whatever view of the SPEC_CTRL MSR
- * the guest has, while on VMEXIT we restore the host view. This
- * would be easier if SPEC_CTRL were architecturally maskable or
- * shadowable for guests but this is not (currently) the case.
- * Takes the guest view of SPEC_CTRL MSR as a parameter.
- */
-extern void x86_spec_ctrl_set_guest(u64);
-extern void x86_spec_ctrl_restore_host(u64);
-
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
 	SPEC_STORE_BYPASS_DISABLE,
 };
 
-/* AMD specific Speculative Store Bypass MSR data */
-extern u64 x86_amd_ls_cfg_base;
-extern u64 x86_amd_ls_cfg_rds_mask;
-
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
--- /dev/null
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SPECCTRL_H_
+#define _ASM_X86_SPECCTRL_H_
+
+#include <asm/nospec-branch.h>
+
+/*
+ * On VMENTER we must preserve whatever view of the SPEC_CTRL MSR
+ * the guest has, while on VMEXIT we restore the host view. This
+ * would be easier if SPEC_CTRL were architecturally maskable or
+ * shadowable for guests but this is not (currently) the case.
+ * Takes the guest view of SPEC_CTRL MSR as a parameter.
+ */
+extern void x86_spec_ctrl_set_guest(u64);
+extern void x86_spec_ctrl_restore_host(u64);
+
+/* AMD specific Speculative Store Bypass MSR data */
+extern u64 x86_amd_ls_cfg_base;
+extern u64 x86_amd_ls_cfg_rds_mask;
+
+#endif
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -9,7 +9,7 @@
 #include <asm/processor.h>
 #include <asm/apic.h>
 #include <asm/cpu.h>
-#include <asm/nospec-branch.h>
+#include <asm/spec-ctrl.h>
 #include <asm/smp.h>
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -12,7 +12,7 @@
 #include <linux/cpu.h>
 #include <linux/module.h>
 
-#include <asm/nospec-branch.h>
+#include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
 #include <asm/bugs.h>
 #include <asm/processor.h>
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -37,7 +37,7 @@
 #include <asm/desc.h>
 #include <asm/debugreg.h>
 #include <asm/kvm_para.h>
-#include <asm/nospec-branch.h>
+#include <asm/spec-ctrl.h>
 
 #include <asm/virtext.h>
 #include "trace.h"
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -48,7 +48,7 @@
 #include <asm/kexec.h>
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
-#include <asm/nospec-branch.h>
+#include <asm/spec-ctrl.h>
 
 #include "trace.h"
 #include "pmu.h"


