Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 74089C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D9720864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRp5zzl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D9720864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966308AbeFNOQP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966288AbeFNONn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F58B208DB;
        Thu, 14 Jun 2018 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985622;
        bh=VnP/QU/3ozkWCPgP8HQNUjF4F134O0gK6YhKoIvvjgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRp5zzl2Gd5NRaN3mAjaPKsFu5p0y+18nNQxLL3TbPai6ktN4nUS8qfkIY9EpFVwf
         gYTNeI6JHEEol+WdNpRmvQIvNvHrLeuXWtXJZ/LDKSNX+MbELIIuAV6W0HnDN/CZ2n
         KM391dvH7qk9KSaJHDIypSGqIDtQWjGZnfex7xWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        yu-cheng yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 07/24] x86/fpu: Fix no387 regression
Date:   Thu, 14 Jun 2018 16:05:02 +0200
Message-Id: <20180614132724.784717440@linuxfoundation.org>
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

From: Andy Lutomirski <luto@kernel.org>

commit f363938c70a04e6bc99023a5e0c44ef7879b903f upstream.

After fixing FPU option parsing, we now parse the 'no387' boot option
too early: no387 clears X86_FEATURE_FPU before it's even probed, so
the boot CPU promptly re-enables it.

I suspect it gets even more confused on SMP.

Fix the probing code to leave X86_FEATURE_FPU off if it's been
disabled by setup_clear_cpu_cap().

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: yu-cheng yu <yu-cheng.yu@intel.com>
Fixes: 4f81cbafcce2 ("x86/fpu: Fix early FPU command-line parsing")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/fpu/init.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -78,13 +78,15 @@ static void fpu__init_system_early_gener
 	cr0 &= ~(X86_CR0_TS | X86_CR0_EM);
 	write_cr0(cr0);
 
-	asm volatile("fninit ; fnstsw %0 ; fnstcw %1"
-		     : "+m" (fsw), "+m" (fcw));
+	if (!test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
+		asm volatile("fninit ; fnstsw %0 ; fnstcw %1"
+			     : "+m" (fsw), "+m" (fcw));
 
-	if (fsw == 0 && (fcw & 0x103f) == 0x003f)
-		set_cpu_cap(c, X86_FEATURE_FPU);
-	else
-		clear_cpu_cap(c, X86_FEATURE_FPU);
+		if (fsw == 0 && (fcw & 0x103f) == 0x003f)
+			set_cpu_cap(c, X86_FEATURE_FPU);
+		else
+			clear_cpu_cap(c, X86_FEATURE_FPU);
+	}
 
 #ifndef CONFIG_MATH_EMULATION
 	if (!cpu_has_fpu) {


