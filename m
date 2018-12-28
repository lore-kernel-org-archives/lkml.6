Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE401C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6B7218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999461;
	bh=vmvI8wkFgeMGJUu876+mwygyD/oZ/ZZeRSH6KKM24lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJimq6JH05jG/H5PNrDpU6GHROuhF1kKzieKmnDVxYMl/hSoC+HDb/AdwZZTmU5RP
	 c9qzzXrpTCmptprbReWVrgBtT3Rh4LhjzerKDU77ESIEMgS4XtCevIdJdDRX+z5oz7
	 B0VAo2mwQiacYMzXK5qBPQOZat0IJjRKtRkFHYl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbeL1MRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732983AbeL1MRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:17:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0004D2148E;
        Fri, 28 Dec 2018 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999456;
        bh=vmvI8wkFgeMGJUu876+mwygyD/oZ/ZZeRSH6KKM24lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKJEvYuAOdZA0hV8oSuJMib+veDjUU334GIFpDKG/Qb4JCZifzC35dYjOv+dRA1pm
         MWu59LCMwjFv1rHteIjEEPNpDe85dGbjaBsTnRg8Q++iWhNPioT3AELZwBpKKiN6LT
         e5deC1cVZH8Zi7ygDrA+wQLpqE0gqj5P3h/3sC4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kvm ML <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Rik van Riel <riel@surriel.com>, x86-ml <x86@kernel.org>
Subject: [PATCH 4.9 18/22] x86/fpu: Disable bottom halves while loading FPU registers
Date:   Fri, 28 Dec 2018 12:52:55 +0100
Message-Id: <20181228113127.414176417@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
References: <20181228113126.144310132@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 68239654acafe6aad5a3c1dc7237e60accfebc03 upstream.

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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/fpu/signal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -342,10 +342,10 @@ static int __fpu__restore_sig(void __use
 			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
 		}
 
+		local_bh_disable();
 		fpu->fpstate_active = 1;
-		preempt_disable();
 		fpu__restore(fpu);
-		preempt_enable();
+		local_bh_enable();
 
 		return err;
 	} else {


