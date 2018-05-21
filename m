Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqvFBB5Xti5RIxmKOGG5ILC843gJmJ2JnnWSwA0gJacGJuh+I2fhBtafRP6FBYYo0wLEFCU
ARC-Seal: i=1; a=rsa-sha256; t=1526937918; cv=none;
        d=google.com; s=arc-20160816;
        b=Kt8bI9/eeoOhiiHRgw9NwcmAW6bEc+jBB/KwhqkRXpPNslBxnNTpqgx6APZqm0XzkJ
         Q2JHIfLZ1hp1cXk9WuZk7mlJBXhM1KSD5VRT+HGpK0WJXZeMsI/yRMl5qQ2uYOaRaE09
         V8uZL5yTjBZQGPz0SGkDhMu+91iPb+B3nLSigwz4FBGqTdnn+/A4p0jXid1/Qq1fivv7
         rb5Wjf17ic/xNdMu5DymV8hPXsnopEVzphOCe68yGPw2NoUGz52VHjh9x1JFD00w2ki9
         PZr0rkhjl80mjAbGP1VSjXRbdrgCJ4+G7EwT7oFVfiTz+gypJhiHFhNdVuW37eWF0AiX
         BiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=gotOT8uT4a0XZh1Q3CscamaYwSadi5OsqwurGRokiQ8=;
        b=pmwrY/juh36NvVGAum1qHhdhvFRF2j3sbx0csKc6Biq9NkQ50ENmHvQME6hprR5JrC
         +lTBUCFR+m7iuSkV/uF9KtXvQ/Ejvzr3RzgY+sEgcbSsy3Iy/LWyd2Tqo/KB6N2uHeo4
         eDNroElJqbaaFkHL1fZiC4e3WEOFCWhetIGo4j4sikUA2ix+mkMJdBifiM8r4CfXnh/i
         ns6jn8xyUbSAfB6VhRZHDMV9mexXQv8a2xb05Kj3Zla+g+POAAIcHCyFUuQZdjO+4vGI
         tBLtzAloqy7JpmOpGLZ5IVO+rk7ue9ys9RdXEdYiYatr6EaO0J8DgZIA/p0J2KEotj/1
         sLlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IFOE1syf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IFOE1syf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 074/110] x86/speculation: Create spec-ctrl.h to avoid include hell
Date: Mon, 21 May 2018 23:12:11 +0200
Message-Id: <20180521210512.695964768@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109858795528866?=
X-GMAIL-MSGID: =?utf-8?q?1601110454869233305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -228,26 +228,12 @@ enum spectre_v2_mitigation {
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
@@ -10,7 +10,7 @@
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
@@ -13,7 +13,7 @@
 #include <linux/cpu.h>
 #include <linux/module.h>
 
-#include <asm/nospec-branch.h>
+#include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
 #include <asm/bugs.h>
 #include <asm/processor.h>
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -50,7 +50,7 @@
 #include <asm/kvm_para.h>
 #include <asm/irq_remapping.h>
 #include <asm/microcode.h>
-#include <asm/nospec-branch.h>
+#include <asm/spec-ctrl.h>
 
 #include <asm/virtext.h>
 #include "trace.h"
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -52,7 +52,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/mmu_context.h>
 #include <asm/microcode.h>
-#include <asm/nospec-branch.h>
+#include <asm/spec-ctrl.h>
 
 #include "trace.h"
 #include "pmu.h"
