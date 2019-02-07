Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57556C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2756521902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfBGN2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:28:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfBGN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:28:13 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1grjip-0001wj-1E; Thu, 07 Feb 2019 14:28:07 +0100
Date:   Thu, 7 Feb 2019 14:28:07 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 16/22] x86/fpu: Always store the registers in
 copy_fpstate_to_sigframe()
Message-ID: <20190207132806.ole3uxytntsfqyrw@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-17-bigeasy@linutronix.de>
 <20190130114322.GD18383@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130114322.GD18383@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-30 12:43:22 [+0100], Borislav Petkov wrote:
> > @@ -171,9 +156,15 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
> >  			sizeof(struct user_i387_ia32_struct), NULL,
> >  			(struct _fpstate_32 __user *) buf) ? -1 : 1;
> >  
> > -	/* Save the live register state to the user directly. */
> > -	if (copy_fpregs_to_sigframe(buf_fx))
> > -		return -1;
> > +	copy_fpregs_to_fpstate(fpu);
> > +
> > +	if (using_compacted_format()) {
> > +		copy_xstate_to_user(buf_fx, xsave, 0, size);
> > +	} else {
> > +		fpstate_sanitize_xstate(fpu);
> > +		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
> > +			return -1;
> > +	}
> >  
> >  	/* Save the fsave header for the 32-bit frames. */
> >  	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
> 
> Comments above that function need updating.

Did:
- * Save the state directly to the user frame pointed by the aligned pointer
- * 'buf_fx'.
+ * Save the state to task's fpu->state and then copy it to the user frame
+ * pointed by the aligned pointer 'buf_fx'.

Sebastian
