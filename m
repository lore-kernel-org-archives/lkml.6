Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25AFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EDD217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qkl9UbX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfBTAyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:54:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40936 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfBTAyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:54:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id bj4so11280946plb.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 16:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4uNdrUywJPhF+zhWxCJFV6yElKL+6Vip2BXw5eAd9JY=;
        b=Qkl9UbX0JOKpyIGJSyGo04tvxgJETZb97d87ynLaexx5wes08gEgEdnv9SwEQXkHpV
         uYeUUfX2JQt+tbA74da4SwE0VcgGsbPruw9wmb9Okccqvc6J188RaOH5MYBnX/Us4BIE
         1kVf86l4glKj07tWoNt1T6rratuUOnefZGBXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4uNdrUywJPhF+zhWxCJFV6yElKL+6Vip2BXw5eAd9JY=;
        b=quLzB5wwydFRCMK2BqNVn6CT4+fxO8WRH5v+7qoZ003fky6rL9/4iYSC277RkbljpT
         5VoWIiYrXsLXCKHs+/rnPOW4uMjAtJZJ3wiY0DgpmRU7RJHnyoKcVLPmPF0rirJkBzJW
         TctFBifbANvPRspaebp93PzdPr5IRfxfjZ0MV91zb9kkeKi6n+M9BkbubOS97wQRUuK9
         /JR8hFNZpdZ2AoZhocGCWtfQia2+OgFPMc0a7VZKM+wbp71YcdhhffbWfYhNNqVsq5Dr
         vslCfa79P20Jh32D1eAfXAv5EUmHr7Np0Ku7cJdf1kPPRZqTR4Maf3xRXbl/xsBlQFhK
         JRsA==
X-Gm-Message-State: AHQUAuYEtQsbI9Rs4u0JqxweqhcDu69X3wzruK4DaRUdXp3wK0ANFePI
        xFWbqtM+8zbLvsD3hGlVwXAaBcgvmLk=
X-Google-Smtp-Source: AHgI3IYOkXek+ihAEQeJpC/w9Zn1RhKGmQ0DFojiYLoEpYpF9F0eVUtF+TR4AyneBvQ8tax2Q+X4EA==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr22461887plr.174.1550624092061;
        Tue, 19 Feb 2019 16:54:52 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e26sm21217164pfi.70.2019.02.19.16.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 16:54:50 -0800 (PST)
Date:   Tue, 19 Feb 2019 16:54:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        x86@kernel.org
Subject: [PATCH] x86/asm: Pin sensitive CR4 bits
Message-ID: <20190220005449.GA25243@beast>
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
 arch/x86/include/asm/special_insns.h | 12 ++++++++++++
 arch/x86/kernel/cpu/common.c         | 12 +++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe..bb08b731a33b 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -72,9 +72,21 @@ static inline unsigned long native_read_cr4(void)
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
+	if (WARN_ONCE(cr4_pin && (val & cr4_pin) == 0,
+		      "cr4 pin bypass attempt?!\n"))
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
