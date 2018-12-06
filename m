Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27846C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB944214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB944214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLFPxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:49819 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbeLFPxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:53:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 07:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,322,1539673200"; 
   d="scan'208";a="125655208"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga004.fm.intel.com with ESMTP; 06 Dec 2018 07:53:37 -0800
Date:   Thu, 6 Dec 2018 07:53:36 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] x86/mm/fault: Streamline the fault error_code decoder
 some more
Message-ID: <20181206155336.GC31263@linux.intel.com>
References: <20181205163624.1842-1-sean.j.christopherson@intel.com>
 <20181206073409.GA64887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206073409.GA64887@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:34:09AM +0100, Ingo Molnar wrote:
> I like your '!' idea, but with a further simplification: how about using 
> '-/+' differentiation and a single character and a fixed-length message.
> 
> The new output will be lines of:
> 
>   #PF error code: -P -W -U -S -I -K (0x00)
>   ...
>   #PF error code: -P -W +U +S -I -K (0x0c)
>   ...
>   #PF error code: +P +W +U +S +I +K (0x3f)
> 
> The symbol abbreviations are pretty self-explanatory:
> 
>   P = protection fault   (X86_PF_PROT)
>   W = write access       (X86_PF_WRITE)
>   U = user-mode access   (X86_PF_USER)
>   S = supervisor mode    (X86_PF_RSVD)
>   I = instruction fault  (X86_PF_INSTR)
>   K = keys fault         (X86_PF_PK)
> 
> Misc notes:
> 
> - In principle the new text is now short enough to include it in one of 
>   the existing output lines, further shortening the oops output - but I
>   havent done that in this patch.
> 
> - Another question is the ordering of the bits: the symbolic display is 
>   actually big endian, while the numeric hexa printout is little endian.
> 
>   I kind of still like it that way, not just because the decoding loop is 
>   more natural, but because the bits are actually ordered by importance: 
>   the PROT bits is more important than the INSTR or the PK bits - and the 
>   more important bits are displayed first.

Hmm, my eyes tend to be drawn to the end of the line, e.g. having PROT
be the last thing makes it stand out more than being buried in the middle
of the line.  Inverting the ordering between raw and decoded also makes
it very difficult to correlate the raw value with each bit.

> - Only build-tested the patch and looked at the generated assembly, but 
>   it all looks sane enough so will obviously work just fine! ;-)

...

>  /*
> - * This helper function transforms the #PF error_code bits into
> - * "[PROT] [USER]" type of descriptive, almost human-readable error strings:
> + * This maps the somewhat obscure error_code number to symbolic text:
> + *
> + * P = protection fault   (X86_PF_PROT)
> + * W = write access       (X86_PF_WRITE)
> + * U = user-mode access   (X86_PF_USER)
> + * S = supervisor mode    (X86_PF_RSVD)
> + * I = instruction fault  (X86_PF_INSTR)
> + * K = keys fault         (X86_PF_PK)
>   */
> -static void err_str_append(unsigned long error_code, char *buf, unsigned long mask, const char *txt)
> +static const char error_code_chars[] = "PWUSIK";
> +
> +/*
> + * This helper function transforms the #PF error_code bits into " +P -W +U -R -I -K"
> + * type of descriptive, almost human-readable error strings:
> + */
> +static void show_error_code(struct pt_regs *regs, unsigned long error_code)

No need for @regs.

>  {
> -     if (error_code & mask) {
> -             if (buf[0])
> -                     strcat(buf, " ");
> -             strcat(buf, txt);
> +     unsigned int bit, mask;
> +     char err_txt[6*3+1]; /* Fixed length of 6 bits decoded plus zero at the end */

Assuming the error code bits are contiguous breaks if/when SGX gets added,
which uses bit 15.  Oopsing on an SGX fault should be nigh impossible, but
it might be nice to be able to reuse show_error_code in other places.

Hardcoding "6" is also a bit painful.

> +
> +     /* We go from the X86_PF_PROT bit to the X86_PF_PK bit: */
> +
> +     for (bit = 0; bit < 6; bit++) {
> +             unsigned int offset = bit*3;
> +
> +             err_txt[offset+0] = ' ';
> +
> +             mask = 1 << bit;
> +             if (error_code & mask)
> +                     err_txt[offset+1] = '+';
> +             else
> +                     err_txt[offset+1] = '-';

To me, using '!' contrasts better when side-by-side with '+'.

> +
> +             err_txt[offset+2] = error_code_chars[bit];
>       }
> +
> +     /* Close the string: */
> +     err_txt[sizeof(err_txt)-1] = 0;
> +
> +     pr_alert("#PF error code: %s (%02lx)\n", err_txt, error_code);

The changelog example has a leading "0x" on the error code.  That being
said, I actually like it without the "0x".

How about printing the raw value before the colon?  Having it at the end
makes it look like extra noise.  And for me, seeing the raw code first
(reading left to right) cue's my brain that it's about to decode some
bits.

SGX will also break the two digit printing.  And for whatever reason four
digits makes me think "this is an error code!".  IIRC the vectoring ucode
makes a lot of assumptions about the error code being at most 16 bits, so
in theory four digits is all we'll ever need.

E.g.

[    0.144247] #PF error code:  +P -W -U -S -I -K (01)
[    0.144411] #PF error code:  +P +W -U -S -I -K (03)
[    0.144826] #PF error code:  +P +W +U -S -I -K (07)
[    0.145252] #PF error code:  +P -W +U -S -I +K (25)
[    0.145706] #PF error code:  -P +W -U -S -I -K (02)
[    0.146111] #PF error code:  -P -W +U -S -I -K (04)
[    0.146521] #PF error code:  -P +W +U -S -I -K (06)
[    0.146934] #PF error code:  -P -W +U -S +I -K (14)
[    0.147348] #PF error code:  +P -W -U -S +I -K (11)
[    0.147767] #PF error code:  -P -W -U -S -I -K (00)

vs. (with SGX added as 'G' for testing purposes)

[    0.158849] #PF error code(0001):  +P !W !U !S !I !K !G
[    0.159292] #PF error code(0003):  +P +W !U !S !I !K !G
[    0.159742] #PF error code(0007):  +P +W +U !S !I !K !G
[    0.160190] #PF error code(0025):  +P !W +U !S !I +K !G
[    0.160638] #PF error code(0002):  !P +W !U !S !I !K !G
[    0.161087] #PF error code(0004):  !P !W +U !S !I !K !G
[    0.161538] #PF error code(0006):  !P +W +U !S !I !K !G
[    0.161992] #PF error code(0014):  !P !W +U !S +I !K !G
[    0.162450] #PF error code(0011):  +P !W !U !S +I !K !G
[    0.162667] #PF error code(8001):  +P !W !U !S !I !K +G
[    0.162667] #PF error code(8003):  +P +W !U !S !I !K +G
[    0.162667] #PF error code(8007):  +P +W +U !S !I !K +G
[    0.162667] #PF error code(8025):  +P !W +U !S !I +K +G
[    0.162667] #PF error code(8002):  !P +W !U !S !I !K +G
[    0.162667] #PF error code(8004):  !P !W +U !S !I !K +G
[    0.162667] #PF error code(8006):  !P +W +U !S !I !K +G
[    0.162667] #PF error code(8014):  !P !W +U !S +I !K +G
[    0.162667] #PF error code(8011):  +P !W !U !S +I !K +G
[    0.162667] #PF error code(0000):  !P !W !U !S !I !K !G

vs. (with consistent ordering between raw and decoded)

[    0.153004] #PF error code(0001):  !K !I !S !U !W +P
[    0.153004] #PF error code(0003):  !K !I !S !U +W +P
[    0.153004] #PF error code(0007):  !K !I !S +U +W +P
[    0.153004] #PF error code(0025):  +K !I !S +U !W +P
[    0.153004] #PF error code(0002):  !K !I !S !U +W !P
[    0.153004] #PF error code(0004):  !K !I !S +U !W !P
[    0.153004] #PF error code(0006):  !K !I !S +U +W !P
[    0.153362] #PF error code(0014):  !K +I !S +U !W !P
[    0.153788] #PF error code(0011):  !K +I !S !U !W +P
[    0.154104] #PF error code(0000):  !K !I !S !U !W !P


A patch with the kitchen sink...
================================>

From 22e6d40e52b4341a424f065a138be54bc79d4db4 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <sean.j.christopherson@intel.com>
Date: Thu, 6 Dec 2018 07:25:13 -0800
Subject: [PATCH] x86/fault: Make show_error_code() more extensible and tweak
 its formatting

  - Initialize each bit individually in the error_code_chars array.  This
    allows for non-contiguous bits and is self-documenting.  Define a
    macro to make the initialization code somewhatmore readable.

  - Reverse the decode order so it's consistent with the raw display.

  - Use ARRAY_SIZE instead of hardcoding '6' in multiple locations.

  - Use '!' for the negative case to better contrast against '+'.

  - Display four digits (was two) when printing the raw error code.

  - Remove @regs from show_error_code().

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/mm/fault.c | 47 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 23dc7163f6ac..cd28d058ed39 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -605,45 +605,48 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 
 /*
  * This maps the somewhat obscure error_code number to symbolic text:
- *
- * P = protection fault   (X86_PF_PROT)
- * W = write access       (X86_PF_WRITE)
- * U = user-mode access   (X86_PF_USER)
- * S = supervisor mode    (X86_PF_RSVD)
- * I = instruction fault  (X86_PF_INSTR)
- * K = keys fault         (X86_PF_PK)
  */
-static const char error_code_chars[] = "PWUSIK";
+#define EC(x) ilog2(X86_PF_##x)
+static const char error_code_chars[] = {
+	[EC(PROT)]	= 'P',
+	[EC(WRITE)]	= 'W',
+	[EC(USER)]	= 'U',
+	[EC(RSVD)]	= 'S',
+	[EC(INSTR)]	= 'I',
+	[EC(PK)]	= 'K',
+};
 
 /*
- * This helper function transforms the #PF error_code bits into " +P -W +U -R -I -K"
+ * This helper function transforms the #PF error_code bits into " +P !W +U !R !I !K"
  * type of descriptive, almost human-readable error strings:
  */
-static void show_error_code(struct pt_regs *regs, unsigned long error_code)
+static void show_error_code(unsigned long error_code)
 {
-	unsigned int bit, mask;
-	char err_txt[6*3+1]; /* Fixed length of 6 bits decoded plus zero at the end */
+	char err_txt[ARRAY_SIZE(error_code_chars)*3+1]; /* 3 chars per bit plus zero at the end */
+	unsigned offset = 0;
+	unsigned long mask;
+	int i;
 
-	/* We go from the X86_PF_PROT bit to the X86_PF_PK bit: */
-
-	for (bit = 0; bit < 6; bit++) {
-		unsigned int offset = bit*3;
+	for (i = ARRAY_SIZE(error_code_chars) - 1; i >= 0; i--) {
+		if (!error_code_chars[i])
+			continue;
 
 		err_txt[offset+0] = ' ';
 
-		mask = 1 << bit;
+		mask = 1 << i;
 		if (error_code & mask)
 			err_txt[offset+1] = '+';
 		else
-			err_txt[offset+1] = '-';
+			err_txt[offset+1] = '!';
 
-		err_txt[offset+2] = error_code_chars[bit];
+		err_txt[offset+2] = error_code_chars[i];
+		offset += 3;
 	}
 
 	/* Close the string: */
-	err_txt[sizeof(err_txt)-1] = 0;
+	err_txt[offset] = 0;
 
-	pr_alert("#PF error code: %s (%02lx)\n", err_txt, error_code);
+	pr_alert("#PF error code(%04lx): %s\n", error_code, err_txt);
 }
 
 static void
@@ -676,7 +679,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
 		 (void *)address);
 
-	show_error_code(regs, error_code);
+	show_error_code(error_code);
 
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
 		struct desc_ptr idt, gdt;
-- 
2.19.2
