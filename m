Return-Path: <kernel-hardening-return-13028-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/jtVC49OHiugWaQIXo6E0CJQ4in0c5KSVxAD2xv+RKC+cOMZ0NZOuYbIdL2hie51s3fP7S
ARC-Seal: i=1; a=rsa-sha256; t=1523990432; cv=none;
        d=google.com; s=arc-20160816;
        b=p7Tvm7FcBp5V0qTbPmBv2pMXm2XZynj6DjvW609tjxac37B0oAGeNaoopRt59ISVhK
         4+eEzChCIdF0L+ZCeY92aYXP4rs91JUCBXMNszLNb0TUec1VHuUtdzXeUuoIDGf9hIxF
         OejBBR+SOe5BMKfqdvP+9CZd73NjLhBArcfDvnSZQFcfRb/+eIoZTWgsVKiCp26KOZ8W
         JE3bWOxuhwp/t60ofwUKjGYd8kNnLusgx6otOInw6B5BCDO9gVhT9jUa/zEvEOD5XksJ
         3cdsGO4Um69edozIiAYZsDNynaC+UbqInHpTEgMCY+bxdTS6KUf5OWyo5lakD9oNiCyh
         aDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Su4TgIpDOWBPtee8Tc5v3AkKwJ6Ffacp4Hb8MCJZMo8=;
        b=JlGj4IL5UuR5EM5M/EpWYreB9JsVmH9iBfXgQJ8kObDhyt8EGoHUAaqm6FUD0pN4wf
         r0GFGVRKt81xzrALEeiPTMimP2EZWlMMoO0JSDzB+VFs2/419MyzU+ca3DlHJfKely0K
         Tpvdd6uYJiHgfKCRdwWDhuE4meLmO5YqdBbs1D9kl7jyumkW4X/IRtkkFfV+iERJqWx/
         BGiT7JE1WDzclPDpRG9FY4plf3rxSk+1Yi0k+bKb9aTHMxjkFF5ky6vpD+wQ1caRD8PL
         IUY5uylCVb86vYocRv3JGPFbOThh2gdTrp/STIidQN5ImGgcblET7pUUUeOSnTltEnzz
         FBdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13028-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13028-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13028-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13028-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	cdall@kernel.org,
	drjones@redhat.com,
	kvmarm@lists.cs.columbia.edu,
	linux-arch@vger.kernel.org,
	marc.zyngier@arm.com,
	mark.rutland@arm.com,
	ramana.radhakrishnan@arm.com,
	suzuki.poulose@arm.com,
	will.deacon@arm.com,
	linux-kernel@vger.kernel.org,
	awallis@codeaurora.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCHv3 11/11] arm64: docs: document pointer authentication
Date: Tue, 17 Apr 2018 19:37:35 +0100
Message-Id: <20180417183735.56985-12-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417183735.56985-1-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019791270913018?=
X-GMAIL-MSGID: =?utf-8?q?1598019791270913018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that we've added code to support pointer authentication, add some
documentation so that people can figure out if/how to use it.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Jones <drjones@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/arm64/booting.txt                |  8 +++
 Documentation/arm64/elf_hwcaps.txt             |  6 ++
 Documentation/arm64/pointer-authentication.txt | 84 ++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 Documentation/arm64/pointer-authentication.txt

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 8d0df62c3fe0..8df9f4658d6f 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -205,6 +205,14 @@ Before jumping into the kernel, the following conditions must be met:
     ICC_SRE_EL2.SRE (bit 0) must be initialised to 0b0.
   - The DT or ACPI tables must describe a GICv2 interrupt controller.
 
+  For CPUs with pointer authentication functionality:
+  - If EL3 is present:
+    SCR_EL3.APK (bit 16) must be initialised to 0b1
+    SCR_EL3.API (bit 17) must be initialised to 0b1
+  - If the kernel is entered at EL1:
+    HCR_EL2.APK (bit 40) must be initialised to 0b1
+    HCR_EL2.API (bit 41) must be initialised to 0b1
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.
diff --git a/Documentation/arm64/elf_hwcaps.txt b/Documentation/arm64/elf_hwcaps.txt
index d6aff2c5e9e2..ebc8b15b45fc 100644
--- a/Documentation/arm64/elf_hwcaps.txt
+++ b/Documentation/arm64/elf_hwcaps.txt
@@ -178,3 +178,9 @@ HWCAP_ILRCPC
 HWCAP_FLAGM
 
     Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0001.
+
+HWCAP_APIA
+
+    EL0 AddPac and Auth functionality using APIAKey_EL1 is enabled, as
+    described by Documentation/arm64/pointer-authentication.txt.
+
diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
new file mode 100644
index 000000000000..8a9cb5713770
--- /dev/null
+++ b/Documentation/arm64/pointer-authentication.txt
@@ -0,0 +1,84 @@
+Pointer authentication in AArch64 Linux
+=======================================
+
+Author: Mark Rutland <mark.rutland@arm.com>
+Date: 2017-07-19
+
+This document briefly describes the provision of pointer authentication
+functionality in AArch64 Linux.
+
+
+Architecture overview
+---------------------
+
+The ARMv8.3 Pointer Authentication extension adds primitives that can be
+used to mitigate certain classes of attack where an attacker can corrupt
+the contents of some memory (e.g. the stack).
+
+The extension uses a Pointer Authentication Code (PAC) to determine
+whether pointers have been modified unexpectedly. A PAC is derived from
+a pointer, another value (such as the stack pointer), and a secret key
+held in system registers.
+
+The extension adds instructions to insert a valid PAC into a pointer,
+and to verify/remove the PAC from a pointer. The PAC occupies a number
+of high-order bits of the pointer, which varies dependent on the
+configured virtual address size and whether pointer tagging is in use.
+
+A subset of these instructions have been allocated from the HINT
+encoding space. In the absence of the extension (or when disabled),
+these instructions behave as NOPs. Applications and libraries using
+these instructions operate correctly regardless of the presence of the
+extension.
+
+
+Basic support
+-------------
+
+When CONFIG_ARM64_PTR_AUTH is selected, and relevant HW support is
+present, the kernel will assign a random APIAKey value to each process
+at exec*() time. This key is shared by all threads within the process,
+and the key is preserved across fork(). Presence of functionality using
+APIAKey is advertised via HWCAP_APIA.
+
+Recent versions of GCC can compile code with APIAKey-based return
+address protection when passed the -msign-return-address option. This
+uses instructions in the HINT space, and such code can run on systems
+without the pointer authentication extension.
+
+The remaining instruction and data keys (APIBKey, APDAKey, APDBKey) are
+reserved for future use, and instructions using these keys must not be
+used by software until a purpose and scope for their use has been
+decided. To enable future software using these keys to function on
+contemporary kernels, where possible, instructions using these keys are
+made to behave as NOPs.
+
+The generic key (APGAKey) is currently unsupported. Instructions using
+the generic key must not be used by software.
+
+
+Debugging
+---------
+
+When CONFIG_ARM64_PTR_AUTH is selected, and relevant HW support is
+present, the kernel will expose the position of TTBR0 PAC bits in the
+NT_ARM_PAC_MASK regset (struct user_pac_mask), which userspace can
+acqure via PTRACE_GETREGSET.
+
+Separate masks are exposed for data pointers and instruction pointers,
+as the set of PAC bits can vary between the two. Debuggers should not
+expect that HWCAP_APIA implies the presence (or non-presence) of this
+regset -- in future the kernel may support the use of APIBKey, APDAKey,
+and/or APBAKey, even in the absence of APIAKey.
+
+Note that the masks apply to TTBR0 addresses, and are not valid to apply
+to TTBR1 addresses (e.g. kernel pointers).
+
+
+Virtualization
+--------------
+
+Pointer authentication is not currently supported in KVM guests. KVM
+will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
+the feature will result in an UNDEFINED exception being injected into
+the guest.
-- 
2.11.0
