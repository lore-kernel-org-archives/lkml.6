Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B143ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4452075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4452075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbeGPIMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:12:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeGPIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:12:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9CCD3CEC;
        Mon, 16 Jul 2018 07:45:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 26/43] x86/alternatives: Discard dynamic check after init
Date:   Mon, 16 Jul 2018 09:36:31 +0200
Message-Id: <20180716073514.746599398@linuxfoundation.org>
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

From: Brian Gerst <brgerst@gmail.com>

commit 2476f2fa20568bd5d9e09cd35bcd73e99a6f4cc6 upstream

Move the code to do the dynamic check to the altinstr_aux
section so that it is discarded after alternatives have run and
a static branch has been chosen.

This way we're changing the dynamic branch from C code to
assembly, which makes it *substantially* smaller while avoiding
a completely unnecessary call to an out of line function.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
[ Changed it to do TESTB, as hpa suggested. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1452972124-7380-1-git-send-email-brgerst@gmail.com
Link: http://lkml.kernel.org/r/20160127084525.GC30712@pd.tnic
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeature.h |   19 ++++++++++++-------
 arch/x86/kernel/cpu/common.c      |    6 ------
 2 files changed, 12 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -132,8 +132,6 @@ extern const char * const x86_bug_flags[
  */
 
 #if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_X86_FAST_FEATURE_TESTS)
-extern bool __static_cpu_has(u16 bit);
-
 /*
  * Static testing of CPU features.  Used the same as boot_cpu_has().
  * These will statically patch the target code for additional
@@ -141,7 +139,7 @@ extern bool __static_cpu_has(u16 bit);
  */
 static __always_inline __pure bool _static_cpu_has(u16 bit)
 {
-		asm_volatile_goto("1: jmp %l[t_dynamic]\n"
+		asm_volatile_goto("1: jmp 6f\n"
 			 "2:\n"
 			 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
 			         "((5f-4f) - (2b-1b)),0x90\n"
@@ -166,13 +164,20 @@ static __always_inline __pure bool _stat
 			 " .byte 0\n"			/* repl len */
 			 " .byte 0\n"			/* pad len */
 			 ".previous\n"
-			 : : "i" (bit), "i" (X86_FEATURE_ALWAYS)
-			 : : t_dynamic, t_no);
+			 ".section .altinstr_aux,\"ax\"\n"
+			 "6:\n"
+			 " testb %[bitnum],%[cap_byte]\n"
+			 " jnz %l[t_yes]\n"
+			 " jmp %l[t_no]\n"
+			 ".previous\n"
+			 : : "i" (bit), "i" (X86_FEATURE_ALWAYS),
+			     [bitnum] "i" (1 << (bit & 7)),
+			     [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
+			 : : t_yes, t_no);
+	t_yes:
 		return true;
 	t_no:
 		return false;
-	t_dynamic:
-		return __static_cpu_has(bit);
 }
 
 #define static_cpu_has(bit)					\
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1576,12 +1576,6 @@ void cpu_init(void)
 }
 #endif
 
-inline bool __static_cpu_has(u16 bit)
-{
-	return boot_cpu_has(bit);
-}
-EXPORT_SYMBOL_GPL(__static_cpu_has);
-
 static void bsp_resume(void)
 {
 	if (this_cpu->c_bsp_resume)


