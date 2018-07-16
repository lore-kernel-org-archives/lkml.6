Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7775ECDFB4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC1E20837
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC1E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389498AbeGPILB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:11:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389486AbeGPILB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:11:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A400DCA5;
        Mon, 16 Jul 2018 07:44:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave@sr71.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 31/43] x86/mm/pkeys: Fix mismerge of protection keys CPUID bits
Date:   Mon, 16 Jul 2018 09:36:36 +0200
Message-Id: <20180716073515.307322828@linuxfoundation.org>
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

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 0d47638f80a02b15869f1fe1fc09e5bf996750fd upstream

Kirill Shutemov pointed this out to me.

The tip tree currently has commit:

	dfb4a70f2 [x86/cpufeature, x86/mm/pkeys: Add protection keys related CPUID definitions]

whioch added support for two new CPUID bits: X86_FEATURE_PKU and
X86_FEATURE_OSPKE.  But, those bits were mis-merged and put in
cpufeature.h instead of cpufeatures.h.

This didn't cause any breakage *except* it keeps the "ospke" and
"pku" bits from showing up in cpuinfo.

Now cpuinfo has the two new flags:

	flags	: ...  pku ospke

BTW, is it really wise to have cpufeature.h and cpufeatures.h?
It seems like they can only cause confusion and mahem with tab
completion.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave@sr71.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20160310221213.06F9DB53@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeature.h  |    4 ----
 arch/x86/include/asm/cpufeatures.h |    4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -94,10 +94,6 @@ extern const char * const x86_bug_flags[
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : 	\
 	 x86_this_cpu_test_bit(bit, (unsigned long *)&cpu_info.x86_capability))
 
-/* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx), word 16 */
-#define X86_FEATURE_PKU		(16*32+ 3) /* Protection Keys for Userspace */
-#define X86_FEATURE_OSPKE	(16*32+ 4) /* OS Protection Keys Enable */
-
 /*
  * This macro is for detection of features which need kernel
  * infrastructure to be used.  It may *not* directly test the CPU
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -276,6 +276,10 @@
 #define X86_FEATURE_PAUSEFILTER (15*32+10) /* filtered pause intercept */
 #define X86_FEATURE_PFTHRESHOLD (15*32+12) /* pause filter threshold */
 
+/* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx), word 16 */
+#define X86_FEATURE_PKU		(16*32+ 3) /* Protection Keys for Userspace */
+#define X86_FEATURE_OSPKE	(16*32+ 4) /* OS Protection Keys Enable */
+
 /*
  * BUG word(s)
  */


