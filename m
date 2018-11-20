Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77728C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463C22087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463C22087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbeKUC7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:59:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44033 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeKUC7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:59:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAKGTF0G3039515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 08:29:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAKGTEMn3039512;
        Tue, 20 Nov 2018 08:29:14 -0800
Date:   Tue, 20 Nov 2018 08:29:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-68239654acafe6aad5a3c1dc7237e60accfebc03@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, Jason@zx2c4.com, riel@surriel.com,
        pbonzini@redhat.com, x86@kernel.org, hpa@zytor.com,
        mingo@kernel.org, kvm@vger.kernel.org, bigeasy@linutronix.de,
        bp@suse.de, tglx@linutronix.de, rkrcmar@redhat.com,
        luto@kernel.org, linux-kernel@vger.kernel.org
Reply-To: bp@suse.de, tglx@linutronix.de, bigeasy@linutronix.de,
          kvm@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, luto@kernel.org,
          rkrcmar@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
          pbonzini@redhat.com, Jason@zx2c4.com, riel@surriel.com
In-Reply-To: <20160226074940.GA28911@pd.tnic>
References: <20181120102635.ddv3fvavxajjlfqk@linutronix.de>
        <20160226074940.GA28911@pd.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/fpu: Disable bottom halves while loading FPU
 registers
Git-Commit-ID: 68239654acafe6aad5a3c1dc7237e60accfebc03
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  68239654acafe6aad5a3c1dc7237e60accfebc03
Gitweb:     https://git.kernel.org/tip/68239654acafe6aad5a3c1dc7237e60accfebc03
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Tue, 20 Nov 2018 11:26:35 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 20 Nov 2018 17:22:42 +0100

x86/fpu: Disable bottom halves while loading FPU registers

The sequence

  fpu->initialized = 1;		/* step A */
  preempt_disable();		/* step B */
  fpu__restore(fpu);
  preempt_enable();

in __fpu__restore_sig() is racy in regard to a context switch.

For 32bit frames, __fpu__restore_sig() prepares the FPU state within
fpu->state. To ensure that a context switch (switch_fpu_prepare() in
particular) does not modify fpu->state it uses fpu__drop() which sets
fpu->initialized to 0.

After fpu->initialized is cleared, the CPU's FPU state is not saved
to fpu->state during a context switch. The new state is loaded via
fpu__restore(). It gets loaded into fpu->state from userland and
ensured it is sane. fpu->initialized is then set to 1 in order to avoid
fpu__initialize() doing anything (overwrite the new state) which is part
of fpu__restore().

A context switch between step A and B above would save CPU's current FPU
registers to fpu->state and overwrite the newly prepared state. This
looks like a tiny race window but the Kernel Test Robot reported this
back in 2016 while we had lazy FPU support. Borislav Petkov made the
link between that report and another patch that has been posted. Since
the removal of the lazy FPU support, this race goes unnoticed because
the warning has been removed.

Disable bottom halves around the restore sequence to avoid the race. BH
need to be disabled because BH is allowed to run (even with preemption
disabled) and might invoke kernel_fpu_begin() by doing IPsec.

 [ bp: massage commit message a bit. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: stable@vger.kernel.org
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181120102635.ddv3fvavxajjlfqk@linutronix.de
Link: https://lkml.kernel.org/r/20160226074940.GA28911@pd.tnic
---
 arch/x86/kernel/fpu/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 61a949d84dfa..d99a8ee9e185 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -344,10 +344,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
 		}
 
+		local_bh_disable();
 		fpu->initialized = 1;
-		preempt_disable();
 		fpu__restore(fpu);
-		preempt_enable();
+		local_bh_enable();
 
 		return err;
 	} else {
