Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAB1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711FB20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711FB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeLGSkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:40:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52214 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbeLGSkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:40:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05B11165C;
        Fri,  7 Dec 2018 10:40:52 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22BD3F5AF;
        Fri,  7 Dec 2018 10:40:48 -0800 (PST)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/13] arm64: docs: document pointer authentication
Date:   Fri,  7 Dec 2018 18:39:31 +0000
Message-Id: <20181207183931.4285-14-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Now that we've added code to support pointer authentication, add some
documentation so that people can figure out if/how to use it.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Reviewed-by: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Andrew Jones <drjones@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/arm64/booting.txt                |  8 +++
 Documentation/arm64/cpu-feature-registers.txt  |  8 +++
 Documentation/arm64/elf_hwcaps.txt             | 12 ++++
 Documentation/arm64/pointer-authentication.txt | 93 ++++++++++++++++++++++++++
 4 files changed, 121 insertions(+)
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
diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
index 7964f03846b1..d4b4dd1fe786 100644
--- a/Documentation/arm64/cpu-feature-registers.txt
+++ b/Documentation/arm64/cpu-feature-registers.txt
@@ -184,12 +184,20 @@ infrastructure:
      x--------------------------------------------------x
      | Name                         |  bits   | visible |
      |--------------------------------------------------|
+     | GPI                          | [31-28] |    y    |
+     |--------------------------------------------------|
+     | GPA                          | [27-24] |    y    |
+     |--------------------------------------------------|
      | LRCPC                        | [23-20] |    y    |
      |--------------------------------------------------|
      | FCMA                         | [19-16] |    y    |
      |--------------------------------------------------|
      | JSCVT                        | [15-12] |    y    |
      |--------------------------------------------------|
+     | API                          | [11-8]  |    y    |
+     |--------------------------------------------------|
+     | APA                          | [7-4]   |    y    |
+     |--------------------------------------------------|
      | DPB                          | [3-0]   |    y    |
      x--------------------------------------------------x
 
diff --git a/Documentation/arm64/elf_hwcaps.txt b/Documentation/arm64/elf_hwcaps.txt
index ea819ae024dd..13d6691b37be 100644
--- a/Documentation/arm64/elf_hwcaps.txt
+++ b/Documentation/arm64/elf_hwcaps.txt
@@ -182,3 +182,15 @@ HWCAP_FLAGM
 HWCAP_SSBS
 
     Functionality implied by ID_AA64PFR1_EL1.SSBS == 0b0010.
+
+HWCAP_PACA
+
+    Functionality implied by ID_AA64ISAR1_EL1.APA == 0b0001 or
+    ID_AA64ISAR1_EL1.API == 0b0001, as described by
+    Documentation/arm64/pointer-authentication.txt.
+
+HWCAP_PACG
+
+    Functionality implied by ID_AA64ISAR1_EL1.GPA == 0b0001 or
+    ID_AA64ISAR1_EL1.GPI == 0b0001, as described by
+    Documentation/arm64/pointer-authentication.txt.
diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
new file mode 100644
index 000000000000..5baca42ba146
--- /dev/null
+++ b/Documentation/arm64/pointer-authentication.txt
@@ -0,0 +1,93 @@
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
+The extension provides five separate keys to generate PACs - two for
+instruction addresses (APIAKey, APIBKey), two for data addresses
+(APDAKey, APDBKey), and one for generic authentication (APGAKey).
+
+
+Basic support
+-------------
+
+When CONFIG_ARM64_PTR_AUTH is selected, and relevant HW support is
+present, the kernel will assign random key values to each process at
+exec*() time. The keys are shared by all threads within the process, and
+are preserved across fork().
+
+Presence of address authentication functionality is advertised via
+HWCAP_PACA, and generic authentication functionality via HWCAP_PACG.
+
+The number of bits that the PAC occupies in a pointer is 55 minus the
+virtual address size configured by the kernel. For example, with a
+virtual address size of 48, the PAC is 7 bits wide.
+
+Recent versions of GCC can compile code with APIAKey-based return
+address protection when passed the -msign-return-address option. This
+uses instructions in the HINT space (unless -march=armv8.3-a or higher
+is also passed), and such code can run on systems without the pointer
+authentication extension.
+
+In addition to exec(), keys can also be reinitialized to random values
+using the PR_PAC_RESET_KEYS prctl. A bitmask of PR_PAC_APIAKEY,
+PR_PAC_APIBKEY, PR_PAC_APDAKEY, PR_PAC_APDBKEY and PR_PAC_APGAKEY
+specifies which keys are to be reinitialized; specifying 0 means "all
+keys".
+
+
+Debugging
+---------
+
+When CONFIG_ARM64_PTR_AUTH is selected, and HW support for address
+authentication is present, the kernel will expose the position of TTBR0
+PAC bits in the NT_ARM_PAC_MASK regset (struct user_pac_mask), which
+userspace can acquire via PTRACE_GETREGSET.
+
+The regset is exposed only when HWCAP_PACA is set. Separate masks are
+exposed for data pointers and instruction pointers, as the set of PAC
+bits can vary between the two. Note that the masks apply to TTBR0
+addresses, and are not valid to apply to TTBR1 addresses (e.g. kernel
+pointers).
+
+Additionally, when CONFIG_CHECKPOINT_RESTORE is also set, the kernel
+will expose the NT_ARM_PACA_KEYS and NT_ARM_PACG_KEYS regsets (struct
+user_pac_address_keys and struct user_pac_generic_keys). These can be
+used to get and set the keys for a thread.
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

