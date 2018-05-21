Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrozSD+YsBqz9j+R1WHZknI+rX9b77cAIMDLT9HDFKD91l0NdKKUeswfRPahiCc6drEIsKC
ARC-Seal: i=1; a=rsa-sha256; t=1526937621; cv=none;
        d=google.com; s=arc-20160816;
        b=MbxWtTfcDuttgsnUh2gmCoaPUhiOOO7+lxm5BraVA9Yr6B694yqOnI2NjaZiw1DpsC
         ffLj4BBdVyz1ZZhe10FqBaoklHQ5/j+Pq1UUOsOD+3MfHtCZtl7ir7/W0CeN3t7x8Wo6
         0fnvUvkNIGqJu13HVU6STfgmeeen4T/dkaST8S0wWtDKkWlV5tp746RnbLD2bRvaKU3I
         gyx3UtthnxMEOYqc8a7XuM9UXupGdD5V3Ht88d0a29RnT4kAOfvdNPENZazbz5q03lnZ
         330sQfH6vuzeuzunDTNu2dvY4gklfzcWqvhsKJw3TUTTv8mRQyD0nH6sg2f5M53UkFko
         KeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=hNfhXn5z+8a2GWazsrWHbZM31fYi7omyOPsc/WLlBg0=;
        b=EMedbZixazhhug0f/SLfHLC6EOOflmObS77E9wlUOSwnkN296XsW+5BzUTw+4VycM/
         b88rpaXij0NrvsmKzdQrD9TexM6fJGK/sYFJuhh2GE0yROMh58gUU6cnVXV4GNL1AdU0
         VhN1NCtRd32ItPRdhUfqHHqMf9xwKl0OIzVMP55FmSfqUw249mwriyaPt3o5ENdli2Zs
         j/2L7mbJGcTBPMtORs2X1raTcCPl3umQQepb7NEk1daTTADxFLz2RW3aMC7+bVir/n1T
         HlecH7d6y3zFhez+xYjkJdcTo7hKEDzYl0d+NzJuy0W1NYXMVlLZxqDsg9MwTfpD4mb1
         4ztQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Go+DBx0W;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Go+DBx0W;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 60/95] x86/speculation: Create spec-ctrl.h to avoid include hell
Date: Mon, 21 May 2018 23:11:50 +0200
Message-Id: <20180521210458.863812227@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109858795528866?=
X-GMAIL-MSGID: =?utf-8?q?1601110143279582831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -46,7 +46,7 @@
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
