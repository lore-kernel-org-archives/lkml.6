Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5922CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F58F208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7tHMUFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F58F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966315AbeFNONt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966300AbeFNONp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC68208DA;
        Thu, 14 Jun 2018 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985625;
        bh=3lTcSw9S5+HadAzaN7KDhOr9ETr3TIUQHdg/wSlyQYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7tHMUFrAHUi6hfb+1TLd+VGgY/9uZ1XuTDe6MRwlpJtosfCqwMiy/UieDmLdmaVE
         jcAQ8UKFiyd0dK467tsT0Kpdv0tWfU/tK939weEdHgCrObvUHfBounWowPcnFNayH8
         DNz10Xr6njTmlYgIzFTtZRkHEIyQEDqdOt7YUc/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Leonid Shatz <leonid.shatz@ravellosystems.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 08/24] x86/fpu: Revert ("x86/fpu: Disable AVX when eagerfpu is off")
Date:   Thu, 14 Jun 2018 16:05:03 +0200
Message-Id: <20180614132724.824634808@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
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

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

commit a65050c6f17e52442716138d48d0a47301a8344b upstream.

Leonid Shatz noticed that the SDM interpretation of the following
recent commit:

  394db20ca240741 ("x86/fpu: Disable AVX when eagerfpu is off")

... is incorrect and that the original behavior of the FPU code was correct.

Because AVX is not stated in CR0 TS bit description, it was mistakenly
believed to be not supported for lazy context switch. This turns out
to be false:

  Intel Software Developer's Manual Vol. 3A, Sec. 2.5 Control Registers:

   'TS Task Switched bit (bit 3 of CR0) -- Allows the saving of the x87 FPU/
    MMX/SSE/SSE2/SSE3/SSSE3/SSE4 context on a task switch to be delayed until
    an x87 FPU/MMX/SSE/SSE2/SSE3/SSSE3/SSE4 instruction is actually executed
    by the new task.'

  Intel Software Developer's Manual Vol. 2A, Sec. 2.4 Instruction Exception
  Specification:

   'AVX instructions refer to exceptions by classes that include #NM
    "Device Not Available" exception for lazy context switch.'

So revert the commit.

Reported-by: Leonid Shatz <leonid.shatz@ravellosystems.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi V. Shankar <ravi.v.shankar@intel.com>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1457569734-3785-1-git-send-email-yu-cheng.yu@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/fpu/xstate.h |    9 ++++-----
 arch/x86/kernel/fpu/init.c        |    6 ------
 2 files changed, 4 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -20,16 +20,15 @@
 
 /* Supported features which support lazy state saving */
 #define XFEATURE_MASK_LAZY	(XFEATURE_MASK_FP | \
-				 XFEATURE_MASK_SSE)
-
-/* Supported features which require eager state saving */
-#define XFEATURE_MASK_EAGER	(XFEATURE_MASK_BNDREGS | \
-				 XFEATURE_MASK_BNDCSR | \
+				 XFEATURE_MASK_SSE | \
 				 XFEATURE_MASK_YMM | \
 				 XFEATURE_MASK_OPMASK | \
 				 XFEATURE_MASK_ZMM_Hi256 | \
 				 XFEATURE_MASK_Hi16_ZMM)
 
+/* Supported features which require eager state saving */
+#define XFEATURE_MASK_EAGER	(XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR)
+
 /* All currently supported features */
 #define XCNTXT_MASK	(XFEATURE_MASK_LAZY | XFEATURE_MASK_EAGER)
 
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -297,12 +297,6 @@ u64 __init fpu__get_supported_xfeatures_
 static void __init fpu__clear_eager_fpu_features(void)
 {
 	setup_clear_cpu_cap(X86_FEATURE_MPX);
-	setup_clear_cpu_cap(X86_FEATURE_AVX);
-	setup_clear_cpu_cap(X86_FEATURE_AVX2);
-	setup_clear_cpu_cap(X86_FEATURE_AVX512F);
-	setup_clear_cpu_cap(X86_FEATURE_AVX512PF);
-	setup_clear_cpu_cap(X86_FEATURE_AVX512ER);
-	setup_clear_cpu_cap(X86_FEATURE_AVX512CD);
 }
 
 /*


