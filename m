Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE100C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E74320684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfBWKQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:16:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42315 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfBWKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:16:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1NAG8E4746080
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 23 Feb 2019 02:16:08 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1NAG6m3746076;
        Sat, 23 Feb 2019 02:16:06 -0800
Date:   Sat, 23 Feb 2019 02:16:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kees Cook <tipbot@zytor.com>
Message-ID: <tip-679cd5ce3bc7755bfe29ec22fa8d2cebede0d7c0@git.kernel.org>
Cc:     kernel-hardening@lists.openwall.com, keescook@chromium.org,
        mingo@kernel.org, jannh@google.com, hpa@zytor.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Reply-To: linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
          tglx@linutronix.de, jannh@google.com,
          kernel-hardening@lists.openwall.com, keescook@chromium.org,
          mingo@kernel.org, sean.j.christopherson@intel.com, hpa@zytor.com
In-Reply-To: <20190221180947.GA24138@beast>
References: <20190221180947.GA24138@beast>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Pin sensitive CR4 bits
Git-Commit-ID: 679cd5ce3bc7755bfe29ec22fa8d2cebede0d7c0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  679cd5ce3bc7755bfe29ec22fa8d2cebede0d7c0
Gitweb:     https://git.kernel.org/tip/679cd5ce3bc7755bfe29ec22fa8d2cebede0d7c0
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Thu, 21 Feb 2019 10:09:47 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Feb 2019 11:07:11 +0100

x86/asm: Pin sensitive CR4 bits

Several recent exploits have used direct calls to the native_write_cr4()
function to disable SMEP and SMAP before then continuing their exploits
using userspace memory access. This pins bits of cr4 so that they cannot
be changed through a common function. This is not intended to be general
ROP protection (which would require CFI to defend against properly), but
rather a way to avoid trivial direct function calling (or CFI bypassing
via a matching function prototype) as seen in:

https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html
(https://github.com/xairy/kernel-exploits/tree/master/CVE-2017-7308)

The goals of this change:
 - pin specific bits (SMEP, SMAP, and UMIP) when writing cr4.
 - avoid setting the bits too early (they must become pinned only after
   first being used).
 - pinning mask needs to be read-only during normal runtime.
 - pinning needs to be rechecked after set to avoid jumps into the middle
   of the function.

Using __ro_after_init on the mask is done so it can't be first disabled
with a malicious write. And since it becomes read-only, it must be avoided
writing to it later (hence the check for bits already having been set
instead of unconditionally writing to the mask).

The use of volatile is done to force the compiler to perform a full reload
of the mask after setting cr4 (to protect against just jumping into the
function past where the masking happens; it must check that the mask was
applied after the set). Due to how this function can be built by the
compiler (especially due to the removal of frame pointers), jumping into
the middle of the function frequently doesn't require stack manipulation to
construct a stack frame (there may only a retq without pops, which is
sufficient for use with exploits like timer overwrites mentioned above).

For example, without the recheck, the function may appear as:

   native_write_cr4:
      mov [pin], %rbx
      or  %rbx, %rdi
   1: mov %rdi, %cr4
      retq

The masking "or" could be trivially bypassed by just calling to label "1"
instead of "native_write_cr4". (CFI will force calls to only be able to
call into native_write_cr4, but CFI and CET are uncommon currently.)

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Link: https://lkml.kernel.org/r/20190221180947.GA24138@beast

---
 arch/x86/include/asm/special_insns.h | 13 +++++++++++++
 arch/x86/kernel/cpu/common.c         | 12 +++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe..fabda1400137 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -72,9 +72,22 @@ static inline unsigned long native_read_cr4(void)
 	return val;
 }
 
+extern volatile unsigned long cr4_pin;
+
 static inline void native_write_cr4(unsigned long val)
 {
+again:
+	val |= cr4_pin;
 	asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
+	/*
+	 * If the MOV above was used directly as a ROP gadget we can
+	 * notice the lack of pinned bits in "val" and start the function
+	 * from the beginning to gain the cr4_pin bits for sure.
+	 */
+	if (WARN_ONCE((val & cr4_pin) != cr4_pin,
+		      "Attempt to unpin cr4 bits: %lx, cr4 bypass attack?!",
+		      ~val & cr4_pin))
+		goto again;
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659..7e0ea4470f8e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -312,10 +312,16 @@ static __init int setup_disable_smep(char *arg)
 }
 __setup("nosmep", setup_disable_smep);
 
+volatile unsigned long cr4_pin __ro_after_init;
+EXPORT_SYMBOL_GPL(cr4_pin);
+
 static __always_inline void setup_smep(struct cpuinfo_x86 *c)
 {
-	if (cpu_has(c, X86_FEATURE_SMEP))
+	if (cpu_has(c, X86_FEATURE_SMEP)) {
+		if (!(cr4_pin & X86_CR4_SMEP))
+			cr4_pin |= X86_CR4_SMEP;
 		cr4_set_bits(X86_CR4_SMEP);
+	}
 }
 
 static __init int setup_disable_smap(char *arg)
@@ -334,6 +340,8 @@ static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 
 	if (cpu_has(c, X86_FEATURE_SMAP)) {
 #ifdef CONFIG_X86_SMAP
+		if (!(cr4_pin & X86_CR4_SMAP))
+			cr4_pin |= X86_CR4_SMAP;
 		cr4_set_bits(X86_CR4_SMAP);
 #else
 		cr4_clear_bits(X86_CR4_SMAP);
@@ -351,6 +359,8 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_UMIP))
 		goto out;
 
+	if (!(cr4_pin & X86_CR4_UMIP))
+		cr4_pin |= X86_CR4_UMIP;
 	cr4_set_bits(X86_CR4_UMIP);
 
 	pr_info_once("x86/cpu: User Mode Instruction Prevention (UMIP) activated\n");
