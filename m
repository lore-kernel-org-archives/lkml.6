Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6522075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6522075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389714AbeGPIMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:12:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388975AbeGPIMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:12:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3C42ECEA;
        Mon, 16 Jul 2018 07:45:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 24/43] x86/cpufeature: Get rid of the non-asm goto variant
Date:   Mon, 16 Jul 2018 09:36:29 +0200
Message-Id: <20180716073514.490563926@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@alien8.de>

commit a362bf9f5e7dd659b96d01382da7b855f4e5a7a1 upstream

I can simply quote hpa from the mail:

  "Get rid of the non-asm goto variant and just fall back to
   dynamic if asm goto is unavailable. It doesn't make any sense,
   really, if it is supposed to be safe, and by now the asm
   goto-capable gcc is in more wide use. (Originally the gcc 3.x
   fallback to pure dynamic didn't exist, either.)"

Booy, am I lazy.

Cleanup the whole CC_HAVE_ASM_GOTO ifdeffery too, while at it.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20160127084325.GB30712@pd.tnic
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeature.h |   49 +++-----------------------------------
 1 file changed, 5 insertions(+), 44 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -131,17 +131,16 @@ extern const char * const x86_bug_flags[
  * fast paths and boot_cpu_has() otherwise!
  */
 
-#if __GNUC__ >= 4 && defined(CONFIG_X86_FAST_FEATURE_TESTS)
+#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_X86_FAST_FEATURE_TESTS)
 extern bool __static_cpu_has(u16 bit);
 
 /*
  * Static testing of CPU features.  Used the same as boot_cpu_has().
- * These are only valid after alternatives have run, but will statically
- * patch the target code for additional performance.
+ * These will statically patch the target code for additional
+ * performance.
  */
 static __always_inline __pure bool _static_cpu_has(u16 bit)
 {
-#ifdef CC_HAVE_ASM_GOTO
 		asm_volatile_goto("1: jmp %l[t_dynamic]\n"
 			 "2:\n"
 			 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
@@ -174,45 +173,6 @@ static __always_inline __pure bool _stat
 		return false;
 	t_dynamic:
 		return __static_cpu_has(bit);
-#else
-		u8 flag;
-		/* Open-coded due to __stringify() in ALTERNATIVE() */
-		asm volatile("1: movb $2,%0\n"
-			     "2:\n"
-			     ".section .altinstructions,\"a\"\n"
-			     " .long 1b - .\n"		/* src offset */
-			     " .long 3f - .\n"		/* repl offset */
-			     " .word %P2\n"		/* always replace */
-			     " .byte 2b - 1b\n"		/* source len */
-			     " .byte 4f - 3f\n"		/* replacement len */
-			     " .byte 0\n"		/* pad len */
-			     ".previous\n"
-			     ".section .discard,\"aw\",@progbits\n"
-			     " .byte 0xff + (4f-3f) - (2b-1b)\n" /* size check */
-			     ".previous\n"
-			     ".section .altinstr_replacement,\"ax\"\n"
-			     "3: movb $0,%0\n"
-			     "4:\n"
-			     ".previous\n"
-			     ".section .altinstructions,\"a\"\n"
-			     " .long 1b - .\n"		/* src offset */
-			     " .long 5f - .\n"		/* repl offset */
-			     " .word %P1\n"		/* feature bit */
-			     " .byte 4b - 3b\n"		/* src len */
-			     " .byte 6f - 5f\n"		/* repl len */
-			     " .byte 0\n"		/* pad len */
-			     ".previous\n"
-			     ".section .discard,\"aw\",@progbits\n"
-			     " .byte 0xff + (6f-5f) - (4b-3b)\n" /* size check */
-			     ".previous\n"
-			     ".section .altinstr_replacement,\"ax\"\n"
-			     "5: movb $1,%0\n"
-			     "6:\n"
-			     ".previous\n"
-			     : "=qm" (flag)
-			     : "i" (bit), "i" (X86_FEATURE_ALWAYS));
-		return (flag == 2 ? __static_cpu_has(bit) : flag);
-#endif /* CC_HAVE_ASM_GOTO */
 }
 
 #define static_cpu_has(bit)					\
@@ -223,7 +183,8 @@ static __always_inline __pure bool _stat
 )
 #else
 /*
- * gcc 3.x is too stupid to do the static test; fall back to dynamic.
+ * Fall back to dynamic for gcc versions which don't support asm goto. Should be
+ * a minority now anyway.
  */
 #define static_cpu_has(bit)		boot_cpu_has(bit)
 #endif


