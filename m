Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqFM9wqYlnTRNhWqtHIzV8A7se6s0mET30hcI6zAhzao0QAccsqo4s1Iyc7YJdf+ANjEhY9
ARC-Seal: i=1; a=rsa-sha256; t=1526937350; cv=none;
        d=google.com; s=arc-20160816;
        b=ygSVxqvYD1hADv6CKkuCGmhDu2kpWz/4LVBtCtvjR2cDg+fgDfPAkC8r8oMhB2Wfl6
         1yB85fn24CbK1G2pQnFgl0845vaOJGfrD1rQKANgACIIbgK17MTXGPLa8GJZB5PtnYV9
         qKJqAyRmrl4yW5jXWYeArf/0GJHBaF4acFuZI5q5t1vPFRlAsrebrBU32jSdQmj7gQD/
         6nHa8lvqpWuJy94XkkhbjuTqYuIHuHq932Qmb4xXCdGrpITreAuxnmpFJFbM3+UgH7K/
         LPvO+WVTWn8xbET7zSa45HTw2+LgR37nIK6QrPQcmHJ8J/vFZmsrH/1NVG/FKYV9KeO9
         r4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2kkUq/ztxwSXhALMCzDKsLkvYPWQU1/W0tvTxs3czOU=;
        b=0s+UBp3tTF9TiItYWTMcoQsM/czyitk3ChvuHjQcHL62BpBq/DdmWj9wsyfk/m2O7D
         uuK7rQhuLuRJCE8DXquB2zoCg6zxcppu6stwI5QHpltmJaHVtn+J3j7QksA02Ak+0LvZ
         iBWyr3zLbsdWivDf7cNomPOr0Ml7dW///qUrJjhZMad0gh++sGOoZAlSYsKIzH1pMb/D
         PLMTWi0ZvJpssVXtQ//S+b47SC3WHDKrztr66Wo8w5I4yx6M6B+50n4nxBG1tAD316dZ
         XrHkyXKSmLBM76H06Owc9Fhyx9hw3XLfN3Y0vaLvOhdH1cJ1MmSIb3jyPx6/0zQeGCVf
         uy+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LpbJAWaF;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LpbJAWaF;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 48/87] x86/speculation: Create spec-ctrl.h to avoid include hell
Date: Mon, 21 May 2018 23:11:24 +0200
Message-Id: <20180521210424.792180894@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109858795528866?=
X-GMAIL-MSGID: =?utf-8?q?1601109858795528866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -45,7 +45,7 @@
 #include <asm/kvm_para.h>
 #include <asm/irq_remapping.h>
 #include <asm/microcode.h>
-#include <asm/nospec-branch.h>
+#include <asm/spec-ctrl.h>
 
 #include <asm/virtext.h>
 #include "trace.h"
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -50,7 +50,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/microcode.h>
-#include <asm/nospec-branch.h>
+#include <asm/spec-ctrl.h>
 
 #include "trace.h"
 #include "pmu.h"
