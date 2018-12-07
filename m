Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D5CC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD03E20672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="b5wItN3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD03E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeLGSjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:39:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45374 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeLGSjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:39:43 -0500
Received: from zn.tnic (p200300EC2BCEC900C13752FC2028AE4C.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:c900:c137:52fc:2028:ae4c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A20BD1EC0BF1;
        Fri,  7 Dec 2018 19:39:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544207981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XUKpLqj7/xXg9jrI/lIGAqGvEsgVQSKGIb3E3fRsWzM=;
        b=b5wItN3SwdasANuLmiz4/mUehomJUuovnbv3/wVQykDxDRROUyfxrQmt4PrEJWGl9M8o44
        VFwCb17KwiL/D1Xkz/iOZBFHSCSG1I8/z/5mfI+xMa8k7iWYLoZtkoDmKar55jONfrS3r3
        CLRZITscbBwkEVXEwOfi2SEKlR5Fg8c=
Date:   Fri, 7 Dec 2018 19:39:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
Message-ID: <20181207183934.GF9385@zn.tnic>
References: <20181119184556.11479-1-bp@alien8.de>
 <20181123200307.GA6223@roeck-us.net>
 <20181123204425.GN30697@zn.tnic>
 <901af2a0-e0d7-586d-5f04-2066cf1ac871@roeck-us.net>
 <20181123210739.GO30697@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181123210739.GO30697@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

I have something which looks like it works here, even with the pentium3
qemu CPU. I'll be hammering on it in the coming days but if you wanna
give it a try, here's a conglomerate patch:

---
From 0c6adce02d2e7f3b5bbdc4cbe3eb3dae99448def Mon Sep 17 00:00:00 2001
From: Borislav Petkov <bp@suse.de>
Date: Fri, 7 Dec 2018 18:54:23 +0100
Subject: [PATCH] WIP

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/alternative.h | 26 +++++++++++++++++++++++++-
 arch/x86/include/asm/msr.h         | 16 ++++++++++++++--
 arch/x86/kernel/alternative.c      |  4 ++--
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index ea9886651c39..db8ebe5dd5be 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -114,6 +114,16 @@ static inline int alternatives_text_reserved(void *start, void *end)
 		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
 	alt_end_marker ":\n"
 
+#define OLDINSTR_3(oldinsn, n1, n2, n3)								\
+	"# ALT: oldinstr\n"										\
+	"661:\n\t" oldinsn "\n662:\n"								\
+	"# ALT: padding\n"										\
+	".skip -((" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
+		" - (" alt_slen ")) > 0) * "							\
+		"(" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
+		" - (" alt_slen ")), 0x90\n"							\
+	alt_end_marker ":\n"
+
 #define ALTINSTR_ENTRY(feature, num)					      \
 	" .long 661b - .\n"				/* label           */ \
 	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
@@ -122,7 +132,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
 	" .byte " alt_pad_len "\n"			/* pad len */
 
-#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */     \
+#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */	\
+	"# ALT: replacement " #num "\n"						\
 	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n\t"
 
 /* alternative assembly primitive: */
@@ -146,6 +157,19 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
 	".popsection\n"
 
+#define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
+	OLDINSTR_3(oldinsn, 1, 2, 3)						\
+	".pushsection .altinstructions,\"a\"\n"					\
+	ALTINSTR_ENTRY(feat1, 1)						\
+	ALTINSTR_ENTRY(feat2, 2)						\
+	ALTINSTR_ENTRY(feat3, 3)						\
+	".popsection\n"								\
+	".pushsection .altinstr_replacement, \"ax\"\n"				\
+	ALTINSTR_REPLACEMENT(newinsn1, feat1, 1)				\
+	ALTINSTR_REPLACEMENT(newinsn2, feat2, 2)				\
+	ALTINSTR_REPLACEMENT(newinsn3, feat3, 3)				\
+	".popsection\n"
+
 /*
  * Alternative instructions for different CPU types or capabilities.
  *
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 91e4cf189914..5cc3930cb465 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -217,6 +217,8 @@ static __always_inline unsigned long long rdtsc(void)
  */
 static __always_inline unsigned long long rdtsc_ordered(void)
 {
+	DECLARE_ARGS(val, low, high);
+
 	/*
 	 * The RDTSC instruction is not ordered relative to memory
 	 * access.  The Intel SDM and the AMD APM are both vague on this
@@ -227,9 +229,19 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	 * ordering guarantees as reading from a global memory location
 	 * that some other imaginary CPU is updating continuously with a
 	 * time stamp.
+	 *
+	 * Thus, use the preferred barrier on the respective CPU, aiming for
+	 * RDTSCP as the default.
 	 */
-	barrier_nospec();
-	return rdtsc();
+	asm volatile(ALTERNATIVE_3("rdtsc",
+				   "mfence; rdtsc", X86_FEATURE_MFENCE_RDTSC,
+				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
+				   "rdtscp", X86_FEATURE_RDTSCP)
+			: EAX_EDX_RET(val, low, high)
+			/* RDTSCP clobbers ECX with MSR_TSC_AUX. */
+			:: "ecx");
+
+	return EAX_EDX_VAL(val, low, high);
 }
 
 static inline unsigned long long native_read_pmc(int counter)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ebeac487a20c..d458c7973c56 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -393,10 +393,10 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			continue;
 		}
 
-		DPRINTK("feat: %d*32+%d, old: (%px len: %d), repl: (%px, len: %d), pad: %d",
+		DPRINTK("feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
-			instr, a->instrlen,
+			instr, instr, a->instrlen,
 			replacement, a->replacementlen, a->padlen);
 
 		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
-- 
2.19.1


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
