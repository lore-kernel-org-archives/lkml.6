Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E28C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C393920849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C393920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeLMOf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:35:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46703 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeLMOf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:35:59 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gXS5h-0001kD-Nd; Thu, 13 Dec 2018 15:35:53 +0100
Date:   Thu, 13 Dec 2018 15:35:53 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 11/29] x86/fpu: Always init the `state' in fpu__clear()
Message-ID: <20181213143553.7ktfajxeewgiclxa@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
 <20181128222035.2996-12-bigeasy@linutronix.de>
 <20181212171129.GD6653@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212171129.GD6653@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-12 18:11:29 [+0100], Borislav Petkov wrote:
> > diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
> > index 9e2ba7e667f61..a873da6b46d6b 100644
> > --- a/arch/x86/math-emu/fpu_entry.c
> > +++ b/arch/x86/math-emu/fpu_entry.c
> > @@ -113,9 +113,6 @@ void math_emulate(struct math_emu_info *info)
> >  	unsigned long code_base = 0;
> >  	unsigned long code_limit = 0;	/* Initialized to stop compiler warnings */
> >  	struct desc_struct code_descriptor;
> > -	struct fpu *fpu = &current->thread.fpu;
> > -
> > -	fpu__initialize(fpu);
> 
> Ok, you're removing it here but where is the FPU going to be initialized
> now in the FPU-less case?
> 
> IOW, it is not clear to me where fpu__clear() get called for the FPU
> emulation case now...

During fork() fpu__initialize() is called for both (with and without
FPU) systems. The difference is made in fpu__clear() where the init is
avoided in the FPU-less case. With this hunk:

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -365,8 +364,8 @@ void fpu__clear(struct fpu *fpu)
        /*
         * Make sure fpstate is cleared and initialized.
         */
+       fpu__initialize(fpu);
        if (static_cpu_has(X86_FEATURE_FPU)) {
-               fpu__initialize(fpu);
                user_fpu_begin();
                copy_init_fpstate_to_fpregs();
        }                                                                                                                                                                                 
we have the initialization in both cases.
The only "negative" thing might be that we now have a memset(, 0, 684)
(fpstate_init_soft()) during fork which would be avoided in case the
FPU-less system has a userland which is compiled with a soft-FPU toolchain.

I would worry about it once someone complains (and I doubt someone
complains even if we remove soft FPU support).

Sebastian
