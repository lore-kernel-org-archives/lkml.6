Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB95C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E2C2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E2C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLFWTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:19:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:39981 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeLFWTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:19:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 14:19:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="99313301"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga008.jf.intel.com with ESMTP; 06 Dec 2018 14:19:28 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [RFC PATCH v2 4/4] x86/vdso: Add __vdso_sgx_enter_enclave() to wrap SGX enclave transitions
Date:   Thu,  6 Dec 2018 14:19:22 -0800
Message-Id: <20181206221922.31012-5-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206221922.31012-1-sean.j.christopherson@intel.com>
References: <20181206221922.31012-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Software Guard Extensions (SGX) SGX introduces a new CPL3-only
enclave mode that runs as a sort of black box shared object that is
hosted by an untrusted normal CPL3 process.

Enclave transitions have semantics that are a lovely blend of SYCALL,
SYSRET and VM-Exit.  In a non-faulting scenario, entering and exiting
an enclave can only be done through SGX-specific instructions, EENTER
and EEXIT respectively.  EENTER+EEXIT is analogous to SYSCALL+SYSRET,
e.g. EENTER/SYSCALL load RCX with the next RIP and EEXIT/SYSRET load
RIP from R{B,C}X.

But in a faulting/interrupting scenario, enclave transitions act more
like VM-Exit and VMRESUME.  Maintaining the black box nature of the
enclave means that hardware must automatically switch CPU context when
an Asynchronous Exiting Event (AEE) occurs, an AEE being any interrupt
or exception (exceptions are AEEs because asynchronous in this context
is relative to the enclave and not CPU execution, e.g. the enclave
doesn't get an opportunity to save/fuzz CPU state).

Like VM-Exits, all AEEs jump to a common location, referred to as the
Asynchronous Exiting Point (AEP).  The AEP is specified at enclave entry
via register passed to EENTER/ERESUME, similar to how the hypervisor
specifies the VM-Exit point (via VMCS.HOST_RIP at VMLAUNCH/VMRESUME).
Resuming the enclave/VM after the exiting event is handled is done via
ERESUME/VMRESUME respectively.  In SGX, AEEs that are handled by the
kernel, e.g. INTR, NMI and most page faults, IRET will journey back to
the AEP which then ERESUMEs th enclave.

Enclaves also behave a bit like VMs in the sense that they can generate
exceptions as part of their normal operation that for all intents and
purposes need to handled in the enclave/VM.  However, unlike VMX, SGX
doesn't allow the host to modify its guest's, a.k.a. enclave's, state,
as doing so would circumvent the enclave's security.  So to handle an
exception, the enclave must first be re-entered through the normal
EENTER flow (SYSCALL/SYSRET behavior), and then resumed via ERESUME
(VMRESUME behavior) after the source of the exception is resolved.

All of the above is just the tip of the iceberg when it comes to running
an enclave.  But, SGX was designed in such a way that the host process
can utilize a library to build, launch and run an enclave.  This is
roughly analogous to how e.g. libc implementations are used by most
applications so that the application can focus on its business logic.

The big gotcha is that because enclaves can generate *and* handle
exceptions, any SGX library must be prepared to handle nearly any
exception at any time (well, any time a thread is executing in an
enclave).  In Linux, this means the SGX library must register a
signal handler in order to intercept relevant exceptions and forward
them to the enclave (or in some cases, take action on behalf of the
enclave).  Unfortunately, Linux's signal mechanism doesn't mesh well
with libraries, e.g. signal handlers are process wide, are difficult
to chain, etc...  This becomes particularly nasty when using multiple
levels of libraries that register signal handlers, e.g. running an
enclave via cgo inside of the Go runtime.

In comes vDSO to save the day.  Now that vDSO can fixup exceptions,
add a function, __vdso_sgx_enter_enclave(), to wrap enclave transitions
and intercept any exceptions that occur when running the enclave.

__vdso_sgx_enter_enclave() accepts four parameters:

  - A pointer to a Thread Control Structure (TCS).  A TCS is a page
    within the enclave that defines/tracks the context of an enclave
    thread.

  - An opaque pointer passed to the enclave via RDI, e.g. to marshal
    data into the enclave.

  - A pointer to a struct sgx_enclave_exit_info that is used to relay
    exit/fault information back to the caller.  The primary variable
    in the exit info is the ENCLU leaf at the time of exit, which can
    be queried to determine whether the enclave exited cleanly (EEXIT),
    or took an exception (EENTER or ERESUME).

    The exact leaf is captured, instead of e.g. a fault flag, so that
    the caller can identity whether a fault occurred in the enclave or
    on EENTER.   A fault on EENTER generally means the enclave has died
    and needs to be restarted.

    On a clean EEXIT, registers RDI, RSI and RDX are captured as-is,
    e.g. to pass data out of the enclave.  On a fault that is reported
    to the caller, the exit info is stuffed (by way of the vDSO fixup
    handler) with the trapnr, error_code and address.  Not all enclave
    exits are reported to the caller, e.g. interrupts and faults that
    are handled by the kernel do not trigger fixup and IRET back to
    ENCLU[ERESUME], i.e. unconditionally resume the enclave.

  - An optional exit handler that, when defined, is invoked prior to
    returning.  The callback provides the enclave's untrusted runtime an
    opportunity to resolve a fault or service a remote procedure call
    without losing its stack context.

    In addition to allowing the runtime to do silly shenanigans with its
    stack, e.g. pushing data onto the stack from within the enclave, the
    handler approach preserves the full call stack for debugging purposes.
    For example, to accept a new EPC page into the enclave, an enclave
    with a single TCS must re-EENTER the enclave using the same TCS to
    EACCEPT the new page prior to executing ERESUME to restart at the
    fault context.  The handler approach allows reentry without undoing
    the original call stack, i.e. preserves the view of the original
    interrupted call.

    Note that this effectively requires userspace to implement an exit
    handler if they want to support correctable enclave faults, as there
    is no other way to request ERESUME.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/entry/vdso/Makefile             |   1 +
 arch/x86/entry/vdso/vdso.lds.S           |   1 +
 arch/x86/entry/vdso/vsgx_enter_enclave.c | 119 +++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 arch/x86/entry/vdso/vsgx_enter_enclave.c

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index eb543ee1bcec..8b530e20e8be 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -18,6 +18,7 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs-$(VDSO64-y)		+= vsgx_enter_enclave.o
 
 # files to link into kernel
 obj-y				+= vma.o extable.o
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index d3a2dce4cfa9..50952a995a6c 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -25,6 +25,7 @@ VERSION {
 		__vdso_getcpu;
 		time;
 		__vdso_time;
+		__vdso_sgx_enter_enclave;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vsgx_enter_enclave.c b/arch/x86/entry/vdso/vsgx_enter_enclave.c
new file mode 100644
index 000000000000..896c2eb079bb
--- /dev/null
+++ b/arch/x86/entry/vdso/vsgx_enter_enclave.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2018 Intel Corporation.
+
+#include <uapi/linux/errno.h>
+#include <uapi/linux/types.h>
+
+#include "extable.h"
+
+/*
+ * The exit info/handler definitions will live elsewhere in the actual
+ * implementation, e.g. arch/x86/include/uapi/asm/sgx.h.
+ */
+struct sgx_enclave_exit_info {
+	__u32   leaf;
+	union {
+		struct {
+			__u16 trapnr;
+			__u16 error_code;
+			__u64 address;
+		} fault;
+		struct {
+			__u64 rdi;
+			__u64 rsi;
+			__u64 rdx;
+		} eexit;
+	};
+};
+
+typedef long (sgx_enclave_exit_handler)(struct sgx_enclave_exit_info *exit_info,
+					void *tcs, void *priv);
+
+/*
+ * ENCLU (ENCLave User) is an umbrella instruction for a variety of CPL3
+ * SGX functions,  The ENCLU function that is executed is specified in EAX,
+ * with each function potentially having more leaf-specific operands beyond
+ * EAX.  In the vDSO we're only concerned with the leafs that are used to
+ * transition to/from the enclave.
+ */
+enum sgx_enclu_leaf {
+	SGX_EENTER	= 2,
+	SGX_ERESUME	= 3,
+	SGX_EEXIT	= 4,
+};
+
+notrace long __vdso_sgx_enter_enclave(void *tcs, void *priv,
+				      struct sgx_enclave_exit_info *exit_info,
+				      sgx_enclave_exit_handler *exit_handler)
+{
+	u64 rdi, rsi, rdx;
+	u32 leaf;
+
+	if (!tcs || !exit_info)
+		return -EINVAL;
+
+	leaf = SGX_EENTER;
+
+enter_enclave:
+	asm volatile(
+		/*
+		 * When an event occurs in an enclave, hardware first exits the
+		 * enclave to the AEP, switching CPU context along the way, and
+		 * *then* delivers the event as usual.  As part of the context
+		 * switching, registers are loaded with synthetic state (except
+		 * BP and SP, which are saved/restored).  The defined synthetic
+		 * state loads registers so that simply executing ENCLU will do
+		 * ERESUME, e.g. RAX=4, RBX=TCS and RCX=AEP after an AEE.  So,
+		 * we only need to load RAX, RBX and RCX for the initial entry.
+		 * The AEP can point at that same ENCLU, fixup will jump us out
+		 * if an exception was unhandled.
+		 */
+		"	lea	1f(%%rip), %%rcx\n"
+		"1:	enclu\n"
+		"2:\n"
+
+		".pushsection .fixup, \"ax\" \n"
+		"3:	jmp 2b\n"
+		".popsection\n"
+		_ASM_VDSO_EXTABLE_HANDLE(1b, 3b)
+
+		: "=a"(leaf), "=D" (rdi), "=S" (rsi), "=d" (rdx)
+		: "a" (leaf), "b" (tcs), "D" (priv)
+		: "cc", "memory",
+		  "rcx", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
+	);
+
+	/*
+	 * EEXIT means we left the assembly blob via EEXIT, anything else is
+	 * an unhandled exception (handled exceptions and interrupts simply
+	 * ERESUME from the AEP).
+	 */
+	exit_info->leaf = leaf;
+	if (leaf == SGX_EEXIT) {
+		exit_info->eexit.rdi = rdi;
+		exit_info->eexit.rsi = rsi;
+		exit_info->eexit.rdx = rdx;
+	} else {
+		exit_info->fault.trapnr = rdi;
+		exit_info->fault.error_code = rsi;
+		exit_info->fault.address = rdx;
+	}
+
+	/*
+	 * Invoke the caller's exit handler if one was provided.  The return
+	 * value tells us whether to re-enter the enclave (EENTER or ERESUME)
+	 * or to return (EEXIT).
+	 */
+	if (exit_handler) {
+		leaf = exit_handler(exit_info, tcs, priv);
+		if (leaf == SGX_EENTER || leaf == SGX_ERESUME)
+			goto enter_enclave;
+		if (leaf == SGX_EEXIT)
+			return 0;
+		return -EINVAL;
+	} else if (leaf != SGX_EEXIT) {
+		return -EFAULT;
+	}
+
+	return 0;
+}
-- 
2.19.2

