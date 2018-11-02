Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A67C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F792082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F792082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeKCIEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:04:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59791 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeKCIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:04:20 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gIiLM-0007v4-KR; Fri, 02 Nov 2018 23:55:08 +0100
Date:   Fri, 2 Nov 2018 23:55:08 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 10/11] x86/fpu: prepare copy_fpstate_to_sigframe for
 TIF_LOAD_FPU
Message-ID: <20181102225508.nv552gj356aykahf@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-11-bigeasy@linutronix.de>
 <ef6012c0-52b9-14bb-c581-97627fdd5cb5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef6012c0-52b9-14bb-c581-97627fdd5cb5@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-12 12:40:19 [-0700], Dave Hansen wrote:
> On 10/04/2018 07:05 AM, Sebastian Andrzej Siewior wrote:
> > From: Rik van Riel <riel@surriel.com>
> > 
> > If TIF_LOAD_FPU is set, then the registers are saved (not loaded). In that case
> > we skip the saving part.
> 
> This sentence hurts my brain.
> 
> 	"If TIF_LOAD_FPU is set the registers are ... not loaded"
> 
> I think that means that something could use some better naming.
> 
> Should TIF_LOAD_FPU be TIF_NEED_FPU_LOAD, perhaps?

ARM has TIF_FOREIGN_FPSTATE which basically means that the current FP
stat does not belong to current().
Let me try to use TIF_NEED_FPU_LOAD and see how that works out.

> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  arch/x86/kernel/fpu/signal.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> > index c8f5ff58578ed..979dcd1ed82e0 100644
> > --- a/arch/x86/kernel/fpu/signal.c
> > +++ b/arch/x86/kernel/fpu/signal.c
> > @@ -155,13 +155,17 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
> >  			sizeof(struct user_i387_ia32_struct), NULL,
> >  			(struct _fpstate_32 __user *) buf) ? -1 : 1;
> >  
> > -	/* Update the thread's fxstate to save the fsave header. */
> > -	if (ia32_fxstate) {
> > -		copy_fxregs_to_kernel(fpu);
> > -	} else {
> > -		copy_fpregs_to_fpstate(fpu);
> > -		fpregs_deactivate(fpu);
> > +	__fpregs_changes_begin();
> > +	if (!test_thread_flag(TIF_LOAD_FPU)) {
> 
> This needs commenting, please.
> 
> If we do not need to load the FPU at return to userspace, it means the
> state is in the the registers, not the buffer.  So, update the buffer to
> match the registers.

okay. Let me add this then.

Sebastian
