Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC68C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F172081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F172081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeKBXtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:49:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59216 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeKBXty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:49:54 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gIaea-0007UL-7s; Fri, 02 Nov 2018 15:42:28 +0100
Date:   Fri, 2 Nov 2018 15:42:28 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 08/11] x86/fpu: Always store the registers in
 copy_fpstate_to_sigframe()
Message-ID: <20181102144227.nugzdwmis6oecis7@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-9-bigeasy@linutronix.de>
 <53f013ca-d6ff-2387-f9b0-d6c6df66d082@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53f013ca-d6ff-2387-f9b0-d6c6df66d082@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-12 11:15:51 [-0700], Dave Hansen wrote:
> > @@ -172,27 +155,20 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
> >  			sizeof(struct user_i387_ia32_struct), NULL,
> >  			(struct _fpstate_32 __user *) buf) ? -1 : 1;
> >  
> > -	if (fpu->initialized || using_compacted_format()) {
> > -		/* Save the live register state to the user directly. */
> > -		if (copy_fpregs_to_sigframe(buf_fx))
> > -			return -1;
> > -		/* Update the thread's fxstate to save the fsave header. */
> > -		if (ia32_fxstate)
> > -			copy_fxregs_to_kernel(fpu);
> > +	/* Update the thread's fxstate to save the fsave header. */
> > +	if (ia32_fxstate) {
> > +		copy_fxregs_to_kernel(fpu);
> >  	} else {
> > -		/*
> > -		 * It is a *bug* if kernel uses compacted-format for xsave
> > -		 * area and we copy it out directly to a signal frame. It
> > -		 * should have been handled above by saving the registers
> > -		 * directly.
> > -		 */
> > -		if (boot_cpu_has(X86_FEATURE_XSAVES)) {
> > -			WARN_ONCE(1, "x86/fpu: saving compacted-format xsave area to a signal frame!\n");
> > -			return -1;
> > -		}
> > +		copy_fpregs_to_fpstate(fpu);
> > +		fpregs_deactivate(fpu);
> > +	}
> 
> Could you add a high-level comment for this if{}else{} block that says
> something like:
> 
> 	/* Save the registers to the fpstate. */
> 
> I also think it's worthwhile to explain the asymmetry between the
> ia32_fxstate case and the other branch.  Why don't we
> fpregs_deactivate() in the ia32_fxstate path, for instance?

Since the ->initialized is gone, the whole hunk here looks differently
and probably easier to understand.

> > +	if (using_compacted_format()) {
> > +		copy_xstate_to_user(buf_fx, xsave, 0, size);
> > +	} else {
> >  		fpstate_sanitize_xstate(fpu);
> > -		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
> > +		size = fpu_user_xstate_size;
> > +		if (__copy_to_user(buf_fx, xsave, size))
> >  			return -1;
> >  	}

dropped this.

> This seems unnecessary.  Why are you updating 'size' like this?

Sebastian
