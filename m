Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3E608C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E771C208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9/4nOpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E771C208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966158AbeFNOPk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965614AbeFNONs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE44208DD;
        Thu, 14 Jun 2018 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985628;
        bh=Cs/gu1tPblBOfW3B7HRknhvrWico/fmmclweIH8H/wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9/4nOpNmsxItpV1j4JZac/9oA6T7DCjHOkDhLjAzy2nnUac8G7+cTyt5CdUAe5Ii
         kmAQb0shrsu8HoXEwj36/6TxUU1O9zgtGjf10zSD2VPEJtXy0k6Cyk/qCMTrEBjkR2
         0jiLR0flKbzECp1gOAS08WeBqGs2k1VKxRDOlU1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng <yu-cheng.yu@intel.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 09/24] x86/fpu: Fix eager-FPU handling on legacy FPU machines
Date:   Thu, 14 Jun 2018 16:05:04 +0200
Message-Id: <20180614132724.861855858@linuxfoundation.org>
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

From: Borislav Petkov <bp@alien8.de>

commit 6e6867093de35141f0a76b66ac13f9f2e2c8e77a upstream.

i486 derived cores like Intel Quark support only the very old,
legacy x87 FPU (FSAVE/FRSTOR, CPUID bit FXSR is not set), and
our FPU code wasn't handling the saving and restoring there
properly in the 'eagerfpu' case.

So after we made eagerfpu the default for all CPU types:

  58122bf1d856 x86/fpu: Default eagerfpu=on on all CPUs

these old FPU designs broke. First, Andy Shevchenko reported a splat:

  WARNING: CPU: 0 PID: 823 at arch/x86/include/asm/fpu/internal.h:163 fpu__clear+0x8c/0x160

which was us trying to execute FXRSTOR on those machines even though
they don't support it.

After taking care of that, Bryan O'Donoghue reported that a simple FPU
test still failed because we weren't initializing the FPU state properly
on those machines.

Take care of all that.

Reported-and-tested-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/20160311113206.GD4312@pd.tnic
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/fpu/core.c |    4 +++-
 arch/x86/kernel/fpu/init.c |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -409,8 +409,10 @@ static inline void copy_init_fpstate_to_
 {
 	if (use_xsave())
 		copy_kernel_to_xregs(&init_fpstate.xsave, -1);
-	else
+	else if (static_cpu_has(X86_FEATURE_FXSR))
 		copy_kernel_to_fxregs(&init_fpstate.fxsave);
+	else
+		copy_kernel_to_fregs(&init_fpstate.fsave);
 }
 
 /*
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -135,7 +135,7 @@ static void __init fpu__init_system_gene
 	 * Set up the legacy init FPU context. (xstate init might overwrite this
 	 * with a more modern format, if the CPU supports it.)
 	 */
-	fpstate_init_fxstate(&init_fpstate.fxsave);
+	fpstate_init(&init_fpstate);
 
 	fpu__init_system_mxcsr();
 }


