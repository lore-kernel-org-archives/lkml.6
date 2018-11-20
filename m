Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62210C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C8C2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C8C2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeKTUzG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:55:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40776 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeKTUzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:55:06 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gP3Ep-0005LI-Tz; Tue, 20 Nov 2018 11:26:36 +0100
Date:   Tue, 20 Nov 2018 11:26:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3] x86/fpu: Disable BH while while loading FPU registers in
 __fpu__restore_sig()
Message-ID: <20181120102635.ddv3fvavxajjlfqk@linutronix.de>
References: <20181119160410.ne7oiq2gkwt6jiqg@linutronix.de>
 <20181119181000.GH14688@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181119181000.GH14688@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sequence
   fpu->initialized = 1; /* step A */
   preempt_disable();	 /* step B */
   fpu__restore(fpu);
   preempt_enable();

is racy in regard to a context switch.
For 32bit frames __fpu__restore_sig() prepares the FPU state within
fpu->state. To ensure that a context switch (switch_fpu_prepare() in
particular) does not modify fpu->state it uses fpu__drop() which sets
fpu->initialized to 0.
After fpu->initialized is cleared, the CPU's FPU state is not saved to
fpu->state during a context switch. It then loads the new state to
fpu->state from userland and ensures it is sane. The new state is loaded
via fpu__restore(). The code sets then fpu->initializes to 1 in order to
avoid fpu__initialize() doing anything (overwrite the new state) which
is part of fpu__restore().

A context switch between step A and B would save CPU's current FPU
registers to fpu->state and overwrite the newly prepared state. This
looks like tiny race window but the Kernel Test Robot reported this back
in 2016 while we had lazy FPU support. Borislav Petkov made the link
between that report and another patch that has been posted.
Since the removal of the lazy FPU support, this race goes unnoticed
because the warning has been removed.

Disable bottom halfes around the restore sequence to avoid the race. BH
needs to be disabled because BH is allowed to run (even with preemption
disabled) and might invoke kernel_fpu_begin() by doing IPsec.

Link: https://lkml.kernel.org/r/20160226074940.GA28911@pd.tnic
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2…v3: Rewording parts of the commit message as per Borislav Petkov.
v1…v2: A more verbose commit as message.

 arch/x86/kernel/fpu/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 61a949d84dfa5..d99a8ee9e185e 100644
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
-- 
2.19.1

