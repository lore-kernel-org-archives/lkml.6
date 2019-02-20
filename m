Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A98C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CEE20645
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H8792qCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfBTSJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:09:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46650 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfBTSJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:09:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so12272064pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 10:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3zRdEL3mrQi6BTMqUM38gIfO1gQ/S5BNofYyNhfXEJk=;
        b=H8792qCTtFdcjAADs2L4QV6NOpEh8gEMiK/RLDcUpPmgf6TBkmmQVwewtsYDEXLDbG
         brHvHNunZQcJfCC6RbjM5ACzvtlJNJc/jlBPENiISsNTnlKFCyn3P2MM6ik77u0UJ0Yp
         a+tcFn3ezWwNWDDt0Mk/kcPVP/xRTSjZbJ2c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3zRdEL3mrQi6BTMqUM38gIfO1gQ/S5BNofYyNhfXEJk=;
        b=k0vaukJmiDuWbzUM3ak5YitAV0t0QI+2k55vTWrdKzSqC3mNN3COR0n7ll4sLJeVa3
         SPBZQqOVxRzn050puhLz66eEqGDgAOprc5n32svlv6UrESq6TwjwClvM6rTkCO3c1wvF
         51EIWKRFDqa+mCEPuTnrXdSCRybYMMHzzXdbJQo6abSXymHg+pyrlRZ3tTvqjQYbAf7W
         c1pubByrBtDHmjb+W4IvoVB0hkuuyuwpgpYTxguvd9DNggjQ66TxTGnfr8q0/INOt6d/
         OPDy5Pri0jN8bbNL9O9CcOv2HlfKfHV2yfrTgFG5d8mL3RFGlcm0QzoVelZpJCRIDLpu
         xneA==
X-Gm-Message-State: AHQUAuYAwlLP50Id7XnfbdOJdBIc0lcVpq6Nf4bqHNLgVyNZzbuglOLo
        6/5VA4LG0y/HoiWr7Qk5ba/ArA==
X-Google-Smtp-Source: AHgI3IY3bS6c53ienlkeLVhdUHsaTUVEml+YfuLwWeq7/TB8w1M1WLqZsIz9UPr/Z7/OBOCDsWTDxw==
X-Received: by 2002:a62:b242:: with SMTP id x63mr24257848pfe.4.1550686176132;
        Wed, 20 Feb 2019 10:09:36 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a5sm21557313pgv.12.2019.02.20.10.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 10:09:35 -0800 (PST)
Date:   Wed, 20 Feb 2019 10:09:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        x86@kernel.org
Subject: [PATCH v2] x86/asm: Pin sensitive CR4 bits
Message-ID: <20190220180934.GA46255@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
with a malicious write. And since it becomes read-only, we must avoid
writing to it later (hence the check for bits already having been set
instead of unconditionally writing to the mask).

The use of volatile is done to force the compiler to perform a full reload
of the mask after setting cr4 (to protect against just jumping into the
function past where the masking happens; we must check that the mask was
applied after we do the set). Due to how this function can be built by the
compiler (especially due to the removal of frame pointers), jumping into
the middle of the function frequently doesn't require stack manipulation
to construct a stack frame (there may only a retq without pops, which is
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
---
v2: fix think-o in cr4_pin recheck (Jann Horn)
---
 arch/x86/include/asm/special_insns.h | 11 +++++++++++
 arch/x86/kernel/cpu/common.c         | 12 +++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe..4c26004ed5d4 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -72,9 +72,20 @@ static inline unsigned long native_read_cr4(void)
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
+	if (WARN_ONCE((val & cr4_pin) != cr4_pin, "cr4 bypass attempt?!\n"))
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
-- 
2.17.1


-- 
Kees Cook
