Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E31FDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96536208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+nJf+rH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96536208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966189AbeFNONM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966150AbeFNONH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20F7208DA;
        Thu, 14 Jun 2018 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985587;
        bh=1eBZA8Ba7EGEK4GKQerWDKcNm/3TPWKlPHcDFzlNaSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+nJf+rHTx4eR7RrrL4CthpCKX1tG6V0SMxxXwZqPotFmU1DeO7JQqnFdmRwAQKm4
         2x6llG8hR8n0nBrAkqtIXLtFU6MHHP8k7tAlshR40XujVfqXcJo68C1y/aPAgFHcd4
         dSLQwrpjmdV4W7QqzbrAl9grszJai6MTKw/BRZXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 05/24] x86/fpu: Disable AVX when eagerfpu is off
Date:   Thu, 14 Jun 2018 16:05:00 +0200
Message-Id: <20180614132724.697953870@linuxfoundation.org>
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

From: yu-cheng yu <yu-cheng.yu@intel.com>

commit 394db20ca240741a08d472173db13d6f6a6e5a28 upstream.

When "eagerfpu=off" is given as a command-line input, the kernel
should disable AVX support.

The Task Switched bit used for lazy context switching does not
support AVX. If AVX is enabled without eagerfpu context
switching, one task's AVX state could become corrupted or leak
to other tasks. This is a bug and has bad security implications.

This only affects systems that have AVX/AVX2/AVX512 and this
issue will be found only when one actually uses AVX/AVX2/AVX512
_AND_ does eagerfpu=off.

Reference: Intel Software Developer's Manual Vol. 3A

Sec. 2.5 Control Registers:
TS Task Switched bit (bit 3 of CR0) -- Allows the saving of the
x87 FPU/ MMX/SSE/SSE2/SSE3/SSSE3/SSE4 context on a task switch
to be delayed until an x87 FPU/MMX/SSE/SSE2/SSE3/SSSE3/SSE4
instruction is actually executed by the new task.

Sec. 13.4.1 Using the TS Flag to Control the Saving of the X87
FPU and SSE State
When the TS flag is set, the processor monitors the instruction
stream for x87 FPU, MMX, SSE instructions. When the processor
detects one of these instructions, it raises a
device-not-available exeception (#NM) prior to executing the
instruction.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Ravi V. Shankar <ravi.v.shankar@intel.com>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: yu-cheng yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/1452119094-7252-5-git-send-email-yu-cheng.yu@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/fpu/xstate.h |   11 ++++++-----
 arch/x86/kernel/fpu/init.c        |    6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -20,15 +20,16 @@
 
 /* Supported features which support lazy state saving */
 #define XFEATURE_MASK_LAZY	(XFEATURE_MASK_FP | \
-				 XFEATURE_MASK_SSE | \
+				 XFEATURE_MASK_SSE)
+
+/* Supported features which require eager state saving */
+#define XFEATURE_MASK_EAGER	(XFEATURE_MASK_BNDREGS | \
+				 XFEATURE_MASK_BNDCSR | \
 				 XFEATURE_MASK_YMM | \
-				 XFEATURE_MASK_OPMASK |	\
+				 XFEATURE_MASK_OPMASK | \
 				 XFEATURE_MASK_ZMM_Hi256 | \
 				 XFEATURE_MASK_Hi16_ZMM)
 
-/* Supported features which require eager state saving */
-#define XFEATURE_MASK_EAGER	(XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR)
-
 /* All currently supported features */
 #define XCNTXT_MASK	(XFEATURE_MASK_LAZY | XFEATURE_MASK_EAGER)
 
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -292,6 +292,12 @@ u64 __init fpu__get_supported_xfeatures_
 static void __init fpu__clear_eager_fpu_features(void)
 {
 	setup_clear_cpu_cap(X86_FEATURE_MPX);
+	setup_clear_cpu_cap(X86_FEATURE_AVX);
+	setup_clear_cpu_cap(X86_FEATURE_AVX2);
+	setup_clear_cpu_cap(X86_FEATURE_AVX512F);
+	setup_clear_cpu_cap(X86_FEATURE_AVX512PF);
+	setup_clear_cpu_cap(X86_FEATURE_AVX512ER);
+	setup_clear_cpu_cap(X86_FEATURE_AVX512CD);
 }
 
 /*


